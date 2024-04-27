-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 02, 2024 at 09:45 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bw`
--

-- --------------------------------------------------------

--
-- Table structure for table `arrestpoints`
--

CREATE TABLE `arrestpoints` (
  `arrestID` int(11) NOT NULL,
  `arrestX` float NOT NULL,
  `arrestY` float NOT NULL,
  `arrestZ` float NOT NULL,
  `arrestInterior` int(11) NOT NULL,
  `arrestWorld` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

--
-- Dumping data for table `arrestpoints`
--

INSERT INTO `arrestpoints` (`arrestID`, `arrestX`, `arrestY`, `arrestZ`, `arrestInterior`, `arrestWorld`) VALUES
(19, 1289.29, -1677.74, 13.6087, 0, 0),
(20, 1229.2, -1313.02, 796.786, 1, 7286);

-- --------------------------------------------------------

--
-- Table structure for table `atm`
--

CREATE TABLE `atm` (
  `atmID` int(11) NOT NULL,
  `atmX` float NOT NULL,
  `atmY` float NOT NULL,
  `atmZ` float NOT NULL,
  `atmA` float NOT NULL,
  `atmInterior` int(11) NOT NULL,
  `atmWorld` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `business`
--

CREATE TABLE `business` (
  `businessID` int(11) NOT NULL,
  `businessName` varchar(32) DEFAULT NULL,
  `businessOwner` int(12) DEFAULT 0,
  `businessOwnerName` varchar(32) DEFAULT NULL,
  `businessPartner` int(12) NOT NULL,
  `businessPartnerName` varchar(32) DEFAULT NULL,
  `businessType` int(12) DEFAULT 0,
  `businessTreasury` int(12) DEFAULT 0,
  `businessStorage` int(12) DEFAULT 0,
  `businessCapacity` int(12) DEFAULT 0,
  `businessPrice` int(12) NOT NULL,
  `businessOil` float DEFAULT NULL,
  `businessMaxOil` float DEFAULT NULL,
  `businessPosX` float DEFAULT 0,
  `businessPosY` float DEFAULT 0,
  `businessPosZ` float DEFAULT 0,
  `businessIntX` float DEFAULT 0,
  `businessIntY` float DEFAULT 0,
  `businessIntZ` float DEFAULT 0,
  `businessInterior` int(12) DEFAULT 0,
  `businessWorld` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

--
-- Dumping data for table `business`
--

INSERT INTO `business` (`businessID`, `businessName`, `businessOwner`, `businessOwnerName`, `businessPartner`, `businessPartnerName`, `businessType`, `businessTreasury`, `businessStorage`, `businessCapacity`, `businessPrice`, `businessOil`, `businessMaxOil`, `businessPosX`, `businessPosY`, `businessPosZ`, `businessIntX`, `businessIntY`, `businessIntZ`, `businessInterior`, `businessWorld`) VALUES
(20, '(Ls-Mall) | Skin Shop', 133, 'Hugo_Wingin', 0, '', 1, 0, 0, 25, 0, 0, 0, 215.587, -159.93, 1000.53, 204.415, -160.031, 1000.52, 14, 7020),
(21, '(Ls-Mall) Burger Shot', 133, 'Hugo_Wingin', 134, '', 2, 4794, 4, 50, 299, 0, 0, 381.981, -57.4628, 1001.52, 376.557, -67.8403, 1001.52, 10, 7021),
(22, '(Ls-Mall) | Lil\' probe inn', 133, 'Hugo_Wingin', 0, '', 8, 4784, 0, 25, 299, 0, 0, -219.504, 1405.9, 27.7734, -224.953, 1403.99, 27.7734, 18, 7282),
(23, '(Ls-Mall) | 24/7', 0, '', 0, '', 5, 0, 0, 25, 0, 0, 0, -33.8825, -56.0042, 1003.55, -23.3296, -55.543, 1003.55, 6, 7283),
(24, '(Ls-Mall) | Betting shop', 0, '', 0, '', 0, 0, 0, 25, 100, 0, 0, 821.347, 10.2609, 1004.2, 822.393, 1.9017, 1004.18, 3, 7284),
(27, '(Ls-Mall) Bank', 133, 'Hugo_Wingin', 0, '', 10, 0, 0, 25, 100, 0, 0, 2309.45, -2.1738, 26.7422, 2309.94, -8.4869, 26.7422, 0, 7285),
(28, '(View Wood) | Gas', 133, 'Hugo_Wingin', 134, '', 9, 0, 100, 300, 49, 50, 100, 1000.05, -920.04, 42.3281, 1004.29, -940.601, 42.1797, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `callcar`
--

CREATE TABLE `callcar` (
  `callcarID` int(11) NOT NULL,
  `callcarX` float NOT NULL,
  `callcarY` float NOT NULL,
  `callcarZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

--
-- Dumping data for table `callcar`
--

INSERT INTO `callcar` (`callcarID`, `callcarX`, `callcarY`, `callcarZ`) VALUES
(53, 1059.6, -928.519, 42.8853),
(54, 1088.81, -1379.24, 13.7813),
(55, 2440.13, -2465.79, 13.6324),
(56, 2105.43, -1777.97, 13.3905),
(57, 2127.76, -1137.56, 25.4347),
(58, 2307.55, 2454.19, 10.8203),
(59, 1836.78, 879.133, 10.7004),
(60, 2741.72, -2469.14, 13.6484);

-- --------------------------------------------------------

--
-- Table structure for table `carshop`
--

