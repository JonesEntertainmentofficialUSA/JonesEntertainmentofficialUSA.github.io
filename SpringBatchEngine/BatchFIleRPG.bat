@echo off 
setlocal enableDelayedExpansion
chcp 65001 >nul
title BATCH FILE ADVENTURE
start "" powershell -WindowStyle Hidden -c "$p = New-Object Media.SoundPlayer 'C:\Users\!USERNAME!\OneDrive\Desktop\BATCH FILE ADVENTURE\Title-Screen-Batch-Adventure-Volt-Beam-Games.wav'; while($true){ $p.Play(); Start-Sleep -Milliseconds 500 }"
set true=1
set false=0
goto TitleScreen 
::goto import.Grid_25x25


:DEV_MODE
cls
@echo on 
start "C:\Users\!USERNAME!\OneDrive\Desktop\DEV-File.bat" 
echo        ENTERCODE: 
set /p Dev_code= 
if not !DEV_code! equ !PASS! exit
if !DEV_code! equ !PASS! goto DEV

:DEV_END
@echo off 
goto TitleScreen

:TitleScreen 
cls
echo                  BATCH FILE ADVENTURE! 
echo                   by Volt Beam Games
echo                  =====================
echo.
echo                  █████████████████████
echo                  █ --) NEW GAME      █
echo                  █     CONTINUE      █
echo                  █████████████████████
echo.
choice /c wsop /n
if !ERRORLEVEL! equ 1 goto ContinueOption
if !ERRORLEVEL! equ 2 goto ContinueOption
if !ERRORLEVEL! equ 3 goto New_Game
if !ERRORLEVEL! equ 4 goto DEV_MODE

:ContinueOption
cls
echo                  BATCH FILE ADVENTURE! 
echo                   by Volt Beam Games
echo                  =====================
echo.
echo                  █████████████████████
echo                  █     NEW GAME      █
echo                  █ --) CONTINUE      █
echo                  █████████████████████
echo.
choice /c wso /n
if !ERRORLEVEL! equ 1 goto TitleScreen
if !ERRORLEVEL! equ 2 goto TitleScreen
if !ERRORLEVEL! equ 3 goto Check_Oldfile


:New_Game                 
::New Game Variables Set
set /A "needEXP=!LV!*5"
set LV=1
set HP=100
set MAXHP=100
set SP=120
set MAXSP=120
set PWR=0
set DEF=0
set SPD=0
set $$$=0
set msgNum=0
set ttlNum=0
set kills=0
set ACC=10
set playerLoc=/(o_o)\
set pX=1
set pY=1
set offensive=Wooden_Sword
set s1=Wooden_Sword
set s2=????????
set s3=????????
set s4=????????
set s5=????????
set s6=????????
set s7=????????
cls
echo                                           ██████████████████████████████████████████████
echo                                           █  Ever since the demon king has arrived,    █
echo                                           █  demons have dominated the world. Humans   █
echo                                           █  now nothing more than slaves. (v)         █
echo                                           ██████████████████████████████████████████████
pause >nul
cls
echo                                           ██████████████████████████████████████████████
echo                                           █  Until, a hero from another world has      █
echo                                           █  appeared! It is up to you, to get enough   █
echo                                           █  power to defeat the demon king!   (v)      █
echo                                           ██████████████████████████████████████████████
pause >nul
color F0
ping localhost -n 1 >nul
color 0F 
goto name_maker

:save_file
cls 
echo             Save? 
echo. 
echo      Name: !name!
echo      Level: !LV! Credits: !$$$! 
echo      TIME: !TIME! -- !DATE!
echo.
echo            [Y/N]
choice /c yn /n 
if !ERRORLEVEL! equ 1 goto saving
if !ERRORLEVEL! equ 2 goto op_menu

:saving
echo.
echo     SAVING...
set SAVEFILE="C:\Users\%USERNAME%\OneDrive\Desktop\BATCH FILE ADVENTURE\BatchFileAdventureSaveFile.txt"
ping localhost -n 3 >nul
(
echo !name! 
echo !TIME! 
echo !DATE!
echo !LV!
echo !HP!
echo !MAXHP!
echo !SP!
echo !MAXSP!
echo !PWR!
echo !DEF!
echo !SPD!
echo !$$$!
echo !pX!
echo !pY!
echo !kills!
echo !ACC!
echo !playerLoc!
echo !offense!
echo !balance!
echo !defense!
echo !Special!
echo !s1!
echo !s2!
echo !s3!
echo !s4!
echo !s5!
echo !s6!
echo !s7!
)>BatchFileAdventureSaveFile.txt
cls
echo                      ████████████████
echo                      █    SAVED!     █
echo                      ████████████████
pause >nul
goto import.Grid_15x15

