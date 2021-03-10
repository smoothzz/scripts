function ResetSenhaLote {
	$reply = Read-Host -Prompt "Tem certeza que deseja continuar?[s/n]"
	if ( $reply -match "[sS]" ) 
	{ 
		$Users = Import-CSV -Path "..\csv\logins.csv" | ForEach-Object {$_.logins}

		foreach ($User in $Users)
		{
			Try
			{
				$cpf = (Get-ADUser -Identity $User -Properties EmployeeNumber|select EmployeeNumber).EmployeeNumber | where manager -eq $null
				if (!$cpf)
				{
                    Write-Host "Login não possue CPF cadastrado"
                }
                else
                {
                $Password = 'Xx@'+$cpf
                Set-ADAccountPassword -Identity $User -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)
				Set-aduser $User -changepasswordatlogon $true
				Write-Host 'Senha resetada $Password' -ForegroundColor Black -BackgroundColor Green
				Remove-Variable * -ErrorAction SilentlyContinue
				Pause
                }				
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