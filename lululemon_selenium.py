from selenium import webdriver
import time
import csv
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import re

# Reading in product URLs of interest

with open("ll_urls.csv", "r") as ll_url_file:
	ll_reader = csv.reader(ll_url_file, delimiter = ",")
	product_urls = list(ll_reader)

product_urls = [product_url[0] for product_url in product_urls]
product_urls = product_urls[1:21]


# Writing CSV file
product_file = open('lululemon_product_info.csv', 'r+', encoding= 'utf-8')
product_writer = csv.writer(product_file)

# Web pages to scrape
for product_url in product_urls:
	product_url = product_url

	# Use Chrome browser
	driver = webdriver.Chrome()
	driver.get(product_url)

	product_dict = {}
	product_name = driver.find_element_by_xpath('.//h1[@class="pdp-title"]/div').text.replace("\n", " ")

	# csv file for each product
	filename = "./reviews/"+re.sub('[^a-zA-Z0-9]', '', product_name)+"_lululemon_review.csv"
	review_file = open(filename, 'w', encoding= 'utf-8')
	review_writer = csv.writer(review_file)

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

	index = 1
	while True:
		try:
			page_number = index
			print("Scraping page number " + str(index) + " for " + product_name)
			index = index + 1

			try:
				reviews=driver.find_elements_by_xpath('//span[@itemprop="review"]')

				for review in reviews:
					review_dict = {}
					try:
						title = review.find_element_by_xpath('.//span[@class="BVRRValue BVRRReviewTitle"]').text
					except Exception as e:
						title = ""

					try:
						content = review.find_element_by_xpath('.//div[@class="BVRRReviewTextContainer"]').text
					except Exception as e:
						content = ""

					try:
						rating = review.find_element_by_xpath('.//div[@id="BVRRRatingOverall_Review_Display"]/div[@class="BVRRRatingNormalImage"]/img').get_attribute("title")
					except Exception as e:
						rating = ""

					try:
						name = review.find_element_by_xpath('.//span[@class="BVRRNickname"]').text
					except Exception as e:
						name = ""

					try:
						location = review.find_element_by_xpath('.//span[@class="BVRRValue BVRRUserLocation"]').text
					except Exception as e:
						location = ""
					try:
						athletic_type = review.find_element_by_xpath('.//span[@class="BVRRValue BVRRContextDataValue BVRRContextDataValueActivity"]').text
					except Exception as e:
						athletic_type = ""

					try:
						age_range = review.find_element_by_xpath('.//span[@class="BVRRValue BVRRContextDataValue BVRRContextDataValueAge"]').text
					except Exception as e:
						age_range = ""

					try:
						body_type = review.find_element_by_xpath('.//span[@class="BVRRValue BVRRContextDataValue BVRRContextDataValueBodyType"]').text
					except Exception as e:
						body_type = ""

					try:
						fit = review.find_element_by_xpath('.//div[@class="BVRRRatingSliderImage"]/img').get_attribute("title")
					except Exception as e:
						fit = ""

					try:
						likes = review.find_element_by_xpath('.//div[@class="BVRRTagDimensionContainer BVRRProTagDimensionContainer"]//span[@class="BVRRTag"]').text
					except Exception as e:
						likes = ""

					try:
						dislikes = review.find_element_by_xpath('.//div[@class="BVRRTagDimensionContainer BVRRConTagDimensionContainer"]//span[@class="BVRRTag"]').text
					except Exception as e:
						dislikes = ""

					try:
						date = review.find_element_by_xpath('.//meta[@itemprop="datePublished"]').get_attribute("content")
					except Exception as e:
						date = ""

					try:
						helpful_yes = review.find_element_by_xpath('.//*[contains(@class, "BVDI_FVVote BVDI_FVPositive BVDI_FVLevel")]//span[@class="BVDINumber"]').text
					except Exception as e:
						helpful_yes = ""

					try:
						helpful_no = review.find_element_by_xpath('.//*[contains(@class, "BVDI_FVVote BVDI_FVNegative BVDI_FVLevel")]//span[@class="BVDINumber"]').text
					except Exception as e:
						helpful_no = ""

					# Responses from lululemon. Some reviews have multiple comments.
					LL_response_dict = {}
					try:
						LL_responses = review.find_elements_by_xpath('.//div[@class="BVRRReviewClientResponseContainer"]')

						for LL_response in LL_responses:
							try:
								LL_response_content = LL_response.find_element_by_xpath('.//div[@class="BVRRReviewClientResponseText"]').text
							except Exception as e:
								LL_response_content = ""

							try:
								LL_response_date = LL_response.find_element_by_xpath('.//span[@class="BVRRReviewClientResponseSubtitleDate"]').text
							except Exception as e:
								LL_response_date = ""

							LL_response_dict['LL_response_content'] = LL_response_content
							LL_response_dict['LL_response_date'] = LL_response_date

					# Exception handling. Just keep it empty
					except Exception as e:
						LL_responses = ""
						LL_response_dict = LL_responses

					# Saving information into review dictionary
					review_dict['product_name'] = product_name
					review_dict['product_url'] = product_url
					review_dict['product_avg_rating'] = product_avg_rating
					review_dict['page_number'] = page_number
					review_dict['title'] = title
					review_dict['content'] = content
					review_dict['rating'] = rating
					review_dict['name'] = name
					review_dict['location'] = location
					review_dict['athletic_type'] = athletic_type
					review_dict['age_range'] = age_range
					review_dict['body_type'] = body_type
					review_dict['fit'] = fit
					review_dict['likes'] = likes
					review_dict['dislikes'] = dislikes
					review_dict['date'] = date
					review_dict['helpful_yes'] = helpful_yes
					review_dict['helpful_no'] = helpful_no
					review_dict['LL_responses'] = LL_response_dict

					# Writing row in CSV file for each review
					review_writer.writerow(review_dict.values())


				# Finding the next set of reviews
				try:
					button_xpath = '//span[@class="BVRRPageLink BVRRNextPage"]'
					button = driver.find_element_by_xpath(button_xpath)
					button.click()
					time.sleep(2)
				except Exception as e:
					break

			except Exception as e:
				print(e)
				break
				driver.close()

		except Exception as e:
			print(e)
			print("\nDone scraping {}\n".format(product_name))
			driver.close()
			review_file.close()
			product_file.close()
			break
	driver.close()

review_file.close()
product_file.close()
print("\nDone scraping\n")
