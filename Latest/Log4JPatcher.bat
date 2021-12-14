@echo on
@echo ################################################
@echo #                                              #
@echo #  Log4J Patcher, devloped by Pierce Baronoff  #
@echo #   visit pierce.baronoff.net for more tools   #
@echo #                                              #
@echo ################################################
set /p vrsn=1.4
cd c:\
timeout 5 > NUL
@echo Cehcking for updates
timeout 1 > NUL
set url=https://raw.githubusercontent.com/Vooskie/Log4J-Patcher/main/version.txt
set file=version.txt

certutil -urlcache -split -f %url% %file%
set /p nwstvrsn=<version.txt
if %vrsn% < %nwstvrsn% goto newupdateavailable
if %vrsn% == %nwstvrsn% goto noupdateavailable

:newupdateavailable
echo Downloading Update
set url=https://raw.githubusercontent.com/Vooskie/Log4J-Patcher/main/Latest/Log4JPatcher.bat
set file=Log4JPatcher.bat
certutil -urlcache -split -f %url% %file%
call Log4JPatcher.bat

:noupdateavailable
echo No Update Available
timeout 1 > NUL
setx LOG4J_FORMAT_MSG_NO_LOOKUPS true /m
timeout 1 > NUL
if "%LOG4J_FORMAT_MSG_NO_LOOKUPS%" equ "true" (
  
   echo Patching was successful
   timeout 2 > NUL
   GOTO CheckReboot

) else (

   echo Patching was not successful
   timeout 5 > NUL
   @echo Please check that you are running as administrator from C:\ drive and try again
   timeout 2 > NUL
   GOTO EOF

)
timeout 5 > NUL
GOTO EOF

    :CheckReboot
    
    SET /P yesno=Do you want to Reboot this machine? [Y/N]:
    IF "%yesno%"=="y" GOTO Confirmation
    IF "%yesno%"=="Y" GOTO Confirmation
    IF "%yesno%"=="n" GOTO End
    IF "%yesno%"=="N" GOTO End
    
    :Confirmation
    
    ECHO System is going to Reboot now
    timeout 2 > NUL
    ECHO Thank you for using Log4J Patcher
    timeout 2 > NUL
    shutdown.exe /r /t 00
    
    GOTO EOF
    :End
    
    ECHO System Reboot cancelled
    timeout 2 > NUL
    ECHO Thank you for using Log4J Patcher
    timeout 2 > NUL

    :EOF
    exit