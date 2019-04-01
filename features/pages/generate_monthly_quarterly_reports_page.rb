class GenerateMonthlyQuarterlyReports

  Selector = Selenium::WebDriver::Support::Select

  def initialize(driver)
    @driver = driver
    @driver.switch_to.default_content
    @driver.switch_to.frame('content')
  end

  def wait_for(seconds)
    Selenium::WebDriver::Wait.new({:timeout => seconds}).until { yield }
  end

  def select_report_cycle(report_cycle)
    #Selector = Selenium::WebDriver::Support::Select
    cycle = @driver.find_element(:id => 'selALMBankDataFileCycle')
    selector_cycle = Selector.new cycle
    puts "cycle:#{report_cycle}"
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
    @driver.find_element(:css => '#divETL > table > tbody > tr:nth-child(2) > td:nth-child(2) > span > a:nth-child(1)')
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
    alert_non_interesting_setting.accept if alert_non_interesting_setting

    #wait = Selenium::WebDriver::Wait.new({:timeout => 30})
    #wait.until { @driver.switch_to.alert.displayed?}
    #wait_for(30) { @driver.switch_to.alert.accept }
    sleep(8)
    begin
      alert_generate_success = @driver.switch_to.alert
      puts alert_generate_success.text
    rescue
      alert_generate_success = false
    end
    alert_generate_success.accept if alert_generate_success
  end

  def is_show_progress?
    #wait_for(30) { @driver.switch_to.frame('ReportProgress32') }
    sleep(5)
    @driver.switch_to.frame('ReportProgress33') #EaR report progeress
    report_progress = @driver.find_element(:id => 'divprogress0')
  end

  def check_report_progress(frame_report_list)
    flag = false
    begin_time = Time.now.to_i
    until flag
      end_time = Time.now.to_i
      if(end_time - begin_time > 6000)
	puts 'time is over'
	$result_14.store('report over', 'genereated report time is over')
	flag = true
	break
      end

      if(frame_report_list.size == 0)
	flag = true
	break
      end

      frame_report_list.each do |report_name, frame_id|
	sleep(5)
	puts "before switch:#{report_name},#{frame_id}"
	@driver.switch_to.frame(frame_id)
	puts "after switch:#{report_name},#{frame_id}"
	begin
	  progress = @driver.find_element(:id => 'divprogress0')
	rescue
	  progress = false
	end

	begin
	  report_error = @driver.find_element(:id => 'divReset')
	rescue
	  report_error = false
	end

	if progress
	  #puts progress.text
	  puts "#{report_name} is generating..."
	  if report_error
	    puts "#{report_name} has report error"
	    $result_14.store(report_name, "#{progress.text} has error")
	    frame_report_list.delete(report_name)
	  end
	else
	  if(frame_id == 'ReportProgress34_1') #cash flow report
	    @driver.find_elements(:tag_name => 'img')[1].click
	    sleep(2)
	    frame_report_list.delete(report_name)
	  else
	    @driver.find_element(:id => 'rpt_excel').click
	    sleep(2)
	    frame_report_list.delete(report_name)
	  end
	end

	@driver.switch_to.parent_frame
      end 
    end
  end

  def compare_report(generate_report_path, benchmark_report_path)
    generate_report_folder = generate_report_path + 'web14/' + CURRENT_DAY
    benchmark_report_folder = benchmark_report_path + 'web14/' + 'exl/' 
    $result_14 = {}
    Find.find(generate_report_folder) do |file|
      next if File.directory?(file) 
      next if (Time.now.to_i - File.atime(file).to_i > 120)
      file_name = File.basename(file, '.*')
      file_name = file_name.sub(/_\d+_\d+/, '')
      regex = /(\d+)/
      cycle = regex.match(file_name)
      ext = File.extname(file)
      benchmark_report_path = benchmark_report_folder + cycle.to_s + '/' + file_name + ext
      generate_report_path = file
      #benchmark_report_path = benchmark_report_path.gsub(/\//, "\\\\")
      #generate_report_path = file.gsub(/\//, "\\\\")

      #arr_sheet = get_sheet_names(file)
      #arr_sheet.each do |sheet_name|
      #	next if sheet_name == 'DISCLAIMER'
      #	compare_common_sheet(generate_report_path, benchmark_report_path, sheet_name)
      #end
      
      compare_common_sheet(generate_report_path, benchmark_report_path)
    end

  end

  def save_compare_report_result_to_excel
    result_path = RESULT_REPORT_PATH + CURRENT_DAY + '/TestResult.xls'
    result_path = result_path.gsub(/\//, "\\\\")
    excel = open_excel(result_path)
    excel = excel.worksheets('Sheet1')
    excel.activate
    i = 1
    $result_14.each do |key, value|
      i += 1
      excel.cells(i, 1).value = key
      excel.cells(i, 2).value = value
    end
    excel.saveas(result_path)
    close_excel
  end

  def send_compare_report_result
    ip = Socket.ip_address_list[1].ip_address
    html = <<html_end
      <html>
	<body>
	  The following is the result:
	  <table border="1" cellspacing="1" cellpadding="1">
	    <tr>
	      <td>Report</td>
	      <td>WEB14</td>
	    </tr>
	    <% $result_14.each do |key, value| %>
	      <tr>
		<td><%= key %></td>
		  <% if value == 'same' %>
		    <td style='color:green'><%= value %></td>
		  <% else %>
		    <td style='color:red'><%= value %></td>
		  <% end %>
		</tr>
	      <% end %>
	    </table>
	    <a href='file:///\\#{ip}\\AutoTHCN\\lib\\report\\generate_report\\web14\\<%= CURRENT_DAY %>'>click here to view generate report</a>
	    <br />
	    <a href='file:///\\#{ip}\\AutoTHCN\\lib\\report\\benchmark_report\\web14\\exl'>click here to view benchmark report</a>
	    <br />
	    <a href='file:///\\#{ip}\\AutoTHCN\\lib\\data_file\\excel_file'>click here to view benchmark file</a>
	    <br />
	    <a href='file:///\\#{ip}\\AutoTHCN\\lib\\test_result\\<%= CURRENT_DAY %>'>click here to view diff report</a> 
	  </body>
	</html>
html_end

    erb = ERB.new(html)
    send_email('eng-thc@thc.net.cn', 'ThcDecisions Compare finished', erb.result(binding))
  end

end
