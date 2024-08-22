*** Settings ***
Library     SeleniumLibrary
Resource    ../shared/global_vars.resource
Resource    captcha.resource
Resource    captcha.resource


*** Variables ***
${LANDING_PAGE_HEADER_SIGN_IN_TEXT}     Hello, sign in
${LANDING_PAGE_HEADER_YOUR_ACCOUNT}     Your Account

# BUG
#${LANDING_PAGE_HEADER_LOGO_BUGGY_REDIRECT}    xpath=//a[@id='nav-bb-logo']


*** Keywords ***
Go To Landing Page
    [Arguments]    ${browser}   ${headless_mode}

    Handle GUI Or Headless Mode
    ...                     ${GLOBAL_VAR_BROWSER}
    ...                     ${GLOBAL_VAR_HEADLESS_MODE}

Verify Page Loaded
    Location Should Be      ${GLOBAL_VAR_URL}
    Handle Captcha If Present

#    Check for buggy page
    ${landing_header_one}=
    ...                     Run Keyword And Return Status
    ...                     Page Should Contain
    ...                     ${LANDING_PAGE_HEADER_SIGN_IN_TEXT}

    ${landing_header_two}=
    ...                     Run Keyword And Return Status
    ...                     Page Should Contain
    ...                     ${LANDING_PAGE_HEADER_YOUR_ACCOUNT}

    IF    ${landing_header_one} != ${TRUE} and ${landing_header_two} != ${TRUE}
        Fail    None of the possible landing headers weren't displayed
    END

Handle GUI Or Headless Mode
    [Arguments]    ${browser}    ${headless_mode}

#    Captcha bypass only needed for chrome when running tests in GUI mode
    IF    "${GLOBAL_VAR_BROWSER}" == "chrome" and ${GLOBAL_VAR_HEADLESS_MODE} == ${FALSE}
        Log To Console    HEADLESS_MODE:${GLOBAL_VAR_HEADLESS_MODE} BROWSER:${GLOBAL_VAR_BROWSER}
        Go To  ${GLOBAL_VAR_URL}
        Handle Captcha If Present
        Verify Page Loaded
    ELSE
        Log To Console   HEADLESS_MODE:${GLOBAL_VAR_HEADLESS_MODE} BROWSER:${GLOBAL_VAR_BROWSER}
        Go To  ${GLOBAL_VAR_URL}
        Verify Page Loaded
    END
