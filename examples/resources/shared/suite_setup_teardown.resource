*** Settings ***
Library     SeleniumLibrary
Resource    global_vars.resource


*** Keywords ***
Begin Web TestSuite
    # Set Selenium Speed
    Set Selenium Timeout    10s
    Log                     Starting Test Suite!
#    Open Browser    about:blank    ${BROWSER}

End Web TestSuite
    Close All Browsers

Browser Setup
    Open Browser
    ...                     about:blank
    ...                     ${GLOBAL_VAR_BROWSER}
    # Set Window Size    1920    1080

Browser Teardown
    Delete All Cookies
    Close All Browsers
