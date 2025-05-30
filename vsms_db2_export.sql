-- MySQL dump 10.13  Distrib 9.3.0, for macos15.2 (arm64)
--
-- Host: localhost    Database: vsms_db2
-- ------------------------------------------------------
-- Server version	9.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `act_in`
--

DROP TABLE IF EXISTS `act_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_in` (
  `movie_id` int NOT NULL,
  `actor_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `birth_date` date NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`movie_id`,`actor_name`,`birth_date`),
  KEY `actor_name` (`actor_name`,`birth_date`),
  CONSTRAINT `act_in_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `act_in_ibfk_2` FOREIGN KEY (`actor_name`, `birth_date`) REFERENCES `actors` (`actor_name`, `birth_date`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_in`
--

LOCK TABLES `act_in` WRITE;
/*!40000 ALTER TABLE `act_in` DISABLE KEYS */;
INSERT INTO `act_in` VALUES (1,'Tom Hanks','1956-07-09','Forrest Gump'),(2,'Benedict Cumberbatch','1976-07-19','Doctor Strange'),(2,'Scarlett Johansson','1984-11-22','Black Widow'),(2,'Zendaya','1996-09-01','JZ'),(3,'Tom Hanks','1956-07-09','Curry'),(4,'Hiroyuki Sanada','1960-10-12','Samurai Leader'),(6,'Keanu Reeves','1964-09-02','Neo'),(7,'Leonardo DiCaprio','1974-11-11','Dominick'),(7,'Margot Robbie','1990-07-02','Vincent Vega'),(8,'Florence Pugh','1996-01-03','Princess Irulan'),(8,'Timothée Chalamet','1995-12-27','Paul Atreides'),(9,'Gal Gadot','1985-04-30','Wonder Woman'),(10,'Dwayne Johnson','1972-05-02','Ken'),(10,'Margot Robbie','1990-07-02','Barbie'),(10,'Ryan Reynolds','1976-10-23','Barbie’s Neighbor'),(11,'Benedict Cumberbatch','1976-07-19','Lewis Strauss'),(11,'Florence Pugh','1996-01-03','Jean Tatlock'),(11,'Keanu Reeves','1964-09-02','Magic'),(12,'Florence Pugh','1996-01-03','Trump'),(12,'Zendaya','1996-09-01','Waymond Wang'),(13,'Idris Elba','1972-09-06','Chris Washington'),(13,'Ryan Reynolds','1976-10-23','Wade'),(14,'Benedict Cumberbatch','1976-07-19','Lead Mathematician'),(15,'Benedict Cumberbatch','1976-07-19','Detective Miles Corbin'),(15,'Hiroyuki Sanada','1960-10-12','Samurai Mentor'),(15,'Tom Hanks','1956-07-09','Michael'),(16,'Benedict Cumberbatch','1976-07-19','Professor Aris Thorne'),(16,'Idris Elba','1972-09-06','General Kael'),(17,'Gal Gadot','1985-04-30','Curry'),(17,'Timothée Chalamet','1995-12-27','Julian Blackwood'),(17,'Zendaya','1996-09-01','Commander Rayna'),(18,'Benedict Cumberbatch','1976-07-19','Marco Polo Jr.'),(18,'Scarlett Johansson','1984-11-22','Agent Red'),(19,'Benedict Cumberbatch','1976-07-19','Dr. Orion Nebula'),(19,'Hiroyuki Sanada','1960-10-12','Captain Kenji'),(19,'Idris Elba','1972-09-06','X'),(20,'Benedict Cumberbatch','1976-07-19','Master Alchemist Elias'),(20,'Florence Pugh','1996-01-03','Kara the Apprentice'),(20,'Idris Elba','1972-09-06','Lebron'),(20,'Keanu Reeves','1964-09-02','Durant'),(21,'Benedict Cumberbatch','1976-07-19','Sergeant Graves'),(21,'Ryan Reynolds','1976-10-23','Kobe'),(22,'Benedict Cumberbatch','1976-07-19','Agent 00X'),(22,'Dwayne Johnson','1972-05-02','Harden'),(22,'Florence Pugh','1996-01-03','Shaq'),(22,'Timothée Chalamet','1995-12-27','Michael'),(22,'Zendaya','1996-09-01','Jordan'),(23,'Benedict Cumberbatch','1976-07-19','Archivist Kael');
/*!40000 ALTER TABLE `act_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actors`
--

DROP TABLE IF EXISTS `actors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actors` (
  `actor_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `birth_date` date NOT NULL,
  `nationality` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gender` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`actor_name`,`birth_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actors`
--

LOCK TABLES `actors` WRITE;
/*!40000 ALTER TABLE `actors` DISABLE KEYS */;
INSERT INTO `actors` VALUES ('Anya Taylor-Joy','1996-04-16','American-British','Female'),('Benedict Cumberbatch','1976-07-19','British','Male'),('Dwayne Johnson','1972-05-02','American','Male'),('Florence Pugh','1996-01-03','British','Female'),('Gal Gadot','1985-04-30','Israeli','Female'),('Hiroyuki Sanada','1960-10-12','Japanese','Male'),('Idris Elba','1972-09-06','British','Male'),('Keanu Reeves','1964-09-02','Canadian','Male'),('Leo Da','2003-05-05','Mars','Male'),('Leonardo DiCaprio','1974-11-11','American','Male'),('Margot Robbie','1990-07-02','Australian','Female'),('Ryan Reynolds','1976-10-23','Canadian','Male'),('Scarlett Johansson','1984-11-22','American','Female'),('Timothée Chalamet','1995-12-27','American','Male'),('Tom Hanks','1956-07-09','American','Male'),('Zendaya','1996-09-01','American','Female');
/*!40000 ALTER TABLE `actors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `country` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `state_province` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `street` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `postal_code` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `house_number` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'USA','California','Los Angeles','Hollywood Blvd','90028','123'),(2,'USA','New York','New York City','Broadway St','10007','456'),(3,'UK','London','London','Abbey Road','NW8 9AY','3'),(4,'Canada','Ontario','Toronto','Queen Street West','M5V 2A1','789'),(5,'Japan','Tokyo','Tokyo','Shibuya Crossing','150-0042','10-1'),(6,'USA','Georgia','Atlanta','Peachtree Street','30303','P.O. Box 100'),(7,'France','Paris','Paris','Champs-Élysées','75008','101 A'),(8,'Germany','Berlin','Berlin','Unter den Linden','10117','77');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add address',7,'add_address'),(26,'Can change address',7,'change_address'),(27,'Can delete address',7,'delete_address'),(28,'Can view address',7,'view_address'),(29,'Can add company',8,'add_company'),(30,'Can change company',8,'change_company'),(31,'Can delete company',8,'delete_company'),(32,'Can view company',8,'view_company'),(33,'Can add genre type',9,'add_genretype'),(34,'Can change genre type',9,'change_genretype'),(35,'Can delete genre type',9,'delete_genretype'),(36,'Can view genre type',9,'view_genretype'),(37,'Can add actor',10,'add_actor'),(38,'Can change actor',10,'change_actor'),(39,'Can delete actor',10,'delete_actor'),(40,'Can view actor',10,'view_actor'),(41,'Can add director',11,'add_director'),(42,'Can change director',11,'change_director'),(43,'Can delete director',11,'delete_director'),(44,'Can view director',11,'view_director'),(45,'Can add member status type',12,'add_memberstatustype'),(46,'Can change member status type',12,'change_memberstatustype'),(47,'Can delete member status type',12,'delete_memberstatustype'),(48,'Can view member status type',12,'view_memberstatustype'),(49,'Can add movie',13,'add_movie'),(50,'Can change movie',13,'change_movie'),(51,'Can delete movie',13,'delete_movie'),(52,'Can view movie',13,'view_movie'),(53,'Can add has genre',14,'add_hasgenre'),(54,'Can change has genre',14,'change_hasgenre'),(55,'Can delete has genre',14,'delete_hasgenre'),(56,'Can view has genre',14,'view_hasgenre'),(57,'Can add act in',15,'add_actin'),(58,'Can change act in',15,'change_actin'),(59,'Can delete act in',15,'delete_actin'),(60,'Can view act in',15,'view_actin'),(61,'Can add direct movie',16,'add_directmovie'),(62,'Can change direct movie',16,'change_directmovie'),(63,'Can delete direct movie',16,'delete_directmovie'),(64,'Can view direct movie',16,'view_directmovie'),(65,'Can add member',17,'add_member'),(66,'Can change member',17,'change_member'),(67,'Can delete member',17,'delete_member'),(68,'Can view member',17,'view_member'),(69,'Can add purchase',18,'add_purchase'),(70,'Can change purchase',18,'change_purchase'),(71,'Can delete purchase',18,'delete_purchase'),(72,'Can view purchase',18,'view_purchase'),(73,'Can add download',19,'add_download'),(74,'Can change download',19,'change_download'),(75,'Can delete download',19,'delete_download'),(76,'Can view download',19,'view_download');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$vToVMpqC7kZGom28KNc0E1$zflzdwDejPh3OQ9jHTi9lULHYqMyS6j4m4XQ/d7ynj4=','2025-05-28 11:45:30.624040',1,'loptio','','','zerovbulitania@gmail.com',1,1,'2025-05-28 11:44:41.915369');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `company_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `address_id` int DEFAULT NULL,
  PRIMARY KEY (`company_name`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `company_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES ('Miramax',1),('Paramount Pictures',1),('Universal Pictures',1),('Focus Features',2),('Warner Bros.',2),('20th Century Studios',3),('Marvel Studios',3),('Studio Ghibli',5),('Sony Pictures',6),('Lionsgate',7),('A24',8);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `direct_movie`
