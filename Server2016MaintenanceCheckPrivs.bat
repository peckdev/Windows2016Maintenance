c
echo Checking for administrator privileges...
net session >nul 2>&1
if %errorLevel% == 0 (
    echo You have administrative privileges.
) else (
    echo You do not have administrative privileges.
    echo Please run this script as an administrator.
    echo Elevating...
    powershell -Command "Start-Process '%0' -Verb RunAs"
    exit /b
)

echo Disabling password expiration...
wmic path Win32_UserAccount set PasswordExpires=False
echo --------------------------------------------------------
echo Script created and maintained by www.PeckDevelopment.com
echo Support at BTC bc1qw368jup8wl6uu5mfuw3vxuxw5elpqscata5c9t
echo --------------------------------------------------------
echo Checking for Windows updates...
net start wuauserv
echo Waiting for updates to be checked...
timeout /t 10 /nobreak >nul
wuauclt /detectnow
echo Updates have been triggered to check. Please wait...
timeout /t 60 /nobreak >nul
echo Windows update check complete.
echo Installing updates...
wusa.exe /detectnow /quiet /norestart
echo Updates have been installed.
echo Starting Dism scans...
Dism.exe /online /cleanup-image /scanhealth
Dism.exe /online /cleanup-image /restorehealth 

echo Starting sfc scans...
sfc /scannow

@echo off
echo Starting Disk Cleaning...
@if (@CodeSection == @Batch) @then
@echo off
echo Starting Disk Cleaning...

:: VBScript part to automate Disk Cleanup
cscript /nologo /e:vbscript "%~f0"
exit /b

@end

Set objShell = CreateObject("Shell.Application")
Set objWindows = objShell.Windows
For Each objWindow in objWindows
    If InStr(objWindow.FullName, "cleanmgr.exe") > 0 Then
        objWindow.Visible = True
        Exit For
    End If
Next

WScript.Sleep 5000

Set objShell = CreateObject("WScript.Shell")
objShell.AppActivate "Disk Cleanup"

objShell.SendKeys "{TAB}"
WScript.Sleep 500
objShell.SendKeys " "
WScript.Sleep 500
objShell.SendKeys "{TAB}"
WScript.Sleep 500
objShell.SendKeys " "
WScript.Sleep 500
objShell.SendKeys "{TAB}"
WScript.Sleep 500
objShell.SendKeys " "
WScript.Sleep 500
objShell.SendKeys "{TAB}"
WScript.Sleep 500
objShell.SendKeys " "
WScript.Sleep 500
objShell.SendKeys "{TAB}"
WScript.Sleep 500
objShell.SendKeys " "
WScript.Sleep 500
objShell.SendKeys "{TAB}"
WScript.Sleep 500
objShell.SendKeys " "
WScript.Sleep 500
objShell.SendKeys "{TAB}"
WScript.Sleep 500
objShell.SendKeys " "
WScript.Sleep 500

objShell.SendKeys "{ENTER}"


wbadmin start systemstatebackup -backupTarget:C:\ -quiet
echo Restore point created successfully.

echo All tasks finished.
echo Please save all your work if the PC needs a reboot.
echo.

set /p choice=Do you want to restart now? (Y/N): 
if /i "%choice%"=="Y" (
    shutdown /r /t 0
) else (
    echo You chose not to restart. Press any key to exit.
    pause >nul
)
