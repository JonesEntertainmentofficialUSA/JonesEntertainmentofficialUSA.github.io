@echo off
setlocal enableDelayedExpansion
set name=Game
chcp 65001 >nul
:: event reset
set imgName=picture
set obj=
set event.main=0
set starting=false
set event1=false
set DEBUG=true
set dbg.loopCount=0
set dbg.lastLabel=
set dbg.maxLoops=50
::                                        Future Updates -- Every other Month.
::                                        Completely run with Batch and Powershell. 
::                                                   VERSION 1.0.0
echo                                            -- SpringBatch Engine --
ping localhost -n 2 >nul
goto restore

:restore 
set pX=1
set pY=1
set eX=0
set eY=0
set playerLoc=/(0_0)\
set eventNum=0
if !restoring!==v1 set restoreRequest=false
if !restoring!==v1 goto main.GridSet 
goto titlescreen 

:music
set music=%~1
if !mus! equ 0 exit /b
if defined music if exist "%~dp0!music!" (
    powershell -c "(New-Object Media.SoundPlayer '%~dp0!music!').PlaySync()"
)
exit /b


:display_Image
set image=%~1
:: Path to your image (PNG, JPG, GIF, etc.)
set "imgPath=%~dp0!image!"
:: Creates the HTA file
(
echo ^<html^>
echo ^<head^>
echo ^<title^>!imgName!^</title^>
echo ^<HTA:APPLICATION
echo     ID="ImageViewer"
echo     BORDER="none"
echo     SCROLL="no"
echo     SINGLEINSTANCE="yes"
echo     WINDOWSTATE="normal"
echo /^>
echo ^</head^>
echo ^<body style="margin:0; background-color:black;"^>
echo ^<img src="!imgPath!" style="display:block; margin:auto;"^>^</img^>
echo ^</body^>
echo ^</html^>
) > "%~dp0showImage.hta"
:: Launch the HTA
start "" "%~dp0showImage.hta"
pause >nul

:: Close the HTA window by its title
taskkill /FI "WINDOWTITLE eq !imgName!" /T /F >nul 2>&1
exit /b

::Event Labels

:eraseEvent
set eventLocalSpire=0
set event1=false
set eventLocal=
set event.main=0
set eve=
set eX=0
set eY=0
set event_trigger=
set import.event=false
exit /b


:create_event
set eventLocalSpire=1
set event.main=1
set import.event=true
exit /b

:eventCheck
set eventLocalSpire=0
if !event_trigger!==action_button goto event_action
if !event_trigger!==player_touch goto event_touch
if !event_trigger!==autorun goto event_cutscene
goto main.GridSet

:event_action
set /A "diff=!eX!-!pX!"
set /A "diffT=!eY!-!pY!"
if !diff!==1 if !diffT!==0 set eventLocal=true
if !diff!==-1 if !diffT!==0 set eventLocal=true
goto trigger_action


:event_touch
set /A "diff=!eX!-!pX!"
set /A "diffT=!eY!-!pY!"
if !diff!==1 if !diffT!==0 set eventLocal=true
if !diff!==-1 if !diffT!==0 set eventLocal=true
if defined eventLocal goto event
::Place the event here that it will go to. 
goto main.GridSet

:screen_color
set Bg_color=%~1
set Fg_color=%~2
color !Bg_color!!Fg_color!
exit /b


:loading_Screen 
set tip=SpringBatchEngine -- Access the code inorder to make changes to the engine!
::This function can't be called, only sent to.
::Here you can put important info, you can even create a new variable to change the tip depending on a condition!
cls 
echo                         TIP:
echo                         !tip!
ping localhost -n 3 >nul 
set restoring=v1
goto restore


:flash_Screen
call :screen_color F0
call :screen_color 0F
exit /b

::Triggered automatically
:event_cutscene 
:: For screen color, F = White(Background), 0 = Black(ASCII) (for :screen_color arguments.)
call :screen_color F0 
:: Cutscenes work a little differently. The event data is stored here, and depending on which event.main number it is, 
:: it will play that event
rem                        This is a piece of text that the event causes. 
rem                         V          * It can be changed, and you can also use one of rhe provided plug-ins to have a text box.
:: Example code -- call textBox*Plugin*.bat "Hello world!"
rem 
if !event.main! equ 1 echo NPC1 --) "Hello world!"
if !event.main! equ 1 echo NPC1 --) "Open edit to open the engine!"
pause >nul
call :eraseEvent
goto main.GridSet


