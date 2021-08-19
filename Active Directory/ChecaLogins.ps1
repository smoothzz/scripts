Import-Module Activedirectory

Remove-Variable * -ErrorAction SilentlyContinue

function checaLogins {
	$Users = Import-CSV -Path "./csv/logins.csv" -Delimiter ";"

	foreach ($User in $Users)
	{
        $Name = $User.login
        $aduser = get-aduser -Filter {Name -eq $Name} | Select-Object SamAccountName | select -ExpandProperty 'SamAccountName'

        if ($null -eq $aduser) 
        {
                Write-Host 'Usuario não encontrado: '$Name
                $exportObject = [pscustomobject] @{
                Login = $Name;
            }
	    $exportObject | Export-Csv LoginsErro.csv -NoTypeInformation -append
        }
        else
        {
            $exportObject = [pscustomobject] @{
                Nome = $Name;
                Login = $aduser -join ','

            }
	        $exportObject | Export-Csv Logins.csv -Delimiter ';' -NoTypeInformation -append
        }
    }
}
checaLogins