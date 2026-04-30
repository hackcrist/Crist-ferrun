# FerrumResources

## Instalar

```powershell
irm https://raw.githubusercontent.com/hackcrist/Crist-ferrun/main/instalar | iex
```

## Abrir después de instalar

```powershell
irm https://raw.githubusercontent.com/hackcrist/Crist-ferrun/main/abrir | iex
```

## Módulos incluidos

### Principal

- Panel general del sistema.
- Procesos activos, críticos y sospechosos.
- Rendimiento en tiempo real.
- Cola de tareas en curso, completadas y con error.

### Sistema

- Salud del PC.
- Limpieza de temporales y escritorio.
- Gestión de discos, particiones y BitLocker.
- Programas instalados.
- Controladores instalados y dispositivos.
- Recomendación de sistema operativo.
- Activación de Windows.

### Seguridad

- Escaneo local de archivos y carpetas.
- Análisis con VirusTotal para archivo, URL y hash.
- Estado del firewall.
- Reglas, conexiones, bloqueo y desbloqueo de IP.

### Red

- Pruebas de red.
- Interfaces y estadísticas.
- Ping, trazado de ruta y limpieza de DNS.
- Puertos activos y gestión de puertos.

### Gestión

- Explorador de archivos.
- Extracción de archivos comprimidos.
- Personalización del sistema.
- Terminal integrada.
- Tareas programadas.
- Generación de reportes.
- Configuración general.

El comando de instalación descarga la última versión, prepara el entorno local, instala lo necesario e inicia el servidor.

El comando de abrir no reinstala nada. Solo usa la instalación existente y abre el navegador automáticamente.

Ambos comandos trabajan en una sola ventana de PowerShell. Si desde el panel se solicitan permisos de administrador, Windows abre la instancia elevada y la instancia anterior del servidor se cierra.
