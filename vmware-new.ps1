mkdir c:\vmware
$url = "https://download3.vmware.com/software/view/viewclients/CART21FQ1/VMware-Horizon-Client-5.4.3-16346110.exe"
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