::Triggered by action button
:trigger_action
choice /c wasdo /n 
if !ERRORLEVEL! equ 1 set /A "pY=pY-1"
if !ERRORLEVEL! equ 1 if !pY! leq 0 set /A "pY=pY+1"
if !ERRORLEVEL! equ 1 goto main.GridSet
:: ---------
if !ERRORLEVEL! equ 2 set /A "pX=pX-1"
if !ERRORLEVEL! equ 2 if !pX! leq 0 set /A "pX=pX+1"
if !ERRORLEVEL! equ 2 goto main.GridSet
::
if !ERRORLEVEL! equ 3 set /A "pY=pY+1"
if !ERRORLEVEL! equ 3 if !pY! gtr 15 set /A "pY=pY-1"
if !ERRORLEVEL! equ 3 goto main.GridSet 
:: ---------
if !ERRORLEVEL! equ 4 set /A "pX=pX+1"
if !ERRORLEVEL! equ 4 if !pX! gtr 15 set /A "pX=pX-1"
if !ERRORLEVEL! equ 4 goto main.GridSet
:: ---------
if !ERRORLEVEL! equ 5 if !event.main! gtr 0 goto event


::Grid Labels

:playerCollision
if !playerLoc! equ !obj! set /A "pY=!pY!-1"
goto main.GridSet


:main.GridSet 
::call :DEBUG_GUARD main.GridSet
for /L %%x in (1,1,15) do (
    for /L %%y in (1,1,15) do (
        set "cell=X%%xY%%y"

        rem --- 1. Clear the cell ---
        set "!cell!=⛆⛆⛆⛆⛆⛆⛆"

        rem --- 2. Player placement ---
        if %%x==!pX! if %%y==!pY! (
            set "!cell!=!playerLoc!"
        )
		rem --- Event Placement ---
        if %%x==!eX! if %%y==!eY! (
			set "!cell!=!eve!"
	    )
        rem --- 3. Collision check ---
        if "!%%cell%%!"=="!obj!" goto playerCollision
    )
)
goto display_Grid

