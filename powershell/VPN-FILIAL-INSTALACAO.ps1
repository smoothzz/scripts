function Get7Zip{
    $url = "https://www.7-zip.org/a/7z1900-x64.exe"
    Invoke-WebRequest -Uri $url -OutFile "C:\temp\7z64.exe"
    cd C:\temp
    Start-Process 7z64.exe -ArgumentList "/S" -PassThru -Wait
}

function ssl-filial {
    $url = "https://troantunes.000webhostapp.com/RDP-FILIAL.7z"
    Invoke-WebRequest -Uri $url -OutFile "C:\temp\RDP-FILIAL.7z"
    cd C:\temp
    7zip x RDP-FILIAL.7z
    cd G_VPN_RDP-FILIAL
    Write-Host "Por favor precione Sim na tela que ira aparecer!" -ForegroundColor Black -BackgroundColor Red
    Start-Sleep -s 5
    Start-Process Installer.exe -ArgumentList "/S" -PassThru
}

Get7Zip
$7zipPath = "$env:ProgramFiles\7-Zip\7z.exe"
Set-Alias 7zip $7zipPath
ssl-filial
Start-Sleep -s 5
Write-Host "Instalação concluida com sucesso!" -ForegroundColor Black -BackgroundColor Green
Start-Sleep -s 8
exit