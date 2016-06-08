# RSMapWeb

## Los proyectos fueron borrados de las plataformas Travis-CI, CodeShip, Docker, Heroku y Azure por tanto los enlaces se encuentran inaccesibles.

[![Build Status](https://travis-ci.org/luqueburgosjm/RSMapWeb.svg?branch=master)](https://travis-ci.org/luqueburgosjm/RSMapWeb)
[ ![Codeship Status for luqueburgosjm/RSMapWeb](https://codeship.com/projects/43ccd7d0-9dfc-0133-9c1d-6aac2b19c75b/status?branch=master)](https://codeship.com/projects/127675)
[![Build Status](https://snap-ci.com/luqueburgosjm/RSMapWeb/branch/master/build_image)](https://snap-ci.com/luqueburgosjm/RSMapWeb/branch/master)

[![Heroku Deploy](https://upload.wikimedia.org/wikipedia/en/a/a9/Heroku_logo.png)](http://rsmapweb.herokuapp.com/)

[![Azure Deploy](http://www.tufin.com/wp-content/uploads/2015/09/ms-azure-logo-240x41.png)](http://rsmap.cloudapp.net/)

## Módulo web para el proyecto de infraestructura virtual
Éste módulo es encargado de presentar la información recolectada y procesada.

Las tecnologías a que se usarán son Meteor, React y está por seleccionar algún framework de mapas.

Como base de datos se estudiarán las alternativas posibles que permitan unos requisitos en tiempo real.

Por el momento para un desarrollo rápido se usa sqlite.



## Características implementadas actualmente

### Framework base
[Django](https://www.djangoproject.com/), debido a que el [sistema de test de django](https://docs.djangoproject.com/es/1.9/topics/testing/) me parece bastante completo, no se ha incluido ninguno externo para dicha función.

### Integración continua
[Travis-CI](https://travis-ci.org/luqueburgosjm/RSMapWeb), [CodeShip](https://codeship.com/projects/115675) y
[Snap-CI](https://snap-ci.com/luqueburgosjm/RSMapWeb/branch/master/build_image)

Éstas plataformas nos permiten corregir errores que no sean aceptados por el sistema de test.

### Despliegue continuo

El PaaS Heroku es el encargado de desplegar la aplicación automáticamente, es invocado desde Snap-CI cuando se efectúa un *push* sobre la rama **master**.

### Contenedor docker

Se dispone de un contenedor Docker alojado en DockerHub, el cual se actualiza cuando se efectúa un push sobre el repositorio git. De este modo tenemos una imagen lista con el ecosistema de la aplicación para acortar los tiempos en distribuir el entorno de desarrollo configurado. También es posible usar esta imagen para un despliegue en un entorno en producción, aunque no es aconsejable por motivos de seguridad.

Al igual que con Heroku, el contenedor es actualizado cuando se cumplen los test.

[Repositorio del contenedor](https://hub.docker.com/r/luqueburgosjm/rsmapweb/)

### Despliegue remoto

Tenemos dos opciones para desplegar la aplicación:
 - **Fabric**:
    Se realiza através de Fabric gracias al fabfile.py
 - **Vagrant + Ansible**: Mediante el Vagrantfile, creamos y nos conectamos a una instancia en azure, por ejemplo y una vez hecho esto se lanza ansible con un playbook diseñado ejecutar la aplicación con lo que ello conlleva (instalación desde git, configuración, dependencias, etc).

### Enlaces a despliegue

[Heroku](http://rsmapweb.herokuapp.com/)

[Azure](http://rsmapweb.cloudapp.net) *es posible que éste enlace no se encuentre disponible en algún momento por motivos económicos*