:Check_Oldfile
color FC
cls
echo                                --- Checking old file...
ping localhost -n 1 >nul
if exist "BatchFileAdventureSaveFile.txt" ( 
    goto next_fileCheck
) else (
    cls
    echo                                    *ERROR*
    echo                           --- No save file found.
    pause >nul
    goto TitleScreen
)

:next_fileCheck
(
set /p name= 
set /p LastTIME=
set /p LastDATE=
set /p LV=
set /p HP=
set /p MAXHP=
set /p SP=
set /p MAXSP=
set /p PWR=
set /p DEF=
set /p SPD=
set /p $$$=
set /p pX=
set /p pY=
set /p kills=
set /p ACC=
set /p playerLoc=
set /p offense=
set /p balance=
set /p defense=
set /p Special=
set /p s1=
set /p s2=
set /p s3=
set /p s4=
set /p s5=
set /p s6=
set /p s7=
)<BatchFileAdventureSaveFile.txt
cls
color F0
echo      Continue this file?
echo      NAME: !name! LV.!LV! 
echo       !LastTIME! -- !LastDATE!
echo       Credits: $!$$$!
pause >nul
goto import.Grid_15x15

:name_maker
cls
color F0    
echo                    ████████████████████
echo                    █WHAT IS YOUR NAME?█
echo                    ████████████████████
set max=6
::Makes sure the Player Name doesn't get above 6.
set /p input=[MAX CHAR: !max! ]: 
set "name=!input:~0,%max%!"
cls
echo                    ████████████████████
echo                    █SO YOUR NAME IS...█
echo                    ████████████████████
echo.
echo                          !name!    
echo.
echo     Is this okay? [Y/N]
choice /c yn /n 
if !ERRORLEVEL! equ 1 goto opening_start1
if !ERRORLEVEL! equ 2 goto name_maker

:opening_start1
set event=1
set msg_num=1
set char_num=1
set text_b=!true!
goto opening

:opening 
cls
if not !msg_num! geq 5 goto message_space
if !msg_num! equ 6 set text_b=!false!
if !msg_num! equ 5 set char_num=3
goto import.Grid_15x15




::Resets the menu pointer
:op_menu
set menu=TRUE
set rowNum=0
set row1=[@@@@]
set row2=[____]
set row3=[____]
set row4=[____]
set row5=[____]
goto import_Menu

:import_Menu
::Menu was simplified due to custom names, 
cls
echo     █ =======MENU========== █
echo     █ ITEM       !row1!     █
echo     █ EQUIPMENT  !row2!     █
echo     █ STATS      !row3!     █
echo     █ SAVE       !row4!     █
echo     █ EXIT MENU  !row5!     █
echo     █ ===================== █
echo        $!$$$!
echo        !name! - Level: !LV! - HEALTH !HP!/!MAXHP!
echo. 
choice /c wso /n 
if !ERRORLEVEL! equ 1 set /A "rowNum=!rowNum!-1"
if !ERRORLEVEL! equ 1 goto rowNumberCheck
if !ERRORLEVEL! equ 2 set /A "rowNum=!rowNum!+1"
if !ERRORLEVEL! equ 2 goto rowNumberCheck
if !ERRORLEVEL! equ 3 goto op_check

::Makes sure the menu pointer doesn't go off screen
:rowNumberCheck
if !rowNum! leq 0 set rowNum=5
if !rowNum! geq 5 set rowNum=0
goto extra_check

