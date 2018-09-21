class GenerateMonthlyQuarterlyReports

  Selector = Selenium::WebDriver::Support::Select

  def initialize(driver)
    @driver = driver
    @driver.switch_to.default_content
    @driver.switch_to.frame('content')
  end

  def select_report_cycle(report_cycle)
    #Selector = Selenium::WebDriver::Support::Select
    cycle = @driver.find_element(:id => 'selALMBankDataFileCycle')
    selector_cycle = Selector.new cycle
    puts 'cycle:#{report_cycle}'
    selector_cycle.select_by(:text, report_cycle)
  end

  def select_data_type(data_type) #PATH+,CALL File,ETL Files
    upload_data_type = @driver.find_element(:id => 'selTypeReport')  
    select_data_type = Selector.new upload_data_type
    select_data_type.select_by(:text, data_type)
  end

  def upload_PATH_file(file_path)
    @driver.find_element(:id => 'etlPATHPlus').send_keys file_path
  end

  def upload_CALL_file(file_path)
    @driver.find_element(:id => 'etlCallFile').send_keys file_path
  end

  def upload_UBPR_file(file_path)
    @driver.find_element(:id => 'etlUBPRFile').send_keys file_path
  end

  def upload_data_file
    @driver.find_element(:id => 'btnUploadDataFile').click
    begin
      alert_upload_data = @driver.switch_to.alert
    rescue
      alert_upload_data = false
    end
    alert_upload_data.accept if(alert_upload_data)
  end

  def uploaded_file_link
    @driver.find_element(:css => '#divETL > table > tbody > tr:nth-child(11) > td:nth-child(2) > span > a:nth-child(1)')
  end

end
