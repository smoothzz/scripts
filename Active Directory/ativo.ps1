Import-Module Activedirectory

Remove-Variable * -ErrorAction SilentlyContinue

function checaStatus {
	$Users = Import-CSV -Path "./csv/logins.csv" -Delimiter ";"

	foreach ($User in $Users)
	{
        $Name = $User.login
        $aduser = get-aduser -Filter {SamAccountName -eq $Name} | Select-Object Enabled | select -ExpandProperty 'Enabled'

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
                    Login = $Name;
                    Status = $aduser
                }
	            $exportObject | Export-Csv status.csv -Delimiter ';' -NoTypeInformation -append           
        }
    }
}
checaStatus