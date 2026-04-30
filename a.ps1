<# Abre FerrumResources / SPV despues de instalar. #>
$ErrorActionPreference = "Stop"

$rootDir = Join-Path $env:LOCALAPPDATA "FerrumResources"
$sourceDir = Join-Path $rootDir "source"
$venvPython = Join-Path $rootDir "venv\Scripts\python.exe"
$cliPath = Join-Path $sourceDir "systemchecker\cli.py"
$hostAddress = "127.0.0.1"
$port = "5057"
$portNumber = [int]$port
$url = "http://$hostAddress`:$port"

if (-not (Test-Path $venvPython) -or -not (Test-Path $cliPath)) {
    Write-Host "FerrumResources no esta instalado todavia." -ForegroundColor Yellow
    Write-Host "Instalalo primero con:" -ForegroundColor Cyan
    Write-Host "irm https://github.com/hackcrist/Crist-ferrun/raw/main/i.ps1 | iex" -ForegroundColor Green
    return
}

$portBusy = Get-NetTCPConnection -LocalAddress $hostAddress -LocalPort $portNumber -State Listen -ErrorAction SilentlyContinue
if ($portBusy) {
    Write-Host "FerrumResources ya esta abierto. Abriendo navegador..." -ForegroundColor Green
    Start-Process $url
    return
}

$runnerPath = Join-Path $env:TEMP ("FerrumResources-SPV-Open-{0}.ps1" -f ([guid]::NewGuid().ToString("N")))
$runner = @"
`$ErrorActionPreference = "Stop"
`$env:SPV_HOST = "$hostAddress"
`$env:SPV_PORT = "$port"
`$env:SPV_DEBUG = "false"
Write-Host "Abriendo FerrumResources / SPV en $url" -ForegroundColor Cyan
& "$venvPython" "$cliPath" ui --host "$hostAddress" --port $portNumber
"@

Set-Content -LiteralPath $runnerPath -Value $runner -Encoding UTF8

$powerShell = (Get-Command powershell.exe -ErrorAction Stop).Source
Start-Process -FilePath $powerShell -ArgumentList @(
    "-NoExit",
    "-ExecutionPolicy", "Bypass",
    "-File", $runnerPath
) -WindowStyle Normal

Write-Host "FerrumResources se esta abriendo en una nueva ventana." -ForegroundColor Green
