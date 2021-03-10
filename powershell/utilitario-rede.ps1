function doTracert {
$dominio = Read-Host 'Digite o dominio'
tracert $dominio
Remove-Variable * -ErrorAction SilentlyContinue
Pause
Show-Menu
}

function doPing {
$dominio = Read-Host 'Digite o dominio'
ping /n 10 $dominio
Remove-Variable * -ErrorAction SilentlyContinue
Pause
Show-Menu
}

function doTelnet {
$dominio = Read-Host 'Digite o dominio'
$porta = Read-Host 'Digite a porta'
$connection = New-Object System.Net.Sockets.TcpClient($dominio, $porta)
if ($connection.Connected) {
    Write-Host "Success"
}
else {
    Write-Host "Failed"
}

Pause
Show-Menu
}

function Show-Menu {
	Write-Host '1 - Ping'
	Write-Host '2 - Tracert'
    Write-Host '3 - Telnet'
    Write-Host 'q - Sair'

    Do 
    {
	    $selection = Read-Host "Escolha uma opção"
	    switch ($selection)
	    {
	        '1' 
		    {
			    doPing
	        } 
		    '2'
		    {
			    doTracert
	        }
            '3'
		    {
			    doTelnet
	        }

	     }
    }Until ($selection -eq 'q')

}

Show-Menu