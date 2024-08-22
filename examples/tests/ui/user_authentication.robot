*** Settings ***
Resource    ../../resources/shared/global_vars.resource
Resource    ../../resources/shared/suite_setup_teardown.resource
Resource    ../../resources/po/landing_page.resource
Resource    ../../resources/po/sign_in.resource
Resource    ../../resources/po/sign_out.resource


*** Test Cases ***
Should Be Able To Login With Valid Credentials
    [Documentation]    Test user login
    [Tags]
    ...    tc004
    ...    smoke
    ...    login

    Go To Landing Page
    ...                     ${GLOBAL_VAR_BROWSER}
    ...                     ${GLOBAL_VAR_HEADLESS_MODE}

    Login With Valid Credentials
    ...                     ${GLOBAL_VAR_VALID_LOGIN_EMAIL}
    ...                     ${GLOBAL_VAR_VALID_LOGIN_PASSWORD}

Should Be Able To Logout
    [Documentation]    Test user logout
    [Tags]
    ...    tc012
    ...    smoke
    ...    logout

    Go To Landing Page
    ...                     ${GLOBAL_VAR_BROWSER}
    ...                     ${GLOBAL_VAR_HEADLESS_MODE}

    Login With Valid Credentials
    ...                     ${GLOBAL_VAR_VALID_LOGIN_EMAIL}
    ...                     ${GLOBAL_VAR_VALID_LOGIN_PASSWORD}
    Logout From Account
