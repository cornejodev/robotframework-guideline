*** Settings ***
Library     XML
Library     SeleniumLibrary
Resource    ../shared/global_vars.resource
Resource    top_nav.resource
Resource    search_results.resource


*** Variables ***
${PRODUCT_TITLE}                        //h1[@id='title']
${PRODUCT_PRICE_LABEL}                  //span[@class='a-price-whole']
${PRODUCT_BUY_NOW_BUTTON}               //input[@id='buy-now-button']
${PRODUCT_ADD_TO_CART_BUTTON}           //input[@id='add-to-cart-button']
${PRODUCT_GO_TO_CART_BUTTON}            //a[.//span[@class='nav-cart-icon nav-sprite']]
${PRODUCT_DELETE_FROM_CART_BUTTON}      //input[@value='Delete']

${CART_COUNTER}                         //span[@id='nav-cart-count']
${CART_ICON}                            //a[.//span[@class='nav-cart-icon nav-sprite']]


*** Keywords ***
Verify Page Loaded
    Wait Until Page Contains Element
    ...                     ${PRODUCT_PRICE_LABEL}

Verify Product Is Available
    ${purchasable}=
    ...                     Run Keyword And Return Status
    ...                     Page Should Contain Element
    ...                     ${PRODUCT_BUY_NOW_BUTTON}

    IF    ${purchasable} != ${TRUE}
        Fail  Product either out of stock or unavailable
    END

Add Product To Cart
    ${product_title_text}=
    ...                     Get Text
    ...                     ${PRODUCT_TITLE}

    Log   ${product_title_text}
    Click Element   ${PRODUCT_ADD_TO_CART_BUTTON}
    Click Element   ${PRODUCT_GO_TO_CART_BUTTON}
    Verify Product Was Added To Cart  ${product_title_text}
    Log To Console   Product Added Successfully

Select Product From Search Results
    [Arguments]             ${search_term}
    Click First Product Link Matching Search Term  ${search_term}
    Verify Page Loaded

Verify Product Was Added To Cart
    [Arguments]  ${product_title_text}
    Wait Until Page Contains   ${product_title_text}

Empty Cart From Previous Session
    Handle Cart Session Bug

Delete Product From Cart
    Click Element   ${PRODUCT_DELETE_FROM_CART_BUTTON}

    ${product_removed}=
    ...                     Verify Product Has Been Deleted From Cart
    ...                     ${PRODUCT_TITLE}

    IF    ${product_removed} != ${TRUE}
        Fail   Unable to remove product from cart
    END

    Log To Console  Product deleted successfully

Verify Product Has Been Deleted From Cart
    [Arguments]             ${product_title}
    
    ${result}=    Run Keyword And Return Status
    ...           Page Should Contain
    ...           was removed from Shopping Cart
    
    RETURN                  ${result}