:display_Grid
::call :DEBUG_GUARD display_Grid
::cls
::if !event1!==true if !eventLocalSpire! equ 1 if !event.main! gtr 0 (
::    set event1=false
::    set eventLocalSpire=0
::    goto event
::)
echo  !X1Y1! !X2Y1! !X3Y1! !X4Y1! !X5Y1! !X6Y1! !X7Y1! !X8Y1! !X9Y1! !X10Y1! !X11Y1! !X12Y1! !X13Y1! !X14Y1! !X15Y1!
echo  !X1Y2! !X2Y2! !X3Y2! !X4Y2! !X5Y2! !X6Y2! !X7Y2! !X8Y2! !X9Y2! !X10Y2! !X11Y2! !X12Y2! !X13Y2! !X14Y2! !X15Y2!
echo  !X1Y3! !X2Y3! !X3Y3! !X4Y3! !X5Y3! !X6Y3! !X7Y3! !X8Y3! !X9Y3! !X10Y3! !X11Y3! !X12Y3! !X13Y3! !X14Y3! !X15Y3!
echo  !X1Y4! !X2Y4! !X3Y4! !X4Y4! !X5Y4! !X6Y4! !X7Y4! !X8Y4! !X9Y4! !X10Y4! !X11Y4! !X12Y4! !X13Y4! !X14Y4! !X15Y4!
echo  !X1Y5! !X2Y5! !X3Y5! !X4Y5! !X5Y5! !X6Y5! !X7Y5! !X8Y5! !X9Y5! !X10Y5! !X11Y5! !X12Y5! !X13Y5! !X14Y5! !X15Y5!
echo  !X1Y6! !X2Y6! !X3Y6! !X4Y6! !X5Y6! !X6Y6! !X7Y6! !X8Y6! !X9Y6! !X10Y6! !X11Y6! !X12Y6! !X13Y6! !X14Y6! !X15Y6!
echo  !X1Y7! !X2Y7! !X3Y7! !X4Y7! !X5Y7! !X6Y7! !X7Y7! !X8Y7! !X9Y7! !X10Y7! !X11Y7! !X12Y7! !X13Y7! !X14Y7! !X15Y7!
echo  !X1Y8! !X2Y8! !X3Y8! !X4Y8! !X5Y8! !X6Y8! !X7Y8! !X8Y8! !X9Y8! !X10Y8! !X11Y8! !X12Y8! !X13Y8! !X14Y8! !X15Y8!
echo  !X1Y9! !X2Y9! !X3Y9! !X4Y9! !X5Y9! !X6Y9! !X7Y9! !X8Y9! !X9Y9! !X10Y9! !X11Y9! !X12Y9! !X13Y9! !X14Y9! !X15Y9!
echo  !X1Y10! !X2Y10! !X3Y10! !X4Y10! !X5Y10! !X6Y10! !X7Y10! !X8Y10! !X9Y10! !X10Y10! !X11Y10! !X12Y10! !X13Y10! !X14Y10! !X15Y10!
echo  !X1Y11! !X2Y11! !X3Y11! !X4Y11! !X5Y11! !X6Y11! !X7Y11! !X8Y11! !X9Y11! !X10Y11! !X11Y11! !X12Y11! !X13Y11! !X14Y11! !X15Y11!
echo  !X1Y12! !X2Y12! !X3Y12! !X4Y12! !X5Y12! !X6Y12! !X7Y12! !X8Y12! !X9Y12! !X10Y12! !X11Y12! !X12Y12! !X13Y12! !X14Y12! !X15Y12!
echo  !X1Y13! !X2Y13! !X3Y13! !X4Y13! !X5Y13! !X6Y13! !X7Y13! !X8Y13! !X9Y13! !X10Y13! !X11Y13! !X12Y13! !X13Y13! !X14Y13! !X15Y13!
echo  !X1Y14! !X2Y14! !X3Y14! !X4Y14! !X5Y14! !X6Y14! !X7Y14! !X8Y14! !X9Y14! !X10Y14! !X11Y14! !X12Y14! !X13Y14! !X14Y14! !X15Y14!
echo  !X1Y15! !X2Y15! !X3Y15! !X4Y15! !X5Y15! !X6Y15! !X7Y15! !X8Y15! !X9Y15! !X10Y15! !X11Y15! !X12Y15! !X13Y15! !X14Y15! !X15Y15!
choice /c wasd /n 
if !ERRORLEVEL! equ 1 set /A "pY=pY-1"
if !ERRORLEVEL! equ 1 if !pY! leq 0 set /A "pY=pY+1"
if !ERRORLEVEL! equ 1 goto main.GridSet
:: ---------
if !ERRORLEVEL! equ 2 set /A "pX=pX-1"
if !ERRORLEVEL! equ 2 if !pX! leq 0 set /A "pX=pX+1"
if !ERRORLEVEL! equ 2 goto main.GridSet
::
if !ERRORLEVEL! equ 3 set /A "pY=pY+1"
if !ERRORLEVEL! equ 3 if !pY! gtr 15 set /A "pY=pY-1"
if !ERRORLEVEL! equ 3 goto main.GridSet 
:: ---------
if !ERRORLEVEL! equ 4 set /A "pX=pX+1"
if !ERRORLEVEL! equ 4 if !pX! gtr 15 set /A "pX=pX-1"
if !ERRORLEVEL! equ 4 goto main.GridSet




