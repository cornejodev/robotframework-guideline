*** Settings ***
Library     SeleniumLibrary
Resource    captcha.resource
Resource    top_nav.resource


*** Variables ***
${SIGNIN_HEADER_LABEL}                          Sign in
${SIGNIN_EMAIL_TEXTBOX}                         //input[@id='ap_email']
${SIGNIN_PASSWORD_TEXTBOX}                      //input[@id='ap_password']
${SIGNIN_CONTINUE_BUTTON}                       //input[@id='continue']
${SIGNIN_SUBMIT_BUTTON}                         //input[@id='signInSubmit']
${SIGNOUT_BUTTON}                               //span[normalize-space()='Sign Out']

# Security guards from site
${EXTRA_SECURITY_STEP_PHONE_LABEL}              Keep hackers out
${EXTRA_SECURITY_STEP_PHONE_NOT_NOW_LINK}       //a[@id='ap-account-fixup-phone-skip-link']
${EXTRA_SECURITY_STEP_PUZZLE_LABEL}             Solve this puzzle to protect your account

# BUG
${USER_ALREADY_LOGGED_IN_URL}                   https://www.amazon.com/gp


*** Keywords ***
Login With Valid Credentials
    [Arguments]   ${email}   ${password}

    Click "Sign In" Link
    Verify Page Loaded
    Fill "Email" Field      ${email}
    Click "Continue" Button

    Fill "Password" Field    ${password}

    Click "Signin" Button To Access Account
    Handle Extra Security Step If Present
    Verify "Home" Page Has Loaded With User Info

Verify Page Loaded
#    Location Should Contain    ${SIGNIN_URL}
    Wait Until Page Contains
    ...                     ${SIGNIN_HEADER_LABEL}

Fill "Email" Field
    [Arguments]             ${email}
    Input Text
    ...                     ${SIGNIN_EMAIL_TEXTBOX}
    ...                     ${email}

Fill "Password" Field
    [Arguments]             ${password}
    Input Text
    ...                     ${SIGNIN_PASSWORD_TEXTBOX}
    ...                     ${password}

Click "Signin" Button To Access Account
    Click Button
    ...                     ${SIGNIN_SUBMIT_BUTTON}

Click "Continue" Button
    Click Button
    ...                     ${SIGNIN_CONTINUE_BUTTON}

Handle Extra Security Step If Present
    #    Add phone number for enhanced security page
    ${extra_security_step_phone_present}=
    ...                     Run Keyword And Return Status
    ...                     Page Should Contain
    ...                     ${EXTRA_SECURITY_STEP_PHONE_LABEL}

    IF    '${extra_security_step_phone_present}'=='True'
        Click "Not Now" Link For Phone Security Step
    END

    #    Solve puzzle
    ${extra_security_step_puzzle_present}=
    ...                     Run Keyword And Return Status
    ...                     Page Should Contain
    ...                     ${EXTRA_SECURITY_STEP_PUZZLE_LABEL}

    IF    '${extra_security_step_puzzle_present}'=='True'
        Manually Solve Puzzle
    END

Click "Not Now" Link For Phone Security Step
    Click Element   ${EXTRA_SECURITY_STEP_PHONE_NOT_NOW_LINK}

Manually Solve Puzzle
    Log  Waiting for user to manually solve puzzle
    Execute Manual Step  ${EXTRA_SECURITY_STEP_PUZZLE_LABEL}

Verify "Home" Page Has Loaded With User Info
    # Note: Replace this with your own profile name
    # replace with your profile username
    Page Should Contain  Hello, <your_name>
