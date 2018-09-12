Feature: Compare marjor reports
  Make sure the major reports worked correctly

  Background: 
    Given I am on the generate report page

  Scenario: Upload data file
    When select the report cycle
    | report_cycle |
    | 201806       |
    And select the data type
    | data_type |
    | PATH+     |
    And upload the data file
    | data_file                                                 |
    | D:\AutoTHCN\lib\data_file\excel_file\\Agency Bond_min.xls |
    And click upload data file button
    Then the uploaded file should be show in the PATH+ line

  Scenario: Generate reports
    When select required reports
    And click gerenate report button
    Then the reports porgress bar are show on the page 

  Scenario: Download and compare reports
    When download the reports
    Then compare the reports
 

  