::Takes the row number and makes sure the menu pointer is in the  
::right spot.
:extra_check
::1st Choice
if !rowNum! equ 0 set row5=[____]
if !rowNum! equ 0 set row4=[____]
if !rowNum! equ 0 set row3=[____]
if !rowNum! equ 0 set row2=[____]
if !rowNum! equ 0 set row1=[@@@@]
::2nd Choice
if !rowNum! equ 1 set row5=[____]
if !rowNum! equ 1 set row4=[____]
if !rowNum! equ 1 set row3=[____]
if !rowNum! equ 1 set row1=[____]
if !rowNum! equ 1 set row2=[@@@@]
:: 3rd Choice
if !rowNum! equ 2 set row5=[____]
if !rowNum! equ 2 set row4=[____]
if !rowNum! equ 2 set row2=[____]
if !rowNum! equ 2 set row1=[____]
if !rowNum! equ 2 set row3=[@@@@]
::4th Choice
if !rowNum! equ 3 set row5=[____]
if !rowNum! equ 3 set row3=[____]
if !rowNum! equ 3 set row2=[____]
if !rowNum! equ 3 set row1=[____]
if !rowNum! equ 3 set row4=[@@@@]
::5th Choice
if !rowNum! equ 4 set row4=[____]
if !rowNum! equ 4 set row3=[____]
if !rowNum! equ 4 set row2=[____]
if !rowNum! equ 4 set row1=[____]
if !rowNum! equ 4 set row5=[@@@@]
goto import_Menu

:op_check
if !row1! equ [@@@@] goto ITEMS
if !row2! equ [@@@@] goto EQUIP
if !row3! equ [@@@@] goto STATS
if !row4! equ [@@@@] goto save_file
if !row5! equ [@@@@] set menu=FALSE
if !row5! equ [@@@@] goto import.Grid_15x15


:EQUIP
cls
:: ########################################
:: # Offense Varibles                     #
:: ########################################
::---------------
set w_sword_PWR=5
set s_sword_PWR=12
set b_sword_PWR=23
set c_sword_PWR=35
set e_sword_PWR=47
set h_sword_PWR=56
set uchigatana_PWR=70
:: --------------
:: #########################################
:: # Balansive Variables                   #
:: #########################################
set Bal-I=5
set Bal-II=12
set Bal-III=21
set Bal-IV=32
set Bal-V=45
set Bal-VI=60
set Bal-VII=77
rem --------------
::Checks if a certain sword is equipped or not.
if !offense! equ Wooden_Sword set /A "PWR=!PWR!+!w_sword_PWR!"
rem --------------
if !offense! equ Stone_Sword set /A "PWR=!PWR!+!s_sword_PWR!"
rem --------------
::
echo ███████████████████████████████████████████████████
echo  A: OFFENSIVE --- !offense! 
echo  B: BALANCIVE --- !balance! 
echo  C: DEFENSIVE --- !defense!
echo ███████████████████████████████████████████████████
echo  'P' to go Back
echo.
choice /c abcp /n
if !ERRORLEVEL! equ 1 goto change_offense
if !ERRORLEVEL! equ 2 goto change_balance
if !ERRORLEVEL! equ 3 goto change_defense
if !ERRORLEVEL! equ 4 goto op_menu

:change_offense 
echo SET WEAPON TO -
echo =====================
echo A - !s1!
echo B - !s2!
echo C - !s3!
echo D - !s4!
echo E - !s5!
echo F - !s6!
echo G - !s7!
set PWR=248
if not !offense! equ Wooden_Sword set /A "PWR=!PWR!-!w_sword_PWR!"
if not !offense! equ Stone_Sword set /A "PWR=!PWR!-!s_sword_PWR!"
if not !offense! equ Bastard_Sword set /A "PWR=!PWR!-!b_sword_PWR!"


:STATS
cls
echo ████████████████████████████████████████████████████████████████████████████████████████
echo █NAME-!name! 
echo ████████████████████████████████████████████████████████████████████████████████████████
echo █ LEVEL: !LV!
echo █ PWR !PWR!  
echo █ DEF !DEF!
echo █ SPD !SPD!
echo ████████████████████████████████████████████████████████████████████████████████████████
echo █ACC-!ACC!
echo ████████████████████████████████████████████████████████████████████████████████████████
pause 
goto op_menu



