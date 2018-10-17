Feature: Compare marjor reports
  Make sure the major reports worked correctly

  Background: 
    Given I am on the generate report page

  @upload
  Scenario: Upload data file
    When select the report cycle
    | report_cycle |
    | 201809       |
    And select the data type
    | data_type |
    | PATH+     |
    And upload the data file
    | file_path                                                 |
    | D:\AutoTHCN\lib\data_file\excel_file\benchmark_201809.xls |
    And click upload data file button
    Then the uploaded file should be show in the PATH+ line

  @generate
  Scenario: Generate reports
    When select required reports
    And click gerenate report button
    Then the reports porgress bar are show on the page 

  @compare
  Scenario: Download and compare reports
    When check the report prgress and download the reports
    Then compare the reports
    And send the compare result
 

  
