Push-Location

$key = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
$entry = "TimeCopier"
$cmd = "powershell -windowstyle hidden -noexit `"" + (Join-Path $PSScriptRoot "script.ps1") + "`""
Set-Location $key
if ((Get-ItemProperty .).$entry -eq $null) {
	Set-ItemProperty -Name $entry -Value $cmd -Path .
	Write-Host "Autostart entry created."
	Write-Host "Rerun this script to delete it."
}
else {
	Write-Host "Autostart entry already exists!"
  Write-Host "Current value: " (Get-ItemProperty .).$entry
	Write-Host "`n"

	$title = ""
	$message = "Do you want to delete the autostart entry?"
	$yes = New-Object System.Management.Automation.Host.ChoiceDescription "`&Yes",""
	
	$no = New-Object System.Management.Automation.Host.ChoiceDescription "`&No",""
	
	$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
	
	$result = $host.ui.PromptForChoice($title, $message, $options, 0) 
	
	if ($result -eq 0) {
		Remove-ItemProperty -Name $entry -Path .
	}
}

Pop-Location

Write-Host "`nPress any key to continue..."
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null