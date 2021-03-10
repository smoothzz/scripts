$name = Read-Host 'Digite o nome completo'
$namead = ( Get-Culture ).TextInfo.ToTitleCase( $name.ToLower() )
$createlogin = $name.Split("").substring(0,1)
$createlogin = -join $createlogin
$createlogin = $createlogin.Substring(0,$createlogin.length-1)
$lastlogin = $name.Split(" ") | Select-Object -Last 1
$login = $createlogin+$lastlogin
$login