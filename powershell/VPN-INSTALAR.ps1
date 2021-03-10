$7zipPath = "$env:ProgramFiles\7-Zip\7z.exe"
Set-Alias 7zip $7zipPath

function ssl {
    mkdir C:\VPN-SSL
    $url = "https://github.com/smoothzz/home-2021/raw/main/SSL.7z"
    Invoke-WebRequest -Uri $url -OutFile "C:\VPN-SSL\SSL.7z"
    cd c:\VPN-SSL
    7zip x SSl.7z
    cd C:\VPN-SSL\G_VPN_SSL    
    Start-Process Installer.exe -ArgumentList "/S" -PassThru
}

function ssl-filial {
    mkdir C:\VPN-RDPFILIAL
    $url = "https://github.com/smoothzz/home-2021/raw/main/RDP-FILIAL.7z"
    Invoke-WebRequest -Uri $url -OutFile "C:\VPN-RDPFILIAL\RDP-FILIAL.7z"
    cd C:\VPN-RDPFILIAL
    7zip x RDP-FILIAL.7z
    cd C:\VPN-RDPFILIAL\G_VPN_RDP-FILIAL
    Start-Process Installer.exe -ArgumentList "/S" -PassThru
}

function ssl02 {
    mkdir C:\VPN-SSL02
    $url = "https://github.com/smoothzz/home-2021/raw/main/SSL02.7z"
    Invoke-WebRequest -Uri $url -OutFile "C:\VPN-SSL02\SSL02.7z"
    cd C:\VPN-SSL02
    7zip x SSL02.7z
    cd C:\VPN-SSL02\G_VPN_SSL02
    Start-Process Installer.exe -ArgumentList "/S" -PassThru
}

function ssl03 {
    mkdir C:\VPN-SSL03
    $url = "https://github.com/smoothzz/home-2021/raw/main/SSL03.7z"
    Invoke-WebRequest -Uri $url -OutFile "C:\VPN-SSL03\SSL03.7z"
    cd C:\VPN-SSL03
    7zip x SSL03.7z
    cd C:\VPN-SSL03\G_VPN_SSL03
    Start-Process Installer.exe -ArgumentList "/S" -PassThru
}

function ssl05 {
    mkdir C:\VPN-SSL05
    $url = "https://github.com/smoothzz/home-2021/raw/main/SSL05.7z"
    Invoke-WebRequest -Uri $url -OutFile "C:\VPN-SSL05\SSL05.7z"
    cd C:\VPN-SSL05
    7zip x SSL05.7z
    cd C:\VPN-SSL05\G_VPN_SSL05
    Start-Process Installer.exe -ArgumentList "/S" -PassThru
}

function ssl06 {
    mkdir C:\VPN-SSL06
    $url = "https://github.com/smoothzz/home-2021/raw/main/SSL06.7z"
    Invoke-WebRequest -Uri $url -OutFile "C:\VPN-SSL06\SSL06.7z"
    cd C:\VPN-SSL06
    7zip x SSL06.7z
    cd C:\VPN-SSL06\G_VPN_SSL06
    Start-Process Installer.exe -ArgumentList "/S" -PassThru
}

function ssl07 {
    mkdir C:\VPN-SSL07
    $url = "https://github.com/smoothzz/home-2021/raw/main/SSL07.7z"
    Invoke-WebRequest -Uri $url -OutFile "C:\VPN-SSL07\SSL07.7z"
    cd C:\VPN-SSL07
    7zip x SSL07.7z
    cd C:\VPN-SSL07\G_VPN_SSL07
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