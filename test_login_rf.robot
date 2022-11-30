*** Settings ***
Library     SeleniumLibrary
Documentation    Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/en
${BROWSER}      Chrome
${SIGNINBUTTON}     xpath=//button[@type='submit']
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${PAGELOGO}     xpath=//*[@id="__next"]/div[1]/main/div[3]/div[1]/div/div[1]
${ADDPLAYER}        xpath=//div[2]/div/div/a/button/span[1]
${PLAYERSEMAIL}     xpath=//div[1]/div/div/input
${PLAYERSNAME}      xpath=//div[2]/div/div/input
${PLAYERSSURNAME}       xpath=//div[3]/div/div/input
${PLAYERSPHONE}     xpath=//div[4]/div/div/input
${PLAYERSWEIGHT}        xpath=//div[5]/div/div/input
${PLAYERSLEGDROPDOWN}       xpath=//*[@id='mui-component-select-leg']
${RIGHTLEG}     xpath=//*[@id='menu-leg']/div[3]/ul/li[1]
${LEFTLEG}      xpath=//*[@id='menu-leg']/div[3]/ul/li[2]
${PLAYERSAGE}       xpath=//div[7]/div/div/input
${PLAYERSMAINPOSITION}      xpath=//div[11]/div/div/input
${SUBMITBUTTON}         xpath=//div[3]/button[1]
${IDENTIFIERORPASSWORDINVALID}      xpath=//div[1]/div[3]/span
${PLAYERADDED}     xpath=//*[contains(text(), 'Added player.')]
${LANGUAGESELECTOR}     xpath=//ul[2]/div[1]/div[2]/span
${FIELDALERT}       xpath=//*[contains(text(), 'Required')]
${CANNOTADDPLAYER}      xpath=//*[contains(text(), 'Cannot add player.')]

*** Test Cases ***
Log in to the system
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Assert dashboard
    Close browser

Add a player
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Assert dashboard
    Click Add player button
    Type in player's email
    Type in player's name
    Type in player's surname
    Type in player's phone
    Type in player's weight
    Select player's leg
    Type in player's age
    Type in player's main position
    Click Submit button
    Check that player is added
    Close browser

Login to the system with invalid credentials
    Open login page
    Type in invalid email
    Type in invalid password
    Click on the submit button
    Check Identifier or password invalid message
   Close browser

Changing the language of the dashboard
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Assert dashboard
    Click on the language button
    Assert language
    Close browser

Adding a player to the database without a name
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Assert dashboard
    Click Add player button
    Type in player's email
    Don't type in player's name
    Type in player's surname
    Type in player's phone
    Type in player's weight
    Select player's leg
    Type in player's age
    Type in player's main position
    Click Submit button
    Check field alert
    Close browser

Adding a player to the database with invalid age
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Assert dashboard
    Click Add player button
    Type in player's email
    Type in player's name
    Type in player's surname
    Type in player's phone
    Type in player's weight
    Select player's leg
    Type in player's invalid age
    Type in player's main position
    Click Submit button
    Check that player is not added
    Close browser

*** Keywords ***
Open login page
    Open Browser   ${LOGIN URL}     ${BROWSER}
    Title Should Be     Scouts panel - sign in
Type in email
    Input Text   ${EMAILINPUT}   user01@getnada.com
Type in invalid email
    Input Text   ${EMAILINPUT}   user01@getnada2.com
Type in password
    Input Text   ${PASSWORDINPUT}   Test-1234
Type in invalid password
    Input Text   ${PASSWORDINPUT}   Test-4321
Click on the submit button
    Click element   xpath=//button[@type='submit']
Assert dashboard
    Wait until element is visible   ${PAGELOGO}
    Title Should Be     Scouts panel
    Capture Page Screenshot     alert.png
Click Add player button
    Click element   xpath=//div[2]/div/div/a/button/span[1]
Type in player's email
    Input Text  ${PLAYERSEMAIL}     1234@gmail.com
Type in player's name
    Input Text  ${PLAYERSNAME}      A
Don't type in player's name
    Click element  ${PLAYERSNAME}
Type in player's surname
    Input Text  ${PLAYERSSURNAME}       B
Type in player's phone
    Input Text  ${PLAYERSPHONE}     12345678
Type in player's weight
    Input Text  ${PLAYERSWEIGHT}        80
Select player's leg
    Click element   xpath=//*[@id='mui-component-select-leg']
    Click element   xpath=//*[@id='menu-leg']/div[3]/ul/li[1]
Type in player's age
    Input Text  ${PLAYERSAGE}       10102000
Type in player's invalid age
    Input Text  ${PLAYERSAGE}    1010100000
Type in player's main position
    Input Text  ${PLAYERSMAINPOSITION}      goalkeeper
Click Submit button
    Click element   xpath=//div[3]/button[1]
Check that player is added
    Wait until element is visible       ${PLAYERADDED}
Check Identifier or password invalid message
    Wait until element is visible   ${IDENTIFIERORPASSWORDINVALID}
Click on the language button
    Click element       ${LANGUAGESELECTOR}
Assert language
    Element Text Should Be   ${LANGUAGESELECTOR}    English
Check field alert
    Wait until element is visible       ${FIELDALERT}
Check that player is not added
    Wait until element is visible       ${CANNOTADDPLAYER}