:ITEMS 
cls
echo  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo   PRESS   ITEM NAME         ITEM AMOUNT
echo     A -- Star Candy      -    !SCandies!
echo     B -- Energy Drink    -    !EDrinks!
echo     C -- Asteroid Candy  -    !ACandy!
echo     D -- Sword Sharpener -    !SSharpener!
echo  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo    PRESS a, b, c, or d to use item listed.
echo    =======================================
echo          PRESS 'P' to go back.
echo.
choice /c abcdp /n 
if !ERRORLEVEL! equ 1 goto check_Scandies
if !ERRORLEVEL! equ 2 goto check_Edrinks
if !ERRORLEVEL! equ 3 goto check_Acandies
if !ERRORLEVEL! equ 4 goto check_Ssharpener
if !ERRORLEVEL! equ 5 goto op_menu

:check_Scandies
if !SCandies! leq 0 goto Not_enough_item
set /A "SCandies=!SCandies!-1" 
set recover=300
goto function_recoverHP

:check_Edrinks
if !Edrinks! leq 0 goto Not_enough_item
set /A "Edrinks=!Edrinks!-1" 
set recover=300
goto function_recoverSP

:function_recoverSP
if !SP! geq !MAXSP! goto No_Effect
echo. 
echo     You recovered !recover! SOUL! (v)
echo.
pause >nul
set /A "SP=!SP!+!recover!"
if !SP! gtr !MAXSP! set SP=!MAXSP!
echo        !SP!/!MAXSP! 
pause >nul
if !battle! equ TRUE goto BATTLE_CHECK
if !menu! equ TRUE goto op_menu
if !menu! equ FALSE goto LOC_CHECK

:function_recoverHP
if !HP! geq !MAXHP! goto No_Effect
echo. 
echo     You recovered !recover! HEALTH! (v)
echo.
pause >nul
set /A "HP=!HP!+!recover!"
if !HP! gtr !MAXHP! set HP=!MAXHP!
echo        !HP!/!MAXHP! 
pause >nul
if !battle! equ TRUE goto BATTLE_CHECK
if !menu! equ TRUE goto op_menu
if !menu! equ FALSE goto LOC_CHECK

:No_Effect
echo. 
echo   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo   @ Since this STATUS is full, this    @
echo   @ item won't have any effect...   (v)@
echo   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo.
pause >nul
goto ITEMS

:Not_enough_item
echo. 
echo   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo   @ Seems you don't have this item. (v)@
echo   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo.
pause >nul
goto ITEMS


:message_space
::Start of the quest
if !char_num! equ 1 set character=????
if !char_num! equ 2 set character=Village-Chief
if !msg_num! equ 1 set text=!name!....Get Up.....Hurry.'.'
if !msg_num! equ 2 set text=So...You're finally awake...It seems we must start 
if !msg_num! equ 3 set text=your quest early....The Demon King has sent demons everywhere....
if !msg_num! equ 4 set text=You must go....
if !char_num! equ 3 set character=!name!
if !msg_num! equ 5 set text=Very well....I'll save everyone.

:text_box
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo !character!
echo ==+==+==+==+==+==
echo !text!
echo                              (v)
pause >nul 
if !text_b! equ 0 goto scene_end
if !text_b! equ 1 set /A "msg_num=!msg_num!+1"
if !text_b! equ 1 goto event_tracker

:event_tracker
if !event! equ 1 goto opening

:scene_end
goto import.Grid_15x15


:playerCollision
if !playerLoc! equ !obj! set /A "pY=!pY!-1"
goto import.Grid_15x15


:import.Grid_15x15
::Musics
::change music to .wav file.
::if !mus_num! equ 1 powershell -c "while($true){ $p = New-Object Media.SoundPlayer 'Title-Screen - Batch Adventure - Volt Beam Games.wav'; $p.PlaySync() }"
::if !mus_num! equ 2 powershell -c "while($true){ $p = New-Object Media.SoundPlayer 'Forest - Batch File Adventure - Volt Beam Games.wav'; $p.PlaySync() }"
::Displays every coordinate and makes sure there isn't an object in the way.
:: Loop through X = 1–15 and Y = 1–15
for /L %%x in (1,1,15) do (
    for /L %%y in (1,1,15) do (
        set "cell=X%%xY%%y"

        rem --- 1. Clear the cell ---
        set "!cell!=⛆⛆⛆⛆⛆⛆⛆"

        rem --- 2. Player placement ---
        if %%x==!pX! if %%y==!pY! (
            set "!cell!=!playerLoc!"
        )

        rem --- 3. Collision check ---
        if "!%cell%!"=="!obj!" goto playerCollision
    )
)

