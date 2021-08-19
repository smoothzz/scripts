Import-Module Activedirectory

Remove-Variable * -ErrorAction SilentlyContinue

function RemoveGrupos {
	$reply = Read-Host -Prompt "Tem certeza que deseja continuar?[s/n]"
	if ( $reply -match "[sS]" ) 
	{ 
		$Users = Import-CSV -Path $PSScriptRoot\csv\logins.csv -Delimiter ';'

		foreach ($User in $Users)
		{
			Try
			{
				Get-AdPrincipalGroupMembership -Identity $User.login | Where-Object -Property Name -Ne -Value 'Domain Users' | Remove-AdGroupMember -Members $User.login -Confirm:$false
                Write-Host 'Realizda procedimento login: '$User.login

			}
			Catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
			{ 
				Write-Error "" -ErrorAction SilentlyContinue -ErrorVariable ProcessError
				if ($ProcessError)
				{
                Write-Output $User.login | Out-File $PSScriptRoot\loginserro.txt -append 
				Write-Host "Login não encontrado: "$User.login
				}  
			}    
		}
	} 
	else 
	{
		Write-Host 'Opção de saida do script'
		Remove-Variable * -ErrorAction SilentlyContinue
		pause
	}
}

RemoveGrupos