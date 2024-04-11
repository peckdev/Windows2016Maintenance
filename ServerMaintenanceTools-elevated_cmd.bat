@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

@echo off
echo --------------------------------------------------------
echo Script created and maintained by www.PeckDevelopment.com
echo Support at BTC bc1qw368jup8wl6uu5mfuw3vxuxw5elpqscata5c9t
echo --------------------------------------------------------
echo Launching PowerShell ISE with administrative privileges...
PowerShell.exe -Command "Start-Process powershell_ise.exe -Verb RunAs"

@echo off
echo Launching Computer Management...
Start /b mmc.exe %SystemRoot%\system32\compmgmt.msc /a

REM Your commands to be executed with elevated privileges go here
start cmd.exe /k

exit

