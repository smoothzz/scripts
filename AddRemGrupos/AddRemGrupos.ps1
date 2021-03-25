Import-Module Activedirectory

Remove-Variable * -ErrorAction SilentlyContinue

function SelectVPN {
	Write-Host '1 - VPN SSL'
	Write-Host '2 - VPN SSL 02'
    Write-Host '3 - VPN SSL 03'
	Write-Host '4 - VPN SSL 04'
	Write-Host '5 - VPN SSL 05'
    Write-Host '6 - VPN SSL 06'
    Write-Host '7 - VPN SSL 07'
    Write-Host '8 - VPN RDP FILIAL'
    Write-Host 'q - Sair'

	    $selection = Read-Host "Escolha qual VPN atribuir"
	    switch ($selection)
	    {
	        '1' 
		    {
                "G_VPN_SSL"
	        } 
		    '2'
		    {
			    "G_VPN_SSL02"
	        }
            '3'
		    {
			    "G_VPN_SSL03"
	        }
		    '4' 
		    {
			    "G_VPN_SSL04"
	        }
            '5'
            {
                "G_VPN_SSL05"
            }
            '6'
            {
                "G_VPN_SSL06"
            }
            '7'
            {
                "G_VPN_SSL07"
            }
            '8'
            {
                "G_VPN_SSL_RDP"
            }
	     }
}

function checkCsvAndDelete{
    $CSV1 = "erro.csv"
    $CSV2 = "LoginsVPN.csv"
    $CSV3 = "VpnAtribuidas.csv"
    $CSV4 = "VpnRemovidas.csv"
    if (Test-Path $CSV1) 
    {
    Remove-Item $CSV1
    }
    if (Test-Path $CSV2) 
    {
    Remove-Item $CSV2
    }
    if (Test-Path $CSV3) 
    {
    Remove-Item $CSV3
    }
    if (Test-Path $CSV4) 
    {
    Remove-Item $CSV4
    }
}

function removeGruposVPN {
    checkCsvAndDelete
	$Users = Import-CSV -Path "./csv/logins.csv" -Delimiter ";"

	foreach ($User in $Users)
	{
        $Name = $User.logins
        $aduser = get-aduser -Filter {SamAccountName -eq $Name} | Select-Object SamAccountName | select -ExpandProperty 'SamAccountName'

        if ($null -eq $aduser) 
        {
                Write-Host 'Login não encontrado: '$Name
                $exportObject = [pscustomobject] @{
                Login = $Name;
            }
	    $exportObject | Export-Csv erro.csv -NoTypeInformation -append
        }
        else
        {
            $groups = (Get-ADUser -Identity $Name -Properties MemberOf|select MemberOf).MemberOf| Get-ADGroup|select -ExpandProperty 'Name'
            $grupo = $groups | Select-String -Pattern 'G_VPN_'
            $grupo | ConvertTo-Json
            if ($null -eq $grupo){
                Write-Host 'Login nao possui grupo de VPN:'$Name
            }
            $VPN =  $grupo.Line[0..6]
            foreach ($g in $VPN) {
                if ($null -eq $grupo)
                {
                    Write-Host 'Login nao possui grupo de VPN:'$Name
                }
                else
                {
                    Remove-ADGroupMember -Identity $g -Member $Name -Confirm:$false
                    Write-Host 'Grupo removido:'$g
                }
            }
            $login = $Name
            if (!$grupo){
            $grupo = 'Nao possui VPN'
            }
            $exportObject = [pscustomobject] @{
                Login = $login;
                Grupo = $grupo -join ','

            }
	        $exportObject | Export-Csv VpnRemovidas.csv -Delimiter ';' -NoTypeInformation -append
        }
    }
    Remove-Variable * -ErrorAction SilentlyContinue
	Pause
	cls
	return Show-Menu 
}

