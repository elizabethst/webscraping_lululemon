import pandas as pd
import numpy as np
import csv
import re
import nltk
from nltk.tokenize import word_tokenize ## tokenization
from textblob import TextBlob ## for sentiment analysis
from wordcloud import WordCloud

###############################################################################
reviews = pd.read_csv('./reviews/merged_reviews.csv')
sum(reviews['Content'] == '')/reviews.shape[0]
# 0.2% of reviews did not contain any text

## Filling NaNs with empty string (for removal later)
reviews['Title'] = reviews['Title'].fillna('')
reviews['Content'] = reviews['Content'].fillna('')

###############################################################################
################################PRE-PROCESSING#################################
###############################################################################

## Convert title and content to lowercase
# Remove rows with empty title or content
reviews['Title'] = reviews['Title'].str.lower()
reviews = reviews.loc[reviews['Title'] != ""]
reviews['Content'] = reviews['Content'].str.lower()
reviews = reviews.loc[reviews['Content'] != ""]

## Filtering:
## Removing punctuation by replacing with empty string
reviews['Title'] = reviews['Title'].apply(lambda x: re.sub('[^\w\s]', '', x))
reviews['Content'] = reviews['Content'].apply(lambda x: re.sub('[^\w\s]', '', x))
from nltk.corpus import stopwords
stop = stopwords.words('english')

reviews['Title'] = reviews['Title'].apply(lambda x: " ".join(x for x in x.split() if x not in stop))
reviews['Content'] = reviews['Content'].apply(lambda x: " ".join(x for x in x.split() if x not in stop))

## Sentiment analysis:
def sentiment_func(x):
    x['Title Polarity'] = TextBlob(x['Title']).polarity
    x['Title Subjectivity'] = TextBlob(x['Title']).subjectivity
    x['Content Polarity'] = TextBlob(x['Content']).polarity
    x['Content Subjectivity'] = TextBlob(x['Content']).subjectivity
    return x

reviews = reviews.apply(sentiment_func, axis = 1)

#reviews.to_csv('./reviews/merged_with_SA_reviews.csv', index = False)
