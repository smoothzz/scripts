Import-Module Activedirectory

Remove-Variable * -ErrorAction SilentlyContinue

function checaStatus {
	$Users = Import-CSV -Path "./csv/logins.csv" -Delimiter ";"

	foreach ($User in $Users)
	{
        $Name = $User.login
        $aduser = get-aduser -Filter {Name -eq $Name} | Select-Object SamAccountName | select -ExpandProperty 'SamAccountName'
        
        $data = $User.date

        $modified = Get-ADUser -filter {SamAccountName -eq $aduser} -properties * | Select-Object Modified | Format-Wide

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
            if ($modified -lt $data)
            {
                $exportObject = [pscustomobject] @{
                    Nome = $Name;
                    Login = $aduser -join ',';
                    Status = 'OK'
                }
	            $exportObject | Export-Csv status.csv -Delimiter ';' -NoTypeInformation -append            
            }
            else
            {
                $exportObject = [pscustomobject] @{
                    Nome = $Name;
                    Login = $aduser -join ',';
                    Status = 'Irregular'
                }
	            $exportObject | Export-Csv status.csv -Delimiter ';' -NoTypeInformation -append
                     
            }            
        }
    }
}
checaStatus