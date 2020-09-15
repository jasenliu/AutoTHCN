class MainMenuPage
  
  def initialize(driver)
    @driver = driver
  end

  def asset_liability_management
    @driver.find_element(:css => 'div > ul.nav.navbar-nav.marginSet1 > li:nth-child(5) > a')
  end

  def risk_reports
    @driver.find_element(:css => 'div > div > ul:nth-child(2) > li:nth-child(1) > a')
  end

  def generate_view_reports
    @driver.find_element(:css => 'div > div > ul:nth-child(2) > li:nth-child(1) > ul > li:nth-child(1) > a')
  end

  def click_select_cycle
    @driver.find_element(:id => 'divMainMenu').find_element(:id => 'newTHC_selectCycle').click
  end

  def select_report_cycle(report_cycle)
    id = 'li_' + report_cycle
    @driver.find_element(:id => 'divMainMenu').find_element(:id => id).click

  end

end
