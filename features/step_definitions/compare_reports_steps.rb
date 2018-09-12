Given('I am on the generate report page') do

  url = 'http://192.168.0.14'
  username = 'jsliu'
  password = '1'

  @login = LoginPage.new(@driver)
  @login.visit url
  @login.login(username, password)
  
  @left_panel = LeftPanelPage.new(@driver)
  @left_panel.executive_insights.click
  @left_panel.generate_reports.click
end

When('select the report cycle') do |report_cycle|

end
