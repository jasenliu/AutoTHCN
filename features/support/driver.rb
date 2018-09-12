require 'selenium-webdriver'

#download file setting for chrome
prefs = {
  prompt_for_download: false, 
  default_directory: "D:/download_test/"
}
options = Selenium::WebDriver::Chrome::Options.new
options.add_preference(:download, prefs)

#Selenium::WebDriver.logger.level = :info
@driver = Selenium::WebDriver.for :chrome, options:options
#driver.get 'http://localhost'
#driver.get 'http://192.168.0.14'
