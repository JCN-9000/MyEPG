@ECHO OFF

REM **************************************************************************************

REM ***                Script made by John Vermeulen aka The Duke                      ***

REM ***                              version v1.0b                                     ***

REM ***                                                                                ***

REM *** When using Webgrab in combination with Mediaportal there are 2 problems.       ***

REM *** 1. MP tends to keep the tvguide in use while it still is being updated by WG   ***

REM *** 2. MP does not import correct UTC timecodes when using foreign tvguide sites.  ***

REM ***                                                                                ***

REM *** This script will solve both problems by creating a 2nd tvguide copy            ***

REM *** and at the same time create a UTC timecode fixed tvguide version               ***

REM *** that you can use for the EPG import program.                                   ***

REM **************************************************************************************

REM ***                                                                                ***

REM ***         Many thanks to Jan and Paul for creating Webgrab (plus)                ***

REM ***                                                                                ***

REM **************************************************************************************

 

REM ----------------------------------------------

REM ---    This script will start webgrab      ---

REM --- This script will make a tvguide copy   ---

REM --- This script will Fix the UTC timecode  ---

REM --- This script can run from taskmanager   ---

REM --- All WG options like resume will remain ---

REM ----------------------------------------------

REM --- THERE ARE 2 CONFIG SETTINGS DOWN BELOW ---

REM ----------------------------------------------

 

REM *************************************

REM ***     HOW TO USE THIS SCRIPT    ***

REM *************************************

REM Do NOT USE THE TVGUIDE FILE FOR IMPORT THAT IS CONFIGURED IN WEBGRAB CONFIG!

REM THIS SCRIPT WILL MAKE ANOTHER TVGUIDE COPY THAT YOU MUST USE FOR THE EPG IMPORTER

REM 

REM This script will allways put "fix-" in front of the original tvguide filename. 

REM 

REM In webgrab config options >>> <filename>C:\Webgrabguide\tvguide.xml</filename>

REM MP server cfg XMLT tvguide filename >>> C:\Webgrabguide\fix-tvguide.xml

 

 

Rem >>> INFO: The program WG2MP.exe needed for timefix can be found on http://www.servercare.nl/Lists/Posts/Post.aspx?ID=98

 

 

REM                         *************************************

REM                         *****       WARNING !!!!!       *****

REM                         *************************************

REM I will not be responsable for damaged files or other mishaps, use this script at your own risk.

 

 

 

REM *************************************

REM >>>>>       USER SETTINGS       <<<<<

REM *************************************

 

 

REM ******************************************

REM *** Webgrab config file incl full path ***

REM ******************************************

set wgconfig=C:\ProgramData\ServerCare\WebGrab\WebGrab++.config.xml

 

 

REM ********************************************************************************************************

REM *** Mediaportal has a bug where foreign tvguides will have wrong timecode (UTC time is not used!)    ***

REM *** When using Mediaportal set Timefix ON and put program WG2MP.exe in same folder as this script    ***

REM *** If switch is ON and WG2MP.exe is found then timefix will be executed and fixed TVguide is made   ***

REM *** When Switch is ON a make sure your epg Import program uses the Fixed tvguide for import!         ***

REM *** Switch options: ON/OFF                                                                           ***

REM ********************************************************************************************************

REM *** The Fixed tvguide will get renamed (original in wg config: tvguide.xml >>>>> fix-tvguide.xml)    ***

REM ********************************************************************************************************

set mptimefix=ON

 

 

 

REM ===========================================================

REM ===== END USER SETTINGS! DO NOT EDIT BELOW THIS LINE! =====

REM ===========================================================

 

set mptimefixexe=WG2MP.exe

 

ECHO %date%%time% >> TVscriptlog.txt

ECHO "Automated script Started" >> TVscriptlog.txt

 

REM *** Find the Webgrab exe path en file

for /f "delims=" %%a in ('dir %LOCALAPPDATA%\webgrab*.exe /s /b') do (

                set wgexec=%%a

                )

 

IF NOT EXIST "%wgexec%" (

                ECHO %date%%time% >> TVscripterror.txt

                ECHO "ERROR: WG Executable file not found!, Script will halt!" >> TVscripterror.txt

                GOTO END

)

 

IF NOT EXIST %wgconfig% (

                ECHO %date%%time% >> TVscripterror.txt

                ECHO "ERROR: WG Config file not found!, Script will halt!" >> TVscripterror.txt

                GOTO END

)

 

REM *** Lets find the path/file where the tvguide will be saved so we can use it for the timecode fix script

for /F "delims=<> tokens=2,3" %%i in (%wgconfig%) do (

IF %%i EQU filename (

                set tvguidefile=%%~nxj

                set tvguidepath=%%~dpj

                )

)

 

ECHO -------------------------------------------------------

ECHO ---    Webgrab automated script for Mediaportal     ---

ECHO ---                                                 ---

ECHO ---        Made by John Vermeulen / v1.0b           ---

ECHO -------------------------------------------------------

ECHO .

ECHO -------------------------------------------------------

ECHO ---    Webgrab is running in a Minimized window     ---

ECHO ---                                                 ---

ECHO ---          ! DO NOT CLOSE THIS WINDOW !           ---

ECHO ---  This window will close itself when finished    ---

ECHO ---                                                 ---

ECHO ---        Please wait while Webgrab updates        ---

ECHO -------------------------------------------------------

ECHO ---       Check logs in same folder as script       ---

ECHO -------------------------------------------------------

 

 

 

START /MIN /WAIT %wgexec%

 

IF %mptimefix% == ON (

                ECHO "TimeFix ON"

                IF EXIST %mptimefixexe% (

                WG2MP.exe  %tvguidepath%%tvguidefile% %tvguidepath%fix-%tvguidefile%

                ) ELSE (

                               ECHO %date%%time% >> TVscripterror.txt

                               ECHO "Timefix setting is ON but WG2MP.exe was not found!" >> TVscripterror.txt

                               copy /Y %tvguidepath%%tvguidefile% %tvguidepath%fix-%tvguidefile%

                )              

) ELSE (

                copy /Y %tvguidepath%%tvguidefile% %tvguidepath%fix-%tvguidefile%

)

ECHO %date%%time% >> TVscriptlog.txt

ECHO "Automated script ready" >> TVscriptlog.txt

:END

