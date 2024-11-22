$RegistryPath = "HKCU:\Software\Classes\*\shell\Copy as URI"
$RegistryCommandPath = "$RegistryPath\command"
$RegistryValue = "Copy path as URI" # Displayed text in the context menu
$RegistryCommand = @"
powershell.exe -NoProfile -Command "Add-Type -AssemblyName PresentationCore; Add-Type -AssemblyName PresentationFramework; [System.Windows.Clipboard]::SetText('file:///' + ('%1' -replace '\\', '/'))"
"@

if (-not (Test-Path -Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

Set-ItemProperty -Path $RegistryPath -Name "(Default)" -Value $RegistryValue -Force

if (-not (Test-Path -Path $RegistryCommandPath)) {
    New-Item -Path $RegistryCommandPath -Force | Out-Null
}

Set-ItemProperty -Path $RegistryCommandPath -Name "(Default)" -Value $RegistryCommand -Force | Out-Null
Write-Host "Context menu 'Copy as URI' added successfully." -ForegroundColor Green