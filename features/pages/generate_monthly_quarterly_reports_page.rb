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
      puts alert_upload_data.text
    rescue
      alert_upload_data = false
    end
    alert_upload_data.accept if(alert_upload_data)
  end

  def uploaded_file_link
    @driver.find_element(:css => '#divETL > table > tbody > tr:nth-child(11) > td:nth-child(2) > span > a:nth-child(1)')
  end

  def select_reports(report_list)
    report_check_list = @driver.find_element(:id => 'divClientSettingTemplateDetailContainer').find_elements(:css => "input[type='checkbox']")
    report_check_list.each do |report_checkbox|
      report_list.each do |report|
	report_checkbox.click if report_checkbox.attribute('value') == report
      end
    end
  end

  def generate_report
    @driver.find_element(:id => 'btnDataFileGenerateReport').click
    begin
      alert_non_interesting_setting = @driver.switch_to.alert
      puts alert_non_interesting_setting.text
    rescue
      alert_non_interesting_setting = false
    end
    alert_non_interesting_setting.accept if(alert_non_interesting_setting)
  end

  def is_show_progress?
    @driver.switch_to.frame('ReportProgress32') #EaR report progeress
    report_progress = @driver.find_element(:id => 'divprogress0')
  end

  def check_report_progress(frame_report_list_id)
    frame_report_list_id.each do |frame_id|
      puts frame_id
      @driver.switch_to.frame(frame_id)

      begin
	progress = @driver.find_element(:id => 'divprogress0')
	report_error = @driver.find_element(:id => 'divReset')
      rescue
	progress = false
	report_error = false
      end

      if progress
	puts progress.text
	next if report_error
      else
	if(frame_id == 'ReportProgress33_1') #cash flow report
	  @driver.find_elements(:tag_name => 'img')[0].click
	  sleep(2)
	else
	  @driver.find_element(:id => 'rpt_excel').click
	  sleep(2)
	end
      end
      @driver.switch_to.parent_frame
    end
  end

end
