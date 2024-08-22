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
Logged In User Should Be Able To Add Product To Cart
    [Documentation]    Test addition of product to cart
    [Tags]
    ...    tc008
    ...    functional
    ...    cart

    Go To Landing Page
    ...                     ${GLOBAL_VAR_BROWSER}
    ...                     ${GLOBAL_VAR_HEADLESS_MODE}

    Login With Valid Credentials
    ...                     ${GLOBAL_VAR_VALID_LOGIN_EMAIL}
    ...                     ${GLOBAL_VAR_VALID_LOGIN_PASSWORD}

    Empty Cart From Previous Session
    Search For Products   ${GLOBAL_LIST_PRODUCTS}[0]

    Select Product From Search Results  ${GLOBAL_LIST_PRODUCTS}[0]

    Verify Product Is Available
    Add Product To Cart

Logged In User Should Be Able To Delete A Product From Cart
    [Documentation]    Test deletion of product from cart
    [Tags]
    ...    tc009
    ...    functional
    ...    cart

    Go To Landing Page
    ...                     ${GLOBAL_VAR_BROWSER}
    ...                     ${GLOBAL_VAR_HEADLESS_MODE}

    Login With Valid Credentials
    ...                     ${GLOBAL_VAR_VALID_LOGIN_EMAIL}
    ...                     ${GLOBAL_VAR_VALID_LOGIN_PASSWORD}

    Empty Cart From Previous Session
    Search For Products  ${GLOBAL_LIST_PRODUCTS}[0]
    Select Product From Search Results  ${GLOBAL_LIST_PRODUCTS}[0]
    Verify Product Is Available
    Add Product To Cart
    Delete Product From Cart
