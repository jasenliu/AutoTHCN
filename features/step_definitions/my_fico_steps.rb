When /^go to myfico site$/ do
  url = 'https://www.myfico.com/credit-education/calculators/loan-savings-calculator/'
  @driver.get url
end
    
And /^select the state and loan type to get fico data$/ do
  @my_fico_page = MyFicoPage.new(@driver)
  @my_fico_page.get_fico_data
end
    
Then /^send the fico data result$/ do
  attch_path = RESULT_REPORT_PATH + CURRENT_DAY + '/fico_loan.xls'
  @my_fico_page.run_excel_macro(attch_path)
  #send_email_with_attach('eng-thc@thc.net.cn', 'daily get myFico data', 'get myFico data', attch_path)
end