goto display_Grid
 
:display_Grid
cls
set /A "re=!re!+1"
if !re! equ 25 goto RandomEncounter
echo  ########################################################################################################
echo                                Level: !LV! -- $: !$$$!
echo                                HEALTH: !HP!/!MAXHP! : 
echo                                SOUL:   !SP!/!MAXSP! :
echo  ########################################################################################################
echo  ########################################################################################################
echo  @!X1Y1! !X2Y1! !X3Y1! !X4Y1! !X5Y1! !X6Y1! !X7Y1! !X8Y1! !X9Y1! !X10Y1! !X11Y1! !X12Y1! !X13Y1! !X14Y1! !X15Y1!@@@@@@@@@@@@@@@@@@@@
echo  @!X1Y2! !X2Y2! !X3Y2! !X4Y2! !X5Y2! !X6Y2! !X7Y2! !X8Y2! !X9Y2! !X10Y2! !X11Y2! !X12Y2! !X13Y2! !X14Y2! !X15Y2!@@@@@@@@@@@@@@@@@@@@
echo  @!X1Y3! !X2Y3! !X3Y3! !X4Y3! !X5Y3! !X6Y3! !X7Y3! !X8Y3! !X9Y3! !X10Y3! !X11Y3! !X12Y3! !X13Y3! !X14Y3! !X15Y3!⛆⛆⛆⛆⛆⛆⛆⛆⛆⛆⛆
echo  @!X1Y4! !X2Y4! !X3Y4! !X4Y4! !X5Y4! !X6Y4! !X7Y4! !X8Y4! !X9Y4! !X10Y4! !X11Y4! !X12Y4! !X13Y4! !X14Y4! !X15Y4!@@@@@@@@@@@@@@@@@@@@
echo  @!X1Y5! !X2Y5! !X3Y5! !X4Y5! !X5Y5! !X6Y5! !X7Y5! !X8Y5! !X9Y5! !X10Y5! !X11Y5! !X12Y5! !X13Y5! !X14Y5! !X15Y5!@@@@@@@@@@@@@@@@@@@@
echo  @!X1Y6! !X2Y6! !X3Y6! !X4Y6! !X5Y6! !X6Y6! !X7Y6! !X8Y6! !X9Y6! !X10Y6! !X11Y6! !X12Y6! !X13Y6! !X14Y6! !X15Y6!@@@@@@@@@@@@@@@@@@@@
echo  @!X1Y7! !X2Y7! !X3Y7! !X4Y7! !X5Y7! !X6Y7! !X7Y7! !X8Y7! !X9Y7! !X10Y7! !X11Y7! !X12Y7! !X13Y7! !X14Y7! !X15Y7!@@@@@@@@@@@@@@@@@@@@
echo  @!X1Y8! !X2Y8! !X3Y8! !X4Y8! !X5Y8! !X6Y8! !X7Y8! !X8Y8! !X9Y8! !X10Y8! !X11Y8! !X12Y8! !X13Y8! !X14Y8! !X15Y8!@@@@@@@@@@@@@@@@@@@@
echo  @!X1Y9! !X2Y9! !X3Y9! !X4Y9! !X5Y9! !X6Y9! !X7Y9! !X8Y9! !X9Y9! !X10Y9! !X11Y9! !X12Y9! !X13Y9! !X14Y9! !X15Y9!@@@@@@@@@@@@@@@@@@@@
echo  @!X1Y10! !X2Y10! !X3Y10! !X4Y10! !X5Y10! !X6Y10! !X7Y10! !X8Y10! !X9Y10! !X10Y10! !X11Y10! !X12Y10! !X13Y10! !X14Y10! !X15Y10!@@@@@@@@@@@@@@@@@@@@
echo  @!X1Y11! !X2Y11! !X3Y11! !X4Y11! !X5Y11! !X6Y11! !X7Y11! !X8Y11! !X9Y11! !X10Y11! !X11Y11! !X12Y11! !X13Y11! !X14Y11! !X15Y11!@@@@@@@@@@@@@@@@@@@@
echo  @!X1Y12! !X2Y12! !X3Y12! !X4Y12! !X5Y12! !X6Y12! !X7Y12! !X8Y12! !X9Y12! !X10Y12! !X11Y12! !X12Y12! !X13Y12! !X14Y12! !X15Y12!@@@@@@@@@@@@@@@@@@@@
echo  @!X1Y13! !X2Y13! !X3Y13! !X4Y13! !X5Y13! !X6Y13! !X7Y13! !X8Y13! !X9Y13! !X10Y13! !X11Y13! !X12Y13! !X13Y13! !X14Y13! !X15Y13!@@@@@@@@@@@@@@@@@@@@
echo  @!X1Y14! !X2Y14! !X3Y14! !X4Y14! !X5Y14! !X6Y14! !X7Y14! !X8Y14! !X9Y14! !X10Y14! !X11Y14! !X12Y14! !X13Y14! !X14Y14! !X15Y14!@@@@@@@@@@@@@@@@@@@@
echo  @!X1Y15! !X2Y15! !X3Y15! !X4Y15! !X5Y15! !X6Y15! !X7Y15! !X8Y15! !X9Y15! !X10Y15! !X11Y15! !X12Y15! !X13Y15! !X14Y15! !X15Y15!@@@@@@@@@@@@@@@@@@@@
echo  @~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~@@@@@@@@@@@@@@@@@@@@
choice /c wasdoi /n 
if !ERRORLEVEL! equ 1 set /A "pY=pY-1"
if !ERRORLEVEL! equ 1 if !pY! leq 0 set /A "pY=pY+1"
if !ERRORLEVEL! equ 1 goto import.Grid_15x15
:: ---------
if !ERRORLEVEL! equ 2 set /A "pX=pX-1"
if !ERRORLEVEL! equ 2 if !pX! leq 0 set /A "pX=pX+1"
if !ERRORLEVEL! equ 2 goto import.Grid_15x15
::
if !ERRORLEVEL! equ 3 set /A "pY=pY+1"
if !ERRORLEVEL! equ 3 if !pY! gtr 15 set /A "pY=pY-1"
if !ERRORLEVEL! equ 3 goto import.Grid_15x15
:: ---------
if !ERRORLEVEL! equ 4 set /A "pX=pX+1"
if !ERRORLEVEL! equ 4 if !pX! gtr 15 set /A "pX=pX-1"
if !ERRORLEVEL! equ 4 goto import.Grid_15x15
::
if !ERRORLEVEL! equ 5 goto event_check
::
if !ERRORLEVEL! equ 6 goto op_menu

