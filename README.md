# FerrumResources

FerrumResources es un panel local para revisar, proteger y administrar una PC desde el navegador. El sistema incluye dashboard general, procesos, rendimiento, cola de tareas, salud del PC, limpieza, discos, programas, controladores, recomendación de sistema operativo, activación, escáner de seguridad, firewall, red, puertos, explorador de archivos, personalización, terminal, tareas programadas, reportes y configuración.

La aplicación se instala en un entorno aislado dentro de `%LocalAppData%\FerrumResources` y se abre en:

```text
http://127.0.0.1:5057
```

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