::            ---IMPORTANT---
::       Label -  main.GridSet -- Resets the grid, frame by frame. (This doesn't change player location)
::       Variable - pX -- player X coordinate
::       Variable - pY -- player Y coordinate  (These coords are used so that main.GridSet can determine the player location.)
::       Variable - event_trigger (for this variable use: (when deterimining the type of trigger: action_button, player_touch, & autorun
::       Variable - eX and eY - (works the same as player coordinates (pX & pY) but for events instead.)
:: 
::       label - display_image -- displays an image through HTA & HTML




::Engine/batch Specs -- 
:: Display - 15x15 (Can be changed, keep in mind batch is very limited.)
:: music (.wav files only) 
:: ASCII Graphics only (Special plugins can be added to give it Graphics if you want to)
:: This is a 2D engine only, similar to a snes you could make it "seem" like a 3D game. (Not easy)
:: 5-20 FPS in batch only. (Again, batch is very limited) --
:: Windows only - (Can be translated to Linux) 
:: UI = 20fps 
:: full reset = 5fps
:: 15x15-20x20 map = 30-60fps
:: logic (no rendering required) = 200fps
:: Batch with plugins = 60fps
:: Batch will not show errors, unless you are in VS Code. Normally itll just crash when there is 
:: an error.
:: --basically, This engine is a mix between Game Maker & RPG maker XP 


:: opening labels

:titlescreen 
title !name!
cls
echo                                             !name!
echo                                             ----------------
echo.
echo                                            !a1! NEW GAME
echo                                            !a2! CONTINUE
echo                                                                               X = SHUTDOWN
echo    O = ACCEPT -- W = UP -- S = DOWN
choice /c wsox /n 
if !ERRORLEVEL! equ 1 set a1=--@-
if !ERRORLEVEL! equ 1 set a2=----
if !ERRORLEVEL! equ 1 goto titlescreen 
if !ERRORLEVEL! equ 2 set a1=----
if !ERRORLEVEL! equ 2 set a2=--@-
if !ERRORLEVEL! equ 2 goto titlescreen 
if !ERRORLEVEL! equ 3 if !a1! equ --@- goto new_game
if !ERRORLEVEL! equ 3 if !a2! equ --@- goto continue
if !ERRORLEVEL! equ 4 exit

:new_game
cls
::set starting=true
goto Starting_Area

:event
call :DEBUG_GUARD event
goto eventLayout

:saving
echo.
echo     SAVING...
ping localhost -n 3 >nul
::put any variables here that need to be saved.
(
echo !name!
echo !TIME! 
echo !DATE!
)>"!name!SaveFile.txt"
goto main.GridSet

:continue
if exist "!name!SaveFile.txt" (
) else (
    goto titlescreen
)
::must be in the same order as save, else, data will be jumbled.
(
set /p name=
set /p LastTIME=
set /p LastDATE=
)<"!name!SaveFile.txt"
cls
color F0
echo      Continue this file?
echo       !LastTIME! -- !LastDATE!
pause >nul
goto main.GridSet 

:eventLayout
::event trigger decides what type of event it is.
if !event.main! equ 1 (
		set event_trigger=autorun
		set eY=10
		set eX=10
		set eve=/(-_-)\
		goto eventCheck
) else (
	goto main.GridSet 
)

:Starting_Area 
::call :flash_Screen
::put the music at the beginning of every area.
::set mus=0
::This places the player in a certain spot.
::Make a new boolean variable to decide if the player will go to a new area or not. 
::Always make sure to put "goto main.Gridset" at the bottom of each area.
rem --------------
::      Be sure to name the boolean variables something that makes sense for that area
set pX=1
set pY=1
::
if not !starting!==true goto main.GridSet
:: V -- This triggers the event. You can change the info of the event at the beginning and in
call :create_event
set event1=true
set starting=false
goto main.GridSet

:: It is reccomended that you call this batch file in a separate batch file, that this code will
:: stay organized. 

:: Rec. Editor Platforms -- Notepad, Notepad++ or VScode or anything you prefer.

:DEBUG_GUARD
::Change the variable at the beginning to turn off. These detect for infinite loops.
:: %1 = label name
if not "%DEBUG%"=="true" exit /b

if "!dbg.lastLabel!"=="%~1" (
    set /A dbg.loopCount+=1
) else (
    set dbg.loopCount=0
    set dbg.lastLabel=%~1
)

if !dbg.loopCount! geq !dbg.maxLoops! (
    cls
    color 4F
    echo ================= DEBUGGER HALT =================
    echo Infinite loop detected
    echo.
    echo Label: %~1
    echo Loop Count: !dbg.loopCount!
    echo.
    echo event.main = !event.main!
    echo event1 = !event1!
    echo eventLocalSpire = !eventLocalSpire!
    echo event_trigger = !event_trigger!
    echo pX,pY = !pX!,!pY!
    echo eX,eY = !eX!,!eY!
    echo.
    echo [C] Continue anyway
    echo [E] Exit
    echo ================================================
    choice /c ce /n
    if errorlevel 2 exit
    set dbg.loopCount=0
)
exit /b


::Grid without events (fixed)
:grid_creation
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
goto display_Grid_Main
 
:display_Grid_Main
echo  @!X1Y1! !X2Y1! !X3Y1! !X4Y1! !X5Y1! !X6Y1! !X7Y1! !X8Y1! !X9Y1! !X10Y1! !X11Y1! !X12Y1! !X13Y1! !X14Y1! !X15Y1!@
echo  @!X1Y2! !X2Y2! !X3Y2! !X4Y2! !X5Y2! !X6Y2! !X7Y2! !X8Y2! !X9Y2! !X10Y2! !X11Y2! !X12Y2! !X13Y2! !X14Y2! !X15Y2!@
echo  @!X1Y3! !X2Y3! !X3Y3! !X4Y3! !X5Y3! !X6Y3! !X7Y3! !X8Y3! !X9Y3! !X10Y3! !X11Y3! !X12Y3! !X13Y3! !X14Y3! !X15Y3!@
echo  @!X1Y4! !X2Y4! !X3Y4! !X4Y4! !X5Y4! !X6Y4! !X7Y4! !X8Y4! !X9Y4! !X10Y4! !X11Y4! !X12Y4! !X13Y4! !X14Y4! !X15Y4!@
echo  @!X1Y5! !X2Y5! !X3Y5! !X4Y5! !X5Y5! !X6Y5! !X7Y5! !X8Y5! !X9Y5! !X10Y5! !X11Y5! !X12Y5! !X13Y5! !X14Y5! !X15Y5!@
echo  @!X1Y6! !X2Y6! !X3Y6! !X4Y6! !X5Y6! !X6Y6! !X7Y6! !X8Y6! !X9Y6! !X10Y6! !X11Y6! !X12Y6! !X13Y6! !X14Y6! !X15Y6!@
echo  @!X1Y7! !X2Y7! !X3Y7! !X4Y7! !X5Y7! !X6Y7! !X7Y7! !X8Y7! !X9Y7! !X10Y7! !X11Y7! !X12Y7! !X13Y7! !X14Y7! !X15Y7!@
echo  @!X1Y8! !X2Y8! !X3Y8! !X4Y8! !X5Y8! !X6Y8! !X7Y8! !X8Y8! !X9Y8! !X10Y8! !X11Y8! !X12Y8! !X13Y8! !X14Y8! !X15Y8!@
echo  @!X1Y9! !X2Y9! !X3Y9! !X4Y9! !X5Y9! !X6Y9! !X7Y9! !X8Y9! !X9Y9! !X10Y9! !X11Y9! !X12Y9! !X13Y9! !X14Y9! !X15Y9!@
echo  @!X1Y10! !X2Y10! !X3Y10! !X4Y10! !X5Y10! !X6Y10! !X7Y10! !X8Y10! !X9Y10! !X10Y10! !X11Y10! !X12Y10! !X13Y10! !X14Y10! !X15Y10!@
echo  @!X1Y11! !X2Y11! !X3Y11! !X4Y11! !X5Y11! !X6Y11! !X7Y11! !X8Y11! !X9Y11! !X10Y11! !X11Y11! !X12Y11! !X13Y11! !X14Y11! !X15Y11!@
echo  @!X1Y12! !X2Y12! !X3Y12! !X4Y12! !X5Y12! !X6Y12! !X7Y12! !X8Y12! !X9Y12! !X10Y12! !X11Y12! !X12Y12! !X13Y12! !X14Y12! !X15Y12!@
echo  @!X1Y13! !X2Y13! !X3Y13! !X4Y13! !X5Y13! !X6Y13! !X7Y13! !X8Y13! !X9Y13! !X10Y13! !X11Y13! !X12Y13! !X13Y13! !X14Y13! !X15Y13!@
echo  @!X1Y14! !X2Y14! !X3Y14! !X4Y14! !X5Y14! !X6Y14! !X7Y14! !X8Y14! !X9Y14! !X10Y14! !X11Y14! !X12Y14! !X13Y14! !X14Y14! !X15Y14!@
echo  @!X1Y15! !X2Y15! !X3Y15! !X4Y15! !X5Y15! !X6Y15! !X7Y15! !X8Y15! !X9Y15! !X10Y15! !X11Y15! !X12Y15! !X13Y15! !X14Y15! !X15Y15!@
choice /c wasd /n 
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