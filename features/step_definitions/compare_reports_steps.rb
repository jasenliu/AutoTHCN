Given('I am on the generate report page') do

  url = 'http://192.168.0.14'
  username = 'user80008'
  password = 'test.test'

  @login = LoginPage.new(@driver)
  @login.visit url
  @login.login(username, password)
  
  @left_panel = LeftPanelPage.new(@driver)
  @left_panel.executive_insights.click
  @left_panel.generate_reports.click
end

When('select the report cycle') do |table|
  report_cycle = table.hashes[0]['report_cycle']
  @generate_monthly_quarterly_reports = GenerateMonthlyQuarterlyReports.new(@driver)
  @generate_monthly_quarterly_reports.select_report_cycle(report_cycle)
end

And('select the data type') do |table|
  data_type = table.hashes[0]['data_type']
  @generate_monthly_quarterly_reports.select_data_type(data_type) 
end

And('upload the data file') do |table|
  file_path = table.hashes[0]['file_path']
  @generate_monthly_quarterly_reports.upload_PATH_file(file_path)
end

And('click upload data file button') do
  @generate_monthly_quarterly_reports.upload_data_file
end

Then('the uploaded file should be show in the PATH+ line') do
  uploaded_file_link = @generate_monthly_quarterly_reports.uploaded_file_link
  expect(uploaded_file_link).to be_displayed
end

When('select required reports') do

end
