@echo off
echo --------------------------------------------------------
echo Script created and maintained by www.PeckDevelopment.com
echo Support at BTC bc1qw368jup8wl6uu5mfuw3vxuxw5elpqscata5c9t
echo --------------------------------------------------------
echo Checking for administrator privileges...
@echo off
setlocal

echo Starting Disk Cleaning...


set "logFile=%temp%\DiskCleanupLog.txt"

:: Elevate privileges to run as administrator
echo Running Disk Cleanup with administrator privileges...
powershell.exe -Command "Start-Process -FilePath '%comspec%' -ArgumentList '/c DiskCleanup.bat' -Verb RunAs"

:: Check if Disk Cleanup is running and show progress
echo Waiting for Disk Cleanup to finish...
:LOOP
timeout /t 1 /nobreak >nul
tasklist | find /i "cleanmgr.exe" >nul
if not errorlevel 1 (
    echo Disk Cleanup is still running...
    goto :LOOP
)

:: Parse the Disk Cleanup log file to retrieve cleanup details
echo Disk Cleanup completed. Retrieving cleanup details...
for /f "tokens=1,2" %%a in ('findstr /c:"Total amount of disk space you gain" "%logFile%"') do (
    set "cleanedUpSpace=%%b"
)
echo Cleaned up space: %cleanedUpSpace%

:: Delete the temporary log file
if exist "%logFile%" del "%logFile%"

pause
