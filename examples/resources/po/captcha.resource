*** Settings ***
Library     Dialogs
Library     SeleniumLibrary
Resource    ../shared/global_vars.resource


*** Variables ***
${CAPTCHA_LEGEND}               //h4[normalize-space()='Enter the characters you see below']
${CAPTCHA_INPUT_TEXTBOX}        //input[@id='captchacharacters']
${CAPTCHA_BYPASS_LOOPHOLE}      //a[normalize-space()='Try different image']


*** Keywords ***
Handle Captcha If Present
    ${captcha_legend}=
    ...                     Run Keyword And Return Status
    ...                     Page Should Contain Element
    ...                     ${CAPTCHA_LEGEND}

    ${captcha_textbox}=
    ...                     Run Keyword And Return Status
    ...                     Page Should Contain Element
    ...                     ${CAPTCHA_INPUT_TEXTBOX}

    ${bypass_loophole}=
    ...                     Run Keyword And Return Status
    ...                     Page Should Contain Element
    ...                     ${CAPTCHA_BYPASS_LOOPHOLE}

    IF    ${captcha_legend} == ${TRUE} and ${captcha_textbox} == ${TRUE} and ${bypass_loophole} == ${TRUE}
        # By clicking on the link 'Try different image' you can bypass the captcha
        Click Element  ${CAPTCHA_BYPASS_LOOPHOLE}
    END

    # Captcha wasnt bypassed successfully
    IF    ${captcha_legend} == ${TRUE} and ${captcha_textbox} == ${TRUE} and ${bypass_loophole} == ${TRUE}
        Manually Enter Captcha
    END

Manually Enter Captcha
    Log  Waiting for manual captcha input
    Execute Manual Step      ${CAPTCHA_LEGEND}
