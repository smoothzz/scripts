Import-Module Activedirectory

function ResetSenha {
$login = Read-Host 'Digite o login para resetar!'
$a = get-aduser $login -Properties * | Select-Object -ExpandProperty DisplayName
$a.split(' ') | foreach {$b += $_[0]}
$user = $b.ToLower()
$Password = $user.substring(0,1).toupper()+$user.substring(1,1).tolower()+123456
Write-Host 'Nome: '$a
Write-Host 'Login: '$login
Write-Host 'Senha: '$Password
Write-Host 'Senha reseta conforme solicitado!'
Remove-Variable * -ErrorAction SilentlyContinue
Pause
return Show-Menu
}

function PesquisaUser {
$user = Read-Host 'Digite o nome para pesquisar!'
$searchUser="*$user*"
get-aduser -f {name -like $searchUser} | Select-Object -ExpandProperty DistinguishedName
Remove-Variable * -ErrorAction SilentlyContinue
return
}

function Show-Menu {
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
         'You chose option #1'
            ResetSenha
     } '2' {
         'You chose option #2'
 PesquisaUser
     } '3' {
         'You chose option #3'
     } 'q' {
         return
     }
 }
 }

 Show-Menu