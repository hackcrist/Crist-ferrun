# FerrumResources

## Instalar

```powershell
irm https://raw.githubusercontent.com/hackcrist/Crist-ferrun/main/instalar | iex
```

## Abrir después de instalar

```powershell
irm https://raw.githubusercontent.com/hackcrist/Crist-ferrun/main/abrir | iex
```

El comando de instalación descarga la última versión, prepara el entorno local, instala lo necesario e inicia el servidor.

El comando de abrir no reinstala nada. Solo usa la instalación existente y abre el navegador automáticamente.

Ambos comandos trabajan en una sola ventana de PowerShell. Si desde el panel se solicitan permisos de administrador, Windows abre la instancia elevada y la instancia anterior del servidor se cierra.
