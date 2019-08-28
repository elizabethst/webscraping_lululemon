library(shiny)
library(tidyverse)
library(data.table)
library(lubridate)
library(shinythemes)
library(plotly)
library(RColorBrewer)
library(ggthemes)
library(shinydashboard)
library(wordcloud)
library(tm)
library(memoise)
library(DT)

lululemon_reviews = fread("./data/merged_with_SA_reviews.csv")
lululemon_reviews$`Product Name` = str_remove(lululemon_reviews$`Product Name`, "\"")
lululemon_reviews$`Date` = as_date(lululemon_reviews$`Date`)
lululemon_reviews$`lululemon response date` = as_date(lululemon_reviews$`lululemon response date`)
lululemon_reviews = lululemon_reviews %>% mutate(., "Responded" = ifelse(`lululemon response` != "", "Yes", "No"))

lululemon_reviews$`Athletic Type` = sub("^$", "N/A", lululemon_reviews$`Athletic Type`)
lululemon_reviews$`Age Range` = sub("^$", "N/A", lululemon_reviews$`Age Range`)
lululemon_reviews$`Body Type` = sub("^$", "N/A", lululemon_reviews$`Body Type`)
lululemon_reviews$`Fit` = sub("^$", "N/A", lululemon_reviews$`Fit`)

product_choices = lululemon_reviews %>% select(., `Product Name`) %>% unique() %>% pull
athletic_type_choices = lululemon_reviews %>% select(., `Athletic Type`) %>% unique() %>% pull
athletic_type_choices = athletic_type_choices[c(1:3,5,6,4)]
age_range_choices = lululemon_reviews %>% select(., `Age Range`) %>% unique() %>% pull
age_range_choices = age_range_choices[c(1,3,4,2,6,7,9,8,5)]
body_type_choices = lululemon_reviews %>% select(., `Body Type`) %>% unique() %>% pull
body_type_choices = body_type_choices[c(1:5,7,6)]
fit_choices = lululemon_reviews %>% select(., `Fit`) %>% unique() %>% pull
fit_choices = fit_choices[c(2:8,1)]

# Wordcloud
getTermMatrix <- memoise(function(product) {
  if (!(product %in% product_choices))
    stop("Unknown product")
  myCorpus = Corpus(VectorSource(lululemon_reviews %>% filter(., `Product Name` == product) %>% select(., "Content") %>% pull))
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  m = as.matrix(myDTM)
  sort(rowSums(m), decreasing = TRUE)
})