*** Settings ***
Documentation   Validate the LibreView login
Library         SeleniumLibrary

*** Variables ***
#INPUT TESTS

${mainURL}           https://www.libreview.com/
${browser}           Chrome
${driverPath}        /Users/elainekodama/Desktop/Abbott-Tests/chromedriver

${validUsername}     codechallengeadc@outlook.com
${validPassword}     P@ssword$12
#invalid emails
${noAtSign}          codechallengeadcoutlook
${noPeriod}          codechallengeadc@outlookcom
${noAtOrPeriod}      codechallengeadcoutlookcom
${noOutlook}         codechallengeadc@com
#invalid passwords
${wrongPassword}     wrong password
${noCaps}            p@ssword$1234

${correctCountry}    US
${correctLanguage}   en-US

*** Keywords ***
open browser
    Create Webdriver    ${browser}  executable_path=${driverPath}
    Go to               ${mainURL}

check if error message is correct
    [Arguments]      ${element}     ${text}
    wait until element is visible   ${element}
    element text should be          ${element}  ${text}