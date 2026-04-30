<# 
Instalador rápido de FerrumResources / SPV.
Uso público esperado:
irm https://raw.githubusercontent.com/GrandKenzy/FerrumResources/main/install.ps1 | iex
#>

$ErrorActionPreference = "Stop"

$runnerPath = Join-Path $env:TEMP ("FerrumResources-SPV-Install-{0}.ps1" -f ([guid]::NewGuid().ToString("N")))

$runner = @'
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

$repoZipUrl = "https://codeload.github.com/GrandKenzy/FerrumResources/zip/refs/heads/main"
$rootDir = Join-Path $env:LOCALAPPDATA "FerrumResources"
$sourceDir = Join-Path $rootDir "source"
$venvDir = Join-Path $rootDir "venv"
$downloadPath = Join-Path $env:TEMP "FerrumResources-main.zip"
$extractRoot = Join-Path $env:TEMP ("FerrumResources-{0}" -f ([guid]::NewGuid().ToString("N")))
$hostAddress = "127.0.0.1"
$port = "5057"

function Write-Step {
    param([string]$Message)
    Write-Host ("[{0}] {1}" -f (Get-Date -Format "HH:mm:ss"), $Message) -ForegroundColor Cyan
}

function Write-Ok {
    param([string]$Message)
    Write-Host ("[{0}] {1}" -f (Get-Date -Format "HH:mm:ss"), $Message) -ForegroundColor Green
}

function Write-Warn {
    param([string]$Message)
    Write-Host ("[{0}] {1}" -f (Get-Date -Format "HH:mm:ss"), $Message) -ForegroundColor Yellow
}

function Invoke-Python {
    param([Parameter(ValueFromRemainingArguments = $true)][string[]]$Arguments)
    if ($script:UsePyLauncher) {
        & py -3 @Arguments
    } else {
        & $script:PythonExe @Arguments
    }
}

function Find-Python {
    if (Get-Command py -ErrorAction SilentlyContinue) {
        $script:UsePyLauncher = $true
        $script:PythonExe = "py"
        return
    }

    $python = Get-Command python -ErrorAction SilentlyContinue
    if ($python) {
        $script:UsePyLauncher = $false
        $script:PythonExe = $python.Source
        return
    }

    throw "No se encontró Python. Instala Python 3.9 o superior y vuelve a ejecutar el comando."
}

function Install-App {
    Write-Host ""
    Write-Host "FerrumResources / SPV - instalador automático" -ForegroundColor Cyan
    Write-Host "La ventana quedará abierta con el servidor y los registros visibles." -ForegroundColor DarkGray
    Write-Host ""

    Write-Step "Preparando carpetas locales..."
    New-Item -ItemType Directory -Force -Path $rootDir | Out-Null
    if (Test-Path $sourceDir) {
        Remove-Item -LiteralPath $sourceDir -Recurse -Force
    }
    if (Test-Path $extractRoot) {
        Remove-Item -LiteralPath $extractRoot -Recurse -Force
    }

    Write-Step "Buscando Python..."
    Find-Python
    $pythonVersion = Invoke-Python --version
    Write-Ok $pythonVersion

    Write-Step "Descargando la última versión desde GitHub..."
    Invoke-WebRequest -Uri $repoZipUrl -OutFile $downloadPath -UseBasicParsing

    Write-Step "Extrayendo archivos..."
    Expand-Archive -LiteralPath $downloadPath -DestinationPath $extractRoot -Force
    $extracted = Get-ChildItem -LiteralPath $extractRoot -Directory | Select-Object -First 1
    if (-not $extracted) {
        throw "No se pudo extraer el paquete descargado."
    }
    Move-Item -LiteralPath $extracted.FullName -Destination $sourceDir -Force

    Write-Step "Creando entorno aislado..."
    if (-not (Test-Path $venvDir)) {
        Invoke-Python -m venv $venvDir
    }
    $venvPython = Join-Path $venvDir "Scripts\python.exe"
    if (-not (Test-Path $venvPython)) {
        throw "No se encontró Python dentro del entorno virtual."
    }

    Write-Step "Actualizando instalador de paquetes..."
    & $venvPython -m pip install --upgrade pip

    Write-Step "Instalando FerrumResources / SPV..."
    $projectDir = Join-Path $sourceDir "systemchecker"
    & $venvPython -m pip install --upgrade --force-reinstall $projectDir

    Write-Ok "Instalación completada."
    Write-Host ""
    Write-Host ("Servidor local: http://{0}:{1}" -f $hostAddress, $port) -ForegroundColor Green
    Write-Host "No se abrirá el navegador automáticamente. Entra manualmente a esa dirección." -ForegroundColor Yellow
    Write-Host "Para detener el servidor, presiona Ctrl+C en esta ventana." -ForegroundColor DarkGray
    Write-Host ""

    $env:SPV_HOST = $hostAddress
    $env:SPV_PORT = $port
    $env:SPV_DEBUG = "false"

    Write-Step "Iniciando servidor..."
    $spvCommand = Join-Path $venvDir "Scripts\spv.exe"
    if (-not (Test-Path $spvCommand)) {
        throw "No se encontró el comando instalado de SPV."
    }
    & $spvCommand ui --host $hostAddress --port ([int]$port) --no-browser
}

try {
    Install-App
} catch {
    Write-Host ""
    Write-Host "La instalación falló:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
    Write-Host "La ventana seguirá abierta para revisar el error." -ForegroundColor Yellow
}
'@

Set-Content -LiteralPath $runnerPath -Value $runner -Encoding UTF8

$powerShell = (Get-Command powershell.exe -ErrorAction Stop).Source
Start-Process -FilePath $powerShell -ArgumentList @(
    "-NoExit",
    "-ExecutionPolicy", "Bypass",
    "-File", $runnerPath
) -WindowStyle Normal

Write-Host "Instalador iniciado en una nueva ventana de PowerShell."
