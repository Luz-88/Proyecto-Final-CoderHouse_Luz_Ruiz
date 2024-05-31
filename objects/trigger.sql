USE gestion_citas_dentisalud;

DROP TABLE IF EXISTS registro_cambios_agenda;
CREATE TABLE registro_cambios_agenda (
    id_registro INT AUTO_INCREMENT PRIMARY KEY,
    fecha_cambio DATE,
    hora_cambio TIME,
    id_agenda_pk INT,
    descripcion_agenda VARCHAR(255),
    estado_anterior INT,
    estado_actual INT
);

DROP TRIGGER IF EXISTS registrar_cambio_estado_agenda;
DELIMITER //
CREATE TRIGGER registrar_cambio_estado_agenda
AFTER UPDATE ON agendas
FOR EACH ROW
BEGIN
   
    IF OLD.estado <> NEW.estado THEN
               INSERT INTO registro_cambios_agenda (fecha_cambio, hora_cambio, id_agenda_pk, descripcion_agenda, estado_anterior, estado_actual)
        VALUES (CURDATE(), CURTIME(), NEW.id_agenda_pk, NEW.descripcion, OLD.estado, NEW.estado);
    END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS validar_fecha_nacimiento;
DELIMITER //
CREATE TRIGGER validar_fecha_nacimiento
BEFORE INSERT ON pacientes
FOR EACH ROW
BEGIN
    DECLARE fecha_actual DATE;
    DECLARE mensaje_error VARCHAR(255);
    
    SET fecha_actual = CURDATE();   
    IF NEW.fecha_nac > fecha_actual THEN       
        SET mensaje_error = 'La fecha de nacimiento debe ser anterior a la fecha actual.';
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje_error;
    END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS evitar_eliminar_pacientes_con_citas;
DELIMITER //
CREATE TRIGGER evitar_eliminar_pacientes_con_citas
BEFORE DELETE ON pacientes
FOR EACH ROW
BEGIN
    DECLARE n_citas INT;

        SELECT COUNT(*) INTO n_citas
    FROM citas
    WHERE id_paciente_pk = OLD.id_paciente_pk;
       IF n_citas > 0 THEN -- si la cita es mayor que cero
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede eliminar el paciente porque tiene citas asociadas.';
    END IF;
END;
//
DELIMITER ;

 
