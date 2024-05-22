<center>
<img src="https://objetivo.news/download/multimedia.normal.bcba10cea1861629.Y29kZXJob3VzZS1xdWUtZXMtcXVlLWhhY2VuX25vcm1hbC53ZWJw.webp" style="width: 100% ; aspect-ratio:16/9">
</center>


# <center>Entrega de proyecto final</center>
@Luz Emily Ruiz Neiva

@Comision: 53180

@Tutor: Santiago Gonzalez

@Docente: Anderson Torres
****************************************************************************************************************************************************************************************************
> INDICE:
- Descripcion del proyecto
- Descripcion de entidades
- Diccionario de datos
- Modelo entidad relacion
- Dresentacion de queryes en diferentes objetos
- Queries a ejecutar
- Vistas
- Funciones
- Stored Procedures
- Triggers
- Roles de Uusarios
_______________________________________________________________________________________________________________________________________________________________________________________________________

Descripción del Proyecto:
El Centro Odontologico Dentisalud requiere una base de datos para el
registro y gestion de citas diarias, que pueda almacenar informacion general
de sus pacientes, tal como datos personales, Obra Social, turnos otorgados, y
horarios relacionados a su grupo de consultorios y servicios.
Para desarrollar este modelo de base de datos se requiere, la creación de las
siguientes entidades.

* Odontologos
* Agendas
* Horarios
* Consultorios
* Servicios
* Citas
* Tipo de consulta
* Pacientes
_____________________________________________________________________________________________________________________________________________________________________________________________________________

> DESCRIPCIÓN DE ENTIDADES:

*- Odontologos:*
Se precisa contar con el resgistro de los profesionales que realizan las atenciones
odontologica de los pacientes, con sus datos personales necesarios para su correcta
identificación.

*- Agendas:*  
La bd debe permitir el registro de las distintas agendas que manejas los profesionales,
teniendo en cuenta su vigencia y disponibilidad.

*- Horarios:*
Se requiere que la db registre los horarios disponibles de los profesionales, asi mismo los
días, y consultorio donde se disponibilizan los horarios de atencion.

*- Consultorios:*  
Es de gran importancia almacenar informacion de los diferentes consultorios
disponibles según los servicios prestados por el centro, e identificados para el correcto
registro de los turnos 

*- Tipo de consulta:*   
Se precisa que la base de datos guarde los diferentes tipos de atencion que se realizan
en el centro odontologico, y con esto identificar si un paciente se presenta por primera
vez o por segumiento.

*- Servicios:*  
Para la correcta generacion de turnos es necesario contar un registro de los diferentes
servicios prestados por los profesionales Odontologos en el Centro.

*- Citas:*  
Para gestio de turnos del centro la base de datos debe permitirnos registrar toda la
informacion sobre turnos programados por dia, por cada profesional, clasificado por
servicio, tipo de atención, y rango horario de atención.

*- Pacientes:*  
La bd debe permitir almacenar información general de los pacientes, tal como datos
personales, nombre completo, fecha de nacimiento, numero de identificación, y ademas
conservar la fecha de registro y la ultima actualizacion de datos, para contar con
informacion actualizada.


### **Consignas:**
- La base de datos debe contener al menos:
    * ~ 15 tablas, entre las cuales debe haber al menos 1 tabla de hechos,  2 tablas transaccionales.
    * ~ 5 vistas.
    * ~ 2 stored procedure.
    * ~ 2  trigger.
    * ~ 2 funciones
    
- El documento debe contener:
    - Introducción
    - Objetivo
    - Situación problemática
    - Modelo de negocio
    - Diagrama de entidad relació
    - Listado de tablas con descripción de estructura (columna,descripción, tipo de datos, tipo de clave)
    - Scripts de creación de cada objeto de la base de datos
    - Scripts de inserción de datos
    - Informes generados en base a la información de la base
    - Herramientas y tecnologías usadas

>DICCIONARIO DE DATOS

![image](https://github.com/Luz-88/Proyecto-Final-CoderHouse_Luz_Ruiz/assets/164443777/045309b3-b440-49e1-b485-ad15b284144e)
![image](https://github.com/Luz-88/Proyecto-Final-CoderHouse_Luz_Ruiz/assets/164443777/f1a44197-d716-4b93-a89c-31e0f4a75d99)

>DIAGRAMA ENTIDAD RELACION

![image](https://github.com/Luz-88/Proyecto-Final-CoderHouse_Luz_Ruiz/assets/164443777/41e2def0-b797-438f-8980-e769558c2ebf)






---

## Tematica del proyecto

## Modelo de negocio

## Diagrama entidad relacion (DER)

## Listado de tablas y descripcion

## Estructura e ingesta de datos

## Objetos de la base de datos

## Roles y permisos

## Back up de la base de datos

## Herramientas y tecnologias usadas

## Como levantar el proyecto en CodeSpaces GitHub
* env: Archivo con contraseñas y data secretas
* Makefile: Abstracción de creacción del proyecto
* docker-compose.yml: Permite generar las bases de datos en forma de contenedores

#### Pasos para arrancar el proyecto

* En la terminal de linux escribir :
    - `make` _si te da un error de que no conexion al socket, volver al correr el comando `make`_
    - `make clean-db` limpiar la base de datos
    - `make test-db` para mirar los datos de cada tabla
    - `make backup-db` para realizar un backup de mi base de datos
    - `make access-db` para acceder a la base de datos
