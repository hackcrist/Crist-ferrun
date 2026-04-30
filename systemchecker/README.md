# SystemChecker / SPV

**SPV** significa **System Process Viewer**. Es una herramienta local en Python con CLI y una interfaz web en Flask para revisar procesos, rendimiento, red, discos, puertos, limpieza, reportes y utilidades del sistema.

Este proyecto vive dentro del repositorio **FerrumResources**, en la subcarpeta `systemchecker`, pero el paquete que instala `pip` se llama **`spv`**.

---

## Nombres importantes

| Concepto | Nombre |
|---|---|
| Repositorio GitHub | `FerrumResources` |
| Subcarpeta del proyecto | `systemchecker` |
| Archivo de instalación | `systemchecker/setup.py` |
| Nombre del paquete en pip | `spv` |
| Comando CLI principal | `spv` |
| Comando para abrir la UI Flask | `spv ui` |
| Comando alternativo para abrir la UI | `spv-ui` |
| Versión actual | `3.1.0` |

> Importante: `systemchecker` es la carpeta del proyecto dentro del repositorio. El paquete instalado por `pip` es `spv`.

---

## Requisitos

Necesitas tener instalado:

- Python 3.9 o superior.
- `pip`.
- `git`.

Verifica las versiones:

```bash
python --version
python -m pip --version
git --version
```

Actualiza `pip`:

```bash
python -m pip install --upgrade pip
```

---

## Instalación desde GitHub con pip

Como `setup.py` está dentro de `systemchecker`, debes instalar usando `#subdirectory=systemchecker`:

```bash
python -m pip install "git+https://github.com/GrandKenzy/FerrumResources.git@main#subdirectory=systemchecker"
```

En Windows PowerShell es igual:

```powershell
python -m pip install "git+https://github.com/GrandKenzy/FerrumResources.git@main#subdirectory=systemchecker"
```

---

## Abrir la interfaz web Flask

Después de instalar, abre la UI con:

```bash
spv ui
```

También existe un comando alternativo directo:

```bash
spv-ui
```

Por defecto la aplicación abre en:

```text
http://127.0.0.1:5057
```

Si no abre el navegador automáticamente, entra manualmente a esa URL.

---

## Cambiar host o puerto de la UI

Puedes usar argumentos:

```bash
spv ui --host 127.0.0.1 --port 5060
```

O variables de entorno.

PowerShell:

```powershell
$env:SPV_PORT="5060"
spv ui
```

CMD:

```cmd
set SPV_PORT=5060
spv ui
```

Después abre:

```text
http://127.0.0.1:5060
```

---

## Usar el CLI

Para ver la ayuda general:

```bash
spv --help
```

Ejemplos:

```bash
spv health
spv disk --list
spv network --stats
spv programs --list
spv drivers --list
```

---

## Verificar instalación

```bash
python -m pip show spv
```

Ver archivos instalados:

```bash
python -m pip show -f spv
```

En Windows puedes localizar el ejecutable así:

```powershell
where spv
where spv-ui
```

---

## Actualizar o reinstalar desde GitHub

```bash
python -m pip install --upgrade --force-reinstall "git+https://github.com/GrandKenzy/FerrumResources.git@main#subdirectory=systemchecker"
```

---

## Instalación local para desarrollo

```bash
git clone https://github.com/GrandKenzy/FerrumResources.git
cd FerrumResources/systemchecker
python -m pip install -e .
spv ui
```

En Windows PowerShell:

```powershell
git clone https://github.com/GrandKenzy/FerrumResources.git
cd FerrumResources\systemchecker
python -m pip install -e .
spv ui
```

La opción `-e` instala el paquete en modo editable. Los cambios del código se reflejan sin reinstalar cada vez.

---

## Dependencias principales

El paquete instala automáticamente:

- `Flask`
- `psutil`
- `requests`

---

## Solución de problemas

### Error: `TemplateNotFound: dashboard.html`

Este error indica que Flask arrancó correctamente, pero `pip` no instaló las carpetas de UI:

```text
templates/
static/
```

La solución es que el paquete incluya esos archivos en `setup.py` y `MANIFEST.in`.

Reinstala después de subir el parche:

```bash
python -m pip install --upgrade --force-reinstall "git+https://github.com/GrandKenzy/FerrumResources.git@main#subdirectory=systemchecker"
```

Luego abre:

```bash
spv ui
```

### Error: `git` no se reconoce como comando

Instala Git desde:

```text
https://git-scm.com/downloads
```

Después cierra y abre la terminal nuevamente.

### Error: `does not appear to be a Python project`

Usa el comando con `#subdirectory=systemchecker`:

```bash
python -m pip install "git+https://github.com/GrandKenzy/FerrumResources.git@main#subdirectory=systemchecker"
```

### Error: `No module named systemchecker`

El paquete instalado se llama `spv`, no `systemchecker`.

Correcto:

```bash
python -m pip show spv
spv ui
```

Incorrecto:

```python
import systemchecker
```

### El comando `spv` no aparece

Verifica que Python Scripts esté en el `PATH`. En Windows, normalmente es una ruta parecida a:

```text
C:\Users\TU_USUARIO\AppData\Local\Programs\Python\Python313\Scripts
```

También puedes ejecutar:

```bash
python -m pip show spv
```

---

## Desinstalar

```bash
python -m pip uninstall spv
```