goto import.Grid_15x15

:RandomEncounter
color 0F
ping localhost -n 1 >nul
color F0
ping localhost -n 1 >nul
color 0F
ping localhost -n 1 >nul
color F0
::change the first basic_battle back to rare after it is made
if !RANDOM! geq 7000 goto start_basic_battle
if !RANDOM! leq 5000 goto start_basic_battle
if !RANDOM! equ 6543 (
    goto start_LegendBattle
) else (
    goto start_basic_battle
)


:start_basic_battle
if !RANDOM! geq 7000 set ELV=5
if !RANDOM! leq 5000 set ELV=2
if !RANDOM! equ 6543 (
    set ELV=8
) else (
    set ELV=2
)
if !ELV! equ 2 set EHP=25
if !ELV! equ 2 set EATK=10
if !ELV! equ 2 set EDEF=5
if !ELV! equ 2 set EXP_gained=45
if !ELV! equ 2 set money_earned=20
::
if !ELV! equ 5 set EHP=90
if !ELV! equ 5 set EATK=25
if !ELV! equ 5 set EDEF=15
if !ELV! equ 5 set EXP_gained=85
if !ELV! equ 5 set money_earned=60
::
if !ELV! equ 8 set EHP=200
if !ELV! equ 8 set EATK=60
if !ELV! equ 8 set EDEF=37
if !ELV! equ 8 set EXP_gained=150
if !ELV! equ 8 set money_earned=125
goto basic_battle

