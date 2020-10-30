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
      | http://192.168.0.14/pathfiletool2.asp?abanumber=-13071&cycle=202006&y=37e77b56520b52e2769afd30d43a4350 |
      | http://192.168.0.14/pathfiletool2.asp?abanumber=-13070&cycle=202006&y=787c79031c19911f8f365ef73b1b4ea1 |
      | http://192.168.0.14/pathfiletool2.asp?abanumber=73921093&cycle=202006&y=52019801eef50d1afb23c54212a753cb |
      | http://192.168.0.14/pathfiletool2.asp?abanumber=73914398&cycle=202006&y=2a1358c07983d778a3e3c0b913279f0a |
      | http://192.168.0.14/pathfiletool2.asp?abanumber=-12679&cycle=202006&y=ad2b9aaed1528bfa2cf90d7606cc54fd |

  Scenario: Send the smart tool compare results
    When compare the smart tool pathfile
    Then send the smart tool compare results
