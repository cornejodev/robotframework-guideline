*** Settings ***
Resource            ../../resources/shared/global_vars.resource
Resource            ../../resources/shared/suite_setup_teardown.resource
Resource            ../../resources/po/landing_page.resource

Test Setup          Browser Setup
Test Teardown       Browser Teardown


*** Test Cases ***
Landing Page Should Load
    [Documentation]    Test navigation to landing page
    [Tags]
    ...    tc001
    ...    smoke
    ...    login

    Go To Landing Page
    ...                     ${GLOBAL_VAR_BROWSER}
    ...                     ${GLOBAL_VAR_HEADLESS_MODE}
