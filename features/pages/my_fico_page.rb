class MyFicoPage

  STATE_LIST = [
  'National',
  'Connecticut',
  'Delaware',
  'Maine',
  'Massachusetts',
  'New Hampshire',
  'New Jersey',
  'New York',
  'Pennsylvania',
  'Rhode Island',
  'Vermont'
  ]

  LOAN_TYPE_LIST = [
  '30-Year Fixed',
  '15-Year Fixed',
  '7/1 ARM',
  '5/1 ARM',
  '3/1 ARM',
  '1/1 ARM'
  ]

 Selector = Selenium::WebDriver::Support::Select 

  def initialize(driver)
    @driver = driver
  end

  def select_state(state_name)
    state = @driver.find_element(:name => 'ctl00$cphMainContent$ddlRegion')
    select_state = Selector.new state
    select_state.select_by(:text, state_name)
  end

  def select_loan_type(loan_type_name)
    loan_type = @driver.find_element(:name => 'ctl00$cphMainContent$ddlLoanTypes')
    select_loan_type = Selector.new loan_type
    select_loan_type.select_by(:text, loan_type_name)
  end

  def get_fico_data
    separate = -6
    STATE_LIST.each do |state|
     select_state(state)
     sleep(2)
     LOAN_TYPE_LIST.each do |loan_type|
       full_data = []
       fico_score = []
       apr = []
       separate += 6
       select_loan_type(loan_type)
       sleep(2)
       
       fico_table = @driver.find_element(:xpath => '//*[@id="aspnetForm"]/div[3]/table/tbody/tr[2]/td/table/tbody/tr/td[2]/table/tbody/tr[4]/td/table/tbody/tr/td[2]/table')
       tr_list = fico_table.find_elements(:tag_name => 'tr')
       tr_list.each do |tr|
         td_list = tr.find_elements(:tag_name => 'td')
         td_list.each do |td|
           text = td.text.lstrip
          next if text == ""
          full_data << text
         end
       end

       for i in 0..(full_data.size - 1)
         if i % 2 == 0
           fico_score << full_data[i]
         else
           apr << full_data[i]
         end
       end
       puts "state:#{state}"
       puts "loan_type:#{loan_type}"
       p fico_score
       p apr
       if fico_score.size == 0
         puts "the data is null"
         separate -= 6
       else
         save_fico_data_to_excel(fico_score, apr, separate, state, loan_type)
       end

     end
    end

  end

  def save_fico_data_to_excel(fico_data_arr, apr_data_arr, separate, state, loan_type)
    file_path = RESULT_REPORT_PATH + CURRENT_DAY + '/fico_loan.xls'
    file_path = file_path.gsub(/\//, "\\\\")
    
    fico_data_size = fico_data_arr.size
    for i in 0..(fico_data_size -1)
      excel_book = open_excel(file_path)
      excel_sheet = excel_book.worksheets('src')
      excel_sheet.activate
      row = i + 2 + separate
      excel_sheet.cells(row, 1).value = state
      excel_sheet.cells(row, 2).value = loan_type
      excel_sheet.cells(row, 3).value = fico_data_arr[i]
      excel_sheet.cells(row, 4).value = apr_data_arr[i]
      excel_book.close(1)
      close_excel 
    end
  end

  def run_excel_macro(file_path)
    file_path = file_path.gsub(/\//, "\\\\")
    excel = WIN32OLE::new('excel.Application')
    excel.displayalerts = false
    excel.visible = false
    excel_book = excel.workbooks.open(file_path)
    #excel_sheet = excel_book.worksheets('src')
    #excel_sheet.activate
    excel.run('download')
    excel_book.close(1)
    close_excel 

  end
  
end
