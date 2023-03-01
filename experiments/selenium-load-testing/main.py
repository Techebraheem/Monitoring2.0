from selenium import webdriver
import time
from datetime import datetime
from selenium.webdriver.support.ui import WebDriverWait
import requests

# create webdriver instance for Chrome
driver = webdriver.Chrome()

# set initial URL
url = "https://dwa-sandbox.energyweb.org/"

# reload page 100 times
for i in range(117):
    # navigate to URL
    driver.get(url)

    # get the response code
    response_code = requests.get(driver.current_url).status_code
    print(response_code)

    # wait for a short period of time between reloads
    time.sleep(1)

    # refresh the page
    driver.refresh()
    print(i)
    
    now = datetime.now()
    current_time = now.strftime("%H:%M:%S")
    print("Current Time =", current_time)

# close the webdriver instance
driver.quit()
