# Imagen de Docker

La imagen de docker viene dada por el fichero Dockerfile con el siguiente contenido:

```
# SO
FROM ubuntu:14.04

# Autor
MAINTAINER José Manuel Luque <luqueburgosjm@gmail.com>

# Update y esenciales
RUN sudo apt-get update
RUN sudo apt-get install -y git
RUN sudo apt-get install -y build-essential

# Descaga repositorio
RUN sudo git clone https://github.com/luqueburgosjm/RSMapWeb.git

# Despliegue e instalacion
RUN ls -l
RUN cd RSMapWeb && make docker

# Comando para lanzar la aplicacion
CMD cd RSMapWeb && make run
```

Gracias a Snap-CI cada vez que se ejecuta un push que pase los test se actualizará con el nuevo contenido en DockerHub, de esta forma el contenedor estará accesible desde cualquier lugar.

El Makefile incluye dos órdenes relacionadas con Docker:

```
make docker-install
make docker
```

La primera lanza la imagen de docker, en ella tenemos un entorno listo para desarrollar en cualquier SO que tenga soporte para docker así evitamos problemas de dependencias por ejemplo.

Con la segunda desplegamos la aplicación dentro del entorno de docker.
