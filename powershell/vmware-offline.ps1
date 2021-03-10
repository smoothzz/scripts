Start-Process vmware-client.exe -Wait
$user = (Get-WmiObject -Class Win32_Process -Filter 'Name="explorer.exe"').
    GetOwner().
    User
$path = $env:TEMP
$appname = "VDI.lnk"
Copy-Item -Path $path\$appname -Destination "C:\Users\$user\Desktop"
Start-Process "C:\Users\$user\Desktop\vdi"