function grupoVpnPorLogin {
    checkCsvAndDelete
	$Users = Import-CSV -Path "./csv/logins.csv" -Delimiter ";"

	foreach ($User in $Users)
	{
        $Name = $User.logins
        $aduser = get-aduser -Filter {SamAccountName -eq $Name} | Select-Object SamAccountName | select -ExpandProperty 'SamAccountName'

        if ($null -eq $aduser) 
        {
                Write-Host 'Login não encontrado: '$Name
                $exportObject = [pscustomobject] @{
                Login = $Name;
            }
	    $exportObject | Export-Csv erro.csv -NoTypeInformation -append
        }
        else
        {
            $groups = (Get-ADUser -Identity $Name -Properties MemberOf|select MemberOf).MemberOf| Get-ADGroup|select -ExpandProperty 'Name'
            $grupo = $groups | Select-String -Pattern 'G_VPN_'
            Write-Host 'Login verificado:'$Name
            $login = $Name
            if (!$grupo){
            $grupo = 'Nao possui'
            }
            $exportObject = [pscustomobject] @{
                Login = $login;
                Grupo = $grupo -join ','
            }
	        $exportObject | Export-Csv LoginsVPN.csv -Delimiter ';' -NoTypeInformation -append
        }
    } 	
    Remove-Variable * -ErrorAction SilentlyContinue
	Pause
	cls
	return Show-Menu
}

function atribuirVPN {
    checkCsvAndDelete
	$Users = Import-CSV -Path "./csv/logins.csv" -Delimiter ";"

	foreach ($User in $Users)
	{
        $Name = $User.logins
        $aduser = get-aduser -Filter {SamAccountName -eq $Name} | Select-Object SamAccountName | select -ExpandProperty 'SamAccountName'

        if ($null -eq $aduser) 
        {
                Write-Host 'Login não encontrado: '$Name
                $exportObject = [pscustomobject] @{
                Login = $Name;
            }
	    $exportObject | Export-Csv erro.csv -NoTypeInformation -append
        }
        else
        {
            $grupo = SelectVPN
            Add-ADGroupMember -Identity $grupo -Members $Name
            $login = $Name
            $exportObject = [pscustomobject] @{
                Login = $login;
                Grupo = $grupo -join ','
            }
	        $exportObject | Export-Csv VpnAtribuidas.csv -Delimiter ';' -NoTypeInformation -append
        }
    } 	
    Remove-Variable * -ErrorAction SilentlyContinue
	Pause
	cls
	return Show-Menu
}

function atribuirVpnPorNome {
    checkCsvAndDelete

    $Name = Read-Host 'Digite o nome do usuario'
    $search = get-aduser -f {name -like $Name} -Properties * | Select-Object SamAccountName, DistinguishedName, EmployeeNumber, EmployeeID, Department, Created | format-list
    if ($null -eq $search)
    {
        Write-Host 'Login não encontrado:' $Name
    }
    else
    {
        $search
        $reply = Read-Host -Prompt "É esse usuario que deseja atribuir VPN??[s/n]"
        if ( $reply -match "[sS]" )
        {
            $aduser = get-aduser -Filter {Name -eq $Name} | Select-Object SamAccountName | select -ExpandProperty 'SamAccountName'

            if ($null -eq $aduser) 
            {
                Write-Host 'Login não encontrado: '$Name
                $exportObject = [pscustomobject] @{
                    Login = $Name;
                    }
                    $exportObject | Export-Csv erro.csv -NoTypeInformation -append
            }
            else
            {
                $grupo = SelectVPN
                Add-ADGroupMember -Identity $grupo -Members $aduser
                Write-Host 'Grupo de VPN atribuido para o usuario:' $Name $grupo
                $login = $Name
                $exportObject = [pscustomobject] @{
                    Login = $Name;
                    Grupo = $grupo -join ','
                    }
                $exportObject | Export-Csv VpnAtribuidas.csv -Delimiter ';' -NoTypeInformation -append
            }    
        }
        Remove-Variable * -ErrorAction SilentlyContinue
	    Pause
	    cls
	    return Show-Menu
    }
}

function Show-Menu {
	Write-Host '1 - Econtrar os o grupo de VPN por Login'
	Write-Host '2 - Remover grupos de VPN por Login'
    Write-Host '3 - Atribuir grupo de VPN pelo Login'
    Write-Host '4 - Atribuir VPN por nome'
    Write-Host 'q - Sair'

    Do 
    {
	    $selection = Read-Host "Escolha uma opção"
	    switch ($selection)
	    {
	        '1' 
		    {
			    grupoVpnPorLogin
	        } 
		    '2'
		    {
			    removeGruposVPN
	        }
            '3'
		    {
			    atribuirVPN
	        }
            '4'
            {
                atribuirVpnPorNome
            }
	     }
    }Until ($selection -eq 'q')

}

Show-Menu