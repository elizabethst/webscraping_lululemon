library(shiny)
library(tidyverse)
library(data.table)
library(lubridate)
library(shinythemes)
library(plotly)
library(RColorBrewer)
library(ggthemes)
library(shinydashboard)
#setwd("~/Documents/NYC Data Science Academy/RShiny_lululemon/")
lululemon_reviews = fread("./data/merged_with_SA_reviews.csv")
colnames(lululemon_reviews)
lululemon_reviews$`Product Name` = str_remove(lululemon_reviews$`Product Name`, "\"")
lululemon_reviews$`Date` = as_date(lululemon_reviews$`Date`)
lululemon_reviews$`lululemon response date` = as_date(lululemon_reviews$`lululemon response date`)

product_choices = lululemon_reviews %>% select(., `Product Name`) %>% unique() %>% pull
athletic_type_choices = lululemon_reviews %>% select(., `Athletic Type`) %>% unique() %>% pull
athletic_type_choices = athletic_type_choices[-4]
age_range_choices = lululemon_reviews %>% select(., `Age Range`) %>% unique() %>% pull
age_range_choices = age_range_choices[c(1,3,4,2,6,7,9,8)]
body_type_choices = lululemon_reviews %>% select(., `Body Type`) %>% unique() %>% pull
body_type_choices = body_type_choices[-6]
fit_choices = lululemon_reviews %>% select(., `Fit`) %>% unique() %>% pull
fit_choices = fit_choices[-1]



# Sentiment analysis
#https://www.quora.com/What-is-polarity-and-subjectivity-in-sentiment-analysis







lululemon_reviews %>% group_by(., `Name`) %>% summarise(n = n()) %>% arrange(desc(n))
# should do a barplot of users who post more than one review!








