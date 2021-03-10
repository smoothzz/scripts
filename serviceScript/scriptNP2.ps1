Import-Module Activedirectory

function ResetSenha {
$login = Read-Host 'Digite o login para resetar!'
$aduser = get-aduser $login -Properties * | Select-Object -ExpandProperty DisplayName
$Password = $login.substring(0,1).toupper()+$login.substring(1,1).tolower()+123456
Write-Host 'Nome: '$aduser
Write-Host 'Login: '$login
Write-Host 'Senha: '$Password
$reply = Read-Host -Prompt "Tem certeza que deseja continuar?[s/n]"
if ( $reply -match "[sS]" ) { 
    Set-ADAccountPassword -Identity $login -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)
    Write-Host 'Senha resetada conforme solicitado!'
Remove-Variable * -ErrorAction SilentlyContinue
Pause
return Show-Menu
} else {
Write-Host 'Cancelando solicitação...'
Remove-Variable * -ErrorAction SilentlyContinue
Pause
return Show-Menu
}
}

function PesquisaUser {
$user = Read-Host 'Digite o nome para pesquisar!'
$searchUser="*$user*"
get-aduser -f {name -like $searchUser} | Select-Object SamAccountName, DistinguishedName, Enabled | format-list
Remove-Variable * -ErrorAction SilentlyContinue
Pause
cls
return Show-Menu
}

function ResetSenhaLote {
$reply = Read-Host -Prompt "Tem certeza que deseja continuar?[s/n]"
if ( $reply -match "[sS]" ) { 
$Users = Import-CSV -Path "C:\logins.csv" | ForEach-Object {$_.logins}

foreach ($User in $Users){
$aduser = get-aduser $User -Properties * | Select-Object -ExpandProperty DisplayName
$Password = $User.substring(0,1).toupper()+$User.substring(1,1).tolower()+123456
Write-Host 'Nome: '$aduser
Write-Host 'Login: '$User
Write-Host 'Senha: '$Password
Remove-Variable * -ErrorAction SilentlyContinue
}
}else{
Remove-Variable * -ErrorAction SilentlyContinue
Pause
cls
return Show-Menu
}
}

function Show-Menu {
 Write-Host '1 - Resetar senha'
 Write-Host '2 - Bucar Usuario por nome'
 Write-Host '3 - Resetar senha em lote'
 $selection = Read-Host "Escolha uma opção: "
 switch ($selection)
 {
     '1' {
            ResetSenha
     } '2' {
            PesquisaUser
     } '3' {
            ResetSenhaLote
     } 'q' {
         return
     }
 }
 }

Show-Menu