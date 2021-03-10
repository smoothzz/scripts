$ProxyAddress = [System.Net.WebProxy]::GetDefaultProxy().Address
[system.net.webrequest]::defaultwebproxy = New-Object system.net.webproxy($ProxyAddress)
$CredCache = [System.Net.CredentialCache]::new()
$NetCreds = Get-Credential
$CredCache.Add($ProxyAddress, "Basic", $NetCreds)
[system.net.webrequest]::defaultwebproxy.credentials = $CredCache
[system.net.webrequest]::defaultwebproxy.BypassProxyOnLocal = $true

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
timeout /t 5
Invoke-WebRequest -Uri $url -OutFile "C:\Users\$user\Downloads\suporte.exe"
Start-Process "C:\Users\$user\Downloads\suporte.exe"
}