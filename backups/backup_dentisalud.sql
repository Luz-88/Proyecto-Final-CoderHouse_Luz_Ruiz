CREATE DATABASE  IF NOT EXISTS `gestion_citas_dentisalud` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gestion_citas_dentisalud`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: gestion_citas_dentisalud
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `agendas`
--

DROP TABLE IF EXISTS `agendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agendas` (
  `id_agenda_pk` int NOT NULL AUTO_INCREMENT,
  `id_odontologo` int DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `fecha_desde` date DEFAULT NULL,
  `fecha_hasta` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_agenda_pk`),
  KEY `fk_agenda_odont` (`id_odontologo`),
  CONSTRAINT `fk_agenda_odont` FOREIGN KEY (`id_odontologo`) REFERENCES `odontologos` (`id_odontologo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agendas`
--

LOCK TABLES `agendas` WRITE;
/*!40000 ALTER TABLE `agendas` DISABLE KEYS */;
INSERT INTO `agendas` VALUES (1,1,'Ortodoncia dra. Maria Martinez','2024-04-15','2025-04-15',1),(2,2,'Extraciones dr. Jorge Castro','2024-01-11','2025-11-11',1),(3,5,'Estetica deltal  dra. Bethy Juarez','2024-03-03','2025-03-03',1),(4,4,'Odontologia General Marta Gonzalez','2024-01-03','2025-01-03',1),(5,3,'Odontologia General Laura Sanchez','2024-01-13','2025-01-13',0);
/*!40000 ALTER TABLE `agendas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `registrar_cambio_estado_agenda` AFTER UPDATE ON `agendas` FOR EACH ROW BEGIN
    -- Verificar si el estado anterior es diferente al nuevo estado
    IF OLD.estado <> NEW.estado THEN
        -- Insertar en la tabla de registro de cambios
        INSERT INTO registro_cambios_agenda (fecha_cambio, hora_cambio, id_agenda_pk, descripcion_agenda, estado_anterior, estado_actual)
        VALUES (CURDATE(), CURTIME(), NEW.id_agenda_pk, NEW.descripcion, OLD.estado, NEW.estado);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `citas`
--

DROP TABLE IF EXISTS `citas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citas` (
  `id_cita_pk` int NOT NULL AUTO_INCREMENT,
  `id_paciente_pk` int DEFAULT NULL,
  `id_odontologo` int DEFAULT NULL,
  `id_agenda_pk` int DEFAULT NULL,
  `id_horarios_pk` int DEFAULT NULL,
  `fecha_programada` datetime DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `estado_progreso` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_cita_pk`),
  KEY `fk_cita_pac` (`id_paciente_pk`),
  KEY `fk_cita_odon` (`id_odontologo`),
  KEY `fk_cita_agen` (`id_agenda_pk`),
  KEY `fk_cita_hor` (`id_horarios_pk`),
  CONSTRAINT `fk_cita_agen` FOREIGN KEY (`id_agenda_pk`) REFERENCES `agendas` (`id_agenda_pk`),
  CONSTRAINT `fk_cita_hor` FOREIGN KEY (`id_horarios_pk`) REFERENCES `horarios` (`id_horarios_pk`),
  CONSTRAINT `fk_cita_odon` FOREIGN KEY (`id_odontologo`) REFERENCES `odontologos` (`id_odontologo`),
  CONSTRAINT `fk_cita_pac` FOREIGN KEY (`id_paciente_pk`) REFERENCES `pacientes` (`id_paciente_pk`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citas`
--

LOCK TABLES `citas` WRITE;
/*!40000 ALTER TABLE `citas` DISABLE KEYS */;
INSERT INTO `citas` VALUES (1,1,5,3,4,'2024-03-15 00:00:00','08:00:00','08:30:00','Atendido'),(2,2,2,2,8,'2024-04-20 00:00:00','10:30:00','11:00:00','Ausente'),(3,3,1,1,1,'2024-05-10 00:00:00','14:00:00','14:30:00','Pendiente'),(4,4,3,5,7,'2024-04-05 00:00:00','08:30:00','09:00:00','Atendido'),(5,5,4,4,8,'2024-07-12 00:00:00','12:00:00','12:30:00','Pendiente'),(6,6,2,2,1,'2024-04-18 00:00:00','16:30:00','17:00:00','Atendido'),(7,7,1,1,9,'2024-03-22 00:00:00','09:00:00','09:30:00','Atendido'),(8,8,4,4,3,'2024-04-05 00:00:00','13:30:00','14:00:00','Ausente'),(9,9,3,5,6,'2024-11-10 00:00:00','15:00:00','15:30:00','Pendiente'),(10,10,5,3,10,'2024-12-15 00:00:00','11:30:00','12:00:00','Pendiente');
/*!40000 ALTER TABLE `citas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consultorios`
--

DROP TABLE IF EXISTS `consultorios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consultorios` (
  `consultorio_pk` int NOT NULL AUTO_INCREMENT,
  `id_servicio_pk` int DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`consultorio_pk`),
  KEY `fk_consultorio_serv` (`id_servicio_pk`),
  CONSTRAINT `fk_consultorio_serv` FOREIGN KEY (`id_servicio_pk`) REFERENCES `servicios` (`id_servicio_pk`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultorios`
--

LOCK TABLES `consultorios` WRITE;
/*!40000 ALTER TABLE `consultorios` DISABLE KEYS */;
INSERT INTO `consultorios` VALUES (1,2,'Consultorio de Ortodoncia',1),(2,3,'Consultorio de Extracciones',1),(3,4,'Consultorio de Estetica',0),(4,1,'Odontologia General',1);
/*!40000 ALTER TABLE `consultorios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horarios`
--

DROP TABLE IF EXISTS `horarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horarios` (
  `id_horarios_pk` int NOT NULL AUTO_INCREMENT,
  `id_agenda_pk` int DEFAULT NULL,
  `dias_semana` varchar(50) DEFAULT NULL,
  `hora_desde` time DEFAULT NULL,
  `hora_hasta` time DEFAULT NULL,
  `duracion` int DEFAULT NULL,
  `id_servicio_pk` int DEFAULT NULL,
  `tconsulta_pk` int DEFAULT NULL,
  `consultorio_pk` int DEFAULT NULL,
  `estado_horario` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_horarios_pk`),
  KEY `fk_horario_agenda` (`id_agenda_pk`),
  KEY `fk_horario_serv` (`id_servicio_pk`),
  KEY `fk_horario_tconsul` (`tconsulta_pk`),
  KEY `fk_horario_consultorio` (`consultorio_pk`),
  CONSTRAINT `fk_horario_agenda` FOREIGN KEY (`id_agenda_pk`) REFERENCES `agendas` (`id_agenda_pk`),
  CONSTRAINT `fk_horario_consultorio` FOREIGN KEY (`consultorio_pk`) REFERENCES `consultorios` (`consultorio_pk`),
  CONSTRAINT `fk_horario_serv` FOREIGN KEY (`id_servicio_pk`) REFERENCES `servicios` (`id_servicio_pk`),
  CONSTRAINT `fk_horario_tconsul` FOREIGN KEY (`tconsulta_pk`) REFERENCES `tipo_consulta` (`tconsulta_pk`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horarios`
--

LOCK TABLES `horarios` WRITE;
/*!40000 ALTER TABLE `horarios` DISABLE KEYS */;
INSERT INTO `horarios` VALUES (1,1,'Lunes','08:00:00','12:30:00',30,1,1,1,1),(2,1,'Lunes','14:00:00','18:30:00',30,1,2,1,0),(3,4,'Martes','08:00:00','12:30:00',30,4,1,2,0),(4,3,'Martes','14:00:00','18:30:00',30,3,2,2,1),(5,4,'Miércoles','08:00:00','12:30:00',30,4,2,2,1),(6,5,'Miércoles','14:00:00','18:30:00',30,3,1,4,1),(7,4,'Jueves','08:00:00','12:30:00',30,4,2,3,1),(8,5,'Jueves','14:00:00','18:30:00',30,2,1,3,1),(9,1,'Viernes','08:00:00','12:30:00',30,1,2,1,1),(10,2,'Viernes','14:00:00','18:30:00',30,2,2,2,1),(11,5,'Lunes','08:00:00','12:14:00',30,4,1,1,1),(12,5,'Lunes','14:00:00','18:22:00',30,4,2,1,1);
/*!40000 ALTER TABLE `horarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `odontologos`
--

DROP TABLE IF EXISTS `odontologos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `odontologos` (
  `id_odontologo` int NOT NULL AUTO_INCREMENT,
  `apellido` varchar(100) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `nacionalidad` varchar(100) DEFAULT NULL,
  `tipo_doc` varchar(10) DEFAULT NULL,
  `nro_doc` int DEFAULT NULL,
  `matricula` int DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `fecha_registro` datetime DEFAULT NULL,
  `fecha_ult_act` date DEFAULT NULL,
  PRIMARY KEY (`id_odontologo`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `odontologos`
--

LOCK TABLES `odontologos` WRITE;
/*!40000 ALTER TABLE `odontologos` DISABLE KEYS */;
INSERT INTO `odontologos` VALUES (1,'Martínez','María','Argentina','DNI',56789012,654321,'maria@email.com','2023-04-15 12:00:00','2023-04-17'),(2,'Castro','Jorge','Argentina','DNI',56789012,654321,'castro@email.com','2022-04-15 09:00:00','2023-04-17'),(3,'Sánchez','Laura','Argentina','DNI',34567890,432109,'laura@email.com','2021-04-19 11:00:00','2022-03-12'),(4,'González','Marta','Chilena','RUT',56789012,210987,'marta@email.com','2020-05-20 08:00:00','2023-03-12'),(5,'Juarez','Bethy','colombiana','CI',55789012,214987,'bethy@email.com','2021-06-20 09:00:00','2022-12-12');
/*!40000 ALTER TABLE `odontologos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pacientes`
--

DROP TABLE IF EXISTS `pacientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pacientes` (
  `id_paciente_pk` int NOT NULL AUTO_INCREMENT,
  `apellido_pac` varchar(100) DEFAULT NULL,
  `nombre_pac` varchar(100) DEFAULT NULL,
  `nacionalidad_pac` varchar(100) DEFAULT NULL,
  `tipo_doc_pac` varchar(10) DEFAULT NULL,
  `nro_documento` int DEFAULT NULL,
  `fecha_nac` date DEFAULT NULL,
  `sexo_pac` varchar(100) DEFAULT 'Desconocido',
  `email_pac` varchar(100) NOT NULL,
  `telf` int DEFAULT NULL,
  `obra_social` varchar(100) DEFAULT NULL,
  `plan` varchar(100) DEFAULT NULL,
  `nro_credencial` int DEFAULT NULL,
  PRIMARY KEY (`id_paciente_pk`),
  UNIQUE KEY `email_pac` (`email_pac`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pacientes`
--

LOCK TABLES `pacientes` WRITE;
/*!40000 ALTER TABLE `pacientes` DISABLE KEYS */;
INSERT INTO `pacientes` VALUES (1,'González','Lucía','Argentina','DNI',12345678,'1980-05-15','Femenino','lucia@email.com',112334455,'OSDE','Plan 210',123456789),(2,'Rodríguez','Juan','Argentina','DNI',23456789,'1975-10-20','Masculino','juan@email.com',223445566,'Swiss Medical','Plan Plata',987654321),(3,'García','María','Argentina','DNI',34567890,'1988-07-08','Femenino','maria@email.com',344556677,'Particular','Particular',NULL),(4,'López','Carlos','Argentina','DNI',45678901,'1970-12-30','Masculino','carlos@email.com',445667788,'OSDE','Plan 310',456789123),(5,'Martínez','Ana','Argentina','DNI',56789012,'1990-03-25','Femenino','ana@email.com',566778899,'Swiss Medical','Plan Oro',321654987),(6,'Fernández','Diego','Argentina','DNI',67890123,'1985-08-12','Masculino','diego@email.com',667789900,'Particular','Particular',NULL),(7,'Pérez','Laura','Argentina','DNI',78901234,'1965-06-03','Femenino','laura@email.com',778890011,'OSDE','Plan 420',789456123),(8,'Gómez','Miguel','Argentina','DNI',89012345,'1978-11-18','Masculino','miguel@email.com',88001122,'Swiss Medical','Plan Platino',852147963),(9,'Díaz','Paula','Argentina','DNI',90123456,'1983-09-22','Femenino','paula@email.com',99001233,'Particular','Particular',NULL),(10,'Torres','José','Argentina','DNI',12345677,'1992-02-10','Masculino','jose@email.com',11223455,'OSDE','Plan 530',369852147);
/*!40000 ALTER TABLE `pacientes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `validar_fecha_nacimiento` BEFORE INSERT ON `pacientes` FOR EACH ROW BEGIN
    DECLARE fecha_actual DATE;
    DECLARE mensaje_error VARCHAR(255);
    
    SET fecha_actual = CURDATE();   
    IF NEW.fecha_nac > fecha_actual THEN       
        SET mensaje_error = 'La fecha de nacimiento debe ser anterior a la fecha actual.';
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = mensaje_error;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `evitar_eliminar_pacientes_con_citas` BEFORE DELETE ON `pacientes` FOR EACH ROW BEGIN
    DECLARE n_citas INT;

        SELECT COUNT(*) INTO n_citas
    FROM citas
    WHERE id_paciente_pk = OLD.id_paciente_pk;
       IF n_citas > 0 THEN -- si la cita es mayor que cero
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede eliminar el paciente porque tiene citas asociadas.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `registro_cambios_agenda`
--

DROP TABLE IF EXISTS `registro_cambios_agenda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registro_cambios_agenda` (
  `id_registro` int NOT NULL AUTO_INCREMENT,
  `fecha_cambio` date DEFAULT NULL,
  `hora_cambio` time DEFAULT NULL,
  `id_agenda_pk` int DEFAULT NULL,
  `descripcion_agenda` varchar(255) DEFAULT NULL,
  `estado_anterior` int DEFAULT NULL,
  `estado_actual` int DEFAULT NULL,
  PRIMARY KEY (`id_registro`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registro_cambios_agenda`
--

LOCK TABLES `registro_cambios_agenda` WRITE;
/*!40000 ALTER TABLE `registro_cambios_agenda` DISABLE KEYS */;
INSERT INTO `registro_cambios_agenda` VALUES (1,'2024-05-20','22:35:34',4,'Odontologia General Marta Gonzalez',0,1);
/*!40000 ALTER TABLE `registro_cambios_agenda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicios`
--

DROP TABLE IF EXISTS `servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicios` (
  `id_servicio_pk` int NOT NULL AUTO_INCREMENT,
  `descripcio_serv` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_servicio_pk`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicios`
--

LOCK TABLES `servicios` WRITE;
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
INSERT INTO `servicios` VALUES (1,'Ortodoncia'),(2,'Extracciones'),(3,'Estetica Dental'),(4,'Odontologia General');
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_consulta`
--

DROP TABLE IF EXISTS `tipo_consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_consulta` (
  `tconsulta_pk` int NOT NULL AUTO_INCREMENT,
  `tipo_consulta` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`tconsulta_pk`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_consulta`
--

LOCK TABLES `tipo_consulta` WRITE;
/*!40000 ALTER TABLE `tipo_consulta` DISABLE KEYS */;
INSERT INTO `tipo_consulta` VALUES (1,'Primera Consulta'),(2,'Consulta de Seguimiento');
/*!40000 ALTER TABLE `tipo_consulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vista_atenciones_medico`
--

DROP TABLE IF EXISTS `vista_atenciones_medico`;
/*!50001 DROP VIEW IF EXISTS `vista_atenciones_medico`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_atenciones_medico` AS SELECT 
 1 AS `nombre_medico`,
 1 AS `total_atenciones`,
 1 AS `Fecha_cita`,
 1 AS `descripcion_agenda`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_citas_atendidas`
--

DROP TABLE IF EXISTS `vista_citas_atendidas`;
/*!50001 DROP VIEW IF EXISTS `vista_citas_atendidas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_citas_atendidas` AS SELECT 
 1 AS `id_cita_pk`,
 1 AS `nombre_completo`,
 1 AS `fecha_cita`,
 1 AS `hora_inicio`,
 1 AS `hora_fin`,
 1 AS `estado`,
 1 AS `profesional_que_atendio`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_horarios_inactivos`
--

DROP TABLE IF EXISTS `vista_horarios_inactivos`;
/*!50001 DROP VIEW IF EXISTS `vista_horarios_inactivos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_horarios_inactivos` AS SELECT 
 1 AS `agenda`,
 1 AS `dias_semana`,
 1 AS `hora_desde`,
 1 AS `hora_hasta`,
 1 AS `horario_inactivo`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'gestion_citas_dentisalud'
--

--
-- Dumping routines for database 'gestion_citas_dentisalud'
--
/*!50003 DROP FUNCTION IF EXISTS `f_citas_atendidas_paciente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `f_citas_atendidas_paciente`(
    id_paciente INT
) RETURNS varchar(200) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE citas_pac INT;
    DECLARE nombre_completo_pac VARCHAR(200);
    
    SELECT CONCAT(apellido_pac, ' ', nombre_pac) INTO nombre_completo_pac
    FROM pacientes
    WHERE id_paciente_pk = id_paciente;
    
    IF nombre_completo_pac IS NULL THEN
        RETURN 'Paciente nunca antes Atendido';
    ELSE
        SELECT COUNT(*)
        INTO citas_pac
        FROM citas
        WHERE id_paciente_pk = id_paciente AND estado_progreso = 'Atendido';
        
        RETURN CONCAT(nombre_completo_pac, ' ha sido atendido ', citas_pac, ' veces.');
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `f_citas_atendidas_por_servicio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `f_citas_atendidas_por_servicio`(
    fecha_desde DATE,
    fecha_hasta DATE,
    servicio VARCHAR(100)
) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE num_citas INT;
    
    SELECT COUNT(*)
    INTO num_citas
    FROM citas AS c
    INNER JOIN horarios AS h ON c.id_horarios_pk = h.id_horarios_pk
    INNER JOIN agendas AS a ON c.id_agenda_pk = a.id_agenda_pk
    INNER JOIN servicios AS s ON a.id_odontologo = s.id_servicio_pk
    WHERE c.fecha_programada BETWEEN fecha_desde AND fecha_hasta
    AND s.descripcio_serv = servicio
    AND c.estado_progreso = 'Atendido';

    IF num_citas = 0 THEN SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT  = '>>> 0 CITAS PARA EL SERVICIO Y RANGO INGRESADO <<<', MYSQL_ERRNO = 1000;
            ELSE
        RETURN num_citas;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `f_horarios_disponibles_agendas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `f_horarios_disponibles_agendas`(
    id_agenda INT
) RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE horarios_disponibles VARCHAR(255);
    
    SELECT GROUP_CONCAT(
        'Día: ', dias_semana, ', ',
        'Desde: ', TIME_FORMAT(hora_desde, '%H:%i'), ', ',
        'Hasta: ', TIME_FORMAT(hora_hasta, '%H:%i')
        ORDER BY dias_semana, hora_desde
        SEPARATOR '; '
    )
    INTO horarios_disponibles
    FROM horarios
    WHERE id_agenda_pk = id_agenda
    AND estado_horario = 1
    AND id_horarios_pk NOT IN (
        SELECT id_horarios_pk
        FROM citas
        WHERE id_agenda_pk = id_agenda
    );

    IF horarios_disponibles IS NULL THEN
        RETURN 'No existen horarios disponibles para esta agenda';
    ELSE
        RETURN horarios_disponibles;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_buscar_paciente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscar_paciente`(
    IN p_nro_documento VARCHAR(20)
)
BEGIN
    DECLARE paciente_encontrado INT;
    
    -- Verificar si el paciente existe
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cambiar_estado_cita` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cambiar_estado_cita`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_crear_nuevo_paciente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_crear_nuevo_paciente`(
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
    -- Insertar un nuevo paciente
    INSERT INTO gestion_citas_dentisalud.pacientes (
        apellido_pac, nombre_pac, nacionalidad_pac, tipo_doc_pac, 
        nro_documento, fecha_nac, sexo_pac, email_pac, telf, 
        obra_social, plan, nro_credencial
    ) VALUES (
        p_apellido, p_nombre, p_nacionalidad, p_tipo_doc, 
        p_nro_doc, p_fecha_nac, p_sexo, p_email, p_telf, 
        p_obra_social, p_plan, p_nro_credencial
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vista_atenciones_medico`
--

/*!50001 DROP VIEW IF EXISTS `vista_atenciones_medico`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_atenciones_medico` AS select concat(`o`.`nombre`,' ',`o`.`apellido`) AS `nombre_medico`,count(`c`.`id_cita_pk`) AS `total_atenciones`,max(`c`.`fecha_programada`) AS `Fecha_cita`,`ag`.`descripcion` AS `descripcion_agenda` from ((`citas` `c` join `agendas` `ag` on((`c`.`id_agenda_pk` = `ag`.`id_agenda_pk`))) join `odontologos` `o` on((`c`.`id_odontologo` = `o`.`id_odontologo`))) where (`c`.`estado_progreso` = 'Atendido') group by `o`.`apellido`,`o`.`nombre`,`ag`.`descripcion` order by `Fecha_cita` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_citas_atendidas`
--

/*!50001 DROP VIEW IF EXISTS `vista_citas_atendidas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_citas_atendidas` AS select `c`.`id_cita_pk` AS `id_cita_pk`,concat(`p`.`nombre_pac`,' ',`p`.`apellido_pac`) AS `nombre_completo`,date_format(`c`.`fecha_programada`,'%d/%m/%Y') AS `fecha_cita`,`c`.`hora_inicio` AS `hora_inicio`,`c`.`hora_fin` AS `hora_fin`,`c`.`estado_progreso` AS `estado`,concat(`odon`.`nombre`,' ',`odon`.`apellido`) AS `profesional_que_atendio` from ((`pacientes` `p` join `citas` `c` on((`p`.`id_paciente_pk` = `c`.`id_paciente_pk`))) join `odontologos` `odon` on((`c`.`id_odontologo` = `odon`.`id_odontologo`))) where (`c`.`estado_progreso` = 'Atendido') order by `c`.`fecha_programada` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_horarios_inactivos`
--

/*!50001 DROP VIEW IF EXISTS `vista_horarios_inactivos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_horarios_inactivos` AS select `a`.`descripcion` AS `agenda`,`h`.`dias_semana` AS `dias_semana`,`h`.`hora_desde` AS `hora_desde`,`h`.`hora_hasta` AS `hora_hasta`,`h`.`estado_horario` AS `horario_inactivo` from (`horarios` `h` join `agendas` `a` on((`h`.`id_agenda_pk` = `a`.`id_agenda_pk`))) where (`h`.`estado_horario` = 0) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-20 22:48:56
