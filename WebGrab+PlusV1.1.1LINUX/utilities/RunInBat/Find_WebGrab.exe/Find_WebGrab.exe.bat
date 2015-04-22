@ECHO OFF 
REM ********************************************** 
REM ***     Find Webgrab executable script     *** 
REM *** Made by John Vermeulen / version v1.0b *** 
REM ***                                        *** 
REM ********************************************** 

ECHO ********************* ENGLISH *************************** 
ECHO ***                                                   *** 
ECHO *** Find Webgrab executable script                    *** 
ECHO *** made by John Vermeulen / version v1.0b            *** 
ECHO ***                                                   *** 
ECHO *** The result is saved in a file findwebgrab.txt     *** 
ECHO *** located in the same folder as this script         *** 
ECHO ***                                                   *** 
ECHO ********************************************************* 
ECHO * 
ECHO ********************** DUTCH **************************** 
ECHO ***                                                   *** 
ECHO *** Find Webgrab executable script                    *** 
ECHO *** Made by John Vermeulen / version v1.0b            *** 
ECHO ***                                                   *** 
ECHO *** Het resultaat is opgeslagen in het bestand        *** 
ECHO *** findwebgrab.txt in dezelfde folder als dit script *** 
ECHO ***                                                   *** 
ECHO ********************************************************* 
ECHO * 
ECHO * 


for /f "delims=" %%a in ('dir %LOCALAPPDATA%\webgrab*.exe /s /b') do ( 
set wgexec=%%a 
) 

Echo Webgrab is found at: %wgexec% 
Echo Webgrab location: %wgexec% > findwebgrab.txt 
ECHO * 
pause 