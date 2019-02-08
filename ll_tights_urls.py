# testing on https://shop.lululemon.com/c/women-pants/_/N-1z109yvZ7yh
# just getting URLs of tights
# for infinite scroll: https://michaeljsanders.com/2017/05/12/scrapin-and-scrollin.html

from selenium import webdriver
import time
import csv
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# Use Chrome browser
driver = webdriver.Chrome()
# Web pages to scrape
driver.get('https://shop.lululemon.com/c/women-pants/_/N-1z109yvZ7yh')

# Writing CSV file
csv_file = open('ll_urls.csv', 'w', encoding= 'utf-8')
writer = csv.writer(csv_file)

# Selenium script to scroll to the bottom, wait 3 seconds for the next batch of data to load, then continue scrolling.  It will continue to do this until the page stops loading new data.
lenOfPage = driver.execute_script("window.scrollTo(0, document.body.scrollHeight);var lenOfPage=document.body.scrollHeight;return lenOfPage;")
match=False
while(match==False):
	lastCount = lenOfPage
	time.sleep(1.5)
	lenOfPage = driver.execute_script("window.scrollTo(0, document.body.scrollHeight);var lenOfPage=document.body.scrollHeight;return lenOfPage;")
	if lastCount==lenOfPage:
		match=True

try:
	products = driver.find_elements_by_xpath('//div[@class=" product-tile"]')

	for product in products:
		product_url = product.find_element_by_xpath('.//div[@class="product-display-name"]/a').get_attribute("href")
		writer.writerow([product_url])

except Exception as e:
	print(e)
	driver.close()
	csv_file.close()


print("\nDone scraping product URLs\n")
