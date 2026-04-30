# FerrumResources

FerrumResources es una herramienta local para revisar y administrar el estado de una PC desde un panel web. Permite ver procesos, rendimiento, disco, red, puertos, programas, controladores, reportes, limpieza del sistema y utilidades de seguridad.

La aplicación se instala en un entorno aislado dentro de `%LocalAppData%\FerrumResources`. Después de instalar, se abre desde el navegador en `http://127.0.0.1:5057`.

## Instalar

```powershell
irm https://raw.githubusercontent.com/hackcrist/Crist-ferrun/main/i | iex
```

## Abrir después de instalar

```powershell
irm https://raw.githubusercontent.com/hackcrist/Crist-ferrun/main/a | iex
```

El comando de instalación descarga la última versión, prepara el entorno local, instala las dependencias necesarias e inicia el servidor.

El comando de abrir no reinstala nada. Solo usa la instalación existente y abre el navegador automáticamente.

Ambos comandos trabajan en una sola ventana de PowerShell. Si desde el panel se solicitan permisos de administrador, Windows abrirá la instancia elevada y la instancia anterior del servidor se cerrará.
