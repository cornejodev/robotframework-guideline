*** Settings ***
Library     Collections
Library     Dialogs
Library     SeleniumLibrary
Library     ../../libraries/keywords/amazon_suite.py
Resource    top_nav.resource


*** Variables ***
${SEARCH_RESULTS_LIST}      //*[@data-component-type='s-search-result']


*** Keywords ***
Search For Products
    [Arguments]             ${search_term}
    Search For Products With Navbar  ${search_term}
    Verify Search Completed   ${search_term}

Verify Search Completed
    [Arguments]             ${search_term}
    # Note: wait until page contains is case insensitive
    Wait Until Page Contains   ${search_term}

Click First Product Link Matching Search Term
    [Arguments]             ${search_term}
    Wait Until Page Contains Element   ${SEARCH_RESULTS_LIST}
    # wait for any link to enable, i.e page finished loading
    Wait Until Element Is Enabled   //a

    ${product_link}=  Product Url Matcher   ${search_term}

#    Workaround for error ElementNotInteractableException: Message: element not interactable
#    Error sometimes appears, and sometimes doesn't, this workaround wont display the text
    
    ${product_href_locator}=
    ...                     SeleniumLibrary.Get Element Attribute
    ...                     ${product_link}
    ...                     href

    Go To  ${product_href_locator}
