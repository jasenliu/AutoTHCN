Feature: Smart tool
  Make sure the smart tool woked correctly

  Background: 
    Given login the web site

  @open
  Scenario Outline: Compare smart tool pathfile
    When open the smart tool page <url>
    And click the next button for each sector
    Then download the smart tool pathfile

    Examples:
      | url												       |
      | http://192.168.0.14/pathfiletool2.asp?abanumber=-10901&cycle=201809&y=b76abb8d28ae8b5b1595fbab8e6411b3 | 
      | http://192.168.0.14/pathfiletool2.asp?abanumber=-10584&cycle=201809&y=d32fce4b58a43843b84843519aebcf92 |
      | http://192.168.0.14/pathfiletool2.asp?abanumber=-10943&cycle=201809&y=dea00e25140e66939aea7aef832dfd50 |
      | http://192.168.0.14/pathfiletool2.asp?abanumber=-10980&cycle=201809&y=b1d7c826dc2f713887c588519ec7bcc7 |

  Scenario: Send the smart tool compare results
    When compare the smart tool pathfile
    Then send the smart tool compare results
