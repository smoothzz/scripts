Remove-Variable * -ErrorAction SilentlyContinue

function checaGrupos {
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
	    $exportObject | Export-Csv LoginsErro.csv -NoTypeInformation -append
        }
        else
        {
            $groups = (Get-ADUser -Identity $Name -Properties MemberOf|select MemberOf).MemberOf| Get-ADGroup|select -ExpandProperty 'Name'
            if ($null -eq $groups){
                Write-Host 'Login nao possui grupo:'$Name
            }
            if (!$groups){
            $groups = 'Nao possui Grupo'
            }
            $exportObject = [pscustomobject] @{
                Login = $Name;
                Grupo = $groups -join ','

            }
	        $exportObject | Export-Csv Grupos.csv -Delimiter ';' -NoTypeInformation -append
        }
    }
}
checaGrupos