*** Settings ***
Resource            ../../resources/shared/global_vars.resource
Resource            ../../resources/shared/suite_setup_teardown.resource
Resource            ../../resources/po/landing_page.resource
Resource            ../../resources/po/search_results.resource
Resource            ../../resources/po/sign_in.resource
Resource            ../../resources/po/product.resource

Test Setup          Browser Setup
Test Teardown       Browser Teardown


*** Test Cases ***
Logged Out User Should Be Able To Search For A Product
    [Documentation]    Test product lookup while logged out
    [Tags]
    ...    tc002
    ...    smoke
    ...    search

    Go To Landing Page
    ...                     ${GLOBAL_VAR_BROWSER}
    ...                     ${GLOBAL_VAR_HEADLESS_MODE}
   
    Search For Products     ${GLOBAL_LIST_PRODUCTS}[0]

Logged Out User Should Be Able To View A Product
    [Documentation]    Test product selection after lookup while logged out
    [Tags]
    ...    tc003
    ...    smoke
    ...    search

    Go To Landing Page
    ...                     ${GLOBAL_VAR_BROWSER}
    ...                     ${GLOBAL_VAR_HEADLESS_MODE}

    Search For Products     ${GLOBAL_L_IST_PRODUCTS}[0]
    Select Product From Search Results   ${GLOBAL_LIST_P_RODUCTS}[0]

Logged In User Should Be Able To Search For Products
    [Documentation]    Test product lookup while logged in
    ...    tc005
    ...    functional
    ...    search

    Go To Landing Page
    ...                     ${GLOBAL_VAR_BROWSER}
    ...                     ${GLOBAL_VAR_HEADLESS_MODE}

    Login With Valid Credentials
    ...                     ${GLOBAL_VAR_VALID_LOGIN_EMAIL}
    ...                     ${GLOBAL_VAR_VALID_LOGIN_PASSWORD}

    Search For Products     ${GLOBAL_LIST_PRODUCTS}[0]
    Browser Teardown

Logged In User Should Be Able To View A Product
    [Documentation]    Test product selection after lookup while logged in
    [Tags]
    ...    tc006
    ...    functional
    ...    search

    Go To Landing Page
    ...                     ${GLOBAL_VAR_BROWSER}
    ...                     ${GLOBAL_VAR_HEADLESS_MODE}

    Login With Valid Credentials
    ...                     ${GLOBAL_VAR_VALID_LOGIN_EMAIL}
    ...                     ${GLOBAL_VAR_VALID_LOGIN_PASSWORD}
   
    Search For Products  ${GLOBAL_LIST_PRODUCTS}[0]
    Select Product From Search Results   ${GLOBAL_LIST_PRODUCTS}[0]
    Browser Teardown

Logged In User Should Be Able To View Availability Of A Product
    [Documentation]    Test viewing of availability of product after lookup while logged in
    [Tags]
    ...    tc007
    ...    functional
    ...    search

    Go To Landing Page
    ...                     ${GLOBAL_VAR_BROWSER}
    ...                     ${GLOBAL_VAR_HEADLESS_MODE}

    Login With Valid Credentials
    ...                     ${GLOBAL_VAR_VALID_LOGIN_EMAIL}
    ...                     ${GLOBAL_VAR_VALID_LOGIN_PASSWORD}
    
    Search For Products     ${GLOBAL_LIST_PRODUCTS}[0]
    Select Product From Search Results   ${GLOBAL_LIST_PRODUCTS}[0]
    Verify Product Is Available
