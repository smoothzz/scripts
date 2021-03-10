Import-Module Activedirectory

Remove-Variable * -ErrorAction SilentlyContinue

function ResetSenha {
	$login = Read-Host 'Digite o login para resetar!'
	$aduser = get-aduser $login -Properties * | Select-Object -ExpandProperty DisplayName
	$Password = $login.substring(0,1).toupper()+$login.substring(1,1).tolower()+123456
	Write-Host 'Nome: '$aduser
	Write-Host 'Login: '$login
	Write-Host 'Nova Senha: '$Password -ForegroundColor Black -BackgroundColor Green
	$reply = Read-Host -Prompt "Tem certeza que deseja continuar?[s/n]"
	if ( $reply -match "[sS]" ) { 
		Set-ADAccountPassword -Identity $login -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)
		Write-Host ''
		Write-Host 'Senha resetada conforme solicitado!' -ForegroundColor Black -BackgroundColor White
		Remove-Variable * -ErrorAction SilentlyContinue
		Pause
		cls
		return Show-Menu
		} else {
		Write-Host 'Cancelando solicitação...'
		Remove-Variable * -ErrorAction SilentlyContinue
		Pause
		cls
		return Show-Menu
		}
}

function PesquisaUserNome {
	$user = Read-Host 'Digite o nome para pesquisar!'
	$searchUser="*$user*"
	get-aduser -f {name -like $searchUser} | Select-Object SamAccountName, DistinguishedName, Enabled | format-list
	Remove-Variable * -ErrorAction SilentlyContinue
	Pause
	cls
	return Show-Menu
}

function PesquisaUserLogin {
	$user = Read-Host 'Digite o login para pesquisar!'
	$searchUser="*$user*"
	get-aduser -f {SamAccountName -like $searchUser} | Select-Object SamAccountName, name, DistinguishedName, Enabled | format-list
	Remove-Variable * -ErrorAction SilentlyContinue
	Pause
	cls
	return Show-Menu
}

function ResetSenhaLote {
	$reply = Read-Host -Prompt "Tem certeza que deseja continuar?[s/n]"
	if ( $reply -match "[sS]" ) 
	{ 
		$Users = Import-CSV -Path "..\csv\logins.csv" | ForEach-Object {$_.logins}

		foreach ($User in $Users)
		{
			Try
			{
				$aduser = get-aduser $User -Properties * | Select-Object -ExpandProperty DisplayName
				$Password = $User.substring(0,1).toupper()+$User.substring(1,1).tolower()+123456 
				Write-Host 'Nome: '$aduser
				Write-Host 'Login: '$User
				Write-Host 'Nova Senha: '$Password -ForegroundColor Black -BackgroundColor Green
				Set-ADAccountPassword -Identity $login -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)
				Remove-Variable * -ErrorAction SilentlyContinue
			}
			Catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
			{ 
				Write-Error "" -ErrorAction SilentlyContinue -ErrorVariable ProcessError
				if ($ProcessError)
				{
				Write-Host "Login não encontrado : $User" -ForegroundColor Black -BackgroundColor Red
				}  
			}    
		}
	} 
	else 
	{
		Remove-Variable * -ErrorAction SilentlyContinue
		Pause
		cls
		return Show-Menu
	}
		pause
		Remove-Variable * -ErrorAction SilentlyContinue
		cls
		return Show-Menu
}

function MostrarGrupos {
	$usernp = Read-Host 'Digite o login para pesquisar!'
	(Get-ADUser -Identity $usernp -Properties MemberOf|select MemberOf).MemberOf| Get-ADGroup|select Name|sort name|format-wide
	Remove-Variable * -ErrorAction SilentlyContinue
	Pause
	cls
	return Show-Menu
}

function DesbloquearLogin {
	$login = Read-Host 'Digite o login para desbloquear!'
	$aduser = get-aduser $login -Properties * | Select-Object -ExpandProperty DisplayName
	Write-Host 'Nome: '$aduser
	Write-Host 'Login: '$login
	$reply = Read-Host -Prompt "Tem certeza que deseja continuar?[s/n]"
	if ( $reply -match "[sS]" ) { 
        Unlock-ADAccount -Identity $login
		Write-Host ''
		Write-Host 'Login desbloqueado conforme solicitado!' -ForegroundColor Black -BackgroundColor White
		Remove-Variable * -ErrorAction SilentlyContinue
		Pause
		cls
		return Show-Menu
		} else {
		Write-Host 'Cancelando solicitação...'
		Remove-Variable * -ErrorAction SilentlyContinue
		Pause
		cls
		return Show-Menu
		}
}

function Show-Menu {
	Write-Host '1 - Resetar senha'
	Write-Host '2 - Bucar usuario por nome'
    Write-Host '3 - Bucar usuario por Login'
	Write-Host '4 - Mostrar grupos'
	Write-Host '5 - Resetar senha em lote'
    Write-Host '6 - Desbloquear login'
	$selection = Read-Host "Escolha uma opção"
	switch ($selection)
	{
	    '1' 
		{
			ResetSenha
	    } 
		'2'
		{
			PesquisaUserNome
	    }
        '3'
		{
			PesquisaUserLogin
	    }
		'4' 
		{
			MostrarGrupos
	    }
		'5' 
		{
			ResetSenhaLote
	    }
        '6' 
		{
			DesbloquearLogin
	    }
		'q'
		{
	        return
	    }
	 }
 }

Show-Menu