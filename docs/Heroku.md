# Heroku

Heroku nos permite tener la aplicación desplegada en un medio intermedio, el cual nos puede ayudar para ver los resultados no obstante no lo considero un medio de producción, almenos al nivel que lo hemos tratado (versión gratuita).

Para desplegar la aplicación en Heroku nos valemos de

```
make heroku-deploy
```

que realiza los siguientes pasos

```
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
heroku login
heroku create
git add .
git commit -m "Desplegando en Heroku"
git push heroku master
heroku ps:scale web=1
heroku open
```
