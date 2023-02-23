
# Demo API 🚀

Dentro de esta documentación se encuentran las herramientas necesarias para realizar llamadas al API la cual contiene los siguientes recursos:

- Usuarios
  - Dentro del endpoint de usuarios se encuentran los siguientes recursos:
    - Creación de usuarios: Permite la creación de nuevos usuario, especificando su nombre, email, nivel de ingles, conocimientos tecnicos, url de CV, contraseña y rol.
    - Edición de usuarios: Permitir la modificación de información de usuarios existentes.
    - Eliminación de usuarios: Permitir la eliminación de usuarios existentes de forma permanente.
    - Búsqueda de usuarios: Permitir la búsqueda de usuarios por id.
- Cuentas
  - Dentro del endpoint de cuentas se encuentran los siguientes recursos:
    - Creación de cuentas: Permite la creación de cuentas nuevas, especificando el nombre de la cuenta, nombre del cliente y responsable de la cuenta.
    - Edición de cuentas: Permite la modificación de información de cuentas existentes.
    - Eliminación de cuentas: Permitir la eliminación de cuentas existentes de forma permanente.
    - Búsqueda de cuentas: Permitir la búsqueda de cuentas por id.
- Equipos
  - Dentro del endpoint de equipos se encuentran los siguientes recursos:
    - Creación de equipos: Permite la creación de equipos nuevas, especificando el id de la cuenta y el nombre del equipo.
    - Edición de equipos: Permite la modificación de información de equipos existentes.
    - Eliminación de equipos: Permitir la eliminación de equipos existentes de forma permanente.
    - Búsqueda de equipos: Permitir la búsqueda de equipos por id.
    - Asignación usuarios: Permite agregar a un usuario previamente registrado a un equipo.
    - Remover usuarios: Permite remover a un usuario previamente registrado a un equipo.
- Movimientos
  - Permite visualizar los movimientos realizados en cada uno de los integrantes de un equipo, es decir, sirve como un log el cual muestra el nombre del usuario, nombre del equipo, fecha de asignacion a un equipo y fecha en la que se elimino del equipo. 


## Pre-requisitos
El API demo construida con Ruby 3.1.0, asegurate de tener instalada esta versión en tu entorno local. Si no sabes como isntalar Ruby te recomiendo hacerlo con rvm.

## Antes de comenzar
El proyecto tiene un Makefile para simplificar el uso de comando engorrosos y repetitivos, si quieres ver la lista de comandos y su documentación solo ejecuta:
```bash
$ make help

dkr-build                      Build project on Docker.
dkr-console                    Lunch console on Docker.
dkr-debug-mode                 Lunch the project on Docker as developer mode.
dkr-setup                      Build and rails prepare.
dkr-start                      Lunch the project on Docker.
doc                            Generate documentation (Rdoc).
rubocop                        Run linter (Rubocop).
setup                          Install dependencies from Gemfile.
rspec                          Run test suite (Rspec).
```
## Documentación
Esta api cuenta con toda la documentación necesaria y ejemplos del uso del API en el siguiente link:

[Swagger](https://osnet.herokuapp.com/api-docs/index.html)

![Kapture 2023-02-22 at 21 28 51](https://user-images.githubusercontent.com/47339360/220815874-78cd13f0-667b-4d43-a05e-f403fd05d1ac.gif)

## Instalación
Este proyecto requiere docker para su funcionamiento, solo asegurate de tenerlo instalado,
sino sabes cómo, lo puedes hacer desde la siguiente liga:

[Descargar e instalar Docker](https://docs.docker.com/get-docker/)

Una vez que hayas instalado Ruby 3.1.0 y Docker ejecuta el siguiente comando para instalar el proyecto localmente:
```bash
$ make dkr-setup
```
## Guía de uso
Para que puedas probar el proyecto en tu local solo ejecuta el siguiente
comando:
```bash
$ make dkr-start
```
lo anterior arrancara un web server para que puedas hacer peticiones en la siguiente ruta:
```
http://localhost:3001
```

Si el proyecto arranco de manera correcta, deberas de ver el server de rails funcionando

![Screen Shot 2023-02-22 at 21 35 02](https://user-images.githubusercontent.com/47339360/220816009-d798919a-dea4-47f4-9637-0af6ca42dcc3.png)

El deploy se hace en Heroku.

## Tests
El testing se hace con [Rspec](https://rspec.info/), si quieres ejecutar la suite de pruebas ejecuta `make dkr-console` y posteriormente el siguiente comando:
```bash
$ make rspec
```
La cobertura actual del proyecto esta por arriba del 90%

![Screen Shot 2023-02-22 at 21 46 41](https://user-images.githubusercontent.com/47339360/220817229-91325ddc-4e0b-41d6-8814-82e1cbde6abf.png)


## Live Demo
El Demo esta hosteado en Heroku en la ruta:
```bash
https://osnet.herokuapp.com
```
Dentro de la documentación de swagger encontraras en environment de `production` para que puedas realizar pruebas sobre este host.

## Licencia

Demo API is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
