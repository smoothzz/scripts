$url = "https://download.teamviewer.com/download/TeamViewerQS.exe"
$user = (Get-WmiObject -Class Win32_Process -Filter 'Name="explorer.exe"').
    GetOwner().
    User
$path = "C:\Users\$user\Downloads\suporte.exe"
if([System.IO.File]::Exists($path))
{
Start-Process "C:\Users\$user\Downloads\suporte.exe"
}
else
{
Invoke-WebRequest -Uri $url -OutFile "C:\Users\$user\Downloads\suporte.exe"
Start-Process "C:\Users\$user\Downloads\suporte.exe"
}