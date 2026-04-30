# FerrumResources

Instalación rápida en PowerShell:

```powershell
irm https://github.com/hackcrist/Crist-ferrun/raw/main/i.ps1 | iex
```

Abrir después de instalar:

```powershell
irm https://github.com/hackcrist/Crist-ferrun/raw/main/a.ps1 | iex
```

Comando completo:

```powershell
irm https://raw.githubusercontent.com/hackcrist/Crist-ferrun/main/install.ps1 | iex
```

El instalador abre una ventana independiente de PowerShell, instala la aplicación en un entorno local aislado, inicia el servidor y abre el navegador automáticamente.

El comando de abrir no reinstala dependencias. Solo usa la instalación local guardada en `%LocalAppData%\FerrumResources`.
