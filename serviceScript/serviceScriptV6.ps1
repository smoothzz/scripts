Import-Module Activedirectory

Remove-Variable * -ErrorAction SilentlyContinue

function ResetSenha {
	$login = Read-Host 'Digite o login para resetar!'
	$aduser = get-aduser $login -Properties * | Select-Object -ExpandProperty DisplayName -ErrorAction SilentlyContinue
	if (!$aduser)
	{
		Write-Host ""
		Write-Host "Login nao encontrado!" -ForegroundColor Black -BackgroundColor Red
		Pause
		cls
		return Show-Menu
	}
	else
	{
		$Password = $login.substring(0,1).toupper()+$login.substring(1,1).tolower()+123456
		Write-Host 'Nome: '$aduser
		Write-Host 'Login: '$login
		Write-Host 'Nova Senha: '$Password -ForegroundColor Black -BackgroundColor Green
		$reply = Read-Host -Prompt "Tem certeza que deseja continuar?[s/n]"
		if ( $reply -match "[sS]" )
		{ 
			Set-ADAccountPassword -Identity $login -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)
			Write-Host ''
			Write-Host 'Senha resetada conforme solicitado!' -ForegroundColor Black -BackgroundColor White
			Remove-Variable * -ErrorAction SilentlyContinue
			Pause
			cls
			return Show-Menu
		}
		else
		{
			Write-Host 'Cancelando solicitação...'
			Remove-Variable * -ErrorAction SilentlyContinue
			Pause
			cls
			return Show-Menu
		}
	}
}

function PesquisaUserNome {
	$user = Read-Host 'Digite o nome para pesquisar!'
	$searchUser="*$user*"
	$search = get-aduser -f {name -like $searchUser} | Select-Object SamAccountName, DistinguishedName, Enabled | format-list
	if (!$search)
	{
		Write-Host "Nome nao encontrado!" -ForegroundColor Black -BackgroundColor Red
	}
	else
	{
		$search
	}
	Remove-Variable * -ErrorAction SilentlyContinue
	Pause
	cls
	return Show-Menu
}

function PesquisaUserLogin {
	$user = Read-Host 'Digite o login para pesquisar!'
	$searchUser="*$user*"
	$search = get-aduser -f {SamAccountName -like $searchUser} | Select-Object SamAccountName, name, DistinguishedName, Enabled | format-list
	if(!$search)
	{
		Write-Host "Login nao encontrado!" -ForegroundColor Black -BackgroundColor Red
	}
	else
	{
		$search
	}
	Remove-Variable * -ErrorAction SilentlyContinue
	Pause
	cls
	return Show-Menu
}

