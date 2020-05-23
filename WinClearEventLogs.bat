@echo off
FOR /F "tokens=1,2*" %%V IN ('bcdedit') DO SET adminTest=%%V
IF (%adminTest%)==(Access) goto noAdmin
for /F "tokens=*" %%G in ('wevtutil.exe el') DO (call :do_clear "%%G")
echo.
echo ==============================================
del C:\Windows\System32\LogFiles\*.* /AHS /F /S /Q
del C:\Windows\Prefetch\*.* /AHS /F /S /Q
rd C:\Windows\System32\LogFiles\ /S /Q
echo ==============================================
echo.
echo Event Logs have been cleared! ^<press any key^>
goto theEnd
:do_clear
echo clearing %1
wevtutil.exe cl %1
goto :eof
:noAdmin
echo You must run this script as an Administrator!
echo ^<press any key^>
:theEnd
pause>NUL