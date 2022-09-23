*** Settings ***
Documentation    Test suite for Dealer Search
Resource    ../rf-keywords/Functional.robot
Suite Setup     Launch Application Using
Test Setup    Navigate To Home Page
Test Teardown    Close Application

*** Test Cases ***
Dealer Search Should Contain All Valid Countries
    [Tags]    Dealer Search    Functional   Smoke
    [Documentation]    Test Case to verify all valid countries are displayed in Dealer Search dropdown
     Navigate To Dealer Search
     Dealer Countries Should Contain    USA    Canada    Russia    Netherlands
     Search For A Dealer    USA    60007
     TRY
        Dealer Count Should Be    20 
     EXCEPT    AS    ${error_message}
        ${e}    Set Variable    ${error_message}
        ${a}    Set Variable    I am the ironMan        
	   Log To Console    ${e}
      Log To Console    reached to I am the iron man
      Log To Console    ${f}
		@{exceptions}=    Create List   
		Append To List    ${exceptions}    ${e}
      Append To List    ${exceptions}    ${f}         
		Log To Console    ${exceptions}
      Log To Console    This -----is------ the------- Exceptions
		Execute Javascript    lambda-exceptions    ARGUMENTS    ${exceptions}
		Log To Console    ${TEST_STATUS}
         
     END
 
     