# Fabric

Podemos ejecutar comandos predefinidos en el fabfile sobre nuestra máquina remota, de esta manera nos aseguramos de tener tareas comunes automatizadas de manera fácil y cómoda, el contenido del fichero es el siguiente:

```
from fabric.api import run, local, hosts, cd
from fabric.contrib import django

# Host info
def informacion():
    run('uname -a')

# Descarga repo RSMapWeb
def descargar():
    run('sudo apt-get update')
    run('sudo apt-get install -y git')
    run('sudo git clone https://github.com/luqueburgosjm/RSMapWeb.git')

# Instalacion
def instalar():
    run('cd RSMapWeb && make install')

# Actualizamos la copia del repositorio
def actualizar():
    run('cd RSMapWeb && git pull')

# Test
def test():
    run('cd RSMapWeb && make test')

# Lanza aplicacion
def ejecutar():
    run('cd RSMapWeb && make run')

# Instalación con docker
def docker():
    run('cd RSMapWeb && make docker-install')
```

Cada funcion **def** define, valga la redundancia, una tarea. Para usar cada una de ellas lo hacemos de la siguiente forma:

```
fab -p <password> -H <usuario>@<host> <funcion definida en fabfile>
```
