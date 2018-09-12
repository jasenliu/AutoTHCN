class LeftPanelPage
  
  def initialize(driver)
    @driver = driver
    @driver.switch_to.frame('nav')
  end

  def executive_insights
    @driver.find_element(:css => 'body > ul > li:nth-child(10) > img')
  end
  
  def generate_reports
    @driver.find_element(:css => 'body > ul > li:nth-child(15)')
  end

end
