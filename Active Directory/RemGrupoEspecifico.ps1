Import-Module Activedirectory

Remove-Variable * -ErrorAction SilentlyContinue

function removeGrupo {
	$Users = Import-CSV -Path "./csv/logins.csv" -Delimiter ";"

    $qualgrupo = Read-Host -Prompt 'Qual grupo gostaria de remover?'

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
            $grupo = $groups | Select-String -Pattern $qualgrupo
            $grupo | ConvertTo-Json
            if ($null -eq $grupo){
                Write-Host 'Login nao possui o grupo especificado:'$Name $qualgrupo
            }
            $grupos =  $grupo.Line
            foreach ($g in $grupos) {
                if ($null -eq $grupo)
                {
                    Write-Host 'Login nao possui o grupo especificado:'$Name $qualgrupo
                }
                else
                {
                    Remove-ADGroupMember -Identity $g -Member $Name -Confirm:$false
                    Write-Host 'Grupo removido:'$g
                }
            }
            $login = $Name
            if (!$grupo){
            $grupo = 'Nao possui o grupo especificado'
            }
            $exportObject = [pscustomobject] @{
                Login = $login;
                Grupo = $grupo -join ','

            }
	        $exportObject | Export-Csv GrupoRemovidos.csv -Delimiter ';' -NoTypeInformation -append
        }
    }
}
removeGrupo