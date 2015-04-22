@ECHO OFF 
REM ********************************************** 
REM ***     Find Webgrab executable script     *** 
REM *** Made by John Vermeulen / version v1.0b *** 
REM ***                                        *** 
REM ********************************************** 

for /f "delims=" %%a in ('dir %LOCALAPPDATA%\webgrab*.exe /s /b') do ( 
set wgexec=%%a 
) 

REM **********************************************
REM ***    Run WebGrab+Plus minimized          ***
REM **********************************************

START /MIN %wgexec%