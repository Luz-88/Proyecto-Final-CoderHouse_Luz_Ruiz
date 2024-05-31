USE gestion_citas_dentisalud;

DROP USER IF EXISTS 'admision'@'%';
DROP USER IF EXISTS 'medico'@'%';
DROP USER IF EXISTS 'superusuario'@'%';

CREATE USER 'admision'@'%' IDENTIFIED BY 'ingreso1';
CREATE USER 'medico'@'%' IDENTIFIED BY 'ingreso2';
CREATE USER 'superusuario'@'%' IDENTIFIED BY 'ingreso3';

DROP ROLE IF EXISTS gestion_agendas;
DROP ROLE IF EXISTS visor_agendas;
DROP ROLE IF EXISTS administrador_bbdd;

CREATE ROLE gestion_agendas;
CREATE ROLE visor_agendas;
CREATE ROLE administrador_bbdd;

GRANT SELECT, INSERT, UPDATE ON gestion_citas_dentisalud.* TO 'admision'@'%';
GRANT SELECT ON gestion_citas_dentisalud.* TO 'medico'@'%';
GRANT ALL ON gestion_citas_dentisalud.* TO 'superusuario'@'%';

SHOW GRANTS FOR 'admision'@'%';
SHOW GRANTS FOR 'medico'@'%';
SHOW GRANTS FOR 'superusuario'@'%';
