$url = "https://download.anydesk.com/AnyDesk.exe"
$user = (Get-WmiObject -Class Win32_Process -Filter 'Name="explorer.exe"').
    GetOwner().
    User
Invoke-WebRequest -Uri $url -OutFile "C:\Users\$user\Downloads\SuporteNP2.exe"
cd "C:\Users\$user\Downloads" 
$arguments = "--install `"${env:ProgramFiles}\AnyDesk`" --silent --remove-first --create-shortcuts --create-desktop-icon"
Start-Process SuporteNP2.exe -ArgumentList $arguments -Wait
Write-Host "Anydesk instalado com sucesso!!!"