$user = (Get-WmiObject -Class Win32_Process -Filter 'Name="explorer.exe"').
    GetOwner().
    User

Write-Host "Removendo arquivos da paste temp!"
rm -r -fo C:\temp\*
rm -r -fo  C:\Windows\Temp\*

Write-Host "Removendo cache firefox"
rm -r -fo C:\Users\$user\AppData\Local\Mozilla\Firefox\Profiles\*

Write-Host "Removendo cache Google Chrome"
rm -r -fo C:\Users\$user\AppData\Local\Google\Chrome\User Data\Default\Cache\*

Write-Host "Removendo cache Microsoft Edge"
rm -r -fo C:\Users\$user\AppData\Local\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\*

Write-Host "Removendo cache Internet Explorer"
rm -r -fo C:\Users\$user\AppData\Local\Microsoft\Windows\Temporary Internet Files\*

Write-Host "Removendo cache RDP"
rm -r -fo C:\Users\$user\AppData\Local\Microsoft\Terminal Server Client\Cache\*

Write-Host "$user Limpeza Concluida!"


