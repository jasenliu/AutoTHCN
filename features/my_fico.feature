Feature: Download fico data
  Download fico data

  Scenario: Download fico data
    When go to myfico site
    And select the state and loan type to get fico data
    Then send the fico data result
