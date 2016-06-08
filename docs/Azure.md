# Despliegue en Azure

## Creación de la máquina virtual

En primer lugar necesitamos crear una máquina virtual, éste es un breve resumen de los pasos a seguir, sin embargo, también podemos valernos de Vagrant para hacer ésto como se detallará más adelante.

Las herramientas necesarias para el desempeño de esta función se pueden descargar desde el Makefile, con la orden

```
make azure-install
```

Éstos son los pasos descritos de manera resumida para crear la máquina virtual:

```
sudo npm install -g azure-cli

azure config mode asm

azure account download

azure account import /home/jose/Desktop/ivfinal/Azure\ Pass-
2-6-2016-credentials.publishsettings

azure site create --location "West US" pruebasite

azure vm image list westus ubuntuserver

azure vm create testvm1212 0b11de9248dd4d87b18621318e037d37__RightImage-Ubuntu-14.04-x64-v14.2.1
0b11de9248dd4d87b18621318e037d37__RightImage-Ubuntu-14.04-x64-v14.2.1 jose jose --location "North Europe" --ssh

azure vm start testvm

ssh jose@testvm1212.cloudapp.net
```

## Creación y/o despliegue mediante Vagrant y Ansible

Definimos el Vagrantfile de la siguiente manera:

```
Vagrant.configure('2') do |config|

  config.vm.define "localhost" do |l|
    l.vm.hostname = "localhost"
    l.vm.box = 'azure'
    l.vm.network "public_network"
    l.vm.network "private_network",ip: "192.168.56.10", virtualbox__intnet: "vboxnet0"
    l.vm.network "forwarded_port", guest: 8000, host: 8000

    l.vm.provider :azure do |azure, override|
 	azure.mgmt_certificate = File.expand_path('/home/jose/claves/azure.pem')
 	azure.mgmt_endpoint = 'https://management.core.windows.net'
 	azure.subscription_id = '5748f1ee-1ca8-4749-b2d3-739d2747f319'
 	azure.vm_image = 'b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-14_04_3-LTS-amd64-server-20151218-en-us-30GB'
 	azure.vm_name = 'rsmap'
  azure.cloud_service_name = 'rsmap'
  azure.vm_user = 'jose'
  azure.vm_password = 'jose'
 	azure.vm_location = 'Central US'
 	azure.ssh_port = '22'
  azure.tcp_endpoints = '8000:8000'

  config.ssh.username = 'jose'

 	end
     l.vm.provision "ansible" do |ansible|
    	ansible.sudo = true
    	ansible.playbook = "rsmapdeploy.yml"
    	ansible.verbose = "vvv"
    	ansible.host_key_checking = false
  	end
 end
end
```

El fichero indicado en Vagrantifle **rsmapdeploy.yml** es el playbook de Ansible, que contiene lo siguiente:

```
---
- hosts: localhost
  sudo: yes
  remote_user: jose
  tasks:
  - name: Update sys
    apt: update_cache=yes upgrade=dist
  - name: Basic dependencies
    action: apt pkg={{ item }} state=installed
    with_items:
      - python-setuptools
      - python-dev
      - python-pip
      - build-essential
      - git
      - make
  - name: Git clone
    git: repo=https://github.com/luqueburgosjm/RSMapWeb.git dest=~/RSMapWeb clone=yes force=yes
  - name: Permissions
    command: chmod -R +x ~/RSMapWeb
  - name: App requirements
    pip: requirements=~/RSMapWeb/requirements.txt
  - name : Stop production server if running
    script: ~/RSMapWeb/scripts/stopifrunning.sh
    ignore_errors: yes
  - name: Run app
    command: chdir=~/RSMapWeb nohup python manage.py runserver 0.0.0.0:8000

```

La variable de entorno ANSIBLE_HOSTS debe estar configurada con el valor **export ANSIBLE_HOSTS=~/ansible_hosts**
y el contenido del fichero será:

```
[localhost]
192.168.56.10	ansible_connection=local
```

Ésto permite que se ejecute en local dentro de azure.

Por último nos podemos valer de

```
make azure-deploy
make azure-provision
```

Con el primero *(azure-deploy)* se creará la máquina virtual y su correspondiente provisionamiento, si ya tenemos la instalación hecha en azure, podemos simplemente actualizar el contenido introducido desde git con la segunda orden *(azure-provision)*.