function ResetSenhaLote {
	$reply = Read-Host -Prompt "Tem certeza que deseja continuar?[s/n]"
	if ( $reply -match "[sS]" ) 
	{ 
		$Users = Import-CSV -Path "./csv/logins.csv" | ForEach-Object {$_.logins}

		foreach ($User in $Users)
		{
			Try
			{
				$aduser = get-aduser $User -Properties * | Select-Object -ExpandProperty DisplayName
				$Password = $User.substring(0,1).toupper()+$User.substring(1,1).tolower()+123456 
				Write-Host 'Nome: '$aduser
				Write-Host 'Login: '$User
				Write-Host 'Nova Senha: '$Password -ForegroundColor Black -BackgroundColor Green                
				Set-ADAccountPassword -Identity $User -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)
                Unlock-ADAccount -Identity $User
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

function PesquisaCPF {
	$login = Read-Host 'Digite o login para pesquisar o CPF!'
	$cpf = (Get-ADUser -Identity $login -Properties EmployeeNumber|select EmployeeNumber).EmployeeNumber
    if (!$cpf)
    {
    Write-Host 'Usuario não possue cpf cadastrado' -ForegroundColor Black -BackgroundColor Red
    }
    else
    {
	Write-Host 'Login:'$login 'CPF:' $cpf -ForegroundColor Black -BackgroundColor Green
    }
	Remove-Variable * -ErrorAction SilentlyContinue
	Pause
	cls
	return Show-Menu
}

function BuscaLoginPorNomeEmLote {
    Write-Host "Para usar essa funcao a planilha user em /csv deve estar preenchida com o nome do ci na coluna users, caso ainda nao esteja favor pressionar N e tentar novamente apos preencher!" -ForegroundColor Black -BackgroundColor Red
	$reply = Read-Host -Prompt "Tem certeza que deseja continuar?[s/n]"
	if ( $reply -match "[sS]" ) 
	{ 
		$Users = Import-CSV -Path "./csv/users.csv" | ForEach-Object {$_.users}

		$result = foreach ($User in $Users)
		{
			Try
			{
				$searchUser="*$User*"
				$search = get-aduser -f {name -like $searchUser} | Select-Object SamAccountName, Name | format-list
                $search
				Remove-Variable * -ErrorAction SilentlyContinue
			}
			Catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
			{ 
				Write-Error "" -ErrorAction SilentlyContinue -ErrorVariable ProcessError
				if ($ProcessError)
				{
				Write-Host "Nome não encontrado : $User" -ForegroundColor Black -BackgroundColor Red
				}  
			}    
		}
        $result | Out-File ./txt/Users.txt
        Write-host "Realtorio gerado na pasta TXT/Users.txt" -ForegroundColor Black -BackgroundColor Green
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

function BuscarDadosCompleto {
	$user = Read-Host 'Digite o nome para pesquisar!'
	$searchUser="*$user*"
	$search = get-aduser -f {name -like $searchUser} -Properties * | Select-Object SamAccountName, DistinguishedName, EmployeeNumber, EmployeeID, Department, Created | format-list
	if (!$search)
	{
		Write-Host "Nome nao encontrado!" -ForegroundColor Black -BackgroundColor Red
	}
	else
	{
		$search
	}
	Remove-Variable * -ErrorAction SilentlyContinue
	Pause
	cls
	return Show-Menu
}

function BuscaDadosPeloCPF {
	$cpf = Read-Host 'Digite o cpf para pesquisar!'
	$search = get-aduser -f {employeenumber -eq $cpf} -Properties * | Select-Object SamAccountName, DistinguishedName, EmployeeNumber, EmployeeID, Department, Created, Enabled | format-list
	if (!$search)
	{
		Write-Host "Nome nao encontrado!" -ForegroundColor Black -BackgroundColor Red
	}
	else
	{
		$search
	}
	Remove-Variable * -ErrorAction SilentlyContinue
	Pause
	cls
	return Show-Menu
}

function InseriGrupo {
	$login = Read-Host 'Digite o login do C.I'
	$grupo = Read-Host 'Digite o grupo'

    $aduser = get-aduser $login -Properties * | Select-Object -ExpandProperty DisplayName -ErrorAction SilentlyContinue
	if (!$aduser)
	{
		Write-Host ""
		Write-Host "Login nao encontrado!" -ForegroundColor Black -BackgroundColor Red
		Pause
		cls
		return Show-Menu
	}
	else
	{
	    Add-ADGroupMember -Identity $grupo -Members $login
        (Get-ADUser -Identity $login -Properties MemberOf|select MemberOf).MemberOf| Get-ADGroup|select Name|sort name|format-wide
	    Remove-Variable * -ErrorAction SilentlyContinue
	    Pause
	    cls
	    return Show-Menu        
	}	
}

function Show-Menu {
	Write-Host '1  - Resetar senha'
	Write-Host '2  - Buscar usuario por nome'
    Write-Host '3  - Buscar usuario por Login'
	Write-Host '4  - Mostrar grupos'
	Write-Host '5  - Resetar senha em lote'
    Write-Host '6  - Buscar Login por Usuario em lote'
    Write-Host '7  - Buscar dados do c.i completo'
    Write-Host '8  - Desbloquear login'
	Write-Host '9  - Pesquisar CPF pelo login'
    Write-Host '10 - Pesquisar dados pelo CPF'
    Write-Host '11 - Inserir Login em Grupo'
    Write-Host 'q - Sair'

    Do 
    {
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
                BuscaLoginPorNomeEmLote
            }
            '7' 
		    {
			    BuscarDadosCompleto
	        }
			'8' 
		    {
			    DesbloquearLogin
	        }
            '9' 
		    {
                PesquisaCPF
	        }
            '10' 
		    {
                BuscaDadosPeloCPF
	        }
            '11' 
		    {
                InseriGrupo
	        }

	     }
    }Until ($selection -eq 'q')

}

Show-Menu