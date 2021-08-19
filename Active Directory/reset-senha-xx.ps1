function novoPadrao {
    $login = Read-Host 'Digite o login do usuario'
    $aduser = get-aduser $login -Properties * | Select-Object -ExpandProperty DisplayName -ErrorAction SilentlyContinue

    if (!$aduser)
    {
        Write-Host ""
		Write-Host "Login nao encontrado!" -ForegroundColor Black -BackgroundColor Red    
    }
    else
    {
        $cpf = Get-ADUser -Filter {samaccountname -eq $login} -Properties * | select -ExpandProperty employeenumber

        if (!$cpf)
        {
            Write-Host 'Usuario não possui CPF cadastrado!'
        }
        else
        {
            $senha = 'Xx@'+$cpf
            Set-ADAccountPassword -Identity $login -NewPassword (ConvertTo-SecureString -AsPlainText $Senha -Force)
            Write-Host 'Senha resatada com sucesso!' -ForegroundColor Black -BackgroundColor Green
        }
    }
}

novoPadrao