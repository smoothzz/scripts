function ResetSenhaLote {
	$reply = Read-Host -Prompt "Tem certeza que deseja continuar?[s/n]"
	if ( $reply -match "[sS]" ) 
	{ 
		$Users = Import-CSV -Path "..\csv\logins.csv" | ForEach-Object {$_.logins}

		foreach ($User in $Users)
		{
			Try
			{
				$cpf = '@'+(Get-ADUser -Identity $login -Properties EmployeeNumber|select EmployeeNumber).EmployeeNumber
				$Password = ($login.substring(0,1).toupper()+$login.substring(1,1).tolower())+$cpf
				Set-ADAccountPassword -Identity $login -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)
				Set-aduser $login -changepasswordatlogon $true
				Write-Host 'Senha resetada $Password' -ForegroundColor Black -BackgroundColor Green
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


If (Get-ADUser -Filter {SamAccountName -eq $login}) 
    { 
	$cpf = '@'+(Get-ADUser -Identity $login -Properties EmployeeNumber|select EmployeeNumber).EmployeeNumber
	$Password = ($login.substring(0,1).toupper()+$login.substring(1,1).tolower())+$cpf
	Set-ADAccountPassword -Identity $login -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)
	Set-aduser $login -changepasswordatlogon $true
	Write-Host 'Senha resetada $Password' -ForegroundColor Black -BackgroundColor Green
   }
    Else
    {
       Write-Host "Desculpe, $login não existe" -ForegroundColor RED
    }