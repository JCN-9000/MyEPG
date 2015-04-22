@echo off
echo.
echo This utility will update WebGrab+Plus V1.1.1 to the latest build.
echo.
pause
%~d0
chdir %~dp0
echo.
if exist "C:\Program Files (x86)\ServerCare\WebGrab+PlusV1.1.1\WebGrab+Plus.exe" xcopy "WebGrab+Plus.exe" "C:\Program Files (x86)\ServerCare\WebGrab+PlusV1.1.1\*.*" /y 
if exist "C:\Program Files\ServerCare\WebGrab+PlusV1.1.1\WebGrab+Plus.exe" xcopy "WebGrab+Plus.exe" "C:\Program Files\ServerCare\WebGrab+PlusV1.1.1\*.*" /y
pause

