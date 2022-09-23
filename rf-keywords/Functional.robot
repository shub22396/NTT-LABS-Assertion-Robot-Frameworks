*** Settings ***
Documentation    Test automation of landboats.com
Library    SeleniumLibrary
Library    Collections
Library    String
Library    LambdaTestStatus.py

*** Variables ***
# Configuration
${TIMEOUT}    120 Secs
${URL}    https://www.lundboats.com/
#${LAMBDA URL}    https://shubhamr:@hub.lambdatest.com/wd/hub
${BROWSER}          ${ROBOT_BROWSER}
&{options}          browserName=${browserName}     platform=${platform}       version=${version}        
...                 visual=${visual}       network=${network}        console=${console}    project=TESTS-CUSTOMER-EXPERIENCE      name=RobotFramework Lambda Test
&{CAPABILITIES}     LT:Options=&{options}
${REMOTE_URL}       http://shubhamr:@hub.lambdatest.com/wd/hub


# Home Page
${HOME PAGE TITLE}    LUND® Aluminum Fishing Boats-For Anglers and FamiliesTest
${HOME PAGE LINK}    xpath=//a[@title="Lund Boats"]

# Dealer Search
${FIND A DELAER BUTTON}    xpath=(//a[normalize-space(text())='Find a Dealer'])[2]
${DEALER ADDRESS TEXT}    xpath=//input[@id="inputFindDealer"]
${DEALER COUNTRY LIST}    xpath=//select[@id="ln-ctry-code"]
${DEALER SEARCH ICON}    xpath=//span[contains(@class,'js-dealersearch')]
${FILTER BY BOAT TYPE LIST}    xpath=//select[@class="dealerfilter"]//following-sibling::div[1]
${DEALER SEARCH RESULTS}    xpath=//lable[@class='card-lable']
${DELAER SEARCH PAGE TITLE}    Lund Boat Dealers Near Me: Fishing, Bass Jon, Crappie Dealerships


*** Keywords ***
Launch Application Using
    [Documentation]    Keyword to Launch Website 
    #[Arguments]    ${Browser}
    Set Selenium Timeout    ${TIMEOUT}
    #Open Browser    ${URL}    ${Browser}    remote_url=${LAMBDA URL}    desired_capabilities=name: ${SUITE_NAME}
    Open browser  ${URL}  browser=${BROWSER}
    ...  remote_url=${REMOTE_URL}
    ...  desired_capabilities=${CAPABILITIES}
    Set Window Position    0    0
    Set Window Size    1920    1024    
    #TRY
       #Title Should Be    ${HOME PAGE TITLE} 
    #EXCEPT    AS    ${error_message}
        #${e}    Set Variable    ${error_message}        
	    #Log To Console    ${e}
		#@{exceptions}=    Create List   
		#Append To List    ${exceptions}    ${e}    
		#Log To Console    ${exceptions}
		#Execute Javascript    lambda-exceptions    ARGUMENTS    ${exceptions}
    #END
    

Navigate To Home Page
    [Documentation]    Keyword to Navigate to Homepage by clicking on Logo
    Click Element    ${HOME PAGE LINK}
    #Title Should Be    ${HOME PAGE TITLE}
    TRY
       Title Should Be    ${HOME PAGE TITLE} 
    EXCEPT    AS    ${error_message}
        ${f}    Set Variable    ${error_message}
        Set Global Variable    ${f}
        ${b}    Set Variable    ${error_message}    
	    #Log To Console    ${f}
        #Log To Console    ${b}
        #Log To Console    Reached to Global variBLE
		@{exceptions}=    Create List   
		Append To List    ${exceptions}    ${f}
        Append To List    ${exceptions}    ${b}
		#Log To Console    ${exceptions}
		#Execute Javascript    lambda-exceptions    ARGUMENTS    ${exceptions}
        
    END
    

Navigate To Dealer Search
    [Documentation]    Keyword to Click on Dealer Search on Top Left area
    Click Element    ${FIND A DELAER BUTTON}
    

Dealer Countries Should Contain
    [Documentation]    Keyword to verify the Dealer country list
    [Arguments]    @{Country List}
    ${Actual Country List}    Get List Items     ${DEALER COUNTRY LIST}
    Lists Should Be Equal    ${Country List}    ${Actual Country List}

Search For A Dealer
    [Documentation]    Keyword to Search for a Dealer by Address
    [Arguments]    ${Country}    ${Address}
    Wait Until Element Is Visible    ${DEALER COUNTRY LIST}
    Select From List By Label    ${DEALER COUNTRY LIST}    ${Country}
    Input Text    ${DEALER ADDRESS TEXT}   ${Address}
    
    Click Element    ${DEALER SEARCH ICON}

Dealer Count Should Be
    [Documentation]    Keyword to verify the Dealer search result count
    [Arguments]    ${Count}
    Title Should Be    ${DELAER SEARCH PAGE TITLE}
    Wait Until Element Is Visible    ${FILTER BY BOAT TYPE LIST}
    ${Actual Count}    Get Element Count    ${DEALER SEARCH RESULTS}
    Set Selenium Timeout    15s
    Should Be Equal As Integers    ${Count}    ${Actual Count}
   

Close Application
    [Documentation]    Keyword to close all browsers
    Report Lambdatest Status    ${TEST NAME}    ${TEST STATUS}
    Close All Browsers
    
    
    