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

>DICCIONARIO DE DATOS

![image](https://github.com/Luz-88/Proyecto-Final-CoderHouse_Luz_Ruiz/assets/164443777/045309b3-b440-49e1-b485-ad15b284144e)
![image](https://github.com/Luz-88/Proyecto-Final-CoderHouse_Luz_Ruiz/assets/164443777/f1a44197-d716-4b93-a89c-31e0f4a75d99)

>DIAGRAMA ENTIDAD RELACION

![image](https://github.com/Luz-88/Proyecto-Final-CoderHouse_Luz_Ruiz/assets/164443777/41e2def0-b797-438f-8980-e769558c2ebf)

>QUERIES A EJECUTAR

A continuacion se describe un grupo de queries que involucran diferentes
objetos dentro de la base de datos, y resultan utiles para la gestión de informacion y manejo de
datos en DENTISALUD.

*Vistas:*
1. vista_citas_atendidas: Esta vista muestra las citas atendidas por pacientes, desde la mas reciente
a la mas antigua e indica el profesional que la atendio.
Las tablas utilizadas para generar esta vista son las siguientes: citas, pacientes, odontologos.

2. vista_horarios_inactivos: Las agendas pueden tener mas de un horario configurado y algunos
podrían estar inactivos,
esta vista facilita la visualización de los horarios inactivos que podrían existir dentro de una agenda
determinada.

3. vista_atenciones_medico: Esta vista muestra las citas atendidas por un medico desde la fecha
mas actual a la mas antigua.
Las tablas utilizadas para generar esta vista son las siguientes: horarios, agendas


*Funciones:*

1. f_citas_atendidas_por_servicio: esta funcion indicas la cantidad de citas atendidas en un rango de
fechas para un determinado servicio, Si no existen citas para el rango y servicio ingresado, esta
funcion retornara un mensaje de error indicando que hay 0 citas para ese conjunto de datos. Las
tablas interviniestes son: citas, horarios, agendas y servicios.

2. f_citas_atendidas_paciente: esta funcion indicas la cantidad de veces que ha sido 'Atendido' un
paciente y asi controlar sus atenciones, como tambien cuando este no ha sido atendido, Las tablas
interviniestes son: pacientes, y cias.

3. f_horarios_disponibles_agendas: esta funcion muestra los horarios disponibles o activos dentro de
una desterminada agenda,
en caso de que no existan horarios activos, retorna la informacion de que no existen horarios para esa
agenda. Las tablas interviniestes son: horarios, y cias.

*Stored Procedures:*

1. sp_crear_nuevo_paciente: el siguiente sp permite crear nuevos pacientes, ingresando los datos del
mismo. Las tablas interviniestes son: pacientes.

2. sp_cambiar_estado_cita: el siguiente permite cambiar el estado de una cita y si se ingresa un
balor incorrecto o nullo, este genera un error indicando que es un valor incorrecto. Las tablas
interviniestes son: pacientes.

3. sp_buscar_paciente: el siguiente sp permite buscar a un paciente por numero de documento, si el
documento no existe indicara un error. Las tablas interviniestes son: pacientes

*Triggers:*
1. registro_cambios_agenda: este trigguer registra los cambios reliados en el estado de las agendas,
esta puede estar activa (1) o inactiva (0), los cambios realizados se registraran en la tabla
registro_cambios_agenda, registrando la fecha del cambio,
el estado anterior y el estado actual.
Tablas intervinientes : agendas y registro_cambios_agenda

3. validar_fecha_nacimiento: el siguiente trigger valida que al crearse un nuevo registro en la tabla
pacientes, la fehca de nacimiento no sea mayor a la fecha actual,
si esto sucese se generar un mensaje de error y evita la insercion del registro. Interviene solo la tabla
pacientes.

4. evitar_eliminar_pacientes_con_citas: el siguiente trigger evita que se elimine el registro de un
paciente si este tiene citas relacionadas, si se intenta eliminar un paciente con citas,
se genera un mensaje de error y evita que se elimine el registro. Las tablas intervinientes son las
tablas pacientes y citas


---

__Herramientas y tecnologías usadas__

Acontinuacion se detalla las herramientas y tecnologías utilizadas durante el desarrollo del proyecto, el cual fue creado para la geston de agendas de un pequeño centro de atención odontologica.

__Coder House Plataforma y Docente:__
El curso proporcionó una base sólida de conocimientos en el diseño y desarrollo de bases de datos mysq, y en apoyo del nuestro docente sumado a todo el material didactico y visual compartidos, fueron de vital importancia para el desarrollo y finalixzación del proyecto.

__Tutores CoderHouse:__ En su acompañamiento constante y aclaraciones en el momento preciso, brindaron orientación y apoyo en la resolución de problemas.

__MySQL Workbench:__ Como herramienta principal mediante la cual realizamos todas nuestras practicas y entregas solicitadas a lo largo del curso.

__Windows PowerShell:__ Donde pudimos explorar en aspectos mas tecnicos, y vrealizar algunas practicas mediante la ejecución de comandos basicos.

__GitHub__Como herramienta de compilacion y entrega del proyeto final a fin de generarlo en un entorno profesional y eficiente, brindando conocimiento extra, una opcion de gran utilidad para contar con un protafolio profesional a futuro. 

#### Pasos para arrancar el proyecto

* En la terminal de linux escribir :
    - `make` _si te da un error de que no conexion al socket, volver al correr el comando `make`_
    - `make clean-db` limpiar la base de datos
    - `make test-db` para mirar los datos de cada tabla
    - `make backup-db` para realizar un backup de mi base de datos
    - `make access-db` para acceder a la base de datos
