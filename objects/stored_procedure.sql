USE gestion_citas_dentisalud;

DROP PROCEDURE IF EXISTS sp_crear_nuevo_paciente;
DELIMITER //
CREATE PROCEDURE sp_crear_nuevo_paciente(
    IN p_apellido VARCHAR(100),
    IN p_nombre VARCHAR(100),
    IN p_nacionalidad VARCHAR(100),
    IN p_tipo_doc VARCHAR(10),
    IN p_nro_doc VARCHAR(20),
    IN p_fecha_nac DATE,
    IN p_sexo VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_telf VARCHAR(20),
    IN p_obra_social VARCHAR(100),
    IN p_plan VARCHAR(100),
    IN p_nro_credencial VARCHAR(100)
)
BEGIN

    INSERT INTO gestion_citas_dentisalud.pacientes (
        apellido_pac, nombre_pac, nacionalidad_pac, tipo_doc_pac, 
        nro_documento, fecha_nac, sexo_pac, email_pac, telf, 
        obra_social, plan, nro_credencial
    ) VALUES (
        p_apellido, p_nombre, p_nacionalidad, p_tipo_doc, 
        p_nro_doc, p_fecha_nac, p_sexo, p_email, p_telf, 
        p_obra_social, p_plan, p_nro_credencial
    );
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_cambiar_estado_cita;
DELIMITER //
CREATE PROCEDURE sp_cambiar_estado_cita(
    IN p_id_cita INT,
    IN p_nuevo_estado VARCHAR(50)
)
BEGIN
    DECLARE error_msg VARCHAR(200);
    
    SELECT COUNT(*) INTO error_msg
    FROM gestion_citas_dentisalud.citas
    WHERE id_cita_pk = p_id_cita;
    
    IF error_msg = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: La cita especificada no existe.';
    END IF;
    
    IF NOT (p_nuevo_estado = 'Atendido' OR p_nuevo_estado = 'Ausente' OR p_nuevo_estado = 'Pendiente') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: <<INGRESE DATOS VALIDOS>>.';
    END IF;
    
    UPDATE gestion_citas_dentisalud.citas
    SET estado_progreso = p_nuevo_estado
    WHERE id_cita_pk = p_id_cita;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_buscar_paciente;
DELIMITER //
CREATE PROCEDURE sp_buscar_paciente(
    IN p_nro_documento VARCHAR(20)
)
BEGIN
    DECLARE paciente_encontrado INT;
    
    SELECT COUNT(*) INTO paciente_encontrado
    FROM gestion_citas_dentisalud.pacientes
    WHERE nro_documento = p_nro_documento;
    
    IF paciente_encontrado = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: <<PACIENTE NO EXISTE>>.';
       ELSE
        SELECT *
        FROM gestion_citas_dentisalud.pacientes
        WHERE nro_documento = p_nro_documento;
    END IF;
END//
DELIMITER ;


