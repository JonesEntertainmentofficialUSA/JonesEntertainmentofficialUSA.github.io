@echo off
setlocal enableDelayedExpansion
pause
set pY=1
set pX=1
set playerLoc=oooooo


for /L %%x in (1,1,15) do (
    for /L %%y in (1,1,15) do (

        set "cell=X%%xY%%y"

        rem --- 1. Clear the cell every frame ---
        set "%cell%="

        rem --- 2. Player placement ---
        if "!pX!"=="%%x" if "!pY!"=="%%y" (
            set "%cell%=!playerLoc!"
        )

        rem --- 3. Collision check AFTER placement ---
        if "!%cell%!"=="!obj!" goto playerCollision
    )
)

goto display_Grid
 
:display_Grid
cls
echo  ########################################################################################################
echo                                Level: !LV! -- $: !$$$!
echo                                HEALTH: !HP!/!MAXHP! : 
echo                                SOUL:   !SP!/!MAXSP! :
echo  ########################################################################################################
echo  ########################################################################################################
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
choice /c wasdoi /n 
if !ERRORLEVEL! equ 1 (
    set /A "pY=pY-1"
    if !pY! leq 0 set /A "pY=pY+1"
    goto import.Grid_15x15
)
if !ERRORLEVEL! equ 2 (
    set /A "pX=pX-1"
    if !pX! leq 0 set /A "pX=pX+1"
    goto import.Grid_15x15
)
if !ERRORLEVEL! equ 3 (
    set /A "pY=pY+1"
    if !pY! gtr 15 set /A "pY=pY-1"
    goto import.Grid_15x15
)
if !ERRORLEVEL! equ 4 (
    set /A "pX=pX+1"
    if !pX! gtr 15 set /A "pX=pX-1"
    goto import.Grid_15x15
)
if !ERRORLEVEL! equ 5 (
    goto op_menu
)

if !ERRORLEVEL! equ 6 (
    goto event_check 
)