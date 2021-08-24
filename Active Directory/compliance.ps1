Remove-Variable * -ErrorAction SilentlyContinue

function compliance {
	$Users = Import-CSV -Path "./csv/desativados.csv" -Delimiter ";"

	foreach ($User in $Users)
	{
        $nc = $User.nc
        $funcionario = $User.funcionario
        $cpf = $User.cpf
        $Name = $User.login
        $aduser = get-aduser -Filter {SamAccountName -eq $Name} | Select-Object SamAccountName | select -ExpandProperty 'SamAccountName'

        if ($null -eq $aduser) 
        {
                Write-Host 'Login nao encontrado: '$Name
                $exportObject = [pscustomobject] @{
                Login = $Name;
                Nome = $User.funcionario
                NC = $User.nc;
                CPF = $User.cpf;
            }
	    $exportObject | Export-Csv LoginsErro.csv -NoTypeInformation -append
        }
        else
        {
            $groups = (Get-ADUser -Identity $Name -Properties MemberOf|select MemberOf).MemberOf| Get-ADGroup|select -ExpandProperty 'Name'
            $dados = Get-ADUser -Filter {samaccountname -eq $Name} -Properties * | select name, samaccountname, employeenumber, employeeid, description, enabled
            if (!$groups){
            $groups = 'Nao possui Grupo'
            }
            $exportObject = [pscustomobject] @{
                Login = $Name;
                Grupo = $groups -join ',';
                Nome = $dados.name;
                CPF = $dados.employeenumber;
                NC = $dados.employeeid;
                Descricao = $dados.description;
                Ativo = $dados.enabled
            }
	        $exportObject | Export-Csv logins.csv -Delimiter ';' -NoTypeInformation -append
        }
    }
}
compliance