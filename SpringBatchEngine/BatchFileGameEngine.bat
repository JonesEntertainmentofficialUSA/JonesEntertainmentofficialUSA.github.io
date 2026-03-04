@echo off
setlocal enabledelayedexpansion

:: ============================================================
:: 1. CREATE THE HTA RENDERER FILE
:: ============================================================
>renderer.hta echo ^<!DOCTYPE html^>
>>renderer.hta echo ^<html^>
>>renderer.hta echo ^<head^>
>>renderer.hta echo ^<HTA:APPLICATION border="none" scroll="no" caption="yes" windowstate="normal" /^>
>>renderer.hta echo ^<script language="javascript"^>

:: Grid size
>>renderer.hta echo var rows = 10;
>>renderer.hta echo var cols = 10;



:: Poll for batch commands
>>renderer.hta echo function poll() {
>>renderer.hta echo   try {
>>renderer.hta echo     var fso = new ActiveXObject("Scripting.FileSystemObject");
>>renderer.hta echo     if (!fso.FileExists("engine_cmd.txt")) return;
>>renderer.hta echo     var file = fso.OpenTextFile("engine_cmd.txt", 1);
>>renderer.hta echo     var cmd = file.ReadAll().trim();
>>renderer.hta echo     file.Close();
>>renderer.hta echo     if (cmd.length == 0) return;

:: Parse commands
>>renderer.hta echo     var parts = cmd.split(" ");
>>renderer.hta echo     if (parts[0] == "set") {
>>renderer.hta echo       var x = parts[1];
>>renderer.hta echo       var y = parts[2];
>>renderer.hta echo       var img = parts[3];
>>renderer.hta echo       document.getElementById("t" + x + "_" + y).src = img;
>>renderer.hta echo     }
>>renderer.hta echo   } catch(e) {
>>renderer.hta echo     alert("Error: " + e.message);
>>renderer.hta echo   }
>>renderer.hta echo }

:: Start loops
>>renderer.hta echo window.onload = function() {
>>renderer.hta echo   buildGrid();
>>renderer.hta echo   setInterval(poll, 50);
>>renderer.hta echo }
>>renderer.hta echo ^</script^>
>>renderer.hta echo ^</head^>
>>renderer.hta echo ^<body style="background:yellow; margin:0;"^>
>>renderer.hta echo ^<div id="grid" style="line-height:0;"^>^</div^>
>>renderer.hta echo ^</body^>
>>renderer.hta echo ^</html^>

:: Build grid on load
>>renderer.hta echo function buildGrid() {
>>renderer.hta echo   var grid = document.getElementById("grid");
>>renderer.hta echo   for (var y = 0; y < rows; y++) {
>>renderer.hta echo     for (var x = 0; x < cols; x++) {
>>renderer.hta echo       var img = document.createElement("img");
>>renderer.hta echo       img.id = "t" + x + "_" + y;
>>renderer.hta echo       img.width = 32;
>>renderer.hta echo       img.height = 32;
>>renderer.hta echo       img.src = "tiles/C:\Users\Chris\OneDrive\Pictures\134151309275504563.jpg";
>>renderer.hta echo       grid.appendChild(img);
>>renderer.hta echo     }
>>renderer.hta echo     grid.appendChild(document.createElement("br"));
>>renderer.hta echo   }
>>renderer.hta echo }

:: ============================================================
:: 2. LAUNCH THE HTA RENDERER
:: ============================================================
echo Launching renderer...
timeout /t 2 >nul
start "" renderer.hta

:: ============================================================
:: 3. DEMO: UPDATE TILES IN REAL TIME
:: ============================================================
echo Starting tile updates...

set x=0
set y=0

:loop
echo set !x! !y! tiles/"C:\Users\Chris\OneDrive\Pictures\134151309275504563.jpg" > engine_cmd.txt

set /a x+=1
if !x! geq 10 (
    set x=0
    set /a y+=1
)

if !y! geq 10 set y=0

timeout /t 1 >nul
goto loop