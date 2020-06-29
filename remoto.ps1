$url = "https://download.teamviewer.com/download/TeamViewer_Host_Setup.exe"
$user = (Get-WmiObject -Class Win32_Process -Filter 'Name="explorer.exe"').
    GetOwner().
    User
Invoke-WebRequest -Uri $url -OutFile "C:\Users\$user\Desktop\remoto.exe"
Start-Process "C:\Users\$user\Desktop\remoto.exe"