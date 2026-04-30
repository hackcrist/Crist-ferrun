<# Instalador corto de FerrumResources / SPV. #>
$ErrorActionPreference = "Stop"
$url = "https://raw.githubusercontent.com/hackcrist/Crist-ferrun/main/install.ps1"
$script = Invoke-RestMethod -Uri $url
Invoke-Expression $script
