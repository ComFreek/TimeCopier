[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

function Copy-Date {
    $date = Get-Date -Format "yyyy-MM-dd--HH-mm-ss"
    [Windows.Forms.Clipboard]::SetText("$date")
}

function Init-Gui {
	$NotifyIcon = New-Object System.Windows.Forms.NotifyIcon
	$NotifyIcon.Icon = New-Object System.Drawing.Icon(Join-Path $PSScriptRoot "icon.ico")
	$NotifyIcon.Visible = $True

	Register-ObjectEvent -MessageData ${function:Copy-Date} -InputObject $NotifyIcon -EventName Click -Action {
			$Event.MessageData.Invoke()
			$Sender.ShowBalloonTip(250, "Success", "Date & Time copied!", [System.Windows.Forms.ToolTipIcon]::Info);
	} | Out-Null
}
Init-Gui
