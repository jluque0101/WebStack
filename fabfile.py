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