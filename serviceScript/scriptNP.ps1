Import-Module Activedirectory

do
 {
    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    {
    '1' {
    'Reset de senha #1'
    ResetSenha
    } '2' {
    'Pesquisar Usuario #2'
    PesquisaUser
    } 
    }
    pause
 }
 until ($selection -eq 'q')

function ResetSenha {
$login = Read-Host 'Digite o login para resetar!'
$a = get-aduser $login -Properties * | Select-Object -ExpandProperty DisplayName
$a.split(' ') | foreach {$b += $_[0]}
$user = $b.ToLower()
$Password = $user.substring(0,1).toupper()+$user.substring(1,1).tolower()+123456
Set-ADAccountPassword -Identity $login -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)
Write-Host 'Nome: '$a
Write-Host 'Login: '$login
Write-Host 'Senha: '$Password
Write-Host 'Senha reseta conforme solicitado!'
Remove-Variable * -ErrorAction SilentlyContinue
return
}

function PesquisaUser {
$user = Read-Host 'Digite o nome para pesquisar!'
$searchUser="*$user*"
get-aduser -f {name -like $searchUser} | Select-Object -ExpandProperty DistinguishedName
Remove-Variable * -ErrorAction SilentlyContinue
return
}