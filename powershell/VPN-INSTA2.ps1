$7zipPath = "$env:ProgramFiles\7-Zip\7z.exe"
Set-Alias 7zip $7zipPath

$user = (Get-WmiObject -Class Win32_Process -Filter 'Name="explorer.exe"').
    GetOwner().
    User

function ssl {
    cd C:\Users\$user\AppData\Local\Temp
    7zip x SSl.7z
    cd C:\Users\$user\AppData\Local\Temp\G_VPN_SSL 
    Start-Process Installer.exe -ArgumentList "/S" -PassThru
}

function ssl-filial {
    cd C:\Users\$user\AppData\Local\Temp
    7zip x RDP-FILIAL.7z
    cd C:\Users\$user\AppData\Local\Temp\G_VPN_RDP-FILIAL
    Start-Process Installer.exe -ArgumentList "/S" -PassThru
}

function ssl02 {
    cd C:\Users\$user\AppData\Local\Temp
    7zip x SSL02.7z
    cd C:\Users\$user\AppData\Local\Temp\G_VPN_SSL02
    Start-Process Installer.exe -ArgumentList "/S" -PassThru
}

function ssl03 {
    mkdir C:\VPN-SSL03
    $url = "https://github.com/smoothzz/home-2021/raw/main/SSL03.7z"
    Invoke-WebRequest -Uri $url -OutFile "C:\VPN-SSL03\SSL03.7z"
    cd C:\Users\$user\AppData\Local\Temp
    7zip x SSL03.7z
    cd C:\Users\$user\AppData\Local\Temp\G_VPN_SSL03
    Start-Process Installer.exe -ArgumentList "/S" -PassThru
}

function ssl05 {
    cd C:\Users\$user\AppData\Local\Temp
    7zip x SSL05.7z
    cd C:\Users\$user\AppData\Local\Temp\G_VPN_SSL05
    Start-Process Installer.exe -ArgumentList "/S" -PassThru
}

function ssl06 {
    cd C:\Users\$user\AppData\Local\Temp
    7zip x SSL06.7z
    cd C:\Users\$user\AppData\Local\Temp\G_VPN_SSL06
    Start-Process Installer.exe -ArgumentList "/S" -PassThru
}

function ssl07 {
    cd C:\Users\$user\AppData\Local\Temp
    7zip x SSL07.7z
    cd C:\Users\$user\AppData\Local\Temp\G_VPN_SSL07
    Start-Process Installer.exe -ArgumentList "/S" -PassThru
}

function Show-Menu
{
     param (
           [string]$Title = 'PASCHOALOTTO VPN INSTALLER'
     )
     cls
     Write-Host "================ $Title ================"
     Write-Host "Selecione qual VPN deseja instalar!"
     Write-Host "0: SSL"
     Write-Host "1: SSL FILIAL"
     Write-Host "2: SSL02"
     Write-Host "3: SSL03"
     Write-Host "4: SSL05"
     Write-Host "5: SSL06"
     Write-Host "6: SSL07"
     Write-Host "Q: EXIT"
}
do
{
     Show-Menu
     $input = Read-Host "Por favor selecione uma das opcoes"
     switch ($input)
     {
           '0' {
                ssl
           } '1' {
                ssl-filial
           } '2' {
                ssl02
           } '3' {
                ssl03
           } '4' {
                ssl05
           } '5' {
                ssl06
           } '6' {
                ssl07
           }'q' {
                exit
           }
     }
}
until ($input -eq 'q')