$DomainName = Read-Host "Domain name"
$ComputerName = $env:Computername
$UserName = Read-Host "User name"
$AdminGroup = [ADSI]"WinNT://$ComputerName/Administradores,group"
$User = [ADSI]"WinNT://$DomainName/$UserName,user"
$AdminGroup.Add($User.Path)