--

DROP TABLE IF EXISTS `direct_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `direct_movie` (
  `movie_id` int NOT NULL,
  `director_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `birth_date` date NOT NULL,
  PRIMARY KEY (`movie_id`,`director_name`,`birth_date`),
  KEY `director_name` (`director_name`,`birth_date`),
  CONSTRAINT `direct_movie_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `direct_movie_ibfk_2` FOREIGN KEY (`director_name`, `birth_date`) REFERENCES `director` (`director_name`, `birth_date`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direct_movie`
--

LOCK TABLES `direct_movie` WRITE;
/*!40000 ALTER TABLE `direct_movie` DISABLE KEYS */;
INSERT INTO `direct_movie` VALUES (2,'Anthony Russo','1970-02-03'),(15,'Anthony Russo','1970-02-03'),(22,'Chloe Zhao','1982-03-31'),(3,'Christopher Nolan','1970-07-30'),(6,'Christopher Nolan','1970-07-30'),(11,'Christopher Nolan','1970-07-30'),(16,'Christopher Nolan','1970-07-30'),(20,'Christopher Nolan','1970-07-30'),(8,'Denis Villeneuve','1967-10-03'),(17,'Denis Villeneuve','1967-10-03'),(10,'Greta Gerwig','1983-08-04'),(4,'Hayao Miyazaki','1941-01-05'),(14,'Hayao Miyazaki','1941-01-05'),(23,'Hayao Miyazaki','1941-01-05'),(2,'Joe Russo','1971-07-18'),(12,'Jordan Peele','1979-02-21'),(13,'Jordan Peele','1979-02-21'),(9,'Patty Jenkins','1971-07-24'),(7,'Quentin Tarantino','1963-03-27'),(18,'Quentin Tarantino','1963-03-27'),(21,'Quentin Tarantino','1963-03-27'),(1,'Robert Zemeckis','1952-05-14'),(19,'Robert Zemeckis','1952-05-14');
/*!40000 ALTER TABLE `direct_movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `director`
--

DROP TABLE IF EXISTS `director`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `director` (
  `director_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `birth_date` date NOT NULL,
  `gender` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`director_name`,`birth_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `director`
--

LOCK TABLES `director` WRITE;
/*!40000 ALTER TABLE `director` DISABLE KEYS */;
INSERT INTO `director` VALUES ('Anthony Russo','1970-02-03','Male'),('Chloe Zhao','1982-03-31','Female'),('Christopher Nolan','1970-07-30','Male'),('Denis Villeneuve','1967-10-03','Male'),('Greta Gerwig','1983-08-04','Female'),('Hayao Miyazaki','1941-01-05','Male'),('Joe Russo','1971-07-18','Male'),('Jordan Peele','1979-02-21','Male'),('Patty Jenkins','1971-07-24','Female'),('Quentin Tarantino','1963-03-27','Male'),('Robert Zemeckis','1952-05-14','Male'),('Steven Spielberg','1946-12-18','Male'),('Taika Waititi','1975-08-16','Male');
/*!40000 ALTER TABLE `director` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(15,'vsms_app','actin'),(10,'vsms_app','actor'),(7,'vsms_app','address'),(8,'vsms_app','company'),(16,'vsms_app','directmovie'),(11,'vsms_app','director'),(19,'vsms_app','download'),(9,'vsms_app','genretype'),(14,'vsms_app','hasgenre'),(17,'vsms_app','member'),(12,'vsms_app','memberstatustype'),(13,'vsms_app','movie'),(18,'vsms_app','purchase');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-05-28 07:42:02.294770'),(2,'auth','0001_initial','2025-05-28 07:42:02.397646'),(3,'admin','0001_initial','2025-05-28 07:42:02.426401'),(4,'admin','0002_logentry_remove_auto_add','2025-05-28 07:42:02.429878'),(5,'admin','0003_logentry_add_action_flag_choices','2025-05-28 07:42:02.433197'),(6,'contenttypes','0002_remove_content_type_name','2025-05-28 07:42:02.455892'),(7,'auth','0002_alter_permission_name_max_length','2025-05-28 07:42:02.466022'),(8,'auth','0003_alter_user_email_max_length','2025-05-28 07:42:02.474588'),(9,'auth','0004_alter_user_username_opts','2025-05-28 07:42:02.477496'),(10,'auth','0005_alter_user_last_login_null','2025-05-28 07:42:02.487612'),(11,'auth','0006_require_contenttypes_0002','2025-05-28 07:42:02.488283'),(12,'auth','0007_alter_validators_add_error_messages','2025-05-28 07:42:02.491304'),(13,'auth','0008_alter_user_username_max_length','2025-05-28 07:42:02.503478'),(14,'auth','0009_alter_user_last_name_max_length','2025-05-28 07:42:02.515194'),(15,'auth','0010_alter_group_name_max_length','2025-05-28 07:42:02.521865'),(16,'auth','0011_update_proxy_permissions','2025-05-28 07:42:02.528016'),(17,'auth','0012_alter_user_first_name_max_length','2025-05-28 07:42:02.542872'),(18,'sessions','0001_initial','2025-05-28 07:42:02.547839');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('8cbg6azr6et28zn4hvv08uneew017r85','.eJxVjEEOwiAQRe_C2hCgQwGX7j0DGWBGqoYmpV0Z765NutDtf-_9l4i4rTVunZY4FXEWWpx-t4T5QW0H5Y7tNss8t3WZktwVedAur3Oh5-Vw_w4q9vqtnTaQHQIPhBzYIlJSSitvOUMyyjhgP1rNNozIxJS8BkBlqNiBghPvD-_POC8:1uKFDu:qBTMGCUM0iUj_ZNA1hkPFstSSMzLa41RWAuL9d6TkqI','2025-06-11 11:45:30.625609');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `download`
--

DROP TABLE IF EXISTS `download`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `download` (
  `download_id` int NOT NULL AUTO_INCREMENT,
  `member_id` int DEFAULT NULL,
  `movie_id` int DEFAULT NULL,
  `download_timestamp` datetime NOT NULL,
  `purchase_id` int DEFAULT NULL,
  PRIMARY KEY (`download_id`),
  KEY `member_id` (`member_id`),
  KEY `movie_id` (`movie_id`),
  KEY `fk_download_purchase` (`purchase_id`),
  CONSTRAINT `download_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `download_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_download_purchase` FOREIGN KEY (`purchase_id`) REFERENCES `purchase` (`purchase_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `download`
--

LOCK TABLES `download` WRITE;
/*!40000 ALTER TABLE `download` DISABLE KEYS */;
INSERT INTO `download` VALUES (1,1,1,'2024-01-20 10:30:00',1),(2,1,3,'2024-01-22 15:00:00',2),(3,2,4,'2024-02-01 18:45:00',7),(4,4,2,'2023-12-25 20:00:00',11),(5,1,5,'2023-06-15 11:00:00',3),(6,1,6,'2024-02-10 12:00:00',4),(7,1,8,'2023-11-05 19:30:00',5),(8,2,10,'2024-01-05 14:00:00',8),(9,2,13,'2023-10-28 22:00:00',9),(10,3,1,'2023-01-01 10:00:00',10),(11,4,7,'2024-03-01 09:15:00',12),(12,4,11,'2024-02-15 21:00:00',13),(13,4,12,'2023-09-10 17:00:00',14),(14,5,9,'2024-01-25 16:20:00',16),(15,6,2,'2023-08-10 11:00:00',17),(16,6,13,'2023-10-30 23:50:00',18),(17,7,3,'2024-02-20 13:00:00',19),(18,7,6,'2023-07-01 10:00:00',20),(19,7,8,'2024-03-03 03:00:00',21),(20,7,11,'2023-11-15 18:30:00',22),(21,8,1,'2024-01-10 08:00:00',23),(22,9,4,'2023-12-01 14:30:00',24),(23,9,12,'2024-02-28 19:00:00',25),(24,10,5,'2023-05-01 12:12:12',26),(25,11,10,'2024-02-14 20:00:00',27),(26,11,13,'2023-10-01 10:00:00',28),(27,12,2,'2024-01-01 00:01:00',29),(28,12,6,'2023-10-10 10:10:10',30),(29,12,9,'2024-03-05 17:45:00',31),(30,12,13,'2023-08-15 21:30:00',32),(31,13,5,'2024-02-05 16:00:00',33),(32,13,11,'2023-12-20 19:00:00',34),(33,1,13,'2023-09-05 10:00:00',6),(34,4,13,'2023-09-15 12:00:00',15),(35,1,13,'2023-11-01 11:00:00',6),(36,6,13,'2023-11-20 13:00:00',18),(37,14,24,'2025-05-28 11:11:51',127),(38,1,2,'2025-05-28 11:12:21',128),(39,1,8,'2024-01-20 10:30:00',5),(40,14,11,'2025-05-28 13:44:57',130),(41,1,11,'2025-05-28 13:48:04',131);
/*!40000 ALTER TABLE `download` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre_type`
--

DROP TABLE IF EXISTS `genre_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre_type` (
  `genre_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`genre_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre_type`
--

LOCK TABLES `genre_type` WRITE;
/*!40000 ALTER TABLE `genre_type` DISABLE KEYS */;
INSERT INTO `genre_type` VALUES ('Action'),('Animation'),('Comedy'),('Documentary'),('Drama'),('Fantasy'),('Horror'),('Romance'),('Sci-Fi'),('Thriller');
/*!40000 ALTER TABLE `genre_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `has_genre`
--

DROP TABLE IF EXISTS `has_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `has_genre` (
  `movie_id` int NOT NULL,
  `genre_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`movie_id`,`genre_name`),
  KEY `genre_name` (`genre_name`),
  CONSTRAINT `has_genre_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `has_genre_ibfk_2` FOREIGN KEY (`genre_name`) REFERENCES `genre_type` (`genre_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `has_genre`
--

LOCK TABLES `has_genre` WRITE;
/*!40000 ALTER TABLE `has_genre` DISABLE KEYS */;
INSERT INTO `has_genre` VALUES (2,'Action'),(6,'Action'),(8,'Action'),(9,'Action'),(12,'Action'),(18,'Action'),(20,'Action'),(22,'Action'),(24,'Action'),(4,'Animation'),(25,'Animation'),(27,'Animation'),(10,'Comedy'),(12,'Comedy'),(13,'Documentary'),(15,'Documentary'),(17,'Documentary'),(1,'Drama'),(5,'Drama'),(7,'Drama'),(8,'Drama'),(10,'Drama'),(11,'Drama'),(14,'Drama'),(18,'Drama'),(21,'Drama'),(23,'Drama'),(4,'Fantasy'),(9,'Fantasy'),(10,'Fantasy'),(17,'Fantasy'),(20,'Fantasy'),(11,'Horror'),(19,'Horror'),(21,'Horror'),(1,'Romance'),(2,'Sci-Fi'),(3,'Sci-Fi'),(6,'Sci-Fi'),(8,'Sci-Fi'),(12,'Sci-Fi'),(16,'Sci-Fi'),(19,'Sci-Fi'),(23,'Sci-Fi'),(3,'Thriller'),(7,'Thriller'),(13,'Thriller'),(14,'Thriller'),(15,'Thriller'),(16,'Thriller'),(22,'Thriller');
/*!40000 ALTER TABLE `has_genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `member_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `balance` decimal(10,2) DEFAULT '0.00',
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `registration_date` date NOT NULL,
  `StatusID` int DEFAULT '1',
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `email` (`email`),
  KEY `StatusID` (`StatusID`),
  CONSTRAINT `members_ibfk_1` FOREIGN KEY (`StatusID`) REFERENCES `MemberStatusTypes` (`StatusID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `members_chk_1` CHECK ((`balance` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,'John Smith',32.03,'john.smith@example.com','555-1234','2023-01-15',1),(2,'Alice Wonderland',25.50,'alice.w@example.com','555-5678','2022-11-01',1),(3,'Bob The Builder',0.00,'bob.builder@example.com','555-8765','2023-03-10',2),(4,'Eve Moneybags',200.00,'eve.m@example.com','555-4321','2021-05-20',1),(5,'Charlie Brown',10.00,'charlie.b@example.com','555-0000','2023-05-01',1),(6,'Diana Prince',75.20,'diana.p@example.net','555-1122','2022-08-22',1),(7,'Bruce Wayne',150.00,'bruce.w@example.org','555-3344','2020-12-01',1),(8,'Clark Kent',30.75,'clark.k@example.com','555-5566','2023-02-28',1),(9,'Lucy Liu',15.00,'lucy.l@example.net','555-7788','2023-04-10',1),(10,'Peter Parker',5.50,'peter.p@example.org','555-9900','2023-06-05',2),(11,'Mary Jane Watson',40.00,'mary.jane@example.com','555-2468','2022-07-19',1),(12,'Harry Potter',99.99,'harry.p@example.net','555-1357','2021-09-01',1),(13,'Hermione Granger',60.25,'hermione.g@example.org','555-8642','2021-09-01',1),(14,'Sabi',999861.11,'trump@gmail.com','999-9999','2018-01-01',1),(15,'Charlie Albert',9.00,'zhd@icloud.com','000-0000','2025-05-30',3);
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MemberStatusTypes`
--

DROP TABLE IF EXISTS `MemberStatusTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MemberStatusTypes` (
  `StatusID` int NOT NULL AUTO_INCREMENT,
  `StatusName` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`StatusID`),
  UNIQUE KEY `StatusName` (`StatusName`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MemberStatusTypes`
--

LOCK TABLES `MemberStatusTypes` WRITE;
/*!40000 ALTER TABLE `MemberStatusTypes` DISABLE KEYS */;
INSERT INTO `MemberStatusTypes` VALUES (1,'Active'),(3,'Closed'),(2,'Suspended');
/*!40000 ALTER TABLE `MemberStatusTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies` (
  `movie_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `release_date` date DEFAULT NULL,
  `charge_per_download` decimal(10,2) NOT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`movie_id`),
  KEY `company_name` (`company_name`),
  CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`company_name`) REFERENCES `company` (`company_name`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `movies_chk_1` CHECK ((`charge_per_download` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (1,'Forrest Gump','1994-07-06',3.99,'Paramount Pictures'),(2,'Avengers: Endgame','2019-04-26',4.99,'Marvel Studios'),(3,'Inception','2010-07-16',4.99,'Warner Bros.'),(4,'Spirited Away','2001-07-20',3.50,'Studio Ghibli'),(5,'The Shawshank Redemption','1994-09-23',4.25,'Warner Bros.'),(6,'The Matrix','1999-03-31',4.50,'Warner Bros.'),(7,'Pulp Fiction','1994-10-14',3.99,'Miramax'),(8,'Dune','2021-10-22',6.99,'Warner Bros.'),(9,'Wonder Woman','2017-06-02',5.50,'Warner Bros.'),(10,'Barbie','2023-07-21',7.99,'Warner Bros.'),(11,'Oppenheimer','2023-07-21',7.99,'Universal Pictures'),(12,'Everything Everywhere All at Once','2022-03-11',6.50,'A24'),(13,'Get Out','2017-02-24',4.99,'Universal Pictures'),(14,'The Enigma Cipher','2006-03-15',3.50,'Focus Features'),(15,'Victorian Shadows','2007-09-22',4.00,'Focus Features'),(16,'Quantum Paradox','2008-11-05',4.50,'Sony Pictures'),(17,'The Crimson Quill','2009-04-10',3.90,'20th Century Studios'),(18,'Silk Road Trader','2010-07-01',4.10,'Lionsgate'),(19,'Celestial Cartographer','2011-02-18',4.30,'A24'),(20,'The Alchemist\'s Secret','2012-08-30',4.70,'Universal Pictures'),(21,'Forgotten Frontlines','2013-10-12',4.60,'Sony Pictures'),(22,'Midnight Espionage','2014-05-25',4.40,'20th Century Studios'),(23,'The Last Chronicle','2015-11-20',4.20,'Warner Bros.'),(24,'Peaky Blinders','2022-05-11',129.90,'Marvel Studios'),(25,'NKNU','2022-05-03',2.00,'Miramax'),(27,'X','2025-05-29',3.00,'Miramax');
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase`
--

DROP TABLE IF EXISTS `purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase` (
  `purchase_id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL,
  `movie_id` int NOT NULL,
  `purchase_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`purchase_id`),
  KEY `member_id` (`member_id`),
  KEY `movie_id` (`movie_id`),
  CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`),
  CONSTRAINT `purchase_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`),
  CONSTRAINT `purchase_chk_1` CHECK ((`amount` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase`
--

LOCK TABLES `purchase` WRITE;
/*!40000 ALTER TABLE `purchase` DISABLE KEYS */;
INSERT INTO `purchase` VALUES (1,1,1,'2024-01-20 10:30:00',3.99),(2,1,3,'2024-01-22 15:00:00',4.99),(3,1,5,'2023-06-15 11:00:00',2.99),(4,1,6,'2024-02-10 12:00:00',4.50),(5,1,8,'2023-11-05 19:30:00',6.99),(6,1,13,'2023-09-05 10:00:00',4.99),(7,2,4,'2024-02-01 18:45:00',3.50),(8,2,10,'2024-01-05 14:00:00',7.99),(9,2,13,'2023-10-28 22:00:00',4.99),(10,3,1,'2023-01-01 10:00:00',3.99),(11,4,2,'2023-12-25 20:00:00',5.99),(12,4,7,'2024-03-01 09:15:00',3.99),(13,4,11,'2024-02-15 21:00:00',7.99),(14,4,12,'2023-09-10 17:00:00',6.50),(15,4,13,'2023-09-15 12:00:00',4.99),(16,5,9,'2024-01-25 16:20:00',5.50),(17,6,2,'2023-08-10 11:00:00',5.99),(18,6,13,'2023-10-30 23:50:00',4.99),(19,7,3,'2024-02-20 13:00:00',4.99),(20,7,6,'2023-07-01 10:00:00',4.50),(21,7,8,'2024-03-03 03:00:00',6.99),(22,7,11,'2023-11-15 18:30:00',7.99),(23,8,1,'2024-01-10 08:00:00',3.99),(24,9,4,'2023-12-01 14:30:00',3.50),(25,9,12,'2024-02-28 19:00:00',6.50),(26,10,5,'2023-05-01 12:12:12',2.99),(27,11,10,'2024-02-14 20:00:00',7.99),(28,11,13,'2023-10-01 10:00:00',4.99),(29,12,2,'2024-01-01 00:01:00',5.99),(30,12,6,'2023-10-10 10:10:10',4.50),(31,12,9,'2024-03-05 17:45:00',5.50),(32,12,13,'2023-08-15 21:30:00',4.99),(33,13,5,'2024-02-05 16:00:00',2.99),(34,13,11,'2023-12-20 19:00:00',7.99),(64,1,1,'2024-01-20 10:30:00',3.99),(65,1,3,'2024-01-22 15:00:00',4.99),(66,1,5,'2023-06-15 11:00:00',2.99),(67,1,6,'2024-02-10 12:00:00',4.50),(69,1,13,'2023-09-05 10:00:00',4.99),(70,2,4,'2024-02-01 18:45:00',3.50),(71,2,10,'2024-01-05 14:00:00',7.99),(72,2,13,'2023-10-28 22:00:00',4.99),(73,3,1,'2023-01-01 10:00:00',3.99),(74,4,2,'2023-12-25 20:00:00',5.99),(75,4,7,'2024-03-01 09:15:00',3.99),(76,4,11,'2024-02-15 21:00:00',7.99),(77,4,12,'2023-09-10 17:00:00',6.50),(78,4,13,'2023-09-15 12:00:00',4.99),(79,5,9,'2024-01-25 16:20:00',5.50),(80,6,2,'2023-08-10 11:00:00',5.99),(81,6,13,'2023-10-30 23:50:00',4.99),(82,7,3,'2024-02-20 13:00:00',4.99),(83,7,6,'2023-07-01 10:00:00',4.50),(84,7,8,'2024-03-03 03:00:00',6.99),(85,7,11,'2023-11-15 18:30:00',7.99),(86,8,1,'2024-01-10 08:00:00',3.99),(87,9,4,'2023-12-01 14:30:00',3.50),(88,9,12,'2024-02-28 19:00:00',6.50),(89,10,5,'2023-05-01 12:12:12',2.99),(90,11,10,'2024-02-14 20:00:00',7.99),(91,11,13,'2023-10-01 10:00:00',4.99),(92,12,2,'2024-01-01 00:01:00',5.99),(93,12,6,'2023-10-10 10:10:10',4.50),(94,12,9,'2024-03-05 17:45:00',5.50),(95,12,13,'2023-08-15 21:30:00',4.99),(96,13,5,'2024-02-05 16:00:00',2.99),(97,13,11,'2023-12-20 19:00:00',7.99),(127,14,24,'2025-05-28 11:11:51',129.90),(128,1,2,'2025-05-28 11:12:21',4.99),(130,14,11,'2025-05-28 13:44:57',7.99),(131,1,11,'2025-05-28 13:48:04',7.99),(132,2,11,'2025-05-28 13:48:04',7.99),(133,4,11,'2025-05-28 13:48:04',7.99),(134,8,11,'2023-11-11 13:36:22',7.50);
/*!40000 ALTER TABLE `purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'vsms_db2'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-29  1:02:05