CREATE TABLE `carshop` (
  `carshopID` int(11) NOT NULL,
  `carshopModel` smallint(3) NOT NULL DEFAULT 0,
  `carshopPrice` int(11) NOT NULL DEFAULT 0,
  `carshopType` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `ID` int(12) DEFAULT 0,
  `contactID` int(12) NOT NULL,
  `contactName` varchar(32) DEFAULT NULL,
  `contactNumber` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `entrances`
--

CREATE TABLE `entrances` (
  `entranceID` int(12) NOT NULL,
  `entranceName` varchar(32) DEFAULT NULL,
  `entranceIcon` int(12) DEFAULT 0,
  `entrancePosX` float DEFAULT 0,
  `entrancePosY` float DEFAULT 0,
  `entrancePosZ` float DEFAULT 0,
  `entrancePosA` float DEFAULT 0,
  `entranceIntX` float DEFAULT 0,
  `entranceIntY` float DEFAULT 0,
  `entranceIntZ` float DEFAULT 0,
  `entranceIntA` float DEFAULT 0,
  `entranceInterior` int(12) DEFAULT 0,
  `entranceExterior` int(12) DEFAULT 0,
  `entranceExteriorVW` int(12) DEFAULT 0,
  `entranceType` int(12) DEFAULT 0,
  `entrancePass` smallint(4) DEFAULT 0,
  `entranceLocked` int(12) DEFAULT 0,
  `entranceCustom` int(4) DEFAULT 0,
  `entranceWorld` int(12) DEFAULT 0,
  `entranceFaction` int(11) DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

--
-- Dumping data for table `entrances`
--

INSERT INTO `entrances` (`entranceID`, `entranceName`, `entranceIcon`, `entrancePosX`, `entrancePosY`, `entrancePosZ`, `entrancePosA`, `entranceIntX`, `entranceIntY`, `entranceIntZ`, `entranceIntA`, `entranceInterior`, `entranceExterior`, `entranceExteriorVW`, `entranceType`, `entrancePass`, `entranceLocked`, `entranceCustom`, `entranceWorld`, `entranceFaction`) VALUES
(279, '(Ls-Mall) | Skin Shop', 0, 1102.41, -1440.2, 15.7969, 88.9963, 204.311, -168.753, 1000.52, 359.173, 14, 0, 0, 0, 0, 0, 0, 7020, -1),
(280, '(Ls-Mall) | Burger Shot', 0, 1102.41, -1458, 15.7969, 84.6096, 363.044, -75.0551, 1001.51, 318.079, 10, 0, 0, 0, 0, 0, 0, 7021, -1),
(281, '(Ls-Mall) | Security Service', 0, 1154.73, -1440.15, 15.7969, 267.864, 1494.47, 1303.76, 1093.29, 1.1744, 3, 0, 0, 0, 0, 0, 0, 7281, -1),
(282, '(Ls-Mall) | Lil\' probe inn', 0, 1154.73, -1458.03, 15.7969, 268.578, -229.108, 1401.28, 27.7656, 270.98, 18, 0, 0, 0, 0, 0, 0, 7282, -1),
(283, '(Ls-Mall) | 24/7', 0, 1158.55, -1473.71, 15.7969, 286.938, -27.4236, -58.1826, 1003.55, 358.21, 6, 0, 0, 0, 0, 0, 0, 7283, -1),
(284, '(Ls-Mall) | Betting shop', 0, 1098.59, -1473.58, 15.7969, 69.442, 834.478, 7.4315, 1004.19, 91.2075, 3, 0, 0, 0, 0, 0, 0, 7284, -1),
(285, '(Ls-Mall) | Bank', 0, 1111.99, -1370.03, 13.9844, 358.147, 2305.27, -16.2318, 26.7422, 268.654, 0, 0, 0, 0, 0, 0, 0, 7285, -1),
(286, '(Lv) | Prison Jail', 19, 2337.23, 2458.85, 14.9688, 1.0139, 1206.43, -1314.3, 796.788, 269.375, 12, 0, 0, 0, 0, 0, 0, 7286, -1),
(287, '(Ls) | Police of Headquarters', 30, 1555.5, -1675.63, 16.1953, 275.441, 246.397, 107.516, 1003.22, 357.535, 10, 0, 0, 0, 0, 0, 0, 7287, -1),
(294, '(Ls) | Police of Headquarters', 0, 274.459, 122.016, 1004.62, 88.1938, 1568.58, -1689.99, 6.2188, 183.207, 0, 10, 7287, 0, 0, 0, 0, 0, -1);

-- --------------------------------------------------------

--
-- Table structure for table `factions`
--

CREATE TABLE `factions` (
  `factionID` int(12) NOT NULL,
  `factionName` varchar(32) DEFAULT NULL,
  `factionColor` int(12) DEFAULT 0,
  `factionType` int(12) DEFAULT 0,
  `factionRanks` int(12) DEFAULT 0,
  `factionTreasury` int(12) NOT NULL DEFAULT 0,
  `factionLockerX` float DEFAULT 0,
  `factionLockerY` float DEFAULT 0,
  `factionLockerZ` float DEFAULT 0,
  `factionLockerInt` int(12) DEFAULT 0,
  `factionLockerWorld` int(12) DEFAULT 0,
  `factionWeapon1` int(12) DEFAULT 0,
  `factionAmmo1` int(12) DEFAULT 0,
  `factionWeapon2` int(12) DEFAULT 0,
  `factionAmmo2` int(12) DEFAULT 0,
  `factionWeapon3` int(12) DEFAULT 0,
  `factionAmmo3` int(12) DEFAULT 0,
  `factionWeapon4` int(12) DEFAULT 0,
  `factionAmmo4` int(12) DEFAULT 0,
  `factionWeapon5` int(12) DEFAULT 0,
  `factionAmmo5` int(12) DEFAULT 0,
  `factionWeapon6` int(12) DEFAULT 0,
  `factionAmmo6` int(12) DEFAULT 0,
  `factionWeapon7` int(12) DEFAULT 0,
  `factionAmmo7` int(12) DEFAULT 0,
  `factionWeapon8` int(12) DEFAULT 0,
  `factionAmmo8` int(12) DEFAULT 0,
  `factionWeapon9` int(12) DEFAULT 0,
  `factionAmmo9` int(12) DEFAULT 0,
  `factionWeapon10` int(12) DEFAULT 0,
  `factionAmmo10` int(12) DEFAULT 0,
  `factionRank1` varchar(32) DEFAULT NULL,
  `factionRank2` varchar(32) DEFAULT NULL,
  `factionRank3` varchar(32) DEFAULT NULL,
  `factionRank4` varchar(32) DEFAULT NULL,
  `factionRank5` varchar(32) DEFAULT NULL,
  `factionRank6` varchar(32) DEFAULT NULL,
  `factionRank7` varchar(32) DEFAULT NULL,
  `factionRank8` varchar(32) DEFAULT NULL,
  `factionRank9` varchar(32) DEFAULT NULL,
  `factionRank10` varchar(32) DEFAULT NULL,
  `factionRank11` varchar(32) DEFAULT NULL,
  `factionRank12` varchar(32) DEFAULT NULL,
  `factionRank13` varchar(32) DEFAULT NULL,
  `factionRank14` varchar(32) DEFAULT NULL,
  `factionRank15` varchar(32) DEFAULT NULL,
  `factionSkin1` int(12) DEFAULT 0,
  `factionSkin2` int(12) DEFAULT 0,
  `factionSkin3` int(12) DEFAULT 0,
  `factionSkin4` int(12) DEFAULT 0,
  `factionSkin5` int(12) DEFAULT 0,
  `factionSkin6` int(12) DEFAULT 0,
  `factionSkin7` int(12) DEFAULT 0,
  `factionSkin8` int(12) DEFAULT 0,
  `SpawnX` float DEFAULT NULL,
  `SpawnY` float DEFAULT NULL,
  `SpawnZ` float DEFAULT NULL,
  `SpawnInterior` int(11) DEFAULT NULL,
  `SpawnVW` int(1) DEFAULT NULL,
  `factionEntrance` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

--
-- Dumping data for table `factions`
--

INSERT INTO `factions` (`factionID`, `factionName`, `factionColor`, `factionType`, `factionRanks`, `factionTreasury`, `factionLockerX`, `factionLockerY`, `factionLockerZ`, `factionLockerInt`, `factionLockerWorld`, `factionWeapon1`, `factionAmmo1`, `factionWeapon2`, `factionAmmo2`, `factionWeapon3`, `factionAmmo3`, `factionWeapon4`, `factionAmmo4`, `factionWeapon5`, `factionAmmo5`, `factionWeapon6`, `factionAmmo6`, `factionWeapon7`, `factionAmmo7`, `factionWeapon8`, `factionAmmo8`, `factionWeapon9`, `factionAmmo9`, `factionWeapon10`, `factionAmmo10`, `factionRank1`, `factionRank2`, `factionRank3`, `factionRank4`, `factionRank5`, `factionRank6`, `factionRank7`, `factionRank8`, `factionRank9`, `factionRank10`, `factionRank11`, `factionRank12`, `factionRank13`, `factionRank14`, `factionRank15`, `factionSkin1`, `factionSkin2`, `factionSkin3`, `factionSkin4`, `factionSkin5`, `factionSkin6`, `factionSkin7`, `factionSkin8`, `SpawnX`, `SpawnY`, `SpawnZ`, `SpawnInterior`, `SpawnVW`, `factionEntrance`) VALUES
(224, 'Los Santos Police Department', 6591981, 1, 15, 0, 262.952, 109.759, 1004.62, 10, 7287, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cadet', 'Police Officer', 'Corporal', 'Sergeant', 'Lieutenant', 'Captain ', 'Inspector', 'Chief Of Inspector', 'Superintendent', 'Deputy Commander', 'Commander', 'Commissioner', 'Assistant Chief Of Police', 'Deputy Chief Of Police', 'Chief Of Police', 71, 280, 281, 284, 285, 286, 306, 307, 0, 0, 0, 0, 0, 0),
(225, 'Los Santos Mechanic', -256, 6, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rank 1', 'Rank 2', 'Rank 3', 'Rank 4', 'Rank 5', 'Rank 6', 'Rank 7', 'Rank 8', 'Rank 9', 'Rank 10', 'Rank 11', 'Rank 12', 'Rank 13', 'Rank 14', 'Rank 15', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(227, 'Los Santos Medical Department', -567188481, 3, 15, 0, 1172.71, -1327.92, 15.4017, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'ผู้อำนวยการแพทย์', 'รองผู้อำนวยการแพทย์', 'ผู้ช่วยผู้อำนวยการแพทย์', 'ศาสตราจารย์', 'รองศาสตราจารย์  ', 'นายแพทย์', 'ที่ปรึกษาแพทย์ ', 'แพทย์เฉพาะทางชำนาญการ', 'แพทย์เฉพาะทาง    ', 'ที่ปรึกษาแพทย์เฉพาะทาง', 'แพทย์', 'ผู้ช่วยแพทย์', 'แพทย์ฝึกหัด', 'แพทย์จบใหม่', 'นักเรียนแพทย์ ', 274, 275, 276, 308, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `garages`
--

CREATE TABLE `garages` (
  `garageID` int(11) NOT NULL,
  `garageX` float NOT NULL,
  `garageY` float NOT NULL,
  `garageZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

--
-- Dumping data for table `garages`
--

INSERT INTO `garages` (`garageID`, `garageX`, `garageY`, `garageZ`) VALUES
(49, 1276.9, -1339.61, 13.7306),
(51, 1064.52, -912.845, 43.8596),
(52, 1064.5, -903.435, 43.8596),
(53, 1064.5, -894.583, 43.8596);

-- --------------------------------------------------------

--
-- Table structure for table `gps`
--

CREATE TABLE `gps` (
  `gpsID` int(11) NOT NULL,
  `gpsName` varchar(32) DEFAULT NULL,
  `gpsX` float NOT NULL,
  `gpsY` float NOT NULL,
  `gpsZ` float NOT NULL,
  `gpsType` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

--
-- Dumping data for table `gps`
--

INSERT INTO `gps` (`gpsID`, `gpsName`, `gpsX`, `gpsY`, `gpsZ`, `gpsType`) VALUES
(108, '(Ls) | Hospital', 1172.66, -1323.37, 15.4024, 1),
(109, '(Ls) | Mall', 1128.34, -1429.58, 15.7969, 1),
(110, '(Ls) | Police Station', 1545.27, -1675.55, 13.56, 1),
(111, 'จุดกู้ซากยานพาหนะ', 2414.01, -2469.91, 13.625, 4),
(112, 'Trucking', 2730.24, -2451.47, 17.5937, 5),
(113, 'Forklift', 2721.32, -2380.82, 17.3403, 5),
(114, '(Ls) | Mechanic', 1050.72, -904.997, 42.744, 1),
(115, '(Ls) | Bank', 1111.94, -1370.33, 13.9844, 1),
(117, '- Garbage', 734.631, -1344.13, 13.5192, 5);

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `houseID` int(12) NOT NULL,
  `houseOwner` int(12) DEFAULT 0,
  `housePrice` int(12) DEFAULT 0,
  `houseAddress` varchar(32) DEFAULT NULL,
  `housePosX` float DEFAULT 0,
  `housePosY` float DEFAULT 0,
  `housePosZ` float DEFAULT 0,
  `housePosA` float DEFAULT 0,
  `houseIntX` float DEFAULT 0,
  `houseIntY` float DEFAULT 0,
  `houseIntZ` float DEFAULT 0,
  `houseIntA` float DEFAULT 0,
  `houseInterior` int(12) DEFAULT 0,
  `houseExterior` int(12) DEFAULT 0,
  `houseExteriorVW` int(12) DEFAULT 0,
  `houseLocked` int(4) DEFAULT 0,
  `houseWeapon1` int(12) DEFAULT 0,
  `houseAmmo1` int(12) DEFAULT 0,
  `houseWeapon2` int(12) DEFAULT 0,
  `houseAmmo2` int(12) DEFAULT 0,
  `houseWeapon3` int(12) DEFAULT 0,
  `houseAmmo3` int(12) DEFAULT 0,
  `houseWeapon4` int(12) DEFAULT 0,
  `houseAmmo4` int(12) DEFAULT 0,
  `houseWeapon5` int(12) DEFAULT 0,
  `houseAmmo5` int(12) DEFAULT 0,
  `houseWeapon6` int(12) DEFAULT 0,
  `houseAmmo6` int(12) DEFAULT 0,
  `houseWeapon7` int(12) DEFAULT 0,
  `houseAmmo7` int(12) DEFAULT 0,
  `houseWeapon8` int(12) DEFAULT 0,
  `houseAmmo8` int(12) DEFAULT 0,
  `houseWeapon9` int(12) DEFAULT 0,
  `houseAmmo9` int(12) DEFAULT 0,
  `houseWeapon10` int(12) DEFAULT 0,
  `houseAmmo10` int(12) DEFAULT 0,
  `houseMoney` int(12) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `invID` int(12) NOT NULL,
  `invOwner` int(11) NOT NULL DEFAULT 0,
  `invItem` varchar(32) DEFAULT NULL,
  `invQuantity` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`invID`, `invOwner`, `invItem`, `invQuantity`) VALUES
(1, 140, 'Burger', 5),
(2, 140, 'Water', 5),
(3, 141, 'Burger', 5),
(4, 141, 'Water', 5),
(5, 133, 'Burger', 10),
(6, 133, 'Water', 11),
(8, 142, 'Burger', 5),
(9, 142, 'Water', 5),
(10, 143, 'Burger', 5),
(11, 143, 'Water', 5),
(12, 144, 'Burger', 5),
(13, 144, 'Water', 5),
(14, 145, 'Burger', 5),
(15, 145, 'Water', 5),
(16, 147, 'Burger', 5),
(17, 147, 'Water', 5),
(18, 146, 'Burger', 5),
(19, 146, 'Water', 5),
(20, 148, 'Burger', 5),
(21, 148, 'Water', 5);

-- --------------------------------------------------------

--
-- Table structure for table `objectt`
--

CREATE TABLE `objectt` (
  `ID` int(11) NOT NULL DEFAULT 0,
  `ObjectModel` int(11) NOT NULL DEFAULT 0,
  `ObjectPosX` float NOT NULL,
  `ObjectPosY` float NOT NULL,
  `ObjectPosZ` float NOT NULL,
  `ObjectPosRX` float NOT NULL,
  `ObjectPosRY` float NOT NULL,
  `ObjectPosRZ` float NOT NULL,
  `ObjectWolrd` int(11) NOT NULL DEFAULT 0,
  `Textrueindex` int(11) NOT NULL DEFAULT 0,
  `TextrueModel` int(11) DEFAULT 0,
  `Textrue_Name1` varchar(64) NOT NULL,
  `Textrue_Name2` varchar(64) NOT NULL,
  `Textrue_Color` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

--
-- Dumping data for table `objectt`
--

INSERT INTO `objectt` (`ID`, `ObjectModel`, `ObjectPosX`, `ObjectPosY`, `ObjectPosZ`, `ObjectPosRX`, `ObjectPosRY`, `ObjectPosRZ`, `ObjectWolrd`, `Textrueindex`, `TextrueModel`, `Textrue_Name1`, `Textrue_Name2`, `Textrue_Color`) VALUES
(1, 11729, 260.803, 107.403, 1003.61, 0, 0, 90.8, 7287, 0, 0, '', '', 0),
(2, 11730, 260.802, 108.076, 1003.61, 0, 0, 88.1998, 7287, 0, 0, '', '', 0),
(3, 11729, 260.837, 108.735, 1003.62, 0, 0, 88.6, 7287, 0, 0, '', '', 0),
(4, 11729, 260.853, 109.395, 1003.62, 0, 0, 88.6, 7287, 0, 0, '', '', 0),
(5, 11730, 260.832, 110.04, 1003.61, 0, 0, 90.0999, 7287, 0, 0, '', '', 0),
(6, 2169, 260.992, 110.903, 1003.62, 0, 0, 89.8, 7287, 0, 0, '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `pawnveh`
--

CREATE TABLE `pawnveh` (
  `PawnVehID` int(12) NOT NULL,
  `PawnVehPosX` float NOT NULL,
  `PawnVehPosY` float NOT NULL,
  `PawnVehPosZ` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

--
-- Dumping data for table `pawnveh`
--

INSERT INTO `pawnveh` (`PawnVehID`, `PawnVehPosX`, `PawnVehPosY`, `PawnVehPosZ`) VALUES
(0, 2414.07, -2470.04, 13.625);

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `playerItemcode` int(11) NOT NULL DEFAULT 0,
  `playerStrain` int(11) NOT NULL DEFAULT 0,
  `playerBath` int(11) NOT NULL DEFAULT 0,
  `playerSleep` int(11) NOT NULL DEFAULT 0,
  `playerID` int(11) NOT NULL,
  `playerName` varchar(24) NOT NULL,
  `playerPassword` char(129) NOT NULL,
  `playerRegDate` char(90) NOT NULL DEFAULT 'None',
  `playerGender` tinyint(2) NOT NULL DEFAULT 0,
  `playerAge` smallint(3) NOT NULL DEFAULT 0,
  `playerAdmin` tinyint(2) NOT NULL DEFAULT 0,
  `playerKills` mediumint(8) NOT NULL DEFAULT 0,
  `playerDeaths` mediumint(8) NOT NULL DEFAULT 0,
  `playerMoney` int(11) NOT NULL DEFAULT 0,
  `playerBank` int(11) NOT NULL DEFAULT 0,
  `playerRedMoney` int(11) NOT NULL DEFAULT 0,
  `playerLevel` smallint(3) NOT NULL DEFAULT 0,
  `playerExp` int(11) NOT NULL DEFAULT 0,
  `playerMinutes` tinyint(2) NOT NULL DEFAULT 0,
  `playerHours` int(11) NOT NULL DEFAULT 0,
  `playerPosX` float NOT NULL DEFAULT 0,
  `playerPosY` float NOT NULL DEFAULT 0,
  `playerPosZ` float NOT NULL DEFAULT 0,
  `playerPosA` float NOT NULL DEFAULT 0,
  `playerSkin` smallint(3) NOT NULL DEFAULT 0,
  `playerSkins` smallint(3) NOT NULL DEFAULT 0,
  `playerSkinFaction` smallint(3) NOT NULL DEFAULT 0,
  `playerInterior` tinyint(2) NOT NULL DEFAULT 0,
  `playerWorld` int(11) NOT NULL DEFAULT 0,
  `playerTutorial` tinyint(1) NOT NULL DEFAULT 0,
  `playerSpawn` tinyint(1) NOT NULL DEFAULT 0,
  `playerThirsty` float NOT NULL DEFAULT 0,
  `playerHungry` float NOT NULL DEFAULT 0,
  `playerHealth` float NOT NULL DEFAULT 0,
  `playerInjured` tinyint(1) NOT NULL DEFAULT 0,
  `playerInjuredTime` int(11) NOT NULL DEFAULT 0,
  `playerFaction` int(12) NOT NULL DEFAULT -1,
  `playerFactionRank` int(12) NOT NULL DEFAULT 0,
  `playerPrisoned` tinyint(1) NOT NULL DEFAULT 0,
  `playerPrisonOut` smallint(3) NOT NULL DEFAULT 0,
  `playerJailTime` smallint(3) NOT NULL DEFAULT 0,
  `playerEntrance` int(11) NOT NULL DEFAULT -1,
  `playerMaxItem` int(11) NOT NULL DEFAULT 8,
  `playerItemAmount` int(11) NOT NULL DEFAULT 20,
  `playerPhone` int(11) NOT NULL DEFAULT 0,
  `playerVIP` tinyint(1) NOT NULL DEFAULT 0,
  `playerQuest` smallint(5) NOT NULL DEFAULT 0,
  `playerQuestProgress` int(11) NOT NULL DEFAULT 0,
  `playerWarn` tinyint(5) NOT NULL DEFAULT 0,
  `playerBan` tinyint(1) NOT NULL DEFAULT 0,
  `playerBanReason` varchar(128) NOT NULL DEFAULT 'None',
  `playerWhitelist` int(12) NOT NULL DEFAULT 0,
  `playerPoint` int(12) NOT NULL DEFAULT 0,
  `playerCoin` int(12) NOT NULL DEFAULT 0,
  `GiftBox` int(12) NOT NULL DEFAULT 0,
  `Animation` int(12) NOT NULL DEFAULT 0,
  `Faction` int(12) NOT NULL DEFAULT -1,
  `playerPowder` int(11) NOT NULL DEFAULT 0,
  `playerMarryOn` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`playerItemcode`, `playerStrain`, `playerBath`, `playerSleep`, `playerID`, `playerName`, `playerPassword`, `playerRegDate`, `playerGender`, `playerAge`, `playerAdmin`, `playerKills`, `playerDeaths`, `playerMoney`, `playerBank`, `playerRedMoney`, `playerLevel`, `playerExp`, `playerMinutes`, `playerHours`, `playerPosX`, `playerPosY`, `playerPosZ`, `playerPosA`, `playerSkin`, `playerSkins`, `playerSkinFaction`, `playerInterior`, `playerWorld`, `playerTutorial`, `playerSpawn`, `playerThirsty`, `playerHungry`, `playerHealth`, `playerInjured`, `playerInjuredTime`, `playerFaction`, `playerFactionRank`, `playerPrisoned`, `playerPrisonOut`, `playerJailTime`, `playerEntrance`, `playerMaxItem`, `playerItemAmount`, `playerPhone`, `playerVIP`, `playerQuest`, `playerQuestProgress`, `playerWarn`, `playerBan`, `playerBanReason`, `playerWhitelist`, `playerPoint`, `playerCoin`, `GiftBox`, `Animation`, `Faction`, `playerPowder`, `playerMarryOn`) VALUES
(0, 100, 0, 0, 133, 'Hugo_Wingin', 'A40B78813F32135EBFB9C37AF1B0EE4761F5CD21A46B066364A8344793794FFA56FAE3C0E5E105323A143FE8DB5AAD56DF64CEF10830C8D02D4297B2E7E6A9F3', '16-01-2023 02:24:23', 1, 0, 6, 0, 1, 50000, 15588, 0, 1, 500, 48, 17, 758.109, -1340.07, 13.5282, 100.295, 303, 0, 0, 0, 0, 1, 0, 47.771, 67.847, 95, 0, 0, 227, 5, 0, 0, 0, -1, 20, 50, 953188, 0, 0, 0, 1, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0),
(0, 12, 0, 0, 146, 'Nathan_Wingin', 'FD9D94340DBD72C11B37EBB0D2A19B4D05E00FD78E4E2CE8923B9EA3A54E900DF181CFB112A8A73228D1F3551680E2AD9701A4FCFB248FA7FA77B95180628BB2', '02-04-2024 10:41:33', 1, 18, 6, 0, 0, 5000, 8586, 0, 0, 0, 8, 2, 774.276, -1334.53, 13.5403, 158.251, 304, 0, 0, 0, 0, 1, 0, 57.055, 81.297, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 602856, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0),
(0, 14, 0, 0, 148, 'Godji_Oxygen', 'FD9D94340DBD72C11B37EBB0D2A19B4D05E00FD78E4E2CE8923B9EA3A54E900DF181CFB112A8A73228D1F3551680E2AD9701A4FCFB248FA7FA77B95180628BB2', '02-04-2024 11:06:43', 1, 24, 6, 0, 0, 5000, 9209, 0, 0, 0, 21, 2, 736.352, -1344.75, 13.5179, 297.212, 289, 0, 0, 0, 0, 1, 0, 53.384, 79.676, 76, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 801156, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `safezonedata`
--

CREATE TABLE `safezonedata` (
  `ID` int(11) NOT NULL,
  `szPosX` float NOT NULL,
  `szPosY` float NOT NULL,
  `szPosZ` float NOT NULL,
  `szSize` int(11) NOT NULL DEFAULT 200
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `ID` int(11) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Version` varchar(16) NOT NULL,
  `Locked` int(12) NOT NULL DEFAULT 0,
  `Password` varchar(32) NOT NULL,
  `Weather` int(2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`ID`, `Name`, `Version`, `Locked`, `Password`, `Weather`) VALUES
(0, '', '', 0, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

CREATE TABLE `shops` (
  `shopID` int(11) NOT NULL,
  `shopX` float NOT NULL,
  `shopY` float NOT NULL,
  `shopZ` float NOT NULL,
  `shopInterior` int(11) NOT NULL,
  `shopWorld` int(11) NOT NULL,
  `shopType` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `skinshop`
--

CREATE TABLE `skinshop` (
  `SkinshopID` int(11) NOT NULL,
  `SkinshopModel` int(12) DEFAULT 0,
  `SkinshopPrice` int(12) DEFAULT 0,
  `SkinshopTotal` int(11) DEFAULT NULL,
  `SkinshopType` int(12) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

--
-- Dumping data for table `skinshop`
--

INSERT INTO `skinshop` (`SkinshopID`, `SkinshopModel`, `SkinshopPrice`, `SkinshopTotal`, `SkinshopType`) VALUES
(60, 7, 2500, 2, 1),
(61, 14, 2500, 2, 1),
(62, 15, 2500, 2, 1),
(63, 20, 2500, 2, 1),
(64, 21, 2500, 2, 1),
(65, 22, 2500, 2, 1),
(66, 23, 2500, 2, 1),
(67, 24, 2500, 2, 1),
(68, 25, 2500, 2, 1),
(69, 28, 2500, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `vehiclegang`
--

CREATE TABLE `vehiclegang` (
  `ID` int(11) NOT NULL DEFAULT 0,
  `bPosX` float NOT NULL,
  `bPosY` float NOT NULL,
  `bPosZ` float NOT NULL,
  `Leader` int(11) NOT NULL DEFAULT 0,
  `Slot1` int(12) NOT NULL DEFAULT 0,
  `Slot2` int(12) NOT NULL DEFAULT 0,
  `Slot3` int(12) NOT NULL DEFAULT 0,
  `Slot4` int(12) NOT NULL DEFAULT 0,
  `Slot5` int(12) NOT NULL DEFAULT 0,
  `Slot6` int(12) NOT NULL DEFAULT 0,
  `Slot7` int(12) NOT NULL DEFAULT 0,
  `Slot8` int(12) NOT NULL DEFAULT 0,
  `Slot9` int(12) NOT NULL DEFAULT 0,
  `Slot10` int(12) NOT NULL DEFAULT 0,
  `Color11` int(12) NOT NULL DEFAULT -1,
  `Color12` int(12) NOT NULL DEFAULT -1,
  `Color13` int(12) NOT NULL DEFAULT -1,
  `Color14` int(12) NOT NULL DEFAULT -1,
  `Color15` int(12) NOT NULL DEFAULT -1,
  `Color16` int(12) NOT NULL DEFAULT -1,
  `Color17` int(12) NOT NULL DEFAULT -1,
  `Color18` int(12) NOT NULL DEFAULT -1,
  `Color19` int(12) NOT NULL DEFAULT -1,
  `Color110` int(12) NOT NULL DEFAULT -1,
  `Color21` int(12) NOT NULL DEFAULT -1,
  `Color22` int(12) NOT NULL DEFAULT -1,
  `Color23` int(12) NOT NULL DEFAULT -1,
  `Color24` int(12) NOT NULL DEFAULT -1,
  `Color25` int(12) NOT NULL DEFAULT -1,
  `Color26` int(12) NOT NULL DEFAULT -1,
  `Color27` int(12) NOT NULL DEFAULT -1,
  `Color28` int(12) NOT NULL DEFAULT -1,
  `Color29` int(12) NOT NULL DEFAULT -1,
  `Color210` int(12) NOT NULL DEFAULT -1
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `carID` int(10) NOT NULL,
  `carOwnerID` int(10) DEFAULT 0,
  `carOwner` varchar(24) DEFAULT 'Nobody',
  `carModel` smallint(3) DEFAULT 0,
  `carPrice` int(10) DEFAULT 0,
  `carType` int(12) NOT NULL,
  `carTickets` int(10) DEFAULT 0,
  `carLocked` tinyint(1) DEFAULT 0,
  `carPlate` varchar(32) DEFAULT 'None',
  `carFuel` float DEFAULT 0,
  `carHealth` float DEFAULT 1000,
  `carPosX` float DEFAULT 0,
  `carPosY` float DEFAULT 0,
  `carPosZ` float DEFAULT 0,
  `carPosA` float DEFAULT 0,
  `carColor1` smallint(3) DEFAULT 1,
  `carColor2` smallint(3) DEFAULT 1,
  `carPaintjob` tinyint(2) DEFAULT -1,
  `carInterior` tinyint(2) DEFAULT 0,
  `carWorld` int(10) DEFAULT 0,
  `carNeon` smallint(5) DEFAULT 0,
  `carNeonEnabled` tinyint(1) DEFAULT 0,
  `carTrunk` tinyint(1) DEFAULT 0,
  `carMod1` smallint(4) DEFAULT 0,
  `carMod2` smallint(4) DEFAULT 0,
  `carMod3` smallint(4) DEFAULT 0,
  `carMod4` smallint(4) DEFAULT 0,
  `carMod5` smallint(4) DEFAULT 0,
  `carMod6` smallint(4) DEFAULT 0,
  `carMod7` smallint(4) DEFAULT 0,
  `carMod8` smallint(4) DEFAULT 0,
  `carMod9` smallint(4) DEFAULT 0,
  `carMod10` smallint(4) DEFAULT 0,
  `carMod11` smallint(4) DEFAULT 0,
  `carMod12` smallint(4) DEFAULT 0,
  `carMod13` smallint(4) DEFAULT 0,
  `carMod14` smallint(4) DEFAULT 0,
  `carCash` int(10) DEFAULT 0,
  `carFaction` tinyint(2) DEFAULT -1,
  `carDestroy` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`carID`, `carOwnerID`, `carOwner`, `carModel`, `carPrice`, `carType`, `carTickets`, `carLocked`, `carPlate`, `carFuel`, `carHealth`, `carPosX`, `carPosY`, `carPosZ`, `carPosA`, `carColor1`, `carColor2`, `carPaintjob`, `carInterior`, `carWorld`, `carNeon`, `carNeonEnabled`, `carTrunk`, `carMod1`, `carMod2`, `carMod3`, `carMod4`, `carMod5`, `carMod6`, `carMod7`, `carMod8`, `carMod9`, `carMod10`, `carMod11`, `carMod12`, `carMod13`, `carMod14`, `carCash`, `carFaction`, `carDestroy`) VALUES
(29, 133, 'Hugo_Wingin', 580, 0, 0, 0, 1, '268', 53.64, 535.7, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 18652, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 500, -1, 0),
(30, 134, 'Nathan_April', 419, 0, 0, 0, 0, 'None', 39.95, 962.241, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(31, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1148.91, -1381.34, 13.4136, 90.5042, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(32, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1148.89, -1382.86, 13.4188, 91.7447, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(33, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1148.84, -1379.68, 13.4004, 90.7817, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(34, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1149.1, -1378.21, 13.4056, 91.2685, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(35, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1148.91, -1376.8, 13.3851, 90.0692, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(36, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1148.91, -1375.25, 13.3765, 92.4772, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(37, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1148.48, -1373.55, 13.3076, 101.491, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(38, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1413.68, -2261.95, 13.1453, 359.883, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(39, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1410.47, -2262.15, 13.1469, 2.52094, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(40, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1407.24, -2262.07, 13.1464, 2.56069, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(41, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1404.03, -2261.96, 13.143, 359.005, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(42, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1400.47, -2262.06, 13.1445, 357.501, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(43, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1397.34, -2262.05, 13.1468, 358.78, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(44, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1394.03, -2262.23, 13.1437, 2.19255, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(45, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1390.76, -2262.27, 13.144, 359.521, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(46, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1387.5, -2262.25, 13.1444, 1.71355, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(47, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1384.24, -2262.1, 13.1472, 0.773569, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(48, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1414.4, -2313.63, 13.1554, 182.274, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(49, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1411.19, -2313.66, 13.1455, 181.271, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(50, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1407.85, -2313.7, 13.1463, 181.146, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(51, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1404.71, -2313.6, 13.1463, 180.198, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(52, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1401.38, -2313.51, 13.1466, 180.906, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(53, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1398.15, -2313.55, 13.1456, 182.265, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(54, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1394.86, -2313.51, 13.1456, 179.815, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(55, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1391.49, -2313.4, 13.1468, 179.582, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(56, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1388.26, -2313.3, 13.1458, 180.448, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(57, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1384.97, -2313.39, 13.1466, 181.354, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(58, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 148.88, -1921.74, 3.37722, 268.818, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(59, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 148.906, -1919.32, 3.37256, 267.901, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(60, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 148.968, -1916.96, 3.37289, 267.87, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(61, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 148.976, -1914.63, 3.37293, 270.914, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(62, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 148.92, -1912.3, 3.37293, 269.227, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(63, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1910.99, 176.384, 36.8496, 341.662, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(64, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1912.79, 175.772, 36.8767, 341.945, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(65, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1914.5, 175.229, 36.8741, 338.666, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(66, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1916.18, 174.728, 36.873, 339.757, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(67, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1918.02, 174.083, 36.8715, 339.465, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(68, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 2302.51, 2443.23, 10.4201, 273.783, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(69, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 2302.5, 2440.98, 10.4199, 268.561, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(70, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 2302.53, 2438.97, 10.4182, 270.066, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(71, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 2302.42, 2436.92, 10.4203, 271.444, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(82, 138, 'Godji_Oxygen', 438, 0, 0, 0, 0, 'None', 74.71, 906.405, 557.867, -1283.98, 17.0007, 0, 6, 6, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(83, 0, 'Nobody', 596, 0, 0, 0, 0, 'None', 0, 1000, 1602.33, -1684.07, 5.66685, 90.5296, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(84, 0, 'Nobody', 596, 0, 0, 0, 0, 'None', 0, 1000, 1602.09, -1688.2, 5.66749, 90.6965, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(85, 0, 'Nobody', 596, 0, 0, 0, 0, 'None', 0, 1000, 1602.04, -1692.16, 5.66763, 90.2359, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(86, 0, 'Nobody', 523, 0, 0, 0, 0, 'None', 0, 1000, 1585.4, -1680.05, 5.46792, 267.542, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(87, 0, 'Nobody', 523, 0, 0, 0, 0, 'None', 0, 1000, 1585.31, -1677.55, 5.46678, 268.799, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(88, 0, 'Nobody', 599, 0, 0, 0, 0, 'None', 0, 1000, 1602.03, -1696.14, 5.90478, 90.0578, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(90, 0, 'Nobody', 599, 0, 0, 0, 0, 'None', 0, 1000, 1601.98, -1700.21, 5.90478, 89.11, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(91, 0, 'Nobody', 416, 0, 0, 0, 0, 'None', 0, 1000, 1146.06, -1315.91, 13.5114, 90.6083, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(92, 0, 'Nobody', 416, 0, 0, 0, 0, 'None', 0, 1000, 1146.07, -1309.24, 13.5442, 86.7128, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(93, 0, 'Nobody', 416, 0, 0, 0, 0, 'None', 0, 1000, 1146.09, -1302.24, 13.5361, 84.9653, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(94, 0, 'Nobody', 586, 0, 0, 0, 0, 'None', 0, 1000, 1176.07, -1340.73, 13.4951, 270.575, 5, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(95, 0, 'Nobody', 586, 0, 0, 0, 0, 'None', 0, 1000, 1176.19, -1339.07, 13.4907, 270.218, 5, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(96, 0, 'Nobody', 586, 0, 0, 0, 0, 'None', 0, 1000, 1176.27, -1337.08, 13.4868, 269.793, 5, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(97, 0, 'Nobody', 586, 0, 0, 0, 0, 'None', 0, 1000, 1176.58, -1310.47, 13.4497, 270.727, 5, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(98, 0, 'Nobody', 586, 0, 0, 0, 0, 'None', 0, 1000, 1176.55, -1308.65, 13.457, 265.057, 5, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(99, 0, 'Nobody', 586, 0, 0, 0, 0, 'None', 0, 1000, 1176.28, -1306.71, 13.4765, 268.462, 5, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(100, 0, 'Nobody', 408, 0, 0, 0, 0, 'None', 0, 1000, 750.39, -1334.53, 14.0859, 179.719, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(101, 0, 'Nobody', 408, 0, 0, 0, 0, 'None', 0, 1000, 756.287, -1334.69, 14.0855, 180.014, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(102, 0, 'Nobody', 408, 0, 0, 0, 0, 'None', 0, 1000, 744.236, -1334.5, 14.0948, 179.425, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(103, 0, 'Nobody', 408, 0, 0, 0, 0, 'None', 0, 1000, 762.684, -1334.87, 14.0906, 177.198, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(104, 0, 'Nobody', 408, 0, 0, 0, 0, 'None', 0, 1000, 768.923, -1334.94, 14.0893, 180.43, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `arrestpoints`
--
ALTER TABLE `arrestpoints`
  ADD PRIMARY KEY (`arrestID`);

--
-- Indexes for table `atm`
--
ALTER TABLE `atm`
  ADD PRIMARY KEY (`atmID`);

--
-- Indexes for table `business`
--
ALTER TABLE `business`
  ADD PRIMARY KEY (`businessID`);

--
-- Indexes for table `callcar`
--
ALTER TABLE `callcar`
  ADD PRIMARY KEY (`callcarID`);

--
-- Indexes for table `carshop`
--
ALTER TABLE `carshop`
  ADD PRIMARY KEY (`carshopID`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`contactID`);

--
-- Indexes for table `entrances`
--
ALTER TABLE `entrances`
  ADD PRIMARY KEY (`entranceID`);

--
-- Indexes for table `factions`
--
ALTER TABLE `factions`
  ADD PRIMARY KEY (`factionID`);

--
-- Indexes for table `garages`
--
ALTER TABLE `garages`
  ADD PRIMARY KEY (`garageID`);

--
-- Indexes for table `gps`
--
ALTER TABLE `gps`
  ADD PRIMARY KEY (`gpsID`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`houseID`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`invID`);

--
-- Indexes for table `objectt`
--
ALTER TABLE `objectt`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`playerID`),
  ADD UNIQUE KEY `Username` (`playerName`);

--
-- Indexes for table `safezonedata`
--
ALTER TABLE `safezonedata`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indexes for table `shops`
--
ALTER TABLE `shops`
  ADD PRIMARY KEY (`shopID`);

--
-- Indexes for table `skinshop`
--
ALTER TABLE `skinshop`
  ADD PRIMARY KEY (`SkinshopID`);

--
-- Indexes for table `vehiclegang`
--
ALTER TABLE `vehiclegang`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`carID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `arrestpoints`
--
ALTER TABLE `arrestpoints`
  MODIFY `arrestID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `atm`
--
ALTER TABLE `atm`
  MODIFY `atmID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `business`
--
ALTER TABLE `business`
  MODIFY `businessID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `callcar`
--
ALTER TABLE `callcar`
  MODIFY `callcarID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `contactID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=216;

--
-- AUTO_INCREMENT for table `entrances`
--
ALTER TABLE `entrances`
  MODIFY `entranceID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=295;

--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `factions`
  MODIFY `factionID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=228;

--
-- AUTO_INCREMENT for table `garages`
--
ALTER TABLE `garages`
  MODIFY `garageID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `gps`
--
ALTER TABLE `gps`
  MODIFY `gpsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `invID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `playerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149;

--
-- AUTO_INCREMENT for table `safezonedata`
--
ALTER TABLE `safezonedata`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=150;

--
-- AUTO_INCREMENT for table `shops`
--
ALTER TABLE `shops`
  MODIFY `shopID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157;

--
-- AUTO_INCREMENT for table `skinshop`
--
ALTER TABLE `skinshop`
  MODIFY `SkinshopID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `carID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
