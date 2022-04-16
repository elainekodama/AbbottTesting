*** Settings ***
Documentation   Page objects and keywords for the cookies popup and the country/language selection page
Library         SeleniumLibrary
Resource        ../PO/resources.robot

*** Variables ***
${loginTitle}            id:login-title-text
${emailTextField}        id: loginForm-email-input
${passwordTextField}     id: loginForm-password-input
${loginSubmit}           id: loginForm-submit-button
${emailErrMessage}       id:loginForm-email-input-error-text
${requiredEmail}         Email address is required
${invalidEmail}          Email address is invalid
${passwordErrMessage}    id:loginForm-password-input-error-text
${requiredPassword}      Password is required
${loginErrMessage}       id:error-message-text
${loginErrText}          There was a problem with your email/password combination. Please try again.


*** Keywords ***

fill login
    [Arguments]     ${username}     ${password}
    #fill text fields and submit
    input text      ${emailTextField}       ${username}
    input password  ${passwordTextField}    ${password}
    click button    ${loginSubmit}

#click password, then email, then type in password
invalid email
    [Arguments]     ${emailInput}
    input text                          ${emailTextField}       ${emailInput}
    #click password, then go back to email
    click element                       ${passwordTextField}
    check if error message is correct   ${emailErrMessage}      ${invalidEmail}
    click element                       ${emailTextField}
    check if error message is correct   ${passwordErrMessage}   ${requiredpassword}
    #enter password, check that email is still invalid
    input text                          ${passwordTextField}    ${validPassword}
    check if error message is correct   ${emailErrMessage}      ${invalidEmail}

go to next page
    [Arguments]     ${title}
    input text      ${emailTextField}       ${validUsername}
    input password  ${passwordTextField}    ${validPassword}
    click button    ${loginSubmit}
    wait until element is visible  ${title}