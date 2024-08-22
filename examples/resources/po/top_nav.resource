*** Settings ***
Library     SeleniumLibrary
Resource    product.resource


*** Variables ***
${TOP_NAV_SIGNIN_TEXT}              Hello, sign in
${TOP_NAV_SIGNIN_LINK}              //a[.//span[text()='Hello, sign in']]

${TOP_NAV_SEARCH_BAR}               //input[@id='twotabsearchtextbox']
${TOPNAV_SEARCH_BUTTON}             //input[@id='nav-search-submit-button']

${TOP_NAV_SIGNOUT_DROPDOWN_LINK}    //a[@id='nav-item-signout']

# BUGGY REDIRECT PAGE
${TOP_NAV_YOUR_ACCOUNT_LINK}        //a[normalize-space()='Your Account']
${TOP_NAV_SEARCH_BAR_BUG}           //input[@id='nav-bb-search']
${TOPNAV_SEARCH_BUTTON_BUG}         //input[@class='nav-bb-button']


*** Keywords ***
Click "Sign In" Link
    Wait Until Keyword Succeeds
    ...                     5x
    ...                     4s
    ...                     User Session Check

Search For Products With Navbar
    [Arguments]             ${search_term}
#    Handle Cart Session Bug
    Enter Search Term       ${search_term}
    Submit Search

Enter Search Term
    [Arguments]             ${search_term}

    ${search_bar}=
    ...                     Run Keyword And Return Status
    ...                     Page Should Contain Element
    ...                     ${TOP_NAV_SEARCH_BAR}

    IF    ${search_bar}==${TRUE}
        Input Text
        ...                     ${TOPNAV_SEARCH_BAR}
        ...                     ${search_term}
    ELSE
        Input Text
        ...                     ${TOP_NAV_SEARCH_BAR_BUG}
        ...                     ${search_term}
    END

Submit Search
    ${search_button_one}=
    ...                     Run Keyword And Return Status
    ...                     Page Should Contain Element
    ...                     ${TOPNAV_SEARCH_BUTTON}

    IF    ${search_button_one}==${TRUE}
        Click Button    ${TOPNAV_SEARCH_BUTTON}
    ELSE
        Click Button    ${TOPNAV_SEARCH_BUTTON_BUG}
    END

User Session Check
    ${user_logged_out}=
    ...                     Run Keyword And Return Status
    ...                     Page Should Contain Element
    ...                     ${TOP_NAV_SIGNIN_LINK}

    IF    ${user_logged_out} == ${TRUE}
        Click Element   ${TOP_NAV_SIGNIN_LINK}
    ELSE
#    Means previous user session was preserved somehow while testing
        Log To Console    Buggy redirect triggered, atempting recovery...
        Close All Browsers

        Open Browser
        ...                     ${GLOBAL_VAR_URL}
        ...                     ${GLOBAL_VAR_BROWSER}

        Wait Until Page Contains   ${TOP_NAV_SIGNIN_TEXT}

        Click Element  ${TOP_NAV_SIGNIN_LINK}
    END

Handle Cart Session Bug
    ${items}=    Get Text  //span[@id='nav-cart-count']

#    TODO: handle deletion of multiple items
    IF    "${items}" != "0"
        Log To Console   Emptying cart from previous session...

        Click Element   //a[.//span[@class='nav-cart-icon nav-sprite']]

        Wait Until Element Is Enabled   //input[@value='Delete']

        ${delete_buttons}=
        ...                     SeleniumLibrary.Get WebElements
        ...                     //input[@value='Delete']

        FOR    ${button}    IN    @{delete_buttons}
            Click Element           ${button}
        END

        Wait Until Page Contains  Your Amazon Cart is empty
        Log To Console  Cart from previous session has been emptied
    END

    ${refresh_current_page}=   Get Location

    Go To  ${refresh_current_page}

Click "Sign Out" Link
    Mouse Over  //a[@id='nav-link-accountList']
    Wait Until Element Is Visible   ${TOP_NAV_SIGNOUT_DROPDOWN_LINK}
    Click Element  ${TOP_NAV_SIGNOUT_DROPDOWN_LINK}
    Verify User Signed Out

Verify User Signed Out
    Wait Until Page Contains   Sign in
