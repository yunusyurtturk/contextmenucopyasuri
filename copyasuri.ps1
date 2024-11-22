$RegistryPath = "HKCU:\Software\Classes\*\shell\Copy as URI"
$RegistryValue = "Copy path as URI" # Menu entry that show up in context menu

New-Item -Path $RegistryPath.Replace('`', '') -Force
Set-ItemProperty -Path $RegistryPath -Name "(Default)" -Value $RegistryValue

$RegistryCommandPath = "$RegistryPath\command"
$RegistryCommand = "powershell.exe -NoProfile -Command `"Add-Type -AssemblyName PresentationCore; Add-Type -AssemblyName PresentationFramework; [System.Windows.Clipboard]::SetText('file:///' + ('%1' -replace '\\', '/'))`""

New-Item -Path $RegistryCommandPath -Force | Out-Null

New-ItemProperty -Path $RegistryCommandPath -Name "(Default)" -Value $RegistryCommand -Force | Out-Null
