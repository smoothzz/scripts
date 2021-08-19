Import-Module Activedirectory

Remove-Variable * -ErrorAction SilentlyContinue

function removeGruposPROXY {
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
            $grupo = $groups | Select-String -Pattern 'g_proxy'
            $grupo | ConvertTo-Json
            if ($null -eq $grupo){
                Write-Host 'Login nao possui grupo de Proxy:'$Name
            }
            $VPN =  $grupo.Line
            foreach ($g in $VPN) {
                if ($null -eq $grupo)
                {
                    Write-Host 'Login nao possui grupo de Proxy:'$Name
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
	        $exportObject | Export-Csv ProxyRemovidos.csv -Delimiter ';' -NoTypeInformation -append
        }
    }
}
removeGruposPROXY