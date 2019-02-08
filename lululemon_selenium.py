# testing on https://shop.lululemon.com/p/women-pants/Align-Pant-2/_/prod2020012?color=35552

from selenium import webdriver
import time
import csv
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

# Use Chrome browser
driver = webdriver.Chrome()
# Web pages to scrape
product_url = 'https://shop.lululemon.com/p/women-pants/Align-Pant-2/_/prod2020012?color=35552'
driver.get(product_url)

# Writing CSV file
csv_file = open('lululemon_reviews.csv', 'w', encoding= 'utf-8')
writer = csv.writer(csv_file)
#writer.writerow()



#product_name = product_info.find_element_by_xpath('.//h1[@class="pdp-title"]').text
#product_price = product_info.find_element_by_xpath('.//span[@class="list-price"]').text

# not sure if i'm allowed to use product image
#product_image = product_info.find_element_by_xpath('//img[@class="default-image show-image swiper-slide swiper-slide-active"]')


# Finding review button to click to get to reviews
# I don't I need a review button -- don't need to click anything to get to review
review_button = driver.find_element_by_xpath('//span[@class="reviews-count"]')
review_button.click()



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
	product_avg_rating = driver.find_element_by_xpath('.//div[@id="BVRRRatingOverall_"]/div[@class="BVRRRatingNormalImage"]/img').get_attribute("title")
except Exception as e:
	product_avg_rating = e


index = 1
while index <=3:
#while True:
	try:
		try:
			page_number = driver.find_element_by_xpath('//span[@class="BVRRPageLink BVRRPageNumber BVRRSelectedPageNumber"]').text
		except Exception as e:
			page_number = e

		print("Scraping page number " + str(page_number))
		index = index + 1


		# Waiting for review
		#wait_time = WebDriverWait(driver, 10)
		#reviews = wait_time.until(EC.presence_of_all_elements_located((By.XPATH, '//span[@itemprop="review"]')))
		#### this is probably why it's breaking. maybe it's not updating quickly enough, then updates and breaks the code.
		### maybe use selected page, and make sure that the selected page number matches the index number


		# using time.sleep(2) instead of WebDriverWait/EC
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
				rating = review.find_element_by_xpath('.//div[@id="BVRRRatingOverall_Review_Display"]/@class="BVRRRatingNormalImage"/img').get_attribute("title")
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


			LL_response_dict = {}
			try:
				LL_responses = review.find_elements_by_xpath('.//div[@class="BVRRReviewClientResponseContainer"]')
				
				for LL_response in LL_responses:
					try:
						LL_response_content = LL_response.find_element_by_xpath('.//div[@class="BVRRReviewClientResponseText"]').text
					except Exception as e:
						LL_response_content = e

					try:
						LL_response_date = LL_response.find_element_by_xpath('.//span[@class="BVRRReviewClientResponseSubtitleDate"]').text
					except Exception as e:
						LL_response_date = e

					LL_response_dict['LL_response_content'] = LL_response_content
					LL_response_dict['LL_response_date'] = LL_response_date
					#print(LL_response_dict)

			except Exception as e:
				LL_responses = ""

			review_dict['product_name'] = product_name
			review_dict['product_url'] = product_url
			review_dict['product_list_price'] = product_list_price
			review_dict['product_sale_price'] = product_sale_price
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

			print(review_dict)





		# finding the next set of reviews
		button_xpath = '//span[@class="BVRRPageLink BVRRNextPage"]'
		button = driver.find_element_by_xpath(button_xpath)
		button.click()
		time.sleep(1.5)




	except Exception as e:
		print("no more pages to scrape")
		driver.close()
		csv_file.close() # close file that you opened
		break

print("done!")














