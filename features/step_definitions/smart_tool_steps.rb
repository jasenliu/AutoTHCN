Given /^login the web site$/ do
  url = 'http://192.168.0.14'
  username = 'jdq'
  password = '1'

  @driver.get url
  @driver.find_element(:link => "Log In").click 
  sleep(2)

  @login = LoginPage.new(@driver)
  #@login.visit url
  @login.login(username, password)
end

When /^open the smart tool page (.*?)$/ do |url|
  js="window.open('#{url}');"
  @driver.execute_script(js)
end

And /^click the next button for each sector$/ do
  original_handle = @driver.window_handle
  handles = @driver.window_handles
  handles.each do |handle|
    if handle != original_handle
      @driver.switch_to.window(handle)
      @smart_tool = SmartToolPage.new(@driver)
      wait_for(60){ @smart_tool.interest_rate_swap_is_displayed? }
      @smart_tool.click_each_sector
      break
    end

  end
end

Then /^download the smart tool pathfile$/ do
  @smart_tool.download_pathbook
end

When /^compare the smart tool pathfile$/ do
  save_file_to_generate_folder(DEFAULT_DOWNLOAD_DIRECTORY, GENERATE_REPORT_PATH, SAVE_TIME)
  @smart_tool = SmartToolPage.new(@driver)
  @smart_tool.compare_smart_tool_pathfile(GENERATE_REPORT_PATH, BENCHMARK_REPORT_PATH)
  save_compare_report_result_to_excel
end

Then /^send the smart tool compare results$/ do
  send_compare_report_result
end
