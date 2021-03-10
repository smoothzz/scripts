function DisableProxy {
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\' -Name 'ProxyEnable' -Value 0
}

function ActivateProxy {
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\' -Name 'ProxyEnable' -Value 1
}

function InstallVDI {
mkdir c:\vmware
$url = "https://download.teamviewer.com/download/TeamViewer_Host_Setup.exe"
Invoke-WebRequest -Uri $url -OutFile "C:\vmware\vmware-client.exe"
cd c:\vmware
Start-Process vmware-client.exe -Wait
$user = (Get-WmiObject -Class Win32_Process -Filter 'Name="explorer.exe"').
    GetOwner().
    User
$path = $env:TEMP
$appname = "VDI.lnk"
Copy-Item -Path $path\$appname -Destination "C:\Users\$user\Desktop"
Start-Process "C:\Users\$user\Desktop\vdi"
}

function ODBC {
TASKKILL /IM npcob.exe
TIMEOUT /t 5 /s /v /silent
REG DELETE "HKCU\Software\ODBC\ODBC.INI\plcp001" /f
REG DELETE "HKCU\Software\ODBC\ODBC.INI\plcp002" /f
timeout /t 10 /s /v /silent
Start-Process  "C:\Program Files\npcob\npcob.exe"
}

//Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6