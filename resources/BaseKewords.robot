*** Settings ***
Library                 QWeb

*** Variables ***
${T_SHIRT_LOCATOR}          ''
${PRICE_LOCATOR}            ''
${TOTAL_LOCATOR}            //span[text()='Total']/following-sibling::span
*** Keywords ***
Open Shop Page
        [Documentation]        Open the URL and check if main content is present
        [Tags]                 Smoke
        GoTo                   https://qentinelqi.github.io/shop/
        VerifyText             Find your spirit animal

Find If The Shirt Is Available
        [Documentation]        Accepts the name of Tshirt that user may wish to purchase and returns true if present
        [Arguments]            ${T_SHIRT_NAME}
        ${T_SHIRT_LOCATOR}=    Set Variable        //li/div[@class='product-details']/descendant::a[text()='${T_SHIRT_NAME}']
        VerifyElement          ${T_SHIRT_LOCATOR}       20   #waits 20 seconds

Get The Price Of Shirt
        [Documentation]        Accepts Shirt name and returns Price
        [Arguments]            ${T_SHIRT_NAME}
        ${PRICE_LOCATOR}       Set Variable        //li/div[@class='product-details']/descendant::a[text()='${T_SHIRT_NAME}']/ancestor::div/p
        VerifyElement          ${PRICE_LOCATOR}       20   #waits 20 seconds
        ${PRICE_OF_SHIRT}      GetText                ${PRICE_LOCATOR}
        [Return]               ${PRICE_OF_SHIRT}

Choose The Shirt
        [Documentation]        Accepts the shirt tha user may wish to purchase and clicks it to see more details
        [Arguments]            ${T_SHIRT_NAME}
        VerifyText             Gerald the Giraffe        timeout=20
        ClickElement           ${T_SHIRT_LOCATOR}

Get Cart Total
        [Documentation]        This keyword will simply find the total of cart and will return it back to test
        ${TOTAL_VALUE}=        GetText                ${TOTAL_LOCATOR}
        [Return]               ${TOTAL_VALUE}