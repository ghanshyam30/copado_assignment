*** Settings ***
Documentation           Open the shop website purchase something and validate its price
Library                 QWeb
Resource                ../resources/BaseKeywords.robot
Variables               ../resources/variables.py
Suite Setup             Open Browser    about:blank    ${BROWSER}
Suite Teardown          Close All Browsers

*** Variables ***
# ${T_SHIRT_TO_PURCHASE}        Gerald the Giraffe
${BROWSER}                    Chrome

*** Test Cases ***
Purchase The Shirt
    [Documentation]     Open shop website
    [Tags]              Temp
    Appstate            Open Website Page                    ${SHOP_PAGE_URL}
    VerifyText          Find your spirit animal
    Find If The Shirt Is Available                           ${T_SHIRT_TO_PURCHASE}
    LogScreenshot
    ${ITEM_PRICE}=      Get The Price Of Shirt               ${T_SHIRT_TO_PURCHASE}
    Choose The Shirt    ${T_SHIRT_TO_PURCHASE}
    ClickElement        //button[contains(text(),'Add to cart')]
    VerifyElement       //*[contains(text(),'Cart summary')]
    VerifyElement       //div[@class\='snipcart-item-quantity__total-price snipcart__font--bold snipcart__font--secondary']
    ${CART_TOTOAL}=     Get Cart Total
    LogScreenshot
    Should Be Equal     ${CART_TOTOAL}                       ${ITEM_PRICE}

Test Copado Platform
    [Documentation]    Test the copado platform like enable the recording and run the tests
    [Tags]             Problem
    Appstate           Open Website Page    ${COPADO_PLATFORM}
    VerifyElement      //img[@title\='Copado Robotic Testing']        timeout=10
    TypeText           email             ghana.bambale@gmail.com
    # TypeSecret        password          ${my_pass}
    TypeText           password          Bitch@001
    ClickElement       //button/span[.\='LOGIN']
    VerifyElement      //div/img[@alt\='Copado Robotic Testing']        timeout=10
    VerifyText         Projects
    ClickElement       //h4[.\='Projects']/following-sibling::a[.\='View']        timeout=10
    VerifyText         Projects
    VerifyText         Ghansham's project
    ClickElement       //td/a[.\="Ghansham's project"]/ancestor::tr/td/a[contains(@id,"Manage Ghansham's project")]
    VerifyElement      //h5/span[contains(text(),"Ghansham's project")]           timeout=10
    ClickElement       //a[@id\='robots-link']
    VerifyText         My robot
    VerifyText         Custom starter suite
    ClickElement       //a[contains(text(),'Custom starter suite')]/ancestor::div[contains(@class,'list-group-item-action')]/div[@class\='controls ng-star-inserted']/a
    VerifyText         Suite details                        timeout=20
    ${RECORDING_STATUS}=                        Get Text                        //li/p[text()\='Video recording']/following-sibling::p
    ClickElement       //button[@ngbtooltip\='Edit suite']                    # Could have used ClickIcon
    VerifyText         Edit suite
    VerifyText         Video streaming & recording
    DropDown           streamAndRecord                        [[1]]
    LogScreenshot
    # ${RECORDING_STATUS}=                        Get Text                        //select[@id\='streamAndRecord']
    ClickElement       //button[@type\='submit' and contains(text(),"Save")]
    VerifyText         Custom starter suite
    VerifyText         Advanced options                       10
    DropDown           record                        [[1]]
    LogScreenshot
    DropDown           stream                        [[1]]
    LogScreenshot
    ClickElement       //button[@id\='suite-run-btn']
    SwitchWindow       NEW
    LogScreenshot
    #SelectElement     All