$7zipPath = "$env:ProgramFiles\7-Zip\7z.exe"
Set-Alias 7zip $7zipPath
$user = (Get-WmiObject -Class Win32_Process -Filter 'Name="explorer.exe"').
    GetOwner().
    User

function AnydeskInstall {
	$url = "https://download.anydesk.com/AnyDesk.exe"
	Invoke-WebRequest -Uri $url -OutFile "C:\Users\$user\Downloads\AnyDesk.exe"
	cd "C:\Users\$user\Downloads" 
	$arguments = "--install `"${env:ProgramFiles}\AnyDesk`" --silent --remove-first --create-shortcuts --create-desktop-icon"
	Start-Process AnyDesk.exe -ArgumentList $arguments -Wait
	Write-Host "Anydesk instalado com sucesso!!!"
    Write-Host "Aguarde ate que o programa seja incializado automaticamente" -ForegroundColor Black -BackgroundColor Green
    Write-Host "Caso nao visualize na tela, o icone fica proximo ao relogio na bandeja, icone vermelho!" -ForegroundColor Black -BackgroundColor Green
    pause
}

function AmmyInstall {
    $url = "https://troantunes.000webhostapp.com/ammy.7z"
    Invoke-WebRequest -Uri $url -OutFile "C:\Users\$user\Desktop\ammy.7z"
    cd C:\Users\$user\Desktop
    7zip x ammy.7z
    Start-Process ammy.exe
	Write-Host "Ammyy instalado com sucesso!!!"
    Write-Host "Aguarde ate que o programa seja incializado automaticamente" -ForegroundColor Black -BackgroundColor Green
    pause
}

function TVInstall {
	$url = "https://download.teamviewer.com/download/TeamViewerQS.exe"
	Invoke-WebRequest -Uri $url -OutFile "C:\Users\$user\Desktop\TeamViwer.exe"
	Start-Process "C:\Users\$user\Desktop\remoto.exe"
	Write-Host "TeamViewer instalado com sucesso!!!"
    Write-Host "Aguarde ate que o programa seja incializado automaticamente" -ForegroundColor Black -BackgroundColor Green
    pause
}

function Show-Menu {
	Write-Host '1 - Instalar Teamviewer'
	Write-Host '2 - Instalar Anydesk'
    Write-Host '3 - Instalar Ammyy Admin'
	$selection = Read-Host "Escolha uma opcao"
	switch ($selection)
	{
	    '1' 
		{
			TVInstall
	    } 
		'2'
		{
			AnydeskInstall
	    }
        '3'
		{
			AmmyInstall
	    }
		'q'
		{
	        return
	    }
	 }
 }

Show-Menu
