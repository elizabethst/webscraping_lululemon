#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Feb  9 13:23:13 2019

@author: stellakim
"""

import pandas as pd
import numpy as np
#import csv
#import re
import ast
import os



###############################################################################
###################### Reviews scraped on 02/08/2019 ##########################
###############################################################################


###############################################################################
# Reading in product information
product_colnames = ["Product Name", "URL", "Current Price", "List Price", "Colors", "Average Rating"]
product_info = pd.read_csv('./reviews/lululemon_product_info.csv', names = product_colnames)


###############################################################################
# There are some missing reviews in the first file, for Align Pant II, but I
# scraped them in an additional file.
review_colnames =  ["Product Name", "URL", "Average Rating", "Page Number", 
                    "Title", "Content", "Rating", "Name", "Location", "Athletic Type", "Age Range", "Body Type", 
                    "Fit", "Likes", "Dislikes", "Date", "Helful Yes", "Helpful No", "lululemon Response"]
align_reviews = pd.read_csv('./reviews/0.AlignPantII25_lululemon_review.csv', names = review_colnames)
# Missing reviews for page 178 and 193.
align_reviews[align_reviews['Rating'].isna()]['Page Number'].unique()

align_missing = pd.read_csv('./reviews/41.AlignPantII25_lululemon_review.csv', names = review_colnames)
missing_reviews = align_missing[(align_reviews['Page Number'] == 178) | (align_reviews['Page Number'] == 193)]

align_reviews = align_reviews.drop(align_reviews[(align_reviews["Page Number"] == 178) | (align_reviews["Page Number"] == 193)].index)

align_reviews = pd.concat([align_reviews, missing_reviews], axis = 0).sort_index()

del (missing_reviews, align_missing)


###############################################################################
# Creating data frame, will concatenate all other data frames
reviews = align_reviews
del align_reviews

# Splitting lululemon Response into content and date
reviews["lululemon Response"] = reviews["lululemon Response"].map(lambda dict: ast.literal_eval(dict))
reviews = reviews.join(pd.DataFrame(reviews['lululemon Response'].to_dict()).T)
reviews['LL_response_date']
reviews.rename(columns={'LL_response_content':'lululemon response', 'LL_response_date':'lululemon response date'}, inplace=True)


# Dropping URL and lululemon Response
reviews = reviews.drop(columns = ["URL", "lululemon Response"])

# Removing "out of 5" and converting to float from columns containing ratings
rating_cols = [col for col in reviews.columns if "Rating" in col]
for col in rating_cols:
    reviews[col] = reviews[col].map(lambda x: float(x.replace(" out of 5", "")))
del rating_cols

# Cleaning up Location column.
reviews['Location'] = reviews['Location'].str.replace(", USA", "")
reviews['Location'] = reviews['Location'].str.replace("\d", "", regex = True)

#reviews['lululemon response']




# I realized that while if there was an item for sale at list price and sale
# price (i.e. some colors on sale), they were listed separately, but the
# reviews were linked.

###############################################################################
# Code from this source:
# https://arcpy.wordpress.com/2012/05/11/sorting-alphanumeric-strings-in-python/
def sorted_nicely( l ):
    """ Sorts the given iterable in the way that is expected.
 
    Required arguments:
    l -- The iterable to be sorted.
 
    """
    convert = lambda text: int(text) if text.isdigit() else text
    alphanum_key = lambda key: [convert(c) for c in re.split('([0-9]+)', key)]
    return sorted(l, key = alphanum_key)


filenames = sorted_nicely(os.listdir('./reviews'))[:42]
files_to_ignore = list(product_info[product_info["Product Name"].duplicated()].index)
file_indices = [index for index in range(len(filenames)) if index not in files_to_ignore]
filenames = list(map(lambda index: filenames[index], file_indices))
filenames = filenames[1:]
del (files_to_ignore, file_indices)


for file in filenames:
    try:
        # Reading in reviews
        tmp = pd.read_csv("./reviews/"+str(file), names = review_colnames)
        # Splitting lululemon Response into content and date
        tmp["lululemon Response"] = tmp["lululemon Response"].map(lambda dict: ast.literal_eval(dict))
        tmp = tmp.join(pd.DataFrame(tmp['lululemon Response'].to_dict()).T)
        #tmp['LL_response_date']
        tmp.rename(columns={'LL_response_content':'lululemon response', 'LL_response_date':'lululemon response date'}, inplace=True)
        # Dropping URL and lululemon Response
        tmp = tmp.drop(columns = ["URL", "lululemon Response"])
        # Removing "out of 5" and converting to float from columns containing ratings
        rating_cols = [col for col in tmp.columns if "Rating" in col]
        for col in rating_cols:
            tmp[col] = tmp[col].map(lambda x: float(x.replace(" out of 5", "")))
        del rating_cols
        # Cleaning up Location column.
        tmp['Location'] = tmp['Location'].str.replace(", USA", "")
        tmp['Location'] = tmp['Location'].str.replace("\d", "", regex = True)
        reviews = pd.concat([reviews, tmp], axis = 0)
        print("done with " + file)
    except Exception as e:
        print(e)
        continue

reviews






































################################################################################
## Reading in reviews
#review_colnames =  ["Product Name", "URL", "Average Rating", "Page Number", 
#                    "Title", "Content", "Rating", "Name", "Location", "Athletic Type", "Age Range", "Body Type", 
#                    "Fit", "Likes", "Dislikes", "Date", "Helful Yes", "Helpful No", "lululemon Response"]
#reviews = pd.read_csv('./reviews/14.SpeedUpTightFullOnLuxtremeBrushed28_lululemon_review.csv', names = review_colnames)
#
#
################################################################################
## Splitting lululemon Response into content and date
#reviews["lululemon Response"] = reviews["lululemon Response"].map(lambda dict: ast.literal_eval(dict))
#reviews = reviews.join(pd.DataFrame(reviews['lululemon Response'].to_dict()).T)
#reviews['LL_response_date']
#reviews.rename(columns={'LL_response_content':'lululemon response', 'LL_response_date':'lululemon response date'}, inplace=True)
#
#
################################################################################
## Dropping URL and lululemon Response
#reviews = reviews.drop(columns = ["URL", "lululemon Response"])
#
#
################################################################################
## Removing "out of 5" and converting to float from columns containing ratings
#rating_cols = [col for col in reviews.columns if "Rating" in col]
#for col in rating_cols:
#    reviews[col] = reviews[col].map(lambda x: float(x.replace(" out of 5", "")))
#del rating_cols
#
#
################################################################################
## Cleaning up Location column.
#reviews['Location'] = reviews['Location'].str.replace(", USA", "")
#reviews['Location'] = reviews['Location'].str.replace("\d", "", regex = True)
#
#
#
### Replacing empty dictionaries in 'lululemon Response' with ""
##reviews['lululemon Response'] = reviews['lululemon Response'].map(lambda x: x.replace("{}", ""))
#
#
## Replacing empty strings with np.nan for the entire df
##reviews = reviews.replace("", np.nan)
