class GenerateMonthlyQuarterlyReports

  def initialize(driver)
    @driver = driver
    @driver.switch_to.defaut_content
    @driver.switch_to.frame('content')
  end

  def select_report_cycle(report_cycle)
    Selector = Selenium::WebDriver::Support::Select
    cycle = @driver.find_element(:id => 'selALMBankDataFileCycle')
    selector_cycle = Selector.new cycle
    selector_cycle.select_by(:text, report_cycle)
  end

  def select_file_type(file_type) #PATH+,CALL File,ETL Files

  end

end
