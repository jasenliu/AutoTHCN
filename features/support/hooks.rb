Before do
  #download file setting for chrome
  prefs = {
    prompt_for_download: false, 
    default_directory: DEFAULT_DOWNLOAD_DIRECTORY
  }
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_preference(:download, prefs)

  #handle Net::ReadTimeout (Net::ReadTimeout)
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.read_timeout = 300 # seconds
  client.open_timeout = 300 # seconds

  @driver = Selenium::WebDriver.for(:chrome, options: options, http_client: client) 
  @driver.manage.window.maximize

  init_folder(ROOT_DIRECTORY)
end

After do
  @driver.quit
end

After do |scenario|
  screen_path = SCREENSHOT_PATH + scenario.name + '_' + SAVE_TIME + '.png'
  @driver.save_screenshot(screen_path) if scenario.failed?
end
