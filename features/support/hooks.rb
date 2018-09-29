Before do
  #download file setting for chrome
  prefs = {
    prompt_for_download: false, 
    default_directory: DEFAULT_DOWNLOAD_DIRECTORY
  }
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_preference(:download, prefs)
  @driver = Selenium::WebDriver.for :chrome, options:options
  @driver.manage.window.maximize
  init_folder(ROOT_DIRECTORY)
end

After do
  @driver.quit
end

After do |scenario|

end
