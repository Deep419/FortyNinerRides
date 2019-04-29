CREATE DATABASE  IF NOT EXISTS `FortyNinerGolfCartRides` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `FortyNinerGolfCartRides`;
-- MySQL dump 10.13  Distrib 5.7.25, for macos10.14 (x86_64)
--
-- Host: localhost    Database: FortyNinerGolfCartRides
-- ------------------------------------------------------
-- Server version	5.7.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Campus_Faculty`
--

DROP TABLE IF EXISTS `Campus_Faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Campus_Faculty` (
  `personID` int(11) NOT NULL,
  `personTypeID` int(11) DEFAULT NULL,
  `fullTime` bit(1) DEFAULT NULL,
  PRIMARY KEY (`personID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Campus_Faculty`
--

LOCK TABLES `Campus_Faculty` WRITE;
/*!40000 ALTER TABLE `Campus_Faculty` DISABLE KEYS */;
INSERT INTO `Campus_Faculty` VALUES (523069579,1,_binary ''),(1248183673,1,_binary '\0'),(1307095410,1,_binary ''),(1925517761,1,_binary '');
/*!40000 ALTER TABLE `Campus_Faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Driver`
--

DROP TABLE IF EXISTS `Driver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Driver` (
  `licenseNum` bigint(20) NOT NULL,
  `personID` int(11) DEFAULT NULL,
  `dateHired` date DEFAULT NULL,
  UNIQUE KEY `licenseNum` (`licenseNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Driver`
--

LOCK TABLES `Driver` WRITE;
/*!40000 ALTER TABLE `Driver` DISABLE KEYS */;
INSERT INTO `Driver` VALUES (1609122105899,1476964689,'2018-11-06'),(1618112957999,700345995,'2018-12-11'),(1623040565199,1762985662,'2019-02-25'),(1624031337499,988689224,'2018-07-27'),(1645062663699,684391563,'2018-06-27'),(1645112537699,265586444,'2019-01-07'),(1657122042199,1363956411,'2019-10-01'),(1662041376899,1707883649,'2019-02-20'),(1682122089599,873415582,'2019-12-05'),(1695121147199,1251944980,'2018-12-26');
/*!40000 ALTER TABLE `Driver` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger hireCheck before insert on Driver
for each row 
begin
	if new.dateHired > curdate() then
		set new.dateHired = curdate();
	end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Golfcart`
--

