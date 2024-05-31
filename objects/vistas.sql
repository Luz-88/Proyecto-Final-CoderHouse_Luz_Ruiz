USE gestion_citas_dentisalud;

CREATE VIEW vista_citas_atendidas AS
    SELECT 
        c.id_cita_pk,
        CONCAT(p.nombre_pac, ' ', apellido_pac) AS nombre_completo,
        DATE_FORMAT(c.fecha_programada, '%d/%m/%Y') AS fecha_cita,
        c.hora_inicio,
        c.hora_fin,
        c.estado_progreso AS estado,
        CONCAT(odon.nombre, ' ', apellido) AS profesional_que_atendio
    FROM
        pacientes as p
            INNER JOIN
        citas as c ON p.id_paciente_pk = c.id_paciente_pk
            INNER JOIN
        odontologos as odon ON c.id_odontologo = odon.id_odontologo
    WHERE
        c.estado_progreso = 'Atendido'
    ORDER BY fecha_programada DESC;

CREATE VIEW vista_horarios_inactivos AS
    SELECT 
        a.descripcion AS agenda,
        h.dias_semana,
        h.hora_desde,
        h.hora_hasta,
        h.estado_horario AS horario_inactivo
    FROM
        horarios AS h
            INNER JOIN
        agendas AS a ON h.id_agenda_pk = a.id_agenda_pk
    WHERE
        h.estado_horario = 0;

CREATE VIEW vista_atenciones_medico AS
SELECT 
 	CONCAT(o.nombre, ' ', apellido) AS nombre_medico,
    COUNT(c.id_cita_pk) AS total_atenciones,
    MAX(c.fecha_programada) AS Fecha_cita,
    ag.descripcion AS descripcion_agenda
FROM 
    citas c
INNER JOIN 
    agendas AS ag ON c.id_agenda_pk = ag.id_agenda_pk   
INNER JOIN 
    odontologos o ON c.id_odontologo = o.id_odontologo
WHERE c.estado_progreso = 'Atendido'    
GROUP BY 
    o.apellido, o.nombre, ag.descripcion
ORDER BY fecha_cita DESC;
