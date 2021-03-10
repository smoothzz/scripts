Function Disable-NetProxy
{
  Begin
    {

            $regKey="HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
       
    }
   
    Process
    {
       
        Set-ItemProperty -path $regKey ProxyEnable -value 0 -ErrorAction Stop

        Set-ItemProperty -path $regKey ProxyServer -value "" -ErrorAction Stop
                           
        Set-ItemProperty -path $regKey AutoConfigURL -Value "" -ErrorAction Stop       
      
    }
   
    End
    {

        Write-Output "Proxy is now Disabled"

             
    }

}

Disable-NetProxy