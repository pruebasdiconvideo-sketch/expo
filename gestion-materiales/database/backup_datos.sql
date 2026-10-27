-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: db_smart_power_on
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `asignacion_unidad`
--

DROP TABLE IF EXISTS `asignacion_unidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asignacion_unidad` (
  `id_asignacion` bigint NOT NULL AUTO_INCREMENT,
  `id_unidad` bigint NOT NULL,
  `id_detalle_despacho` bigint NOT NULL,
  `estado` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'RESERVADA',
  `fecha_asignacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_asignacion`),
  KEY `fk_asignacion_unidad` (`id_unidad`),
  KEY `idx_asignacion_detalle` (`id_detalle_despacho`),
  CONSTRAINT `fk_asignacion_detalle` FOREIGN KEY (`id_detalle_despacho`) REFERENCES `detalle_despacho` (`id_detalle_despacho`) ON DELETE CASCADE,
  CONSTRAINT `fk_asignacion_unidad` FOREIGN KEY (`id_unidad`) REFERENCES `unidad_inventario` (`id_unidad`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asignacion_unidad`
--

LOCK TABLES `asignacion_unidad` WRITE;
/*!40000 ALTER TABLE `asignacion_unidad` DISABLE KEYS */;
/*!40000 ALTER TABLE `asignacion_unidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `despacho`
--

DROP TABLE IF EXISTS `despacho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `despacho` (
  `id_despacho` bigint NOT NULL AUTO_INCREMENT,
  `id_solicitud` bigint NOT NULL,
  `id_usuario_almacenero` bigint NOT NULL,
  `tipo` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PREPARANDO',
  `observacion` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_despacho` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `motivo_anulacion` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_anulacion` datetime DEFAULT NULL,
  `id_usuario_anula` bigint DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_despacho`),
  KEY `fk_despacho_almacenero` (`id_usuario_almacenero`),
  KEY `idx_despacho_solicitud` (`id_solicitud`),
  KEY `idx_despacho_estado` (`estado`),
  KEY `fk_despacho_anula_usuario` (`id_usuario_anula`),
  CONSTRAINT `fk_despacho_almacenero` FOREIGN KEY (`id_usuario_almacenero`) REFERENCES `usuario` (`id_usuario`) ON DELETE RESTRICT,
  CONSTRAINT `fk_despacho_anula_usuario` FOREIGN KEY (`id_usuario_anula`) REFERENCES `usuario` (`id_usuario`) ON DELETE SET NULL,
  CONSTRAINT `fk_despacho_solicitud` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitud` (`id_solicitud`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `despacho`
--

LOCK TABLES `despacho` WRITE;
/*!40000 ALTER TABLE `despacho` DISABLE KEYS */;
INSERT INTO `despacho` VALUES (1,2,1,'COMPLETO','CONFIRMADO','','2026-10-25 20:00:24',NULL,NULL,NULL,'2026-10-25 21:20:18'),(2,2,1,'COMPLETO','CONFIRMADO','','2026-10-25 20:00:39',NULL,NULL,NULL,'2026-10-25 20:00:59'),(3,1,1,'COMPLETO','ANULADO','','2026-10-25 21:23:27','GHFGHFG','2026-10-25 23:19:35',1,'2026-10-25 23:19:35');
/*!40000 ALTER TABLE `despacho` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_solicitud`
--

