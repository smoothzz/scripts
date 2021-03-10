$url = "https://download.anydesk.com/AnyDesk.exe"
$user = (Get-WmiObject -Class Win32_Process -Filter 'Name="explorer.exe"').
    GetOwner().
    User
Invoke-WebRequest -Uri $url -OutFile "C:\Users\$user\Desktop\auxilio-remoto.exe"
Start-Process "C:\Users\$user\Desktop\auxilio-remoto.exe"