class SmartToolPage

  SECTOR_NAME_LIST= [
  'Cash & Short Term',
  'Investments',
  'Loans',
  'Other Assets',
  'Time Deposits',
  'Non Maturity',
  'Borrowings',
  'Other Liabilities'
] 

  def initialize(driver)
    @driver = driver
  end

  def interest_rate_swap_is_displayed?
    @driver.find_element(:name => 'Interest Rate Swap').displayed?
  end

  def get_sector(sector_name)
    @driver.find_element(:name => sector_name) 
  end

  def get_sector_title
    @driver.find_element(:id => 'pfTitle').text
  end

  def get_sector_content
    @driver.find_element(:id => 'files_tap_pf')
  end

  def get_content_files(sector_content)
    sector_content.find_elements(:tag_name => 'span')
  end

  def get_next_button
    @driver.find_element(:id => 'next')
  end

  def get_previw_table
    @driver.find_element(:id => 'tbl_pvw_pf')
  end

  def get_success_alert
    @driver.find_element(:id => 'popup_content')
  end

  def get_ok_button
    @driver.find_element(:id => 'popup_ok')
  end

  def get_investment_step_bar
    @driver.find_element(:id => 'pf_divStepContainer_Invesment')
  end

  def get_common_step_bar
    @driver.find_element(:id => 'pf_divStepContainer')
  end

  def get_investment_result_table
    @driver.find_element(:id => 'tbl_InvestmentFromPathfile2')
  end
  
  def get_non_maturity_result_table
    @driver.find_element(:id => 'tbl_NonMaturityResult')
  end

  def get_validate_and_download_pathbook_button
    @driver.find_element(:class => 'top').find_elements(:tag_name => 'input')[2]
  end

  def get_validation_detail_table
    @driver.find_element(:id => 'tbl_validationDetail')
  end

  def get_download_pathbook_button
    @driver.find_element(:id => 'divValidatePf').find_elements(:tag_name => 'input')[1]
  end

  def click_each_sector
    SECTOR_NAME_LIST.each do |sector_name|
      puts sector_name
      sleep(1)
      sector = self.get_sector sector_name
      sector.click
      wait_for(60) { self.get_sector_title.include? sector_name }

      sector_content = self.get_sector_content
      content_files = self.get_content_files sector_content
      content_files.each do |file|
        sleep(1)
        file_name = file.text
        puts "file_name:#{file_name}"
        next if (file_name == '+' || file_name.include?('New'))
        file.click
        sleep(1)

        if sector_name == 'Investments'
          if self.get_investment_step_bar.displayed?
            self.get_next_button.click #only one step
          else
            self.get_next_button.click #step1 -> step2
            wait_for(180) { self.get_previw_table.displayed? }
            self.get_next_button.click #step2 -> step3
          end

        else
          self.get_next_button.click #step1 -> step2
          if sector_name == 'Non Maturity'
            wait_for(180){ self.get_non_maturity_result_table.displayed? }
          else
            wait_for(300) { self.get_previw_table.displayed? }
          end
          self.get_next_button.click #step2 -> step3
        end

        wait_for(300) { self.get_success_alert.displayed? }
        self.get_ok_button.click
        sleep(1)
      end

    end

    sleep(1)
  end

  def download_pathbook
    self.get_validate_and_download_pathbook_button.click
    wait_for(60){ self.get_validation_detail_table.displayed? }  
    self.get_download_pathbook_button.click

    begin
      alert_not_save = @driver.switch_to.alert
      puts alert_not_save.text
    rescue
      alert_not_save = false
    end
    alert_not_save.accept if alert_not_save
    sleep(1)

    begin
      alert_have_error = @driver.switch_to.alert
      puts alert_have_error.text
    rescue
      alert_have_error = false
    end
    alert_have_error.accept if alert_have_error
    sleep(20)
    
  end

  def compare_smart_tool_pathfile(generate_report_path, benchmark_report_path)
    generate_report_folder = generate_report_path + 'web14/' + CURRENT_DAY
    benchmark_report_folder = benchmark_report_path + 'web14/' + 'smart_tool/' 
    $result_14 = {}
    start_compare_time = Time.now.to_i
    Find.find(generate_report_folder) do |file|
      next if File.directory?(file) 
      file_modify_time = File.mtime(file).to_i
      time_difference = start_compare_time - file_modify_time
      next if (time_difference > 30)
      file_name = File.basename(file, '.*')
      file_name = file_name.sub(/_\d+_\d+_\d+/, '')
      ext = File.extname(file)
      benchmark_report_path = benchmark_report_folder + file_name + ext
      generate_report_path = file

      compare_common_sheet(generate_report_path, benchmark_report_path)
    end

  end

end