DROP TABLE IF EXISTS `detalle_solicitud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_solicitud` (
  `id_detalle` bigint NOT NULL AUTO_INCREMENT,
  `cantidad_requerida` int NOT NULL,
  `id_material` bigint NOT NULL,
  `id_solicitud` bigint NOT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `FKnyws4jtwjjt0uuqnkd4y1tpr9` (`id_material`),
  KEY `FKs6qoty5r4eltv1vcbrefupgpb` (`id_solicitud`),
  CONSTRAINT `FKnyws4jtwjjt0uuqnkd4y1tpr9` FOREIGN KEY (`id_material`) REFERENCES `material` (`id_material`),
  CONSTRAINT `FKs6qoty5r4eltv1vcbrefupgpb` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitud_produccion` (`id_solicitud`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_solicitud`
--

LOCK TABLES `detalle_solicitud` WRITE;
/*!40000 ALTER TABLE `detalle_solicitud` DISABLE KEYS */;
INSERT INTO `detalle_solicitud` VALUES (1,1,1,1),(2,1,2,1),(3,1,3,1);
/*!40000 ALTER TABLE `detalle_solicitud` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material`
--

DROP TABLE IF EXISTS `material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material` (
  `id_material` bigint NOT NULL AUTO_INCREMENT,
  `categoria` varchar(50) DEFAULT NULL,
  `codigo` varchar(50) NOT NULL,
  `descripcion` text,
  `estado` varchar(20) DEFAULT NULL,
  `estante` varchar(20) DEFAULT NULL,
  `mlfb` varchar(100) DEFAULT NULL,
  `modelo` varchar(100) DEFAULT NULL,
  `nivel` varchar(20) DEFAULT NULL,
  `nombre` varchar(150) NOT NULL,
  `numero_serie` varchar(100) DEFAULT NULL,
  `pasillo` varchar(20) DEFAULT NULL,
  `stock_actual` int NOT NULL,
  `stock_minimo` int NOT NULL,
  `unidad_medida` varchar(20) DEFAULT NULL,
  `marca` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_material`),
  UNIQUE KEY `UKqeg7vfbkrtluer1y8s2nrn8sk` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material`
--

LOCK TABLES `material` WRITE;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` VALUES (1,'Equipos','CEL-8MF1','Celda tipo interior IP43 con abatible tipo rack interno','ACTIVO','Estante 01','800-800-2200','SIVACON 8MF1','Nivel 1','Celda de Control y Protección',NULL,'Pasillo A',15,2,'Unidades','Siemens'),(2,'Equipos','REL-7SL87','Relé numérico de protección con puertos de fibra óptica','ACTIVO','Estante 02','P1C972307','SIPROTEC 5','Nivel 1','Relé de Protección Diferencial de Línea',NULL,'Pasillo A',10,2,'Unidades','Siemens'),(3,'Equipos','CON-6MD85','Controlador numérico para subestaciones y bahías de alta tensión','ACTIVO','Estante 01','P1G691383','SIPROTEC 5','Nivel 2','Controlador de Bahía',NULL,'Pasillo B',8,2,'Unidades','Siemens'),(4,'Insumos','BRK-5SY4','Interruptor automático miniatura Curva C 10kA','ACTIVO','Estante 01','5SY4110-7','SENTRON','Nivel 1','Interruptor Termomagnético 1P 10A',NULL,'Pasillo C',120,20,'Unidades','Siemens'),(5,'Equipos','BRK-3VA1','Interruptor 3 polos 25kA con protección térmica y magnética','ACTIVO','Estante 02','3VA1180-3EF32-0AA0','SENTRON 3VA','Nivel 2','Interruptor Automático Caja Moldeada 80A',NULL,'Pasillo C',12,3,'Unidades','Siemens'),(6,'Insumos','BOR-UK5N','Borne de paso pasante tornillo gris para riel DIN','ACTIVO','Estante 01','3004362','CLIPLINE','Nivel 1','Borne Sencillo 57A',NULL,'Pasillo D',500,50,'Unidades','Phoenix Contact'),(7,'Insumos','BOR-UDK4','Borne de tierra para protección PE 6.2mm','ACTIVO','Estante 02','2775184','CLIPLINE','Nivel 1','Borne de Tierra Verde-Amarillo',NULL,'Pasillo D',200,30,'Unidades','Phoenix Contact'),(8,'Equipos','SW-RST2228','Switch industrial rack 19 pulgadas para bus de estación y proceso','ACTIVO','Estante 03','6GK6222-6AB00-5CNO','RUGGEDCOM','Nivel 3','Switch Managed Ethernet',NULL,'Pasillo B',6,1,'Unidades','Siemens'),(9,'Equipos','FUE-QUINT','Fuente primaria conmonblock entrada AC salida DC','ACTIVO','Estante 04','2904600','QUINT POWER','Nivel 2','Fuente de Alimentación 24VDC 5A',NULL,'Pasillo B',14,2,'Unidades','Phoenix Contact'),(10,'Equipos','REL-7PA27','Relé rápido con 4 contactos conmutables y base','ACTIVO','Estante 03','7PA2732-0AA00-2','7PA27','Nivel 2','Relé Auxiliar Monoestable 125VCC',NULL,'Pasillo A',25,5,'Unidades','Siemens');
/*!40000 ALTER TABLE `material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solicitud_produccion`
--

DROP TABLE IF EXISTS `solicitud_produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `solicitud_produccion` (
  `id_solicitud` bigint NOT NULL AUTO_INCREMENT,
  `codigo_proyecto` varchar(50) NOT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `fecha_registro` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id_solicitud`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solicitud_produccion`
--

LOCK TABLES `solicitud_produccion` WRITE;
/*!40000 ALTER TABLE `solicitud_produccion` DISABLE KEYS */;
INSERT INTO `solicitud_produccion` VALUES (1,'G1-Pico-tableroD03','PENDIENTE','2026-10-26 06:34:42.497113');
/*!40000 ALTER TABLE `solicitud_produccion` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-26  8:25:59
