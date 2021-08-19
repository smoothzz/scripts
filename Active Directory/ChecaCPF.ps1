Import-Module Activedirectory

Remove-Variable * -ErrorAction SilentlyContinue

function ChecaTudo {
	$Users = Import-CSV -Path "./csv/logins.csv" -Delimiter ";"

	foreach ($User in $Users)
	{
        $date = $User.date
        $Name = $User.login
        $aduser = get-aduser -Filter {Name -eq $Name} | Select-Object SamAccountName | select -ExpandProperty 'SamAccountName'
        if ($null -eq $aduser) 
        {
                Write-Host 'Usuario não encontrado: '$Name
                $exportObject = [pscustomobject] @{
                Nome = $Name;
            }
	    $exportObject | Export-Csv LoginsErro.csv -NoTypeInformation -append
        }
        else
        {
            $cpf = Get-ADUser -Filter {SamAccountName -eq $aduser} -Properties * | select -ExpandProperty 'EmployeeNumber'
            $enabled = Get-ADUser -Filter {SamAccountName -eq $aduser} -Properties * | select -ExpandProperty 'Enabled'
            $memberof = (Get-ADUser -Identity $aduser -Properties MemberOf|select MemberOf).MemberOf| Get-ADGroup|select -ExpandProperty 'Name'
            $OU = Get-ADUser -Filter {SamAccountName -eq $aduser} -Properties * | select -ExpandProperty 'DistinguishedName'

            if ($enabled -eq 'TRUE')
            {
                $status = 'ATIVO'
            }
            else
            {
                $status = 'INATIVO'            
            }

            Write-Host 'Verificado:' $Name

            $exportObject = [pscustomobject] @{
                Nome = $Name;
                Login = $aduser -join ',';
                Cpf = $cpf -join ','
                Status = $status;
                Recisao = $date;
                Grupos = $memberof -join ','
                OU = $OU
            }
	        $exportObject | Export-Csv tudo.csv -Delimiter ';' -NoTypeInformation -append
        }
    }
}
ChecaTudo