DROP TABLE IF EXISTS `Golfcart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Golfcart` (
  `cartID` int(11) NOT NULL AUTO_INCREMENT,
  `Make` text,
  `Model` text,
  `Seats` int(11) DEFAULT '4',
  PRIMARY KEY (`cartID`),
  UNIQUE KEY `cartID` (`cartID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Golfcart`
--

LOCK TABLES `Golfcart` WRITE;
/*!40000 ALTER TABLE `Golfcart` DISABLE KEYS */;
INSERT INTO `Golfcart` VALUES (1,'EZ-GO','Patriot',6),(2,'EZ-GO','Patriot',6),(3,'CAZADOR','LIMO 400EFI',6),(4,'Evolution','Carrier',11);
/*!40000 ALTER TABLE `Golfcart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Location`
--

DROP TABLE IF EXISTS `Location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Location` (
  `locationID` int(11) NOT NULL,
  `locationName` text NOT NULL,
  PRIMARY KEY (`locationID`),
  UNIQUE KEY `locationID` (`locationID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Location`
--

LOCK TABLES `Location` WRITE;
/*!40000 ALTER TABLE `Location` DISABLE KEYS */;
INSERT INTO `Location` VALUES (1,'Atkins Library'),(2,'Woodward'),(3,'Popp Martin Student Union'),(4,'West Deck'),(5,'East Deck 1');
/*!40000 ALTER TABLE `Location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Person`
--

DROP TABLE IF EXISTS `Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Person` (
  `personID` int(11) NOT NULL,
  `personTypeID` int(11) DEFAULT NULL,
  `firstName` varchar(30) DEFAULT NULL,
  `lastName` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `department` varchar(30) DEFAULT NULL,
  `cell` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`personID`),
  UNIQUE KEY `personID` (`personID`),
  KEY `Person_By_Dept` (`personID`,`personTypeID`,`firstName`,`lastName`,`department`),
  KEY `Person_By_Type` (`personID`,`personTypeID`,`firstName`,`lastName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Person`
--

LOCK TABLES `Person` WRITE;
/*!40000 ALTER TABLE `Person` DISABLE KEYS */;
INSERT INTO `Person` VALUES (21611647,2,'Emery','Kerr','dui.Fusce@tristiqueac.net','BUSINESS',2866438100),(41762045,2,'Martha','Williams','non.enim@Phasellusfermentum.co.uk','SCIENCE',7463951213),(58909427,2,'Candice','Ryan','nisi@tellusidnunc.co.uk','MATH',3154571318),(62022838,3,'Kevin','Wood','libero.Proin.sed@et.org','BUSINESS',1308204566),(76606778,2,'Kiara','Burks','sem.Pellentesque@nibh.edu','BUSINESS',4531688349),(99343536,3,'Mariko','Jordan','faucibus.ut.nulla@Nuncmauriselit.ca','MATH',4711262754),(156194504,1,'Preston','Gibbs','sed@pretiumetrutrum.com','BUSINESS',8467673197),(226303017,1,'Jason','Mercado','ornare.libero.at@nonarcu.net','BUSINESS',6508709935),(227097910,2,'Leigh','Oneal','non.luctus.sit@Proin.net','ENGINEERING',3594155815),(227480385,1,'Ferris','Daniel','Maecenas.malesuada@netuset.ca','ENGINEERING',6379797204),(265586444,2,'Quail','Jefferson','ipsum.porta@erosNam.edu','SCIENCE',3838741844),(269990494,2,'Yuli','Norris','sapien.Nunc.pulvinar@tortorInteger.ca','ENGINEERING',2936665137),(272424800,3,'Rose','Landry','sit.amet@faucibusleoin.co.uk','ENGINEERING',2893783174),(320332864,2,'Alexandra','Holmes','purus.accumsan.interdum@euismodurnaNullam.com','ENGINEERING',7995772768),(332331935,1,'Peter','Head','Sed.malesuada@leoin.org','MATH',5228277331),(353725805,3,'Zephr','Waters','ac.nulla.In@semperNam.net','SCIENCE',6218777166),(364598829,1,'Isaiah','Daugherty','dictum.eu.eleifend@necleo.ca','MATH',3111944438),(370584223,3,'Oliver','Johnson','dictum@tincidunt.org','SCIENCE',9797881522),(382177415,2,'Abra','Ware','tortor.dictum@accumsan.co.uk','ENGINEERING',5723036822),(398427130,1,'Zenaida','Gallegos','ligula.Aliquam@faucibuslectus.ca','SCIENCE',4269857600),(398474194,1,'Inez','Hall','penatibus@tortorNunccommodo.net','MATH',9475736720),(412603553,3,'Devin','Johns','Etiam.ligula@sedorci.edu','MATH',1209841362),(458078410,2,'Ciara','Cruz','Aliquam@tortornibh.net','BUSINESS',8502066732),(478693952,3,'Neve','Mcclure','sem.Nulla@fringilla.org','BUSINESS',3181624954),(488933660,2,'Tad','Todd','eu.metus@accumsansedfacilisis.com','SCIENCE',9514571379),(508166256,1,'Rana','Stafford','ligula.Nullam.feugiat@nonenimMauris.co.uk','BUSINESS',7694701365),(515821373,1,'Cherokee','English','lectus@bibendum.edu','SCIENCE',2332124869),(518035872,3,'Quin','Dorsey','ipsum.primis@Nuncmauris.co.uk','SCIENCE',2911954631),(523069579,1,'Amal','Rojas','risus.Donec.nibh@duilectus.org','BUSINESS',4036624213),(528375686,2,'Blaine','Holland','penatibus@idlibero.com','SCIENCE',4354374095),(531592375,2,'Uriah','Keller','lorem@consectetuerrhoncus.com','ENGINEERING',8636055465),(558545730,3,'Lester','Mejia','Curabitur.massa@imperdiet.org','BUSINESS',6755537229),(616654842,2,'Mufutau','Bentley','Morbi.sit@est.org','SCIENCE',8525284322),(656844583,1,'Hu','Benton','orci.consectetuer.euismod@Duis.edu','ENGINEERING',4053766981),(668166416,1,'Bevis','Hatfield','ornare.lectus@et.com','MATH',9273385790),(684391563,3,'Knox','Bender','justo.Praesent.luctus@at.edu','SCIENCE',2293713031),(687734762,2,'Blossom','Herrera','sagittis.placerat@et.com','ENGINEERING',1674997688),(694226012,3,'Kirk','Sawyer','Etiam.bibendum@quisarcuvel.edu','SCIENCE',4103237130),(700345995,2,'Christopher','Mcfadden','pretium.neque@facilisis.org','BUSINESS',7751727153),(720450865,1,'Ivan','Dillard','Fusce.mollis.Duis@Ut.net','MATH',9603336054),(772287192,3,'Adria','Morin','vehicula.Pellentesque.tincidunt@nondapibusrutrum.edu','MATH',2688037048),(803108177,2,'Josephine','Conner','Nunc.ullamcorper.velit@facilisis.co.uk','SCIENCE',5836138526),(817022915,2,'Castor','Hurst','nunc.sed@vulputatenisisem.com','MATH',5938956877),(824606575,2,'Rudyard','Pollard','Cras.sed@ornare.ca','BUSINESS',5719709772),(873415582,1,'Candace','Robinson','Nunc.laoreet.lectus@Nuncpulvinararcu.org','SCIENCE',2583466159),(890906507,1,'Cairo','Case','molestie.pharetra@estarcu.com','MATH',1305743567),(901698896,3,'Aaron','Dominguez','nostra@dolordapibus.net','ENGINEERING',5347917666),(911328482,2,'Elton','Talley','Mauris.nulla@nonarcu.ca','ENGINEERING',8391239528),(949724978,3,'Aileen','Calderon','quis.tristique.ac@purus.net','SCIENCE',3952378865),(959077926,3,'Cedric','Harrington','vitae@sedtortorInteger.org','ENGINEERING',1931418195),(959390207,3,'Nina','Barnes','vitae.purus@convallisantelectus.com','ENGINEERING',2306757009),(961996478,3,'Xenos','Barnett','Donec.elementum.lorem@ante.ca','MATH',4302902227),(979991345,3,'Eagan','Evans','urna.Ut@ategestas.org','BUSINESS',3433891276),(988689224,3,'Harriet','Suarez','nibh.Aliquam.ornare@risusatfringilla.edu','BUSINESS',8807020012),(1028785610,2,'Blythe','Buck','ullamcorper.viverra@massa.com','BUSINESS',7574971642),(1029384409,2,'Addison','Carver','mauris.id.sapien@Namporttitor.co.uk','ENGINEERING',9117632214),(1034394674,2,'Nayda','Hendricks','Duis.a.mi@nuncrisus.com','MATH',1964781976),(1058216605,1,'Alexander','Mcintyre','primis.in@nunc.ca','ENGINEERING',4879959207),(1072943902,2,'Sylvester','Snyder','diam.dictum.sapien@posuere.com','BUSINESS',9445751647),(1081355196,3,'Owen','Britt','mauris.rhoncus@ipsumdolor.net','ENGINEERING',7481715089),(1100715693,3,'Keaton','Barton','Donec.tincidunt.Donec@laoreetlectus.org','BUSINESS',4312255567),(1107329326,3,'Grace','Singleton','bibendum.ullamcorper.Duis@Integer.co.uk','MATH',7898104158),(1125771674,1,'Dai','Abbott','Aenean@aliquet.ca','SCIENCE',1379011129),(1136167457,3,'Veronica','Maddox','Nulla@ac.com','SCIENCE',2095066908),(1180905448,2,'Graiden','Kane','et.ipsum@utnisia.com','ENGINEERING',1818281295),(1248183673,1,'William','Gould','sodales.at.velit@inconsectetuer.co.uk','BUSINESS',5719143521),(1251944980,2,'Scott','Hanson','rhoncus.Proin@egestas.ca','BUSINESS',4695102460),(1266678408,2,'Vladimir','Alvarado','Cras.dictum.ultricies@libero.com','BUSINESS',3957213198),(1268184521,2,'Ursa','Nielsen','dui@inaliquet.org','MATH',3749866154),(1291260565,1,'Zelenia','Ramirez','massa@cursusdiam.org','SCIENCE',7163651473),(1307095410,1,'Erich','Gilmore','Proin@arcuAliquamultrices.net','BUSINESS',8524981780),(1363956411,2,'Petra','Johnson','auctor.quis.tristique@Donecdignissimmagna.com','ENGINEERING',1661289307),(1405111732,3,'Adena','Newman','auctor.odio.a@velturpisAliquam.org','ENGINEERING',7434044996),(1447821664,2,'Griffin','Cochran','risus@malesuada.net','SCIENCE',7704137877),(1453760167,3,'Raja','Levy','libero.Donec@tellusnonmagna.ca','SCIENCE',4394353508),(1459303926,2,'Ferdinand','Blanchard','Quisque.varius@acturpisegestas.net','SCIENCE',1622520129),(1467013039,2,'Justin','Cameron','arcu.Aliquam.ultrices@Mauris.net','MATH',5892108701),(1476964689,1,'Tobias','Foreman','ac.fermentum@imperdiet.ca','MATH',9212434673),(1484290045,3,'Doris','Bond','iaculis.odio.Nam@pedemalesuada.co.uk','BUSINESS',6893364970),(1495002525,2,'Aurelia','Sargent','venenatis.lacus.Etiam@ultrices.org','ENGINEERING',5938493277),(1535792133,2,'Alan','Bauer','diam.vel@Donec.edu','ENGINEERING',4732468722),(1555313090,1,'Griffith','Pittman','consequat.dolor.vitae@pharetrased.co.uk','BUSINESS',5189961518),(1572304988,2,'Lillith','Huber','massa.Mauris.vestibulum@orciluctuset.org','BUSINESS',5012137728),(1576330323,3,'Daniel','Keith','sit.amet.risus@facilisiSedneque.com','BUSINESS',4805125068),(1587350736,1,'Kelsie','Waller','fringilla@nec.org','ENGINEERING',8765439004),(1612388418,1,'Chloe','Hunt','orci@est.org','MATH',2657429599),(1626383391,2,'Valentine','Lindsey','ultrices.sit.amet@ultriciesornareelit.co.uk','SCIENCE',5362094451),(1707883649,2,'Raven','Estes','mauris@hendreritidante.org','MATH',6674756321),(1720509177,2,'Yardley','Lowery','Nullam.lobortis.quam@justo.ca','ENGINEERING',2661359935),(1753162326,3,'Kalia','Blackburn','ornare@mollisDuis.ca','ENGINEERING',1564087543),(1762985662,1,'Laurel','Christian','Duis.risus.odio@pharetrased.co.uk','SCIENCE',3444794127),(1770330951,1,'Joseph','Howard','metus.Vivamus.euismod@MorbimetusVivamus.org','ENGINEERING',1452197466),(1833907853,1,'Irene','Potter','magna@felisadipiscingfringilla.net','SCIENCE',3113729206),(1864255823,2,'Miranda','Alvarado','Morbi.sit@nec.com','SCIENCE',2085659573),(1905959608,3,'Kenneth','Blanchard','metus.Aenean.sed@vestibulumneque.ca','ENGINEERING',8637573895),(1914453791,3,'Callum','Mendez','arcu.Sed.eu@nec.org','BUSINESS',9153681476),(1925517761,1,'Donovan','Cain','non.dapibus@Mauris.com','BUSINESS',1277314932),(1931743585,3,'Alec','Singleton','Maecenas@acfermentum.edu','ENGINEERING',1496534600),(1978363640,1,'Erich','Kane','pede.Cras.vulputate@parturientmontes.net','SCIENCE',9135604896),(2029707712,2,'Vladimir','Sanchez','id.ante@natoque.com','BUSINESS',3808976465);
/*!40000 ALTER TABLE `Person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PersonType`
--

DROP TABLE IF EXISTS `PersonType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PersonType` (
  `personTypeID` int(11) DEFAULT NULL,
  `personType` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PersonType`
--

LOCK TABLES `PersonType` WRITE;
/*!40000 ALTER TABLE `PersonType` DISABLE KEYS */;
INSERT INTO `PersonType` VALUES (1,'Campus Faculty'),(2,'Staff'),(3,'Student');
/*!40000 ALTER TABLE `PersonType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rating`
--

DROP TABLE IF EXISTS `Rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rating` (
  `customer` int(11) DEFAULT NULL,
  `driver` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `rating` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rating`
--

LOCK TABLES `Rating` WRITE;
/*!40000 ALTER TABLE `Rating` DISABLE KEYS */;
INSERT INTO `Rating` VALUES (272424800,988689224,'2019-02-09',4),(518035872,700345995,'2019-03-24',5),(272424800,988689224,'2019-02-10',5),(412603553,1476964689,'2019-04-10',4);
/*!40000 ALTER TABLE `Rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ride`
--

DROP TABLE IF EXISTS `Ride`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ride` (
  `customer` int(11) NOT NULL,
  `driver` int(11) NOT NULL,
  `pickUpTime` datetime NOT NULL,
  `pickUpLocation` text NOT NULL,
  `golfCart` int(11) NOT NULL,
  PRIMARY KEY (`customer`,`driver`,`pickUpTime`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ride`
--

LOCK TABLES `Ride` WRITE;
/*!40000 ALTER TABLE `Ride` DISABLE KEYS */;
INSERT INTO `Ride` VALUES (62022838,265586444,'2019-02-10 13:00:00','2',2),(272424800,988689224,'2019-02-08 09:30:00','3',NULL),(412603553,1476964689,'2019-04-10 08:00:00','1',NULL),(518035872,700345995,'2019-03-23 12:30:00','5',1),(1453760167,265586444,'2019-05-01 11:15:00','4',4),(1753162326,1476964689,'2019-01-26 07:45:00','2',NULL);
/*!40000 ALTER TABLE `Ride` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Staff`
--

DROP TABLE IF EXISTS `Staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Staff` (
  `personID` int(11) NOT NULL,
  `personTypeID` int(11) DEFAULT NULL,
  `position` text,
  `admin` bit(1) DEFAULT NULL,
  PRIMARY KEY (`personID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Staff`
--

LOCK TABLES `Staff` WRITE;
/*!40000 ALTER TABLE `Staff` DISABLE KEYS */;
INSERT INTO `Staff` VALUES (41762045,2,'Director of Operations',_binary ''),(58909427,2,'Front Desk Receptionist',_binary ''),(687734762,2,'Mechanic',_binary '\0'),(1029384409,2,'Mechanic',_binary '\0');
/*!40000 ALTER TABLE `Staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Student` (
  `personID` int(11) NOT NULL,
  `personTypeID` int(11) DEFAULT NULL,
  `birthDate` date NOT NULL,
  `gradYear` int(11) DEFAULT NULL,
  PRIMARY KEY (`personID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student`
--

LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Student` VALUES (62022838,3,'2000-01-01',2019),(272424800,3,'1999-02-03',2020),(412603553,3,'1996-05-06',2019),(518035872,3,'1997-11-18',2022),(558545730,3,'1996-10-31',2019),(959077926,3,'1997-12-06',2019),(1453760167,3,'1995-06-03',2022),(1753162326,3,'2000-08-26',2021),(1914453791,3,'2000-09-15',2021);
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `driver_rating_info`
--

DROP TABLE IF EXISTS `driver_rating_info`;
/*!50001 DROP VIEW IF EXISTS `driver_rating_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `driver_rating_info` AS SELECT 
 1 AS `driver_id`,
 1 AS `driver_firstname`,
 1 AS `driver_lastname`,
 1 AS `Average_Rating`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `ride_full_details`
--

DROP TABLE IF EXISTS `ride_full_details`;
/*!50001 DROP VIEW IF EXISTS `ride_full_details`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `ride_full_details` AS SELECT 
 1 AS `customer`,
 1 AS `customer_firstname`,
 1 AS `customer_lastname`,
 1 AS `driver`,
 1 AS `driver_firstname`,
 1 AS `driver_lastname`,
 1 AS `golfCart`,
 1 AS `golfcart_make`,
 1 AS `pickupLocation`,
 1 AS `locationName`,
 1 AS `pickupTime`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'FortyNinerGolfCartRides'
--
/*!50003 DROP PROCEDURE IF EXISTS `Person_By_Dept_SP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Person_By_Dept_SP`(in  dept varchar(30))
BEGIN
	select firstName, lastName, email, cell, department from Person
    where department like(upper(dept));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `driver_rating_info`
--

/*!50001 DROP VIEW IF EXISTS `driver_rating_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `driver_rating_info` AS select `r`.`driver` AS `driver_id`,(select `person`.`firstName` from `person` FORCE INDEX (`Person_By_Type`) where (`person`.`personID` = `r`.`driver`)) AS `driver_firstname`,(select `person`.`lastName` from `person` FORCE INDEX (`Person_By_Type`) where (`person`.`personID` = `r`.`driver`)) AS `driver_lastname`,avg(`r`.`rating`) AS `Average_Rating` from `rating` `r` group by `r`.`driver` order by `r`.`rating` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ride_full_details`
--

/*!50001 DROP VIEW IF EXISTS `ride_full_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ride_full_details` AS select `r`.`customer` AS `customer`,(select `person`.`firstName` from `person` FORCE INDEX (`Person_By_Type`) where (`person`.`personID` = `r`.`customer`)) AS `customer_firstname`,(select `person`.`lastName` from `person` FORCE INDEX (`Person_By_Type`) where (`person`.`personID` = `r`.`customer`)) AS `customer_lastname`,`r`.`driver` AS `driver`,(select `person`.`firstName` from `person` FORCE INDEX (`Person_By_Type`) where (`person`.`personID` = `r`.`driver`)) AS `driver_firstname`,(select `person`.`lastName` from `person` FORCE INDEX (`Person_By_Type`) where (`person`.`personID` = `r`.`driver`)) AS `driver_lastname`,`r`.`golfCart` AS `golfCart`,(select `g`.`Make` from `golfcart` `g` where (`g`.`cartID` = `r`.`golfCart`)) AS `golfcart_make`,`r`.`pickUpLocation` AS `pickupLocation`,(select `l`.`locationName` from `location` `l` where (`l`.`locationID` = `r`.`pickUpLocation`)) AS `locationName`,`r`.`pickUpTime` AS `pickupTime` from `ride` `r` order by `r`.`pickUpTime` */;
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

-- Dump completed on 2019-04-16 22:25:48
