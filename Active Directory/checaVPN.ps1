Import-Module Activedirectory

Remove-Variable * -ErrorAction SilentlyContinue

function grupoVpnPorLogin {
	$Users = Import-CSV -Path "./csv/logins.csv" -Delimiter ";"

	foreach ($User in $Users)
	{
        $Name = $User.login
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
            $VPN =  $grupo.Line[0..6]
            foreach ($g in $VPN) {
            Write-Host 'Grupo removido:'$g
            }
            $login = $Name
            if (!$grupo){
            $grupo = 'Nao possui VPN'
            }
            $exportObject = [pscustomobject] @{
                Login = $login;
                Grupo = $grupo -join ','

            }
	        $exportObject | Export-Csv LoginsVPN.csv -Delimiter ';' -NoTypeInformation -append
        }
    } 
}

grupoVpnPorLogin