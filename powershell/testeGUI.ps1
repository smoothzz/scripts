[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$Form_HelloWorld = New-Object System.Windows.Forms.Form
    $Form_HelloWorld.Text = "Hello World"
    $Form_HelloWorld.Size = New-Object System.Drawing.Size(272,160)
    $Form_HelloWorld.FormBorderStyle = "FixedDialog"
    $Form_HelloWorld.TopMost = $true
    $Form_HelloWorld.MaximizeBox = $false
    $Form_HelloWorld.MinimizeBox = $false
    $Form_HelloWorld.ControlBox = $true
    $Form_HelloWorld.StartPosition = "CenterScreen"
    $Form_HelloWorld.Font = "Sagoe UI"

$label_HelloWorld = New-Object System.Windows.Forms.Label
    $label_HelloWorld.Location = New-Object System.Drawing.Size(8,8)
    $label_HelloWorld.Site = New-Object System.Drawing.Size(240,32)
    $label_HelloWorld.TextAlign = "MidleCenter"
    $label_HelloWorld.Text = "Hello World"
    $Form_HelloWorld.Controls.Add($label_HelloWorld)

$button_ClckMe = New-Object System.Windows.Forms.Button
    $button_ClckMe.Location = New-Object System.Drawing.Size(85,80)
    $button_ClckMe.Site = New-Object System.Drawing.Size(240,32)]
    $button_ClckMe.TextAlign = "MiddleCenter"
    $button_ClckMe.Text = "Click ME"
    $button_ClckMe.Add_Click({
        $button_ClckMe = "You Did Click"
        Start-Process calc.exe    
    })
    $Form_HelloWorld.Controls.Add($button_ClckMe)

$Form_HelloWorld.Add_Shown({$Form_HelloWorld.Activate()})
[void] $Form_HelloWorld.ShowDialog()