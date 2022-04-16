*** Settings ***
Documentation  Page objects and keywords for the cookies popup and the country/language selection page
Library        SeleniumLibrary
Resource       ../PO/resources.robot

*** Variables ***
${countryLangURL}           https://www.libreview.com/chooseCountryLanguage
#cookies
${manageCookies}            id:truste-show-consent
${acceptCookies}            id:truste-consent-button
${rejectCookies}            id:truste-consent-required
${xcookies}                 id:truste-consent-close
#country and language
${dropdownMenus}            css:.floating-label
${selectCountryID}          id:country-select
${countryError}             id:country-select-error-text
${countryErrorMessage}      You must select a Country / Region of Residence
${selectLanguageID}         id:language-select
${countryLangsubmit}        id:submit-button


*** Keywords ***
cookies popup
    [Arguments]     ${cookiesElement}
    #cookies
    page should contain button      ${manageCookies}
    page should contain button      ${acceptCookies}
    page should contain button      ${rejectCookies}
    page should contain element     ${xcookies}
    click element                   ${cookiesElement}
    wait until element is visible   ${countryLangsubmit}
    element should be enabled       ${countryLangsubmit}

pass cookies
    click element    ${acceptCookies}

load country and language
    #go to country/language selections
    pass cookies
    wait until element is visible   ${dropdownMenus}
    location should be              ${countryLangURL}

go to next page
    [Arguments]      ${title}
    #go straight to login page
    load country and language
    select from list by value       ${selectCountryID}       ${correctCountry}
    select from list by value       ${selectLanguageID}      ${correctLanguage}
    click button                    ${countryLangsubmit}
    wait until element is visible   ${title}