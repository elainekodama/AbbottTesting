*** Settings ***
Documentation   UI Tests for LibreView
...             1. Open browser
...             2. Choose country and language
...             3. Log in
...             4. Send verification code
...             5. Verify and Log in button disabled
Test Setup      open browser
Test Teardown   Close Browser
Library         SeleniumLibrary
Resource        ../PO/resources.robot
Resource        ../PO/country-language.robot
Resource        ../PO/login.robot
Resource        ../PO/verification.robot


*** Test Cases ***
#Step 1: check if browser opens
#   manage choices
Manage Cookies
    country-language.cookies popup      ${manageCookies}
    #todo: deal with the manage cookies popup-- this fails
#    wait until element is visible       id: ta-overlay-content
#    click button                        id: pop-close05795951636713843
#    wait until element is not visible   id: ta-overlay-content
    element should be enabled           ${countryLangsubmit}
#   allow cookies
Allow Cookies
    country-language.cookies popup      ${acceptCookies}
#   reject cookies
Reject Cookies
    country-language.cookies popup      ${rejectCookies}
#   close cookies tab
Close Cookies
    country-language.cookies popup      ${xCookies}


#Step 2: country/region of residence, language, and submit
#   check if all elements are there
#Check for All Elements
#   resources.check elements           ${navbarelementids}     css:.align-items-center
#   resources.check elements           titles and text
#   resources.check elements           footer elements

#   correct country, correct language
Correct Country and Language
    country-language.load country and language
    select from list by value           ${selectCountryID}      ${correctCountry}
    select from list by value           ${selectLanguageID}     ${correctLanguage}
    click button                        ${countryLangsubmit}
    wait until element is visible       ${loginTitle}
    location should be                  ${mainURL}
    check if element text is correct    ${loginTitle}           ${corrTitleText}
    #check that the country and language are actually accurate
#   no country
Submit with No Country
    country-language.load country and language
    click button                        ${countryLangsubmit}
    resources.check if element text is correct    ${countryError}         ${countryErrorMessage}
    location should be                  ${countryLangURL}
#   check wrong country
    #should not use US standard units if not in US
#   check wrong language
Submit with Different Language
    country-language.load country and language
    select from list by value           ${selectLanguageID}     ${wrongLanguage}
    #should not be in English if English is not chosen
    resources.check if element text is correct    ${loginTitle}           ${incorrTitleText}



#Step 3: username, password, login
#   check if all elements are there
#Check for All Elements
#   resources.check elements           ${navbarelementids}     css:.align-items-center
#   resources.check elements           titles and text
#   resources.check elements           footer elements
#   no inputs
No Email or Password
    country-language.go to next page              ${loginTitle}
    click button                                  ${loginSubmit}
    resources.check if element text is correct   ${emailErrMessage}      ${requiredEmail}
    resources.check if element text is correct   ${passwordErrMessage}   ${requiredpassword}
#   click login with no email
No Email, Type Password
    country-language.go to next page    ${loginTitle}
    input text                          ${passwordTextField}   ${validPassword}
    #email error should pop up
    resources.check if element text is correct     ${emailErrMessage}     ${requiredEmail}
#    type email then click in and out of password
No Password, Type Email
    country-language.go to next page             ${loginTitle}
    input text                                   ${emailTextField}       ${validUsername}
    #click away somewhere random after clicking password text field
    click element                                ${passwordTextField}
    click element                                ${loginTitle}
    #email error should pop up
    resources.check if element text is correct  ${passwordErrMessage}   ${requiredpassword}
#   no @ sign, correct password
Invalid Email-- no '@'
    country-language.go to next page     ${loginTitle}
    login.invalid email                  ${noAtSign}
#   no .com, correct password
Invalid Email-- no '.'
    country-language.go to next page    ${loginTitle}
    login.invalid email                 ${noPeriod}
#   no @, no .com, correct password
Invalid Email-- no '@', '.'
    country-language.go to next page    ${loginTitle}
    login.invalid email                 ${noAtOrPeriod}
#   no outlook, correct password
Invalid Email-- no "outlook"
    country-language.go to next page    ${loginTitle}
    login.invalid email                 ${noOutlook}
#   correct email, wrong password
Correct email, wrong password
    country-language.go to next page             ${loginTitle}
    login.fill login                             ${valid_username}    ${wrongPassword}
    resources.check if element text is correct  ${loginErrMessage}   ${loginErrText}
#   correct email, password no caps
Correct email, password wrong caps
    country-language.go to next page             ${loginTitle}
    login.fill login                             ${valid_username}    ${noCaps}
    resources.check if element text is correct  ${loginErrMessage}   ${loginErrText}
#   correct email, correct password
Successful Login
    country-language.go to next page    ${loginTitle}
    login.fill login                    ${validUsername}   ${validPassword}
    wait until element is visible       ${AuthTitle}
    location should be                  ${authURL}



#Step 4/5: send verification code check the verify code page
#   check if all elements are there
#Check for All Elements
#   resources.check elements           ${navbarelementids}     css:.align-items-center
#   resources.check elements           titles and text
#   resources.check elements           footer elements
#   check log out button
Log Out
    country-language.go to next page    ${loginTitle}
    login.go to next page               ${authTitle}
    verification.log out                ${loginTitle}
#    select email from dropdown menu, check button disabled
Send Code to Email 1
    country-language.go to next page    ${loginTitle}
    login.go to next page               ${authTitle}
    verification.choose email to send   ${email1}
    verification.send code
    #check to see if the code actually went to the correct email
#    select email from dropdown menu, check button disabled
Send Code to Email 2
    country-language.go to next page    ${loginTitle}
    login.go to next page               ${authTitle}
    verification.choose email to send   ${email2}
    verification.send code
    #check to see if the code actually went to the correct email
#   check back button goes to send code page
Check Back Button
    country-language.go to next page    ${loginTitle}
    login.go to next page               ${authTitle}
    verification.send code
    verification.go back