:basic_battle 
cls
if !HP! leq 0 set Basic_battle_text=!name! was defeated...
if !EHP! leq 0 set Basic_battle_text=Battle is won! 
echo                                                                                  !name! -- LV.!LV! -- !HP! HEALTH -- !SP! SOUL
echo.
echo.
echo         ENEMY HP: !EHP! -- LV !ELV!
echo.
echo.
echo                                          █████████████████████████████████
echo                                       ███████████                 ███████████
echo                                       ███████████       ████      ███████████
echo                                       ███████████       ████      ███████████
echo                                       ███████████       ████      ███████████
echo                                       ███████████                 ███████████
echo                                          █████████████████████████████████
echo                                          ██VVVVVVVVVVVVVVVVVVVVVVVVVVVVV██
echo                                           ███████████████████████████████
echo                                          ██           ██          ██    ██ 
echo                                         ██           ██          ██      ██
echo                                         ██          ██            ██      ██
echo.
echo.
echo          ████████████████████████████████████████████████████████████████████████████████████████████████
echo.
echo            * !Basic_battle_text!
echo                                                  (v)
echo          ████████████████████████████████████████████████████████████████████████████████████████████████
pause >nul
if !HP! leq 0 goto game_over
if !EHP! leq 0 goto battle_over
if !basic_Turn! equ enemy goto enemy_turn[basic]
if !basic_Turn! equ player goto player_turn[basic]


:player_turn[basic]
::switches turn back to enemy.
set basic_Turn=enemy
echo          ██   YOUR TURN   ██
echo          ██ ------------- ██
echo          ██ W- ATTACK     ██
echo          ██ A- SCAN ENEMY ██
echo          ██ S- ITEM       ██
echo          ██ D- RUN        ██
echo          ███████████████████
choice /c wasd /n
if !ERRORLEVEL! equ 1 goto ATK_type 
if !ERRORLEVEL! equ 2 goto Basic_check-Battle
if !ERRORLEVEL! equ 3 goto Item_check_Basic
if !ERRORLEVEL! equ 4 goto run_away_Basic

:ATK_type
cls
echo ███████████████████████████████████████
echo  A - BASH                            
echo  B - !Special1!
echo  C - !Special2!
echo  D - !Special3!
echo ███████████████████████████████████████
echo K = Back
echo.
choice /c abcdk /n
if !ERRORLEVEL! equ 1 goto ATK_calc_basic
::
if !ERRORLEVEL! equ 2 set VerATK=1
::
if !ERRORLEVEL! equ 3 set VerATK=2
::
if !ERRORLEVEL! equ 4 set VerATK=3
::
if !ERRORLEVEL! equ 5 goto player_turn[basic]
goto ATK_calc_basic


:ATK_calc_basic 
set /A "atk_dmg=!EDEF!-!PWR!"
set /A "EHP=!EHP!-!atk_dmg!"
set Basic_battle_text=!name! attacks: !atk_dmg! was dealt.
goto basic_battle

:Basic_check-Battle
echo █████████████████████████████
echo ██  Level -- !ELV!             ██
echo ██  * Weak to HOLY attacks ██
echo █████████████████████████████
pause >nul
goto basic_battle


:enemy_turn[basic]
::Switches turn back to player
set basic_Turn=player
set /A "atk_dmg=!EATK!-!DEF!"
set /A "HP=!HP!-!atk_dmg!"
set Basic_battle_text=Enemy attacks !name!: !atk_dmg! was dealt.
goto basic_battle

:battle_over
cls
set /A "kills=!kills!+1"
echo       ██████████████████████████████████████████████████
echo       █                    RESULTS                     █
echo       ██████████████████████████████████████████████████
set /A "needEXP=!LV!*5"
if !kills! equ !needEXP! echo YOU LEVELED UP!!! 
if !kills! equ !needEXP! set /A "LV=!LV!+1"
if !kills! equ !needEXP! set /A "MAXHP=!MAXHP!*!LV!"
if !kills! equ !needEXP! set /A "MAXSP=!MAXSP!*!LV!"
if !kills! equ !needEXP! set /A "PWR=!PWR!*!LV!"
if !kills! equ !needEXP! set /A "DEF=!DEF!*!LV!"
if !kills! equ !needEXP! set /A "SPD=!SPD!*!LV!"
if !kills! equ !needEXP! set /A "ACC=!ACC!*!LV!"
::
echo        *Needed EXP = !needEXP!
echo.
echo       +!EXP_gained! to !LV! 
echo       +$!money_earned! to $!$$$!
echo.
pause >nul 
set re=0
goto import.Grid_15x15


:game_over
cls
color 0C
echo                                           GAME OVER.

ping localhost
