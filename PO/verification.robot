*** Settings ***
Documentation   Page objects and keywords for the cookies popup and the country/language selection page
Library         SeleniumLibrary
Resource        ../PO/resources.robot

*** Variables ***
#get authorization code
${authURL}              https://www.libreview.com/auth/finishlogin
${authTitle}            id:wizardCard-header-text
${emailDropdownID}      id:2fa-method-select
${email1}               email_1
${email2}               email_2
${logOutButton}         id:twoFactor-step1-back-button
${sendCodeButton}       id:twoFactor-step1-next-button
#enter authorization code
${enterCodeTitle}       id:twoFactor-step2-enterYourCode-text
${codeTextField}        id:twoFactor-step2-code-input
${verifyCodeButton}     id:twoFactor-step2-next-button
${goBackButton}         id:twoFactor-step2-back-button
${verifyCodeErrText}    id:twoFactor-step2-code-input-error-text
${noCodeErr}            Verification code is required
${invalidCodeErr}       Please enter the correct security code
${invalidCode}          00000
${wrongCode}            666666

*** Keywords ***
log out
    [Arguments]     ${title}
    click button                    ${logOutButton}
    wait until element is visible   ${title}
    location should be              ${mainURL}
choose email to send
    [Arguments]     ${email}
    select from list by value       ${emailDropdownID}    ${email}
send code
    click button                    ${sendCodeButton}
    wait until element is visible   ${enterCodeTitle}
    element should be disabled      ${verifyCodeButton}
go back
    click button                    ${goBackButton}
    wait until element is visible   ${authTitle}
    location should be              ${authURL}
#no code is entered yet
no verification code
    click element                                 ${codeTextField}
    click element                                 ${enterCodeTitle}     #click away
    resources.check if error message is correct   ${verifyCodeErrText}  ${noCodeErr}
    element should be disabled                    ${verifyCodeButton}
#code is not enough digits
invalid verification code
    input text                                    ${codeTextField}    ${invalidCode}
    click element                                 ${enterCodeTitle}   #click away
    resources.check if error message is correct   ${verifyCodeErrText}     ${invalidCodeErr}
    element should be disabled                    ${verifyCodeButton}
#code is just wrong
wrong verification code
    element should be disabled                    ${verifyCodeButton}
    input text                                    ${codeTextField}        ${wrongCode}
    element should be enabled                     ${verifyCodeButton}
    click button                                  ${verifyCodeButton}
    resources.check if error message is correct   ${verifyCodeErrText}    ${invalidCodeErr}