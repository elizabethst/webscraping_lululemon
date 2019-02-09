from selenium import webdriver
import time
import csv
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import re

with open("ll_urls.csv", "r") as ll_url_file:
	ll_reader = csv.reader(ll_url_file, delimiter = ",")
	product_urls = list(ll_reader)

product_urls = [product_url[0] for product_url in product_urls]

# Writing CSV file
product_file = open('./reviews/lululemon_product_info.csv', 'w', encoding= 'utf-8')
product_writer = csv.writer(product_file)
#writer.writerow()


#testing in a few sites with a few pages of reviews
# product_urls = [['https://shop.lululemon.com/p/women-pants/Train-Times-7-8-Pant/_/prod8555523?color=26083'],
# ['https://shop.lululemon.com/p/women-pants/Wunder-Under-HR-Tight-Brush/_/prod8810020?color=1966'],
# ['https://shop.lululemon.com/p/women-pants/Fast--Free-Tight-Tall-Non-Reflective-31/_/prod9270601?color=31382'],
# ['https://shop.lululemon.com/p/women-pants/Zoned-In-Tight-27/_/prod9080164?color=0001']]

#Web pages to scrape
for product_url in product_urls:
	product_url = product_url

	# Use Chrome browser
	driver = webdriver.Chrome()
	driver.get(product_url)

	product_dict = {}
	product_name = driver.find_element_by_xpath('.//h1[@class="pdp-title"]/div').text.replace("\n", " ")

	try:
		product_sale_price = driver.find_element_by_xpath('.//span[@class="sale-price"]').text
	except Exception as e:
		product_sale_price = ""

	try:
		product_list_price = driver.find_element_by_xpath('.//span[@class="list-price"]').text
	except Exception as e:
		product_list_price = ""

	try:
		product_colors = int(driver.find_element_by_xpath('.//div[@class="swatches-container"]/div[last()]').get_attribute("id"))+1
	except Exception as e:
		product_colors = ""

	try:
		product_avg_rating = driver.find_element_by_xpath('.//div[@id="BVRRRatingOverall_"]/div[@class="BVRRRatingNormalImage"]/img').get_attribute("title")
	except Exception as e:
		product_avg_rating = ""
	product_dict['product_name'] = product_name
	product_dict['product_url'] = product_url
	product_dict['product_list_price'] = product_list_price
	product_dict['product_sale_price'] = product_sale_price
	product_dict['product_colors'] = product_colors
	product_dict['product_avg_rating'] = product_avg_rating
	product_writer.writerow(product_dict.values())
	driver.close()

product_file.close()
print("\nDone getting product info scraping\n")

