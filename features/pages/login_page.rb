class LoginPage

  def initialize(driver)
    @driver = driver
  end

  def visit(url)
    @driver.get url
  end

  def login(username, password)
    self.username = username
    self.password = password
    @driver.find_element(:name, "submit").click
  end
  
  #private
  
  def username=(username) 
    @driver.find_element(:id => "lgnName").send_keys username
  end

  def password=(password)
    @driver.find_element(:name => "lgnPass").send_keys password
  end

end
