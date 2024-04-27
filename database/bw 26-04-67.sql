-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2024 at 06:58 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

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
(21, 1230.36, -1313.21, 796.786, 11, 7302);

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
(29, '(Ls-Mall) Burger Shop', 149, 'Hugo_Wingin', 175, '', 2, 2486, 86, 100, 299, 0, 0, 381.781, -57.4751, 1001.52, 376.548, -67.7994, 1001.52, 10, 7296),
(30, '(Ls-Mall) Lil\' probe inn', 149, 'Hugo_Wingin', -1, '', 8, 7323, 73, 100, 269, 0, 0, -219.448, 1405.78, 27.7734, -225.062, 1404.02, 27.7734, 18, 7297),
(31, '(Ls-Mall) Bank', -1, '', -1, '', 10, 0, 0, 25, 200, 0, 0, 2309.59, -2.3319, 26.7422, 2309.8, -8.5146, 26.7422, 0, 7299),
(32, '(Mulholand) Gas', 149, 'Hugo_Wingin', -1, '', 9, 0, 0, 25, 200, 100, 100, 1000.08, -920.093, 42.3281, 1004.15, -940.241, 42.1797, 0, 0),
(33, '(Flint) Gas', 149, 'Hugo_Wingin', -1, '', 9, 0, 0, 25, 200, 50, 50, -78.498, -1169.82, 2.1391, -90.959, -1169.18, 2.4199, 0, 0),
(34, 'รับดินปืน', 149, 'Hugo_Wingin', -1, '', 11, 0, 0, 25, 200, 0, 0, 1421.97, -1310.12, 13.5547, 2419.6, 85.7949, 26.4704, 0, 0),
(36, '(Ls-Mall) Casino', 149, 'Hugo_Wingin', -1, '', 0, 0, 0, 25, 200, 0, 0, 821.435, 10.2917, 1004.2, 822.078, 2.4027, 1004.18, 3, 7321);

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
(61, 1087.58, -1380.5, 13.7813),
(62, 827.104, -2062.03, 12.8672),
(64, -495.376, -64.8664, 61.0766),
(65, 640.734, 892.144, -42.9534),
(66, 2310.62, 2449.24, 10.8203),
(67, 2438.15, -2462.39, 13.6308),
(68, 2119.31, -1143.24, 24.6622),
(69, 1400.72, -2249.1, 13.5469),
(70, 1894.07, 188.335, 35.8347),
(71, 2101.14, -1367.1, 23.9844),
(72, -82.8956, -1192.2, 1.7545);

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

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`ID`, `contactID`, `contactName`, `contactNumber`) VALUES
(150, 216, 'พีีมิกคาโต๊ะ', 544249),
(151, 217, 'Daniel_Dragon', 544249),
(151, 218, 'Hugo_Wingin', 790961),
(150, 219, 'พี่ฮิวโก้', 790961),
(179, 220, 'นาทาน', 730045),
(149, 221, 'Nathan', 382559),
(157, 222, 'Forrest', 106457),
(194, 223, 'เชลดอน', 886324),
(149, 224, 'Russell', 381498),
(159, 225, 'ไอชิบหาย', 382559),
(186, 226, 'MIKOTO', 544249);

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
(295, '(Ls-Mall) | Skin Shop', 0, 1102.41, -1440.16, 15.7969, 90.2396, 204.258, -168.661, 1000.52, 0.6893, 14, 0, 0, 0, 0, 0, 0, 7295, -1),
(296, '(Ls-Mall) | Burger Shop', 0, 1102.41, -1457.99, 15.7969, 91.9514, 362.947, -75.0126, 1001.51, 315.25, 10, 0, 0, 0, 0, 0, 0, 7296, -1),
(297, '(Ls-Mall) Lil\' probe inn', 0, 1098.59, -1473.57, 15.7969, 67.3588, -229.148, 1401.19, 27.7656, 272.443, 18, 0, 0, 0, 0, 0, 0, 7297, -1),
(298, '(Ls-Mall) 24/7', 0, 1154.73, -1458.01, 15.7969, 271.277, -25.8641, -188.129, 1003.55, 4.216, 17, 0, 0, 0, 0, 0, 0, 7298, -1),
(299, '(Ls-Mall) Bank', 0, 1112.01, -1370.03, 13.9844, 0.4093, 2305.02, -16.1028, 26.7422, 271.88, 0, 0, 0, 0, 0, 0, 0, 7299, -1),
(300, 'LS | Police Station', 0, 1554.97, -1675.71, 16.1953, 273.503, 246.425, 107.436, 1003.22, 359.375, 10, 0, 0, 0, 0, 0, 0, 7300, -1),
(302, 'Lv | Prison Jail', 19, 2337.18, 2459.31, 14.9742, 0.1908, 1206.4, -1314.26, 796.788, 267.195, 11, 0, 0, 0, 0, 0, 0, 7302, -1),
(304, 'Ls | Floor Hospital', 0, 1173.56, -1339.99, 13.992, 90.8826, 1164.19, -1343.1, 26.6184, 187.082, 0, 0, 0, 0, 0, 0, 0, 0, -1),
(305, 'Ls | Police Stats Floor', 0, 274.495, 122.163, 1004.62, 95.2091, 1564.95, -1666.82, 28.3956, 2.0898, 0, 10, 7300, 0, 0, 0, 0, 0, -1),
(306, 'Ls | Hospital ', 0, 1172.5, -1323.34, 15.403, 87.9385, 288.726, 167.247, 1007.17, 2.2293, 3, 0, 0, 0, 0, 0, 0, 7306, -1),
(308, '(Flint) EletricePole', 0, -261.552, -902.506, 44.6856, 242.362, -259.67, -899.603, 79.6328, 153.856, 0, 0, 0, 0, 0, 0, 0, 0, -1),
(309, '(Flint) EletricePole', 0, -174.276, -966.834, 27.0307, 38.5074, -171.295, -965.507, 60.1172, 128.58, 0, 0, 0, 0, 0, 0, 0, 0, -1),
(310, '(Flint) EletricePole', 0, -63.5732, -1042.57, 21.4727, 216.122, -60.4476, -1040.83, 57.1953, 133.012, 0, 0, 0, 0, 0, 0, 0, 0, -1),
(311, '(Flint) EletricePole', 0, -50.4605, -1163.43, 2.4481, 80.9382, -48.5687, -1163.5, 38.25, 86.4334, 0, 0, 0, 0, 0, 0, 0, 0, -1),
(312, '(Flint) EletricePole', 0, -113.606, -1235.52, 2.8184, 347.788, -109.334, -1236.69, 39.217, 81.9109, 0, 0, 0, 0, 0, 0, 0, 0, -1),
(313, '(Flint) EletricePole', 0, -170.171, -1359.37, 3.4665, 177.703, -165.808, -1359.29, 39.1808, 89.8001, 0, 0, 0, 0, 0, 0, 0, 0, -1),
(314, '(Flint) EletricePole', 0, -193.794, -1464.11, 8.2052, 136.89, -191.149, -1467.44, 44.6682, 57.7839, 0, 0, 0, 0, 0, 0, 0, 0, -1),
(315, '(Flint) EletricePole', 0, -289.029, -1570.45, 8.0407, 246.81, -284.786, -1572.91, 43.3733, 54.5899, 0, 0, 0, 0, 0, 0, 0, 0, -1),
(316, '(Flint) EletricePole', 0, -339.673, -1655.49, 23.9831, 73.5032, -336.321, -1657.92, 60.9465, 57.3547, 0, 0, 0, 0, 0, 0, 0, 0, -1),
(317, '(Flint) EletricePole', 0, -388.61, -1752.07, 7.8271, 165.661, -385.029, -1753.44, 42.1246, 71.4129, 0, 0, 0, 0, 0, 0, 0, 0, -1),
(319, '(Flint) EletricePole', 0, -420.44, -1839.18, 4.1168, 219.766, -412.126, -1843.16, 39.6692, 132.803, 0, 0, 0, 0, 0, 0, 0, 0, -1),
(320, '(Flint) EletricePole', 0, -320.92, -844.609, 46.8318, 34.0938, -324.171, -846.969, 83.4312, 309.638, 0, 0, 0, 0, 0, 0, 0, 0, -1),
(321, '(Ls-Mall) Casino', 0, 1097.68, -1370.03, 13.9844, 359.281, 834.472, 7.4209, 1004.19, 94.575, 3, 0, 0, 0, 0, 0, 0, 7321, -1);

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
  `factionRedTreasury` int(11) NOT NULL DEFAULT 0,
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

INSERT INTO `factions` (`factionID`, `factionName`, `factionColor`, `factionType`, `factionRanks`, `factionTreasury`, `factionRedTreasury`, `factionLockerX`, `factionLockerY`, `factionLockerZ`, `factionLockerInt`, `factionLockerWorld`, `factionWeapon1`, `factionAmmo1`, `factionWeapon2`, `factionAmmo2`, `factionWeapon3`, `factionAmmo3`, `factionWeapon4`, `factionAmmo4`, `factionWeapon5`, `factionAmmo5`, `factionWeapon6`, `factionAmmo6`, `factionWeapon7`, `factionAmmo7`, `factionWeapon8`, `factionAmmo8`, `factionWeapon9`, `factionAmmo9`, `factionWeapon10`, `factionAmmo10`, `factionRank1`, `factionRank2`, `factionRank3`, `factionRank4`, `factionRank5`, `factionRank6`, `factionRank7`, `factionRank8`, `factionRank9`, `factionRank10`, `factionRank11`, `factionRank12`, `factionRank13`, `factionRank14`, `factionRank15`, `factionSkin1`, `factionSkin2`, `factionSkin3`, `factionSkin4`, `factionSkin5`, `factionSkin6`, `factionSkin7`, `factionSkin8`, `SpawnX`, `SpawnY`, `SpawnZ`, `SpawnInterior`, `SpawnVW`, `factionEntrance`) VALUES
(228, 'Los Santos Police Department', 678733567, 1, 15, 502, 0, 262.571, 109.547, 1004.62, 10, 7300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cadet', 'Police Officer', 'Corporal', 'Sergeant', 'Lieutenant', 'Captain', 'Inspector', 'Chief Of Inspector', 'Superintendent ', 'Deputy Commander ', 'Commander', 'Commissioner', 'Assistant Chief Of Police', 'Deputy Chief Of Police', 'Chief Of Police', 71, 280, 281, 284, 285, 286, 306, 307, 0, 0, 0, 0, 0, 0),
(229, 'Los Santos News', -536936193, 2, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'นักข่าวฝึกงาน', 'นักข่าวหน้างาน', 'นักข่าวหาเหตุด่วน/หาข่าว', 'เขียนข่าว', 'หัวหน้าสำนักงานข่าว', 'Rank 6', 'Rank 7', 'Rank 8', 'Rank 9', 'Rank 10', 'Rank 11', 'Rank 12', 'Rank 13', 'Rank 14', 'Rank 15', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(230, 'Los Santos Medical Department', -260013825, 3, 15, 1014, 0, 297.514, 186.004, 1007.17, 3, 7306, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'นักเรียนแพทย์ ', 'แพทย์จบใหม่ ', 'แพทย์ฝึกหัด', 'ผู้ช่วยแพทย์ ', 'แพทย์', 'ที่ปรึกษาแพทย์เฉพาะทาง', 'แพทย์เฉพาะทาง ', 'แพทย์เฉพาะทางชำนาญการ ', 'ที่ปรึกษาแพทย์', 'นายเเพทย์   ', 'รองศาสตราจารย์', 'ศาสตราจารย์', 'ผู้ช่วยผู้อำนวยการแพทย์', 'รองผู้อำนวยการแพทย์', 'ผู้อำนวยการแพทย์', 70, 274, 275, 276, 308, 240, 216, 0, 0, 0, 0, 0, 0, 0),
(231, 'Los Santos Mechanic', -11062273, 6, 6, 0, 0, 1064.59, -884.146, 43.6818, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'ช่างยนต์ฝึกหัด', 'ช่างยนต์มืออาชีพ', 'ช่างยนต์ชำนาญการ', 'ผู้ช่วยรองหัวหน้าช่างยนต์', 'รองหัวหน้าช่างยนต์', 'หัวหน้าช่างยนต์', 'Rank 7', 'Rank 8', 'Rank 9', 'Rank 10', 'Rank 11', 'Rank 12', 'Rank 13', 'Rank 14', 'Rank 15', 50, 69, 42, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(232, 'Los Sanntos Sheriff Department', 241587711, 1, 5, 0, 0, 626.965, -571.774, 17.9207, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Rank 1', 'Rank 2', 'Rank 3', 'Rank 4', 'Rank 5', 'Rank 6', 'Rank 7', 'Rank 8', 'Rank 9', 'Rank 10', 'Rank 11', 'Rank 12', 'Rank 13', 'Rank 14', 'Rank 15', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

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
(118, '- (Ls) | Mall (ตลาด)', 1128.2, -1435.25, 15.7969, 1),
(119, '- (Ls) | Hospital (โรงพยาบาล)', 1178.63, -1323.57, 14.1296, 1),
(120, '- (Ls) | Police Station ', 1553.7, -1675.5, 16.1953, 1),
(121, '- Garbage (งานเก็บขยะ)', 735.291, -1343.28, 13.5211, 5),
(122, '- Fishing (งานตกปลา)', 850.042, -2071.92, 12.943, 5),
(123, '- ElectricalPole (งานซ่อมเสาไฟ)', -79.2178, -1135.65, 1.0781, 5),
(124, '- Lumberjack (งานตัดไม้)', -531.222, -64.8856, 62.9849, 5),
(125, '- Garage Gas Flint', 627.583, 894.811, -41.1028, 5),
(126, '- (Ls) | DriverLicense ', 2131.9, -1149.39, 24.2731, 1),
(127, '- Garage LS Mall', 1087.91, -1380.61, 13.7813, 7),
(128, '- Garage Fishing', 827.104, -2062.03, 12.8672, 7),
(129, '- Garage ElectricalPole', -68.8703, -1112.78, 1.0781, 7),
(130, '- Garage Lumberjack', -495.376, -64.8664, 61.0766, 7),
(131, '- Garage Mining', 640.734, 892.144, -42.9534, 7),
(132, '(Ls-Mall) Bank', 1112.07, -1370.65, 13.9844, 6),
(133, '- Garage Prison', 2310.62, 2449.24, 10.8203, 7),
(134, '- (Lv) Prison (เรือนจำ)', 2337.12, 2458, 14.9688, 3),
(136, '- Garage Impound', 2438.15, -2462.39, 13.6308, 7),
(138, '-  Los Santos Impound', 2413.33, -2470.95, 13.6298, 4),
(139, '- Garage DrivingLicense', 2119.36, -1143.05, 24.6777, 7),
(140, '- Garage Newbie', 1400.64, -2249.02, 13.5469, 7),
(141, '- (Ls) | Casino (คาสิโน)', 1097.62, -1370.24, 13.9844, 1),
(142, '- Apple (เก็บแอปเปิ้ล)', 1945.89, 163.605, 37.2459, 5),
(143, '- Garage Apple', 1894.07, 188.335, 35.8347, 7),
(144, '- Classic (คลาสสิค)', 2095.86, -1359.52, 23.9844, 4),
(145, '- Pick up (กระบะ)', 2106.39, -1359.52, 23.9844, 4),
(146, '- Garage Gas Flint', -82.8956, -1192.2, 1.7545, 7),
(147, '- Garage Vehicles Shop', 2101.08, -1366.95, 23.9844, 7);

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
(31, 152, 'Burger', 5),
(33, 150, 'Burger', 2),
(35, 154, 'Burger', 5),
(36, 154, 'Water', 5),
(37, 153, 'Burger', 1),
(39, 152, 'Water', 4),
(40, 149, 'Skin:217', 48),
(44, 155, 'Burger', 5),
(45, 155, 'Water', 5),
(46, 156, 'Burger', 5),
(47, 156, 'Water', 5),
(48, 157, 'Burger', 34),
(49, 157, 'Water', 34),
(50, 158, 'Burger', 5),
(51, 158, 'Water', 5),
(52, 159, 'Burger', 30),
(53, 159, 'Water', 30),
(54, 161, 'Burger', 25),
(55, 161, 'Water', 30),
(56, 160, 'Burger', 5),
(57, 160, 'Water', 5),
(58, 150, 'DrivingLicense', 1),
(59, 152, 'DrivingLicense', 1),
(60, 159, 'DrivingLicense', 1),
(61, 154, 'DrivingLicense', 1),
(62, 155, 'iFruit', 1),
(63, 162, 'Burger', 5),
(64, 162, 'Water', 5),
(65, 161, 'Radio', 1),
(66, 164, 'Burger', 4),
(67, 164, 'Water', 3),
(70, 165, 'Burger', 2),
(72, 155, 'DrivingLicense', 1),
(73, 165, 'DrivingLicense', 1),
(74, 159, 'Hammer', 1),
(75, 150, 'Hammer', 2),
(76, 152, 'MedicCase', 30),
(77, 165, 'iFruit', 1),
(78, 166, 'Burger', 5),
(79, 166, 'Water', 5),
(82, 149, 'Skin:98', 20),
(84, 153, 'Skin:79', 3),
(90, 159, 'Iron', 3),
(91, 150, 'Watch', 1),
(92, 159, 'Watch', 1),
(93, 153, 'Watch', 1),
(94, 150, 'iFruit', 1),
(95, 159, 'iFruit', 1),
(101, 164, 'Watch', 1),
(102, 164, 'Radio', 1),
(103, 151, 'iFruit', 1),
(106, 167, 'Burger', 5),
(107, 167, 'Water', 5),
(109, 155, 'Skin:300', 1),
(110, 168, 'Burger', 5),
(111, 168, 'Water', 5),
(112, 169, 'Burger', 35),
(113, 169, 'Water', 34),
(114, 169, 'DrivingLicense', 1),
(115, 169, 'Watch', 1),
(116, 164, 'FishingRod', 1),
(117, 164, 'Chainsaw', 1),
(118, 164, 'Log', 1),
(119, 164, 'WoodPacks', 1),
(120, 164, 'FishingBait', 20),
(125, 171, 'Burger', 30),
(126, 171, 'Water', 30),
(127, 152, 'iFruit', 1),
(128, 172, 'Burger', 5),
(129, 172, 'Water', 5),
(130, 164, 'DrivingLicense', 1),
(131, 173, 'Burger', 5),
(132, 173, 'Water', 5),
(133, 174, 'Burger', 5),
(134, 174, 'Water', 5),
(135, 175, 'Burger', 5),
(136, 175, 'Water', 4),
(138, 176, 'Burger', 30),
(139, 176, 'Water', 30),
(140, 176, 'DrivingLicense', 1),
(141, 177, 'Burger', 5),
(142, 177, 'Water', 5),
(145, 178, 'Burger', 5),
(146, 178, 'Water', 5),
(148, 153, 'DrivingLicense', 1),
(149, 151, 'DrivingLicense', 1),
(150, 149, 'DrivingLicense', 1),
(155, 179, 'Burger', 3),
(156, 179, 'Water', 1),
(157, 179, 'Chainsaw', 1),
(159, 179, 'Watch', 1),
(160, 170, 'iFruit', 1),
(163, 179, 'iFruit', 1),
(165, 149, 'iFruit', 1),
(169, 180, 'Burger', 5),
(170, 180, 'Water', 5),
(171, 181, 'Burger', 5),
(172, 181, 'Water', 5),
(175, 182, 'Burger', 5),
(176, 182, 'Water', 5),
(177, 180, 'DrivingLicense', 1),
(178, 183, 'Burger', 4),
(179, 183, 'Water', 2),
(186, 180, 'Skin:217', 1),
(192, 183, 'iFruit', 1),
(193, 184, 'Burger', 5),
(194, 184, 'Water', 5),
(195, 149, 'Skin:223', 16),
(198, 161, 'iFruit', 1),
(200, 185, 'Burger', 5),
(201, 185, 'Water', 5),
(203, 186, 'Burger', 5),
(204, 186, 'Water', 2),
(206, 153, 'GunPowder', 3),
(207, 188, 'Burger', 5),
(208, 188, 'Water', 5),
(210, 186, 'DrivingLicense', 1),
(214, 190, 'Burger', 5),
(215, 190, 'Water', 5),
(218, 186, 'FishingRod', 1),
(219, 186, 'Chainsaw', 1),
(220, 191, 'Burger', 5),
(221, 191, 'Water', 5),
(222, 191, 'iFruit', 1),
(227, 157, 'Watch', 1),
(229, 157, 'iFruit', 1),
(234, 157, 'DrivingLicense', 1),
(235, 193, 'Burger', 5),
(236, 193, 'Water', 4),
(237, 194, 'Burger', 30),
(238, 194, 'Water', 30),
(244, 161, 'AdminGun', 1),
(246, 161, 'Skin:223', 1),
(248, 193, 'DrivingLicense', 1),
(249, 194, 'iFruit', 1),
(257, 153, 'Chainsaw', 1),
(263, 195, 'Burger', 30),
(264, 195, 'Water', 30),
(265, 195, 'Skin:223', 24),
(266, 196, 'Burger', 5),
(267, 196, 'Water', 5),
(269, 197, 'Burger', 5),
(270, 197, 'Water', 5),
(271, 196, 'iFruit', 1),
(272, 198, 'Burger', 5),
(273, 198, 'Water', 5),
(282, 199, 'Burger', 5),
(283, 199, 'Water', 5),
(288, 201, 'Burger', 5),
(289, 201, 'Water', 5),
(290, 202, 'Burger', 30),
(291, 202, 'Water', 29),
(292, 203, 'Burger', 3),
(293, 203, 'Water', 6),
(294, 150, 'FishingRod', 1),
(295, 184, 'DrivingLicense', 1),
(296, 204, 'Burger', 5),
(297, 204, 'Water', 5),
(302, 175, 'Camera', 1),
(303, 203, 'iFruit', 1),
(304, 175, 'iFruit', 1),
(306, 175, 'FishingRod', 2),
(307, 203, 'FishingRod', 2),
(308, 203, 'FishingBait', 5),
(310, 203, 'Turtle', 1),
(311, 175, 'Shell', 2),
(313, 203, 'Starfish', 2),
(315, 203, 'Shell', 1),
(318, 205, 'Burger', 5),
(319, 205, 'Water', 5),
(322, 206, 'Burger', 5),
(323, 206, 'Water', 5),
(324, 207, 'Burger', 5),
(325, 207, 'Water', 5),
(328, 203, 'Camera', 1),
(333, 208, 'Burger', 5),
(334, 208, 'Water', 5),
(339, 203, 'DrivingLicense', 1),
(340, 209, 'Burger', 18),
(341, 209, 'Water', 9),
(343, 176, 'iFruit', 1),
(344, 176, 'Watch', 1),
(345, 210, 'Burger', 5),
(346, 210, 'Water', 4),
(349, 211, 'Burger', 5),
(350, 211, 'Water', 5),
(351, 209, 'Chainsaw', 1),
(353, 152, 'Skin:217', 1),
(355, 152, 'Skin:240', 1),
(356, 152, 'Chainsaw', 1),
(357, 152, 'Hammer', 1),
(358, 152, 'FishingRod', 1),
(362, 152, 'WoodPacks', 5),
(380, 152, 'Log', 3),
(381, 152, 'Ore', 1),
(382, 213, 'Burger', 5),
(383, 213, 'Water', 4),
(384, 213, 'FishingRod', 1),
(388, 175, 'Chainsaw', 1),
(391, 207, 'Chainsaw', 1),
(392, 208, 'Chainsaw', 1),
(394, 175, 'WoodPacks', 26),
(397, 207, 'Log', 1),
(398, 203, 'Chainsaw', 1),
(400, 203, 'Watch', 1),
(402, 202, 'DrivingLicense', 1),
(404, 207, 'WoodPacks', 1),
(405, 152, 'Skin:281', 1),
(413, 193, 'FishingRod', 1),
(415, 203, 'Log', 17),
(416, 207, 'FishingBait', 10),
(418, 193, 'Hammer', 1),
(419, 175, 'Hammer', 1),
(420, 203, 'Hammer', 1),
(424, 151, 'Watch', 1),
(426, 203, 'Ore', 1),
(428, 201, 'DrivingLicense', 1),
(429, 203, 'Gold', 4),
(430, 175, 'Gold', 2),
(431, 208, 'FishingRod', 1),
(432, 175, 'Iron', 1),
(434, 207, 'Starfish', 1),
(436, 207, 'Shell', 1),
(438, 207, 'Jellyfish', 2),
(441, 207, 'Fish', 1),
(442, 201, 'iFruit', 1),
(453, 153, 'Log', 2),
(455, 214, 'Burger', 5),
(456, 214, 'Water', 5),
(464, 202, 'Skin:223', 1),
(467, 153, 'FishingRod', 1),
(470, 149, 'BetaTestBox', 18),
(471, 151, 'BetaTestBox', 6),
(475, 153, 'Fish', 6),
(476, 154, 'ToolBox', 20),
(477, 183, 'Hammer', 1),
(482, 183, 'Diamon', 6),
(486, 218, 'Burger', 5),
(487, 218, 'Water', 5),
(490, 186, 'Ore', 2),
(493, 186, 'Skin:217', 1),
(494, 152, 'Watch', 1),
(495, 153, 'iFruit', 1),
(496, 150, 'Camera', 1),
(504, 186, 'Watch', 1),
(505, 219, 'Burger', 10),
(506, 219, 'Water', 5),
(507, 202, 'iFruit', 1),
(508, 202, 'Chainsaw', 1),
(509, 202, 'Log', 3),
(510, 202, 'WoodPacks', 1),
(511, 150, 'Chainsaw', 1),
(513, 202, 'FishingBait', 13),
(515, 150, 'FishingBait', 48),
(518, 220, 'Burger', 5),
(519, 220, 'Water', 5),
(523, 221, 'Burger', 5),
(524, 221, 'Water', 5),
(529, 222, 'Burger', 5),
(530, 222, 'Water', 4),
(531, 222, 'Watch', 1),
(533, 219, 'MedicCase', 19),
(537, 223, 'Burger', 5),
(538, 223, 'Water', 5),
(539, 223, 'iFruit', 1),
(540, 223, 'MedicCase', 49),
(541, 224, 'Burger', 5),
(542, 224, 'Water', 5),
(544, 179, 'WoodPacks', 7),
(546, 179, 'FishingBait', 30),
(548, 151, 'Burger', 24),
(549, 151, 'Water', 21),
(550, 151, 'Skin:223', 1),
(553, 210, 'Hammer', 1),
(559, 157, 'Hammer', 1),
(560, 210, 'Ore', 1),
(570, 151, 'Crate', 12),
(572, 153, 'Hammer', 1),
(575, 157, 'Chainsaw', 1),
(580, 226, 'Burger', 5),
(581, 226, 'Water', 4),
(582, 227, 'Burger', 5),
(583, 227, 'Water', 5),
(584, 228, 'Burger', 5),
(585, 228, 'Water', 5),
(586, 228, 'FishingRod', 1),
(587, 228, 'Watch', 1),
(593, 229, 'Burger', 5),
(594, 229, 'Water', 5),
(595, 230, 'Burger', 5),
(596, 230, 'Water', 5),
(597, 232, 'Burger', 5),
(598, 232, 'Water', 5),
(599, 233, 'Burger', 5),
(600, 233, 'Water', 5),
(601, 234, 'Burger', 5),
(602, 234, 'Water', 5),
(603, 235, 'Burger', 5),
(604, 235, 'Water', 5),
(605, 222, 'FishingRod', 1),
(607, 236, 'Burger', 5),
(608, 236, 'Water', 5),
(609, 222, 'Chainsaw', 1),
(611, 179, 'DrivingLicense', 1),
(613, 227, 'Chainsaw', 1),
(614, 227, 'Log', 16),
(615, 227, 'WoodPacks', 6),
(623, 237, 'Burger', 5),
(624, 237, 'Water', 5),
(625, 237, 'Crate', 1),
(626, 222, 'ApplePack', 1),
(627, 238, 'Burger', 5),
(628, 238, 'Water', 5),
(629, 222, 'Hammer', 2),
(632, 239, 'Burger', 5),
(633, 239, 'Water', 5),
(645, 240, 'Burger', 4),
(646, 240, 'Water', 4),
(647, 153, 'WoodPacks', 18),
(649, 240, 'FishingRod', 1),
(654, 241, 'Burger', 5),
(655, 241, 'Water', 5),
(658, 189, 'Burger', 5),
(659, 189, 'Water', 5),
(660, 242, 'Burger', 5),
(661, 242, 'Water', 5),
(663, 170, 'Skin:223', 1),
(665, 189, 'FishingRod', 1),
(672, 240, 'Gold', 9),
(673, 240, 'Iron', 9),
(681, 209, 'Hammer', 1),
(689, 204, 'Log', 4),
(690, 204, 'Ore', 29),
(692, 240, 'Ore', 1),
(694, 149, 'ToolBox', 5),
(702, 153, 'Skin:217', 1),
(706, 157, 'FishingBait', 19),
(707, 243, 'Burger', 5),
(708, 243, 'Water', 5),
(721, 153, 'MedicCase', 1),
(726, 244, 'Burger', 5),
(727, 244, 'Water', 5),
(729, 244, 'DrivingLicense', 1),
(732, 245, 'Burger', 5),
(733, 245, 'Water', 4),
(734, 246, 'Burger', 5),
(735, 246, 'Water', 5),
(742, 175, 'AdminAk', 1),
(748, 183, 'Iron', 24),
(749, 183, 'Ore', 28),
(751, 183, 'ApplePack', 3),
(756, 240, 'Crate', 13),
(758, 247, 'Burger', 5),
(759, 247, 'Water', 5),
(761, 186, 'Log', 8),
(764, 194, 'Chainsaw', 1),
(765, 194, 'Log', 1),
(766, 247, 'iFruit', 1),
(768, 194, 'Skin:223', 1),
(769, 195, 'DrivingLicense', 1),
(781, 150, 'Ore', 20),
(782, 159, 'Ore', 19),
(792, 193, 'Chainsaw', 1),
(793, 193, 'Log', 1),
(795, 222, 'Ore', 3),
(796, 248, 'Burger', 5),
(797, 248, 'Water', 5),
(805, 170, 'ApplePack', 50),
(807, 249, 'Burger', 5),
(808, 249, 'Water', 5),
(811, 195, 'Radio', 1),
(812, 250, 'Burger', 5),
(813, 250, 'Water', 5),
(824, 220, 'DrivingLicense', 1),
(827, 176, 'AdminGun', 14),
(830, 175, 'DrivingLicense', 1),
(832, 157, 'Skin:223', 1),
(834, 250, 'AdminAk', 4),
(836, 195, 'AdminGun', 1),
(844, 149, 'MedicCase', 15),
(853, 169, 'AdminGun', 2),
(857, 240, 'ApplePack', 3),
(858, 149, 'AdminGun', 11),
(861, 175, 'AdminGun', 1),
(863, 164, 'Skin:283', 1),
(869, 251, 'Burger', 5),
(870, 251, 'Water', 5),
(871, 252, 'Burger', 5),
(872, 252, 'Water', 5),
(880, 213, 'Ore', 4),
(883, 251, 'Chainsaw', 1),
(885, 251, 'WoodPacks', 21),
(888, 234, 'DrivingLicense', 1),
(889, 209, 'DrivingLicense', 1),
(910, 150, 'Skin:217', 1),
(914, 194, 'FishingBait', 32),
(918, 186, 'iFruit', 1),
(919, 254, 'Burger', 5),
(920, 254, 'Water', 5),
(921, 186, 'Shell', 9),
(922, 186, 'Fish', 13),
(923, 186, 'Jellyfish', 10),
(924, 186, 'Starfish', 7),
(925, 186, 'Turtle', 2),
(928, 186, 'Crate', 34),
(929, 165, 'Hammer', 1),
(930, 186, 'ApplePack', 16),
(931, 255, 'Burger', 5),
(932, 255, 'Water', 5),
(933, 153, 'Skin:283', 1),
(934, 251, 'Skin:235', 1),
(935, 251, 'Log', 2),
(936, 251, 'FishingBait', 5),
(937, 256, 'Burger', 5),
(938, 256, 'Water', 5),
(940, 257, 'Burger', 5),
(941, 257, 'Water', 5),
(942, 257, 'Chainsaw', 1),
(943, 257, 'Log', 3),
(944, 257, 'WoodPacks', 5),
(945, 150, 'WoodPacks', 3),
(946, 150, 'Turtle', 1),
(947, 150, 'Jellyfish', 1),
(948, 150, 'Shell', 2),
(949, 150, 'Fish', 1),
(950, 150, 'Starfish', 1),
(955, 222, 'Diamon', 1),
(957, 222, 'DrivingLicense', 1),
(958, 258, 'Burger', 5),
(959, 258, 'Water', 5),
(960, 259, 'Burger', 5),
(961, 259, 'Water', 5);

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
(0, 2413.56, -2471.06, 13.63);

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
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
  `playerColor` int(12) NOT NULL DEFAULT 0,
  `Animation` int(12) NOT NULL DEFAULT 0,
  `Faction` int(12) NOT NULL DEFAULT -1,
  `playerOnDuty` tinyint(3) NOT NULL DEFAULT 0,
  `playerPowder` int(11) NOT NULL DEFAULT 0,
  `playerPowderMax` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`playerStrain`, `playerBath`, `playerSleep`, `playerID`, `playerName`, `playerPassword`, `playerRegDate`, `playerGender`, `playerAge`, `playerAdmin`, `playerKills`, `playerDeaths`, `playerMoney`, `playerBank`, `playerRedMoney`, `playerLevel`, `playerExp`, `playerMinutes`, `playerHours`, `playerPosX`, `playerPosY`, `playerPosZ`, `playerPosA`, `playerSkin`, `playerSkins`, `playerSkinFaction`, `playerInterior`, `playerWorld`, `playerTutorial`, `playerSpawn`, `playerThirsty`, `playerHungry`, `playerHealth`, `playerInjured`, `playerInjuredTime`, `playerFaction`, `playerFactionRank`, `playerPrisoned`, `playerPrisonOut`, `playerJailTime`, `playerEntrance`, `playerMaxItem`, `playerItemAmount`, `playerPhone`, `playerVIP`, `playerQuest`, `playerQuestProgress`, `playerWarn`, `playerBan`, `playerBanReason`, `playerWhitelist`, `playerPoint`, `playerCoin`, `playerColor`, `Animation`, `Faction`, `playerOnDuty`, `playerPowder`, `playerPowderMax`) VALUES
(100, 0, 0, 149, 'Hugo_Wingin', 'A40B78813F32135EBFB9C37AF1B0EE4761F5CD21A46B066364A8344793794FFA56FAE3C0E5E105323A143FE8DB5AAD56DF64CEF10830C8D02D4297B2E7E6A9F3', '17-04-2024 20:30:53', 1, 32, 6, 0, 0, 4336, 51067, 0, 1, 0, 24, 31, -81.1593, -1189.84, 1.75, 274.8, 305, 305, 280, 0, 0, 1, 0, 94.589, 97.038, 100, 0, 0, 228, 15, 0, 0, 0, -1, 20, 50, 790961, 0, 0, 0, 1, 0, 'None', 0, 0, 0, 0, 0, -1, 1, 0, 0),
(100, 0, 0, 150, 'William_Aaron', '06AA87B639659BB3CB656A74FBAA71FF3CE7FE899B016D22B91E139D6F300A54324FECA538347FD58E8D65470B7C137B947507F16C1DA77FC130C8CD0887A6EE', '17-04-2024 20:35:05', 1, 45, 3, 0, 0, 107, 5000, 0, 1, 0, 55, 30, -553.541, -75.1334, 63.524, 274.272, 7, 7, 0, 0, 0, 1, 0, 62.52, 84.747, 100, 0, 0, 232, 1, 0, 0, 0, -1, 20, 50, 382559, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(100, 0, 0, 151, 'Nathan_Wingin', '7276595AF5156D22BFEC7DE5DB93C0396D92E9A2F2A475BD8C70275AD95BFDF103CA09160CE7E3EA1B3B2C7796E73C3840CCE253D0EEA3F9CA187B3619AA325D', '17-04-2024 20:35:59', 1, 21, 6, 0, 0, 2163, 38639, 0, 1, 0, 29, 27, 1552.72, -1675.72, 16.1953, 71.0715, 304, 304, 0, 0, 0, 1, 0, 60.758, 55.561, 100, 0, 0, 228, 15, 0, 0, 0, -1, 20, 50, 730045, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 1, 0, -1, 1, 0, 0),
(100, 0, 0, 152, 'Ekque_Livepoor', '3D9EAF6FBF724D40C82B7B211BCB28FE7504BFF7BB4225D7AAA71EAA21F44034D33E0A90373DE102C3DE351CAB4A2E5472D3A74B0896D9D9A1E579CF9C39E3EC', '17-04-2024 20:35:59', 1, 22, 3, 0, 0, -468, 29106, 0, 1, 0, 59, 16, 1169.28, -1357.79, 26.6743, 55.6481, 274, 289, 274, 0, 0, 1, 0, 41.2, 44.932, 100, 0, 0, 230, 15, 1, 0, 0, 304, 20, 50, 939224, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 1, -1, 1, 0, 0),
(100, 0, 0, 153, 'Godji_Oxygen', '92C0C1B1A66EBAC75FCB6952D495E9E909A2CB99A71998D24D92367E5A649360E969B12D187FFB00616891C448D8171F3283664F2FD19E83A1767B9C835BF3E0', '17-04-2024 20:40:37', 1, 24, 6, 0, 0, 3587, 36317, 0, 1, 1, 8, 30, 2102.09, -1819.92, 13.6325, 31.8828, 289, 289, 0, 0, 0, 1, 0, 6.984, 55.117, 100, 0, 0, 232, 1, 0, 0, 0, -1, 20, 50, 630643, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(10, 0, 0, 154, 'Ezzuddin_Soybad', 'FCA63B05203E94944D038CB7C70EB7E8FFEF83F4CE454294B16F5DE9F5A1C296BD4DCB8115D886629BD26811B19C68869A5EF92D6BA47E281B730BCE1406DD7B', '17-04-2024 20:40:37', 1, 29, 3, 0, 0, 3000, 8981, 0, 1, 0, 30, 6, 1111.83, -1377.2, 14.2812, 283.533, 8, 217, 8, 0, 11, 1, 0, 92.902, 96.829, 95, 0, 0, 231, 7, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 1, 0, 0),
(11, 0, 0, 155, 'Nathaniel_Arthur', 'BA679533DED6FAC0BE6C114CAF3A086F6C1C7ADD5C023595A881276F0432C17FD0DC71FD6D66A81E70C391D7896036D41215655B40F86821EB49BE3FD6BF2F38', '17-04-2024 20:46:20', 1, 23, 0, 0, 0, 2000, 2079, 0, 1, 0, 55, 1, 269.707, 115.334, 1004.62, 267.422, 284, 289, 284, 10, 7300, 1, 0, 67.253, 83.45, 100, 0, 0, 228, 1, 1, 0, 0, 300, 20, 50, 911894, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 1, -1, 1, 0, 0),
(0, 0, 0, 156, 'Ripzx_Saifah', '16B74118C7F8FD6AC8A6C3D8751F0762BBB8A1CBF54BFFEDEC5118ACB592F912C207874986DE8A890FAB1A98C87530A2C047C6B96F5C6B53AE04902D0851DA17', '17-04-2024 20:46:41', 1, 18, 0, 0, 0, 5000, 5000, 0, 1, 0, 4, 0, 1615.37, -1659.9, 28.0975, 11.161, 289, 289, 0, 0, 0, 1, 0, 96.375, 99.352, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(15, 0, 0, 157, 'Sheldorn_Saleevan', '80E48CBC04916951CC7C7D7E79A349CDC506D393A3AD02C9974232F652546A7A54EA68C9F55029D3B756A25BEEB74ACF2BFAD336C09AE8805821A3290E059320', '17-04-2024 20:47:37', 1, 19, 0, 0, 0, 4563, 3917, 0, 1, 0, 9, 3, 1214.78, -1413, 13.3534, 357.263, 297, 297, 0, 0, 0, 1, 0, 84.076, 91.597, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 886324, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(1, 0, 0, 158, 'Alex_Wangpi', 'D42CDA9CD00933A46A048CE66F0D6366F521DF8F6AED69BC7208E4C7BC0B6A7F6B2AA2A261B6440C3EAA476F225A5E064CF10E2705076FE082D0BFED6E4F49D6', '17-04-2024 20:51:37', 1, 21, 0, 0, 0, 5000, 5000, 0, 1, 0, 11, 0, 1102.41, -1457.99, 4964.23, 330.782, 289, 289, 0, 0, 0, 1, 0, 95.705, 98.264, 100, 0, 0, -1, 0, 0, 0, 0, 296, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(23, 0, 0, 159, 'Zee_Mo', 'A38293470F3457D631143AB1E3723E40124A054F87CAF169A9B8CA5D2406FECF4429B8A7DDE07631DF59FDF736079B788D1336818D5E50A80408F0BD16F7965F', '17-04-2024 21:02:08', 1, 24, 0, 0, 0, 818, 15514, 0, 1, 0, 31, 3, 2084.67, -1366.29, 24.5298, 181.522, 223, 223, 0, 0, 0, 1, 0, 49.7, 70.209, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 228656, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 160, 'Constanzo_Provenzio', 'E888E129AEBDEC2152FF814C37EF2D4EFCABBA87B58A321434F246F4BDF1F9FC4FB1FD9DCA8EEE3774D52F07FAC35227D936D72710BBD325A78FD6054ED3918A', '17-04-2024 21:04:12', 1, 24, 0, 0, 0, 4900, 5000, 0, 1, 0, 7, 0, -127.535, -1362.7, 1.95915, 100.569, 289, 289, 0, 0, 0, 1, 0, 97.703, 99.005, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(11, 0, 0, 161, 'Alex_Thestar', 'D42CDA9CD00933A46A048CE66F0D6366F521DF8F6AED69BC7208E4C7BC0B6A7F6B2AA2A261B6440C3EAA476F225A5E064CF10E2705076FE082D0BFED6E4F49D6', '17-04-2024 21:06:39', 1, 21, 0, 0, 0, 3385, 2046, 0, 1, 0, 16, 2, 1270.83, -1368.99, 15.1968, 0.726316, 217, 217, 0, 0, 0, 1, 0, 86.742, 96.019, 95, 0, 0, 229, 5, 0, 0, 0, -1, 20, 50, 324122, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 162, 'Joe_Garcia', '20A8293C558A99EE6526E17503DE2CCA206150605AE4ED3071895D16817181E1A36E5971141668E2BDB04021B8E990CCF1690408B18DA3C7D3A81E5A6A23DBEE', '17-04-2024 21:25:00', 1, 18, 0, 0, 0, 5000, 5000, 0, 1, 0, 1, 0, 1342.7, -2306.69, 12.9897, 120.675, 289, 289, 0, 0, 0, 1, 0, 99.784, 99.838, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 163, 'Adam_Limaker', '057626DF55C11F50BA222A62DD865956EFE97603A105E5548E86AD04EC0CA755B9A81584DC75164E618311D0001B27C208DC0A91342845A1D229D864E9ECC13C', '17-04-2024 21:32:16', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 8, 20, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(71, 0, 0, 164, 'Mikoto_Wingin', 'AA47E5B5DF86903C0DEB41118112F26961A02A850CA1540FCDD99995AF8F54A8222464465052C33A49113A8FCD458C7AF409BCAC23A970C927EBFB6A9C894913', '17-04-2024 21:33:36', 1, 30, 6, 0, 0, -3635, 19737, 0, 1, 0, 37, 10, 655.17, -586.561, 16.3281, 343.449, 289, 289, 0, 0, 0, 1, 0, 74.252, 88.519, 100, 0, 0, 232, 15, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(34, 0, 0, 165, 'Adam_Limeker', 'CAF00BDD36C510BBE1DEFAC19210EE125A8878FD85E54FB01E0B120C4B45FF2AB5D302FD6E8453CCF9E8BF006253B1D4A4DCEF049BDB7817D5B8D8C69156794F', '17-04-2024 21:35:40', 1, 26, 0, 0, 0, 3800, 342, 0, 1, 0, 5, 6, 1540.43, -1669.15, 13.5487, 216.577, 281, 7, 281, 0, 0, 1, 0, 85.903, 98.125, 100, 0, 0, 228, 1, 0, 0, 0, -1, 20, 50, 107025, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 1, -1, 1, 0, 0),
(1, 0, 0, 166, 'Jazzy_Bro', '39DE212BACDB25A7787FBB20C3FBB2A4EFB9A5FE04F2C21A3F637AC65D9D3679BA7484847F0FC11A005E5E8EDF7D120EC099A573917F12171CCA1F1B62DC6D26', '17-04-2024 21:48:51', 1, 19, 0, 0, 0, 5000, 5000, 0, 1, 0, 24, 0, 1611.6, -1065.5, 23.4949, 279.33, 289, 289, 0, 0, 0, 1, 0, 92.425, 96.62, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(2, 0, 0, 167, 'Simon_Wingin', '4557AFB7EC378795B971E94D77C5B3145C60B7A4D5ABF81977F70FD7EC5E536B600E16794DD36A4BA338B130B124C43640E36BE1A8E45E116DF167D98371AF5F', '17-04-2024 23:04:33', 1, 35, 0, 0, 0, 5000, 5000, 0, 1, 0, 25, 0, 1176.19, -1843.31, 13.4856, 102.537, 289, 289, 0, 0, 0, 1, 0, 88.033, 96.366, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 168, 'Rizz_Tyron', 'AB90F5927EE13DDE8F1FB0265BB2EF0229E7E61F7F7E693DB47791DC0A3AFDFD2082E8817E657BC2B3D76AA5D8D5E06ABC84280BF791A6B5028CA7D320CCFBBC', '18-04-2024 00:00:50', 1, 27, 0, 0, 0, 5000, 5000, 0, 1, 0, 2, 0, 2095.2, -1802.86, 13.1356, 0.128208, 289, 289, 0, 0, 0, 1, 0, 99.305, 99.606, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(13, 0, 0, 169, 'Alex_Goodwin', '3561F9ABE77670FC909703E3D21770B2B73DE6621F5C786DEA736B64E6F5B62E7FD2F105CC26A88ACDC79CA13B034C2756FF960934B4C48DD94ADEF0DB328C47', '18-04-2024 00:17:25', 1, 27, 0, 0, 0, 2800, 11259, 0, 1, 0, 14, 2, 273.676, 119.621, 1004.62, 30.5473, 223, 223, 280, 10, 7300, 1, 0, 85.988, 86.436, 100, 0, 0, 228, 1, 0, 0, 0, 300, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(100, 0, 0, 170, 'Armin_Williams', '47AFB8C2B2DBEBA951EAA49A3A322EC6615D7C4361D2A33A931B021F694F05C8EF22BDC064ABF20812AD377A1E7EF628A30FEFD4233DCBD208A1816762C667D6', '18-04-2024 08:43:43', 1, 18, 0, 0, 0, 0, 4182, 0, 1, 0, 58, 23, 1101.41, -1382.3, 13.7812, 241.021, 250, 250, 0, 0, 0, 1, 0, 66.927, 84.653, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 474822, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(3, 0, 0, 171, 'First_Veretta', '2C06B2CE3405D0AA47FF8669408DCD0A4B2CC6EC27CB50B22388538BCCAEADE3D883C2744C6C8F2F8B226FF8BCB6ADBA26307506086CFAD67F9A20BE37478060', '18-04-2024 08:53:46', 1, 30, 0, 0, 0, 0, 15000, 0, 1, 0, 50, 0, 1168.52, -1355.53, 26.6789, 28.3558, 259, 259, 0, 0, 0, 1, 0, 84, 92.756, 100, 0, 0, -1, 0, 0, 0, 0, 304, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 172, 'William_Button', '06AA87B639659BB3CB656A74FBAA71FF3CE7FE899B016D22B91E139D6F300A54324FECA538347FD58E8D65470B7C137B947507F16C1DA77FC130C8CD0887A6EE', '18-04-2024 09:17:18', 1, 35, 0, 0, 0, 5000, 5000, 0, 1, 0, 0, 0, 1444.3, -2287.24, 13.5469, 101.953, 289, 289, 0, 0, 0, 1, 0, 99.938, 99.954, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 173, 'Black_Woods', '06AA87B639659BB3CB656A74FBAA71FF3CE7FE899B016D22B91E139D6F300A54324FECA538347FD58E8D65470B7C137B947507F16C1DA77FC130C8CD0887A6EE', '18-04-2024 09:25:42', 1, 25, 0, 0, 0, 5000, 5000, 0, 1, 0, 0, 0, 1442.44, -2286.46, 13.5469, 109.014, 289, 289, 0, 0, 0, 1, 0, 99.938, 99.954, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 174, 'Black_Woodss', '06AA87B639659BB3CB656A74FBAA71FF3CE7FE899B016D22B91E139D6F300A54324FECA538347FD58E8D65470B7C137B947507F16C1DA77FC130C8CD0887A6EE', '18-04-2024 09:28:33', 1, 25, 0, 0, 0, 5000, 5000, 0, 1, 0, 0, 0, 1445.82, -2286.91, 13.5469, 92.3983, 289, 289, 0, 0, 0, 1, 0, 99.938, 99.954, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(60, 0, 0, 175, 'Brian_Taloy', '609562194BA95E8470D9B84CBB42BA41D4C03D127FF627DB55A90F9A328D682A93FEB7CAF378E007560E6AC0F99E6B956D38B12AC02233A2382F1F156014F62C', '18-04-2024 09:34:47', 1, 25, 0, 0, 0, 116, 33362, 0, 1, 0, 48, 9, 247.65, 120.11, 1003.97, 352.916, 71, 185, 71, 10, 7300, 1, 0, 69.502, 80.464, 98, 0, 0, 228, 14, 0, 0, 0, 300, 20, 50, 116122, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 1, -1, 1, 0, 0),
(38, 0, 0, 176, 'Martin_Bronson', '4F189B2374A2529349188C766F8CCCB487FE977A8B616B11248FB388377918FF86333E5FC27201909BBBD4064E718253B4533D91A3F59CFFD7C25762560568B3', '18-04-2024 10:48:09', 1, 42, 0, 0, 0, 31, 16355, 0, 1, 0, 45, 5, 1557.22, -1833.95, 14.0469, 27.8468, 285, 223, 285, 0, 0, 1, 0, 69.627, 79.516, 100, 0, 0, 228, 14, 0, 0, 0, -1, 20, 50, 299862, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 1, -1, 1, 0, 0),
(0, 0, 0, 177, 'Test_BlackWoodss', '06AA87B639659BB3CB656A74FBAA71FF3CE7FE899B016D22B91E139D6F300A54324FECA538347FD58E8D65470B7C137B947507F16C1DA77FC130C8CD0887A6EE', '18-04-2024 11:02:54', 1, 25, 0, 0, 0, 5000, 5000, 0, 1, 0, 1, 0, 1445.82, -2286.91, 13.5469, 92.3983, 289, 289, 0, 0, 0, 1, 0, 99.815, 99.861, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(3, 0, 0, 178, 'Cherry_Ville', '2E5DA4E9EFAC814E01B98862F5CCE29B07BCEA17C7DB5D24EF301E0F8615FDCE1B59779130A7431BA0F348B5DE430FC4036062544B92A972B1F3A50735E20467', '18-04-2024 11:24:18', 2, 19, 0, 0, 0, 0, 5000, 0, 1, 0, 28, 0, 1111.49, -1378.1, 14.2879, 226.408, 192, 192, 0, 0, 0, 1, 0, 94.554, 96.065, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(69, 0, 0, 179, 'Daniel_Dragon', '890D54754AA2F8AB7136A1F9A09C90454B630B6ACA9F3E24FFD4DCEA1AD65ACA102FF120ADE4CD8572AF8BF14A32BF618EDC56FEB9BEEE6C2C4868F96C7C4708', '18-04-2024 12:59:45', 1, 18, 0, 0, 0, 632, 21, 0, 1, 0, 45, 10, -83.3618, -1192.15, 1.76151, 68.9432, 290, 290, 0, 0, 0, 1, 0, 94.308, 80.556, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 544249, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 7, 0, -1, 0, 0, 0),
(0, 0, 0, 180, 'Test_BlackWoods', '06AA87B639659BB3CB656A74FBAA71FF3CE7FE899B016D22B91E139D6F300A54324FECA538347FD58E8D65470B7C137B947507F16C1DA77FC130C8CD0887A6EE', '18-04-2024 13:46:35', 1, 25, 0, 0, 0, 4000, 5000, 0, 1, 0, 9, 0, 1183.35, -1338.56, 13.5715, 292.605, 289, 289, 0, 0, 0, 1, 0, 97.355, 98.543, 90, 0, 0, -1, 0, 0, 0, 0, 304, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 181, 'Kang_Milano', 'D276DED91F27869212948F651F8085CA6F9FAF0D1012E0E83209BDA1116E6B8D1A7F0A6F47DAC55C441B07CA10CFC245B20963C291F4AC6F80DE1A701E978CE4', '18-04-2024 13:47:49', 1, 23, 0, 0, 0, 5000, 5000, 0, 1, 0, 1, 0, 1410.5, -2262.2, 13.145, 3.40675, 289, 289, 0, 0, 0, 1, 0, 99.713, 99.815, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 182, 'Richard_Livepoor', 'E9A7A592F1FE559E9882270D7F86EDAAE9885D9D22932C6882E7C021E5091AE2BE409081D84BCF7FBB24F2D49F8D233EE9C0D9C19DD39685BFFFC6FFF60ADD0A', '18-04-2024 14:12:32', 1, 25, 0, 0, 0, 10000, 0, 0, 1, 0, 5, 0, 1147.73, -1452.43, 15.7969, 29.0728, 289, 289, 0, 0, 0, 1, 0, 98.861, 99.213, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(37, 0, 0, 183, 'Tyson_Williams', '87367C4860E6A4AC679900BD8444F742B6F43BABDF9000B4A0639DE23DD29217DBE7B5ACE90A6F069C0E4048B20C0DF5AD4F14D254B856B996F4FF6627CB2848', '18-04-2024 14:13:40', 1, 20, 0, 0, 0, 6019, 13763, 0, 1, 0, 46, 5, 631.151, 896.255, -42.7598, 275.497, 202, 202, 0, 0, 0, 1, 0, 92.893, 91.621, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 520401, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 184, 'Jamal_West', 'FD9D94340DBD72C11B37EBB0D2A19B4D05E00FD78E4E2CE8923B9EA3A54E900DF181CFB112A8A73228D1F3551680E2AD9701A4FCFB248FA7FA77B95180628BB2', '18-04-2024 15:51:31', 1, 20, 0, 0, 0, 4000, 5000, 0, 1, 0, 10, 0, 2208.04, -1132.96, 25.625, 68.0089, 289, 289, 0, 0, 0, 1, 0, 97.652, 98.704, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 185, 'Higfive_Flix', 'A1B6836C55060A4BBBEC18366A787F7F8CCBE832E4E19323CEE7D3A1A81376FFAA3A8C24A655206126036FDF626995382FC35782FD6C1ED880B6F6D2DDC4F7CC', '18-04-2024 18:11:42', 1, 20, 0, 0, 0, 5000, 5000, 0, 1, 0, 2, 0, 1411.94, -2253.54, 13.5469, 240.452, 289, 289, 0, 0, 0, 1, 0, 98.51, 99.722, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(100, 0, 0, 186, 'Conner_Rainford', 'B210A5450507B5513C34F005C2E7889FAD2E43B5986519F1D63ABB9A04225F298C8DAEF16D11459825A9FFC16E307ACF8F41A369E2F6F3D1AF5E3F86F57B1C21', '18-04-2024 18:13:04', 1, 25, 3, 0, 0, 50, 6928, 0, 1, 0, 31, 16, 1943.78, 163.979, 37.2812, 76.7093, 289, 289, 280, 0, 0, 1, 0, 37.044, 30.121, 100, 0, 0, 228, 1, 0, 0, 0, -1, 20, 50, 309301, 0, 0, 0, 1, 0, 'None', 0, 0, 0, 0, 1, -1, 0, 0, 0),
(0, 0, 0, 187, 'Razer_Rampage', '1486865B692E0A0631964023A93F3346B143D0842667FF3CBFEB08B237FB882AE90B74A3D46DA2111BA30151BEB2DB6B2BE648DC118345718AB725B8DDDBDB9F', '18-04-2024 18:15:39', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 8, 20, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 188, 'Razer_RampageXD', 'FD9D94340DBD72C11B37EBB0D2A19B4D05E00FD78E4E2CE8923B9EA3A54E900DF181CFB112A8A73228D1F3551680E2AD9701A4FCFB248FA7FA77B95180628BB2', '18-04-2024 18:18:12', 1, 25, 0, 0, 0, 5000, 5000, 0, 1, 0, 5, 0, 1413.17, -2292.51, 13.5469, 294.317, 289, 289, 0, 0, 0, 1, 0, 94.841, 99.236, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(5, 0, 0, 189, 'Williams_Johnson', '658DE8DE61EDA356DE84D82221BF449F955DFC47290CC364E56EB9CA9E971655B95C3DBB367D4CF3862852C038AF4338566E11AFF3D50CD58DC5D6D544A5ED87', '18-04-2024 18:53:39', 1, 21, 0, 0, 0, 3900, 6632, 0, 1, 0, 43, 0, -315.872, -1558.36, 13.2936, 323.168, 289, 289, 0, 0, 0, 1, 0, 87.515, 93.958, 58, 0, 0, -1, 0, 0, 0, 0, 319, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 190, 'Hyper_Xzx', '16B74118C7F8FD6AC8A6C3D8751F0762BBB8A1CBF54BFFEDEC5118ACB592F912C207874986DE8A890FAB1A98C87530A2C047C6B96F5C6B53AE04902D0851DA17', '18-04-2024 19:02:30', 1, 20, 0, 0, 0, 5000, 5000, 0, 1, 0, 1, 0, 1403.33, -2310.33, 13.5469, 159.217, 289, 289, 0, 0, 0, 1, 0, 99.506, 99.884, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(1, 0, 0, 191, 'Morgan_Arthur', 'BA679533DED6FAC0BE6C114CAF3A086F6C1C7ADD5C023595A881276F0432C17FD0DC71FD6D66A81E70C391D7896036D41215655B40F86821EB49BE3FD6BF2F38', '18-04-2024 19:39:34', 1, 23, 0, 0, 0, 2500, 0, 0, 1, 0, 10, 0, 1174.54, -1326.11, 14.9361, 200.011, 289, 289, 0, 0, 0, 1, 0, 97.555, 98.519, 100, 0, 0, 228, 1, 0, 0, 0, -1, 20, 50, 959699, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 192, 'Adam_Lanford', 'D3618B304ED8816CDFD3FED279E49DE6FECF76EC4E6948AAF8957842F48501CA1B8A40D2625C115D941FC286DD794A26EE3EBAFFBFF767EC00FFD788B2A81CF7', '18-04-2024 20:08:41', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 8, 20, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(54, 0, 0, 193, 'Margo_Andison', 'B7CAA5D3ACCC17EDFBEF5E0DE74A93E8351375DA81AEA0A27AAD602E742814529121B0624FC3E1AF524A10BFD08992DE60687A50B90CC8E3CEFBCFB5419521A1', '18-04-2024 20:10:49', 1, 25, 0, 0, 0, 4945, 24137, 0, 1, 0, 40, 8, 1548.86, -1675.19, 14.7105, 83.7706, 289, 289, 280, 0, 0, 1, 0, 77.443, 75.974, 60, 0, 0, 228, 1, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 1, -1, 0, 0, 0),
(8, 0, 0, 194, 'Forrest_Domin', '233BAB60396E5F367FEAAB248E9243510043FD9EB1194155A04ED9756D454D1C6D2C63C3737F70E453167FFC2F5BF8C5A72CE1732249F5B3D6F8D2C39648ACE3', '18-04-2024 20:14:55', 1, 18, 0, 0, 0, 2797, 2111, 0, 1, 0, 29, 1, 1117.94, -1377.36, 14.2879, 48.551, 23, 23, 0, 0, 0, 1, 0, 90.795, 92.524, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 106457, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 1, -1, 0, 0, 0),
(18, 0, 0, 195, 'Gaz_Moore', '09246E335D3BE292DE7F9C0A89FFDAF8DC2F96EAF96FFF4D4E96B74D60B228FC859F889C2F406D823BC2ED22FAD568366C8029123735E1254686DEE480E1A98A', '18-04-2024 21:43:40', 1, 23, 0, 0, 0, 3500, 11092, 0, 1, 0, 18, 3, 1535.7, -1673.42, 13.3828, 103, 280, 223, 280, 0, 0, 1, 0, 70.231, 91.856, 100, 0, 0, 228, 1, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 1, 0, 0),
(2, 0, 0, 196, 'Miko_Aomsin', 'BA679533DED6FAC0BE6C114CAF3A086F6C1C7ADD5C023595A881276F0432C17FD0DC71FD6D66A81E70C391D7896036D41215655B40F86821EB49BE3FD6BF2F38', '18-04-2024 21:48:13', 2, 23, 0, 0, 0, 2200, 0, 0, 1, 0, 25, 0, -562.697, -69.8031, 64.1417, 279.174, 191, 191, 0, 0, 0, 1, 0, 92.75, 96.528, 66, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 656348, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(3, 0, 0, 197, 'Comeeat_Chicken', '011D04F9DBC5F8EE1791F22552299EB19D5B8B72BF3C9AFC7EB26B2B5D927B828EBF5EBA38EFC41B1C9FA7E02826AE3F63D26C26204590C1998CC177CC0657A5', '18-04-2024 22:00:22', 1, 18, 0, 0, 0, 5000, 5000, 0, 1, 0, 27, 0, 2035.39, 956.267, 9.88224, 171.43, 289, 289, 0, 0, 0, 1, 0, 87.227, 96.158, 59, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(2, 0, 0, 198, 'Normal_Lox', 'C5F5ADF620B4B6FA3B8C6F7920896A1B7EB9DF35D9968124726E3BD38B92FE0160090202DB55A7C00A1796D3473B66A563C3D2C4435E10C3FD670FE62D7727F6', '18-04-2024 22:09:11', 1, 18, 0, 0, 0, 0, 5000, 0, 1, 0, 21, 0, 1688.36, -504.387, 33.5651, 251.891, 290, 290, 0, 0, 0, 1, 0, 86.796, 96.945, 28, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 199, 'William_Soghost', '7198BA70EFD5F667A6F0A7A0E8840E07997F00F763DAA8B7461DFE30132A8FAFAE97DC6D92DDC63953B192174DD0175734E44057C283C0862BFD2EEFF1911A7F', '18-04-2024 22:34:57', 1, 18, 0, 0, 0, 5000, 5000, 0, 1, 0, 1, 0, 1126.52, -1414.75, 14.6264, 339.777, 289, 289, 0, 0, 0, 1, 0, 99.242, 99.792, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 200, 'Sompong_Watanabe', 'CFAB68E5C175A1483CEFA79EB86D732AE8FDB727EF74EA2E7D1A07211107EB83F078C216AC1F278C9F4BEDD2F5AD411C09DCDE13691C153A6D86B82A55F9414A', '18-04-2024 23:00:18', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 8, 20, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(7, 0, 0, 201, 'Mike_Toleno', 'CFAB68E5C175A1483CEFA79EB86D732AE8FDB727EF74EA2E7D1A07211107EB83F078C216AC1F278C9F4BEDD2F5AD411C09DCDE13691C153A6D86B82A55F9414A', '18-04-2024 23:03:08', 1, 22, 0, 0, 0, 3245, 0, 0, 1, 0, 24, 1, 1189.99, -1407.62, 12.8038, 176.73, 289, 289, 0, 0, 0, 1, 0, 79.717, 88.127, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 404949, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(14, 0, 0, 202, 'Jamal_Crafood', '446F97F6374BA5536C5E473D7CEAEEFF7EC2E87EBDBE60383536D03405221D8233A86CE10CF723B1524AD2780C8E4921159503B7E14787D492A7459942483218', '18-04-2024 23:11:55', 1, 20, 0, 0, 0, 9723, 1799, 0, 1, 0, 15, 2, 781.967, -2267.79, -0.258872, 187.298, 289, 289, 0, 0, 0, 1, 0, 71.381, 85.74, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 462642, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(73, 0, 0, 203, 'Russell_Price', '2B258F2EA784669018265243116BA4D1F5BE5A67F4E3796894525EBCDD5CDCFC3D99007F278927BB221CCC2479ED4AE2D868AE4881CCA22B65977687113C8D85', '19-04-2024 00:01:00', 1, 25, 0, 0, 0, 331, 24920, 0, 1, 0, 20, 10, 713.683, -540.646, 16.3359, 279.537, 286, 259, 286, 0, 0, 1, 0, 76.377, 59.075, 10, 0, 0, 228, 1, 0, 0, 0, -1, 20, 50, 381498, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 1, -1, 1, 0, 0),
(4, 0, 0, 204, 'Recon_Reacher', '77A8E42C9FD1B120789707103FF74BD0E21FEBF7A27A9164CC2425D9ECBDC53C955A4DED5F9EDAD8C7923FBC88ACE0C1E043DCBEE84B43411101FDEC4E3AC41C', '19-04-2024 00:44:51', 1, 24, 0, 0, 0, 5000, 5000, 0, 1, 0, 50, 0, 769.583, -1338.92, 13.5262, 185.503, 289, 289, 0, 0, 0, 1, 0, 87.52, 93.033, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(3, 0, 0, 205, 'Tommy_Angelo', 'A95DA3C9409889C5CAD260F2B2729DF264B243BF521E013B8C29643B9040A8D049BFB02D6B5E2B8463ABCA88A007D12C8037F5244D7792D32E758C362A5B6301', '19-04-2024 02:30:05', 1, 24, 0, 0, 0, 5000, 5000, 0, 1, 0, 45, 0, 1550.91, -1676.25, 15.6198, 73.3043, 289, 289, 0, 0, 0, 1, 0, 86.071, 93.587, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 1, -1, 0, 0, 0),
(0, 0, 0, 206, 'Acx_Mpr', 'AC9B8F9BC5C9B69B1F5ED84A62EE4F0DC2E0588D745FA17657F9103A08D27A7D4F2F39CC0AC677EC207A0A7B802F7137A3760BC4BED9A72D36E1D886014DBDAA', '19-04-2024 07:16:03', 1, 18, 0, 0, 0, 5000, 5000, 0, 1, 0, 15, 0, -91.0571, -1177.62, 2.19531, 314.567, 289, 289, 0, 0, 0, 1, 0, 92.54, 97.592, 12, 0, 0, -1, 0, 0, 0, 0, 311, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(26, 0, 0, 207, 'Troy Parkins', '0E14526202687EA57A262E0A390A60D467306865237C4205FE8DFA550FFFC48CDC72D16472690CF3390036EC9199356F162CFE5D680810D86544CA4866A7E1A6', '19-04-2024 08:03:53', 1, 24, 0, 0, 0, 3540, 12960, 0, 1, 0, 47, 3, 698.295, -2434.46, 1.01393, 312.794, 250, 250, 0, 0, 0, 1, 0, 32.225, 67.942, 89, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(32, 0, 0, 208, 'Nelson_Weiss', 'AFCF5BB2CB6C6D7F0578404BE108F92A64E484937A00832B55E7722E7A367FA673004C78A0A2F5C540F78FA6CD4B77DAE97F8D5A15F39BB51AD0B791806F3D44', '19-04-2024 09:02:07', 1, 25, 0, 0, 0, 10780, 4809, 0, 1, 0, 23, 4, 1134.36, -1416.8, 13.586, 27.43, 60, 60, 0, 0, 0, 1, 0, 23.623, 63.357, 35, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(92, 0, 0, 209, 'Won_Wachchirawut', '5B5E97588382D66FFE34374D93D5E6149B144299973783347CE910FFFADAB10A29BE386508530C9561B78BC64097C326EEF1771CE54EB4F7077411C5FA4B0652', '19-04-2024 09:57:38', 1, 19, 0, 0, 0, 1287, 34455, 0, 1, 0, 1, 14, 1135.13, -1373.47, 13.9844, 81.5425, 24, 24, 71, 0, 0, 1, 0, 97.583, 95.881, 100, 0, 0, 228, 1, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(7, 0, 0, 210, 'Jim_Howard', 'FD9D94340DBD72C11B37EBB0D2A19B4D05E00FD78E4E2CE8923B9EA3A54E900DF181CFB112A8A73228D1F3551680E2AD9701A4FCFB248FA7FA77B95180628BB2', '19-04-2024 10:21:35', 1, 20, 0, 0, 0, 7062, 3777, 0, 1, 0, 26, 1, 631.141, 888.979, -42.9609, 346.036, 289, 289, 0, 0, 0, 1, 0, 92.955, 92.71, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(27, 0, 0, 211, 'Lindaman_Duicy', 'FD9D94340DBD72C11B37EBB0D2A19B4D05E00FD78E4E2CE8923B9EA3A54E900DF181CFB112A8A73228D1F3551680E2AD9701A4FCFB248FA7FA77B95180628BB2', '19-04-2024 10:39:05', 1, 19, 0, 0, 0, 4900, 21553, 0, 1, 0, 51, 3, 1146.6, -1495.28, 22.769, 118.103, 289, 289, 0, 0, 0, 1, 0, 41.588, 67.478, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 1, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 212, 'Tell_Smith', 'CFAB68E5C175A1483CEFA79EB86D732AE8FDB727EF74EA2E7D1A07211107EB83F078C216AC1F278C9F4BEDD2F5AD411C09DCDE13691C153A6D86B82A55F9414A', '19-04-2024 11:27:15', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 8, 20, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(36, 0, 0, 213, 'Juniper_Hills', '6A382D79101471C694A97174B5AE0B98EEB92024319623AF8F0C4719D48C9F3CF18CD3D0D238AA25D6F9BEC324EAFE2A9BA88D65198AA434DD315E53B264FA51', '19-04-2024 12:07:36', 1, 20, 0, 0, 0, 6553, 13518, 0, 1, 0, 11, 5, -69.3465, -1128.33, 1.07812, 239.253, 188, 188, 0, 0, 0, 1, 0, 27.365, 66.646, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 1, -1, 1, 0, 0),
(0, 0, 0, 214, 'Ponglang_Lookatme', '99A49BB678D9898FFE83A20E3811F88B0F5E90D098C26689BF8D7B7E823DD8946FE2F8A01D6C4E980BDE401BACFEE0F609FB97BD2D66A90FE46463D20048611B', '19-04-2024 13:15:22', 1, 21, 0, 0, 0, 5000, 5000, 0, 1, 0, 5, 0, 1124.06, -1412.39, 14.2993, 287.666, 289, 289, 0, 0, 0, 1, 0, 98.602, 99.236, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 215, 'Cherry_Viile', '2E5DA4E9EFAC814E01B98862F5CCE29B07BCEA17C7DB5D24EF301E0F8615FDCE1B59779130A7431BA0F348B5DE430FC4036062544B92A972B1F3A50735E20467', '19-04-2024 13:21:05', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 8, 20, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 216, 'Nick_Name', 'FAD754B67FB3BDDF0256989C99746C034A6FC04939B4438AE57199734FE303DCC87C219A4A83720D49A0E428C97B05B1E4C4ED07D8C56BFAA8CDD98CEF517DCB', '19-04-2024 13:24:01', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 8, 20, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 217, 'Smith_Boy', 'FDE3CE62F78259EA00226CC2DD49580248D95FA92596B9F0B4E135993DAF2A87D581F3753A8F96860C91AF93AACF2EA2E18BC54C79BB3A1AEE52504D5FF0A804', '19-04-2024 15:21:22', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 8, 20, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 218, 'Boy_Smith', '98337F9B8C3B51F3E68CAF9CDBD12B9806839696DD9D9B7FA33673E6CA896627D5519145B7F2AC81A310AC80279EC68AE97756320499B43AD6CD30F89BB44797', '19-04-2024 15:42:10', 1, 18, 0, 0, 0, 5000, 5000, 0, 1, 0, 0, 0, 1432.05, -2294.02, 13.3828, 144.312, 289, 289, 0, 0, 0, 1, 0, 99.867, 99.907, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(3, 0, 0, 219, 'Dino_Mua', 'FD9D94340DBD72C11B37EBB0D2A19B4D05E00FD78E4E2CE8923B9EA3A54E900DF181CFB112A8A73228D1F3551680E2AD9701A4FCFB248FA7FA77B95180628BB2', '19-04-2024 17:06:35', 1, 25, 0, 0, 0, 4731, 5000, 0, 1, 0, 54, 0, 1145.46, -1293.3, 13.7782, 89.8225, 240, 289, 240, 0, 0, 1, 0, 90.779, 97.292, 100, 0, 0, 230, 1, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(2, 0, 0, 220, 'Bangbu_Samuel', 'A3C07DCA03CB4B15DC5FA1A21BDBEE265A6EF89541D77A84AEA535A77D0FDB4AFADD79C1CA0015B5E0F1134E4BE456247FF710EB3DD45075D182AF9532B0722F', '19-04-2024 17:42:30', 1, 18, 0, 0, 0, 3590, 5000, 0, 1, 0, 38, 0, 1555.5, -1675.56, 16.1953, 332.061, 289, 289, 0, 0, 0, 1, 0, 79.831, 94.166, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(1, 0, 0, 221, 'Edward_Roney', '54D80A5744ABAFC822D3966F93C8AD770ED776047B56CF6FC62818E11ABAF9692E5330E44AB9828749561A27D8677DD43316D35A8224BD0D6D70E3E8B5240838', '19-04-2024 18:33:45', 1, 41, 0, 0, 0, 5000, 5000, 0, 1, 0, 13, 0, 1190.88, -1336.22, 13.398, 81.5386, 289, 289, 0, 0, 0, 1, 0, 96.421, 98.148, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(29, 0, 0, 222, 'Akiba_Kikeba', '2AA940CC79F5E103F3BC85C69601E8189D76BB9596E2083E075C6B7D5084DBCD3824E6C668D59326B49A8889FC8E608931475617D38DE479B7CFF36EC7AE7218', '19-04-2024 19:39:10', 1, 47, 0, 0, 0, 3207, 2073, 0, 1, 0, 40, 4, 1181.8, -1332.04, 13.5821, 260.828, 46, 46, 0, 0, 0, 1, 0, 99.109, 69.908, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 1, -1, 0, 0, 0),
(4, 0, 0, 223, 'Alex_Wangpiv', 'D42CDA9CD00933A46A048CE66F0D6366F521DF8F6AED69BC7208E4C7BC0B6A7F6B2AA2A261B6440C3EAA476F225A5E064CF10E2705076FE082D0BFED6E4F49D6', '19-04-2024 20:31:30', 1, 50, 0, 0, 0, 2500, 0, 0, 1, 0, 50, 0, 1174.51, -1306.67, 13.5766, 285.264, 275, 289, 275, 0, 0, 1, 0, 80.712, 92.755, 100, 0, 0, 230, 1, 0, 0, 0, -1, 20, 50, 464673, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 1, 0, 0),
(0, 0, 0, 224, 'Anakin_XI', '39EE6D6870FADDCDD500FA10C1E31630DC7FAB476F37508AC53E1AD266A3548500A4178E28B3CAF51CD4E25E4996A2B6581DFA840A56C4C98B7DB8EE0C80B67E', '19-04-2024 20:42:52', 1, 19, 0, 0, 0, 5000, 5000, 0, 1, 0, 1, 0, 1403.6, -2236.24, 13.1446, 22.7316, 289, 289, 0, 0, 0, 1, 0, 99.666, 99.884, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 225, 'Mario_Sosad', '6134FD7B4CF3080B9B5EAA0DFAA40BB30D8CFF7D38191CC727B2B148A48C7D4F3C8F6B2E362A84428AA6EA99366FBBC518CE27FCE1C6EA4EE61C1E332F1653DE', '19-04-2024 22:27:33', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 8, 20, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(8, 0, 0, 226, 'Mario_Sosix', 'FD9D94340DBD72C11B37EBB0D2A19B4D05E00FD78E4E2CE8923B9EA3A54E900DF181CFB112A8A73228D1F3551680E2AD9701A4FCFB248FA7FA77B95180628BB2', '19-04-2024 22:28:42', 1, 18, 0, 0, 0, 4601, 14096, 0, 1, 0, 13, 1, 1950.46, 161.257, 36.6084, 58.5057, 289, 289, 0, 0, 0, 1, 0, 99.102, 95.393, 98, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(4, 0, 0, 227, 'Auy_Anime', '3416F19113D33FAEE3403C3D4590A55EC86625FC920B33B207E0BB8C6C954D64C0580AA5462AA008E2767385F9AE5A49C877F85C5C410854F26E16B6E6DF52E5', '19-04-2024 22:33:55', 2, 24, 0, 0, 0, 1200, 5000, 0, 1, 0, 32, 0, -532.021, -64.4329, 62.9922, 93.1485, 191, 191, 0, 0, 0, 1, 0, 92.892, 95.486, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(2, 0, 0, 228, 'Bosco_Baracus', '741E1E10BB0B67F739BEE2E9B4990E9052E4AC4CA746AB22AFC7952FD48A616820C4388B9D17768155C759A15C9123177E7491A2B438124FD3CBD62EC86EF9A1', '19-04-2024 22:42:27', 1, 25, 0, 0, 0, 1832, 0, 0, 1, 0, 26, 0, -413.053, -1837.79, 3.39424, 35.2862, 22, 22, 0, 0, 0, 1, 0, 95.97, 97.986, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 229, 'Feem_Smeet', 'ED1CABCFAD98DF6774022C8B0B281B53279E98C9D0A2D2829A498BB0D9C1ADBDE36976996183E232BBC3A5817AFA0AD06A1C3B26C5B97F23E9AE69657D440AD6', '19-04-2024 23:19:09', 1, 18, 0, 0, 0, 5000, 5000, 0, 1, 0, 5, 0, 803.491, -2498.2, -0.782551, 355.607, 289, 289, 0, 0, 0, 1, 0, 98.52, 99.213, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 230, 'Kana_Harris', '920AAE7CEEA347404AA9E63F993290722F98427634979376FB290E3E69A4EF8DD365FC59D472A0228B539765FA2E747362B55DE30AD5FE8D7C20FA2A68A846C4', '19-04-2024 23:25:08', 2, 21, 0, 0, 0, 5000, 5000, 0, 1, 0, 1, 0, 1459.45, -2210.69, 13.1446, 181.103, 191, 191, 0, 0, 0, 1, 0, 99.143, 99.815, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 231, 'William_Goring', '6021AE74504B9949AB6688EE010D1E1DCCC8D9B68427B37DAC0295BF91E6B1C26F44BEE067B337E44CAC63E29352BB31C3AA0D5428A7249E1F9B443806ED7483', '19-04-2024 23:28:58', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 8, 20, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 232, 'Terk_Dk', 'A38293470F3457D631143AB1E3723E40124A054F87CAF169A9B8CA5D2406FECF4429B8A7DDE07631DF59FDF736079B788D1336818D5E50A80408F0BD16F7965F', '19-04-2024 23:59:01', 1, 32, 0, 0, 0, 5000, 5000, 0, 1, 0, 2, 0, 2775.89, -2063.32, 67.4395, 320.793, 289, 289, 0, 0, 0, 1, 0, 99.131, 99.745, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 233, 'Bud_White', '70689E39DAD73589B21C15F8C4EEE1DF830C540D7187FC531D3ECC3F2BC26C796F1AD61BA6A7AA991873BA100B87298ED63F630989BDDD54A6C23E3AB9D793A0', '20-04-2024 00:20:08', 1, 22, 0, 0, 0, 5000, 5000, 0, 1, 0, 0, 0, 1425.48, -2297.36, 13.3828, 21.8977, 289, 289, 0, 0, 0, 1, 0, 99.907, 99.931, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(5, 0, 0, 234, 'Yunun_Mixco', 'A0BEB0035B40259002A0E84F157AFB0C31FBE9792BDFDB2D607C9FA2CF2435C4DFB9C3F9AAC5ADE87956A9FB8FC7C075CEBF23AAB1A567AD08702C9745A0C07B', '20-04-2024 02:21:34', 1, 20, 0, 0, 0, 4400, 9222, 0, 1, 0, 53, 0, -78.7536, -1134.08, 1.07812, 78.161, 289, 289, 0, 0, 0, 1, 0, 84.72, 92.5, 77, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(2, 0, 0, 235, 'Joseph_Avav', '48C295B409E6E616EA2A1E9253B8959320A7A7A249FA35370AC6C27248000258364157560CC06B16501F21020C983E3323976097901A6D8B63F1B4D9AB9E2E59', '20-04-2024 04:58:28', 1, 19, 0, 0, 0, 5000, 5000, 0, 1, 0, 15, 0, 1162.81, -1394.25, 13.0331, 259.239, 289, 289, 0, 0, 0, 1, 0, 96.95, 97.847, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 236, 'Maxky_Avanosx', '8B1410547001C8A9FDFDE111A0EA6D64755104A249F0B05B71A0F3B2F1C21200B2C5239617EAA25F43511A5C0633AA9C3B08351894CFE29CE05DB70B10C5E68C', '20-04-2024 08:08:31', 1, 20, 0, 0, 0, 5000, 5000, 0, 1, 0, 1, 0, 1249.02, -2366.28, 8.31445, 108.455, 289, 289, 0, 0, 0, 1, 0, 99.644, 99.838, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(1, 0, 0, 237, 'Lukehong_Undercof', 'A44D9E1E7D4A2A894BB31F4094B46278C5BB7D4D61EFA2FEDA8630B47EBA12667F22EE76FC99820B91AE9A3995F46BF0FD5B269CA8D2EF1160AF4F60FA2067FC', '20-04-2024 11:19:44', 1, 28, 0, 0, 0, 5000, 5000, 0, 1, 0, 14, 0, 1211.02, -1359.18, 13.3688, 112.88, 289, 289, 0, 0, 0, 1, 0, 96.927, 98.055, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(2, 0, 0, 238, 'Army_Sunday', '4E0658D00F47D86D19A0E792E4BB94B16DB2E902D307DA5637F57CF60E7A174CB4BB6D7095621745B2065DF0C87B77AF69F5D0FBD63359AD3CC6B72F076C3E1E', '20-04-2024 11:53:44', 1, 25, 0, 0, 0, 5000, 5000, 0, 1, 0, 16, 0, 742.524, -1339.32, 13.5298, 357.638, 289, 289, 0, 0, 0, 1, 0, 96.747, 97.778, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 239, 'Chandra_Khoifah', 'E840EDBB8D601549AF96637EE863F4577F3B964F747C7C71EA90F10D1A3136E601E05F8C049291BECA20873BC89D0FA35882A4FE45351359C36D1728F5A7A565', '20-04-2024 12:32:45', 1, 80, 0, 0, 0, 5000, 5000, 0, 1, 0, 2, 0, 1411.71, -2313.11, 13.5469, 188.201, 289, 289, 0, 0, 0, 1, 0, 99.408, 99.676, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(14, 0, 0, 240, 'Jesse_Leon', 'FD9D94340DBD72C11B37EBB0D2A19B4D05E00FD78E4E2CE8923B9EA3A54E900DF181CFB112A8A73228D1F3551680E2AD9701A4FCFB248FA7FA77B95180628BB2', '20-04-2024 15:06:02', 1, 23, 0, 0, 0, 0, 5565, 0, 1, 0, 15, 2, 1943.57, 164.755, 37.2812, 172.248, 289, 289, 0, 0, 0, 1, 0, 91.965, 96.921, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 1, 0, 0),
(0, 0, 0, 241, 'Adriano_Vece', 'FD9D94340DBD72C11B37EBB0D2A19B4D05E00FD78E4E2CE8923B9EA3A54E900DF181CFB112A8A73228D1F3551680E2AD9701A4FCFB248FA7FA77B95180628BB2', '20-04-2024 15:36:42', 1, 30, 0, 0, 0, 4701, 5000, 0, 1, 0, 5, 0, 1132.87, -1380.64, 14.2812, 0.910857, 289, 289, 0, 0, 0, 1, 0, 96.494, 99.769, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 242, 'Richard_Mergan', '4557AFB7EC378795B971E94D77C5B3145C60B7A4D5ABF81977F70FD7EC5E536B600E16794DD36A4BA338B130B124C43640E36BE1A8E45E116DF167D98371AF5F', '20-04-2024 15:44:50', 1, 32, 0, 0, 0, 5000, 5000, 0, 1, 0, 2, 0, 1207.88, -1304.13, 13.3927, 290.626, 289, 289, 0, 0, 0, 1, 0, 99.348, 99.699, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 243, 'Burbie_Bird', '98A3301C14D159BF06C960BA9DCDB15E134A61E7B20DF63C2C1AA76ECBCC32C4AE52CCA98F4C165B9FCF16354E5573D1DBA84A4A88DF5126FB74BD94002F449F', '20-04-2024 21:35:38', 1, 20, 0, 0, 0, 2500, 5000, 0, 1, 0, 9, 0, 1000.2, -1391.35, 12.7101, 359.543, 289, 289, 0, 0, 0, 1, 0, 98.139, 99.444, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(1, 0, 0, 244, 'Flex_Prakdum', 'F236878E27CD9F9406DBA92159251CDA5B6B346B193BA6A7431719784406E2687C999EDFDBE8A4C3A7D13E0AF8E8A8F4739BEAB3D3276A6FE6001A53D593087B', '20-04-2024 22:26:40', 1, 28, 0, 0, 0, 4500, 5000, 0, 1, 0, 14, 0, 1189.73, -1383.97, 13.5294, 84.3717, 289, 289, 0, 0, 0, 1, 0, 94.429, 98.079, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 245, 'JAMON_ROMDEE', 'A2F22FA799E536B71A280CA162BC6F2FCB8373BCFF186860E1E917CF7B989E81520F048F85F93D07765083ED43D1C0CF711D74F82F5D0510D21083D4E83C0A4B', '20-04-2024 22:45:13', 1, 20, 0, 0, 0, 5000, 5000, 0, 1, 0, 5, 0, 1418.96, -2270.88, 13.5462, 190.538, 289, 289, 0, 0, 0, 1, 0, 99.798, 99.954, 56, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 246, 'Flex_Prakdu', 'B20AD0305A6DCB6BCC2BBCCDE08E3DC60FDEBF0FC7A320F78A3DD6F4ED2E97657A0F8DC47D727421BC60374B25107E05AF1C3C04211315E87A7670B973A6F3C1', '20-04-2024 22:47:55', 1, 20, 0, 0, 0, 5000, 5000, 0, 1, 0, 0, 0, 1413.04, -2275.48, 13.5292, 79.0214, 289, 289, 0, 0, 0, 1, 0, 99.857, 99.931, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(7, 0, 0, 247, 'Jack_Bobgoh', '8F764106BFC51D2EBA2617E7EBF4BFB70239584EF8E7641516BE466EA11EACEA4FAE5932C33E129FCA4192338E27BC1B3888B2A20A1860E605644DB803F54587', '21-04-2024 10:20:58', 1, 19, 0, 0, 0, 800, 5538, 0, 1, 0, 7, 1, -69.9615, -1116.01, 1.07812, 359.399, 289, 289, 0, 0, 0, 1, 0, 78.419, 90.555, 100, 0, 0, -1, 0, 0, 0, 0, 309, 20, 50, 838064, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 248, 'Robert_Jody', 'F0D1207A67D55B83C6F4C6BA7425810C81245E8004D890EBEDA8C0CE63A830478FC3F32858270D4439D3615497FA05752053D5ADB95E48D2095FB6EB2A453E9E', '21-04-2024 18:22:14', 1, 21, 0, 0, 0, 5000, 5000, 0, 1, 0, 2, 0, 1400.51, -2262.27, 13.1397, 1.10343, 289, 289, 0, 0, 0, 1, 0, 99.392, 99.792, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 249, 'Kasinpot_Supakit', '9CADB382FE8E6D4FC3DBE24419E6343B25DAFE9B426882B8C6294F28F64830CA5D2695D81EBF60319796B0C144914048F6C00EA67AFBCFD3CA0D0D9FC64DA109', '21-04-2024 19:21:02', 1, 20, 0, 0, 0, 5000, 5000, 0, 1, 0, 1, 0, 1415.35, -2317.55, 13.5469, 182.963, 289, 289, 0, 0, 0, 1, 0, 99.335, 99.861, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(24, 0, 0, 250, 'Polgee_Parabola', '089BE6DA663E2D090C4E1012439C75E92643AC3FFECBD6EE8E7BE768A93CCFBA4A895612A22DEB03FFFDC044B8CDE629663F74AE9ADC9C2ACE8796BE13AA337E', '21-04-2024 19:56:20', 1, 19, 0, 0, 0, 4129, 11073, 0, 1, 0, 50, 3, 1109.82, -1440.08, 15.7969, 264.841, 259, 259, 0, 0, 0, 1, 0, 24.22, 67.779, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(4, 0, 0, 251, 'Mhong_Mhahe', 'DDB4B00CA3613DEB59FE41021E186B8E803BE3732427E7FF9A9368826D743E9542EDDD029D58BE8737E2C1F8235E7D27AB0F6CF0DB806047E6F8AA76F62A0317', '22-04-2024 01:26:30', 1, 21, 0, 0, 0, 1500, 0, 0, 1, 0, 50, 0, 1791.31, 855.38, 10.6719, 165.345, 289, 289, 0, 0, 0, 1, 0, 79.707, 92.732, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(1, 0, 0, 252, 'John_Unit', '7E4FE20A767778E2BEE87D6BA04FA31CA4F1728EB7A827FFB5058F197E6936057D019DE81AD73728DA3ED316A52D375D40744EC7425676B3DD1F4311D7980C8E', '22-04-2024 01:46:48', 1, 19, 0, 0, 0, 4000, 5000, 0, 1, 0, 13, 0, 1778.18, 701.916, 15.3124, 300.165, 289, 289, 0, 0, 0, 1, 0, 96.741, 98.148, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 253, 'Forrerst_Domin', '233BAB60396E5F367FEAAB248E9243510043FD9EB1194155A04ED9756D454D1C6D2C63C3737F70E453167FFC2F5BF8C5A72CE1732249F5B3D6F8D2C39648ACE3', '22-04-2024 19:28:30', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 8, 20, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 254, 'Colt_Wesson', 'FD9D94340DBD72C11B37EBB0D2A19B4D05E00FD78E4E2CE8923B9EA3A54E900DF181CFB112A8A73228D1F3551680E2AD9701A4FCFB248FA7FA77B95180628BB2', '22-04-2024 20:10:43', 1, 52, 0, 0, 0, 5000, 5000, 0, 1, 0, 4, 0, 1400.81, -2248.19, 13.5469, 181.533, 289, 289, 0, 0, 0, 1, 0, 98.918, 99.398, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(1, 0, 0, 255, 'Natfunlang_Ter', '8869A02032D98E781B9D0F151311B395CDD2B5F8BECC903B53CFB3FCECA259739A438006937D5BBA14B487A63E008C538BFFCB3F4F36DEA2E70DA2F62E192111', '22-04-2024 20:57:14', 1, 19, 0, 0, 0, 5000, 5000, 0, 1, 0, 12, 0, 1940.44, 165.997, 37.2812, 171.081, 289, 289, 0, 0, 0, 1, 0, 96.519, 98.357, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 256, 'Test_Blackwood', 'E58E7AF344DB4CEDAAE80B77B1743906453EA2E83B76A42D0D333AE3FC118F8051F20F3D7EA482C22A89477A6139A7C49AC70B8C58BE8DC349F0C57B39FC1074', '22-04-2024 21:29:51', 1, 18, 0, 0, 0, 5000, 5000, 0, 1, 0, 0, 0, 1429.02, -2276.54, 13.3828, 230.274, 289, 289, 0, 0, 0, 1, 0, 99.598, 99.954, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 50, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 257, 'Young_PP', 'E58E7AF344DB4CEDAAE80B77B1743906453EA2E83B76A42D0D333AE3FC118F8051F20F3D7EA482C22A89477A6139A7C49AC70B8C58BE8DC349F0C57B39FC1074', '23-04-2024 07:44:26', 1, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 8, 20, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 258, 'Hack_Vicl', 'F42228FDC70417661D982429980FDFF47250F7BF32D06E2417F8424CFCB05622EAE904C8C85389EFEFD963DB0020B5304F0FEB1D34053DAA42E6C6F653450820', '26-04-2024 14:47:00', 1, 29, 0, 0, 0, 5000, 5000, 0, 1, 0, 2, 0, 1384.88, -2316.3, 13.5469, 321.569, 289, 289, 0, 0, 0, 1, 0, 98.911, 99.769, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 30, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0),
(0, 0, 0, 259, 'Jonh_Sap', 'F42228FDC70417661D982429980FDFF47250F7BF32D06E2417F8424CFCB05622EAE904C8C85389EFEFD963DB0020B5304F0FEB1D34053DAA42E6C6F653450820', '26-04-2024 19:18:02', 1, 29, 0, 0, 0, 5000, 5000, 0, 1, 0, 3, 0, 1441.65, -2284.6, 13.5469, 68.7022, 289, 289, 0, 0, 0, 1, 0, 99.527, 99.653, 100, 0, 0, -1, 0, 0, 0, 0, -1, 20, 30, 0, 0, 0, 0, 0, 0, 'None', 0, 0, 0, 0, 0, -1, 0, 0, 0);

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

--
-- Dumping data for table `shops`
--

INSERT INTO `shops` (`shopID`, `shopX`, `shopY`, `shopZ`, `shopInterior`, `shopWorld`, `shopType`) VALUES
(158, 1154.51, -1440.18, 15.7969, 0, 0, 1),
(159, 204.296, -159.991, 1000.52, 14, 7295, 3),
(160, -29.0769, -184.632, 1003.55, 17, 7298, 5),
(161, 1104.01, -1421.94, 15.7978, 0, 0, 7),
(162, 1406.31, -1300.07, 13.5435, 0, 0, 2),
(164, 2095.84, -1359.51, 23.9844, 0, 0, 8),
(165, 2106.39, -1359.52, 23.9844, 0, 0, 9),
(166, -89.6887, -1208.48, 2.7029, 0, 0, 5);

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
(1, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1413.67, -2262.06, 13.1461, 1.31035, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(2, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1410.5, -2262.2, 13.1487, 3.40722, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(3, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1407.14, -2262.15, 13.1465, 0.128208, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(4, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1403.95, -2262.28, 13.1491, 3.38438, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(5, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1400.51, -2262.24, 13.1465, 1.10326, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(6, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1397.25, -2262.27, 13.1465, 1.60187, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(7, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1394.02, -2262.27, 13.1463, 0.048458, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(8, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1390.65, -2262.39, 13.1505, 357.262, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(9, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1387.58, -2262.21, 13.1466, 359.645, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(10, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1384.34, -2262.31, 13.1422, 0.788853, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(11, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1414.48, -2313.44, 13.1516, 178.833, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(12, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1411.19, -2313.41, 13.1474, 178.645, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(13, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1407.79, -2313.37, 13.1509, 180.838, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(14, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1404.58, -2313.41, 13.1486, 178.265, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(15, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1401.37, -2313.38, 13.1512, 180.21, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(16, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1398.17, -2313.38, 13.1474, 181.589, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(17, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1394.9, -2313.42, 13.1481, 184.095, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(18, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1391.61, -2313.53, 13.1482, 175.322, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(19, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1388.25, -2313.43, 13.1465, 179.707, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(20, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1384.97, -2313.5, 13.1514, 180.999, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(22, 0, 'Nobody', 453, 0, 0, 0, 0, 'None', 0, 1000, 808.121, -2081.72, -0.344155, 178.965, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(23, 0, 'Nobody', 453, 0, 0, 0, 0, 'None', 0, 1000, 802.591, -2081.42, -0.383331, 182.038, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(24, 0, 'Nobody', 453, 0, 0, 0, 0, 'None', 0, 1000, 798.041, -2081.82, -0.414637, 181.304, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(25, 0, 'Nobody', 453, 0, 0, 0, 0, 'None', 0, 1000, 792.737, -2081.67, -0.363227, 178.77, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(26, 0, 'Nobody', 453, 0, 0, 0, 0, 'None', 0, 1000, 787.305, -2081.41, -0.344907, 181.294, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(27, 0, 'Nobody', 453, 0, 0, 0, 0, 'None', 0, 1000, 803.945, -2066.33, -0.434756, 359.407, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(28, 0, 'Nobody', 453, 0, 0, 0, 0, 'None', 0, 1000, 798.404, -2066.36, -0.397705, 3.55094, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(29, 0, 'Nobody', 453, 0, 0, 0, 0, 'None', 0, 1000, 793.104, -2066.48, -0.263868, 1.55628, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(30, 0, 'Nobody', 453, 0, 0, 0, 0, 'None', 0, 1000, 787.424, -2066.5, -0.330275, 359.428, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(38, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, -82.4329, -1139.11, 0.675855, 337.438, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(39, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, -84.0472, -1138.4, 0.678162, 336.492, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(40, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, -85.6325, -1137.71, 0.676749, 334.709, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(41, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, -87.4719, -1136.85, 0.677531, 337.883, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(42, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 752.881, -1357.42, 13.1, 1.17274, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(43, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 750.159, -1357.42, 13.0996, 0.509774, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(44, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 746.086, -1357.52, 13.0991, 0.468571, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(45, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 743.276, -1357.61, 13.0988, 0.56025, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(46, 0, 'Nobody', 523, 0, 0, 0, 1, 'None', 0, 1000, 1584.33, -1675.39, 5.37368, 271.273, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(47, 0, 'Nobody', 523, 0, 0, 0, 0, 'None', 0, 1000, 1583.96, -1678.6, 5.36699, 269.153, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(48, 0, 'Nobody', 596, 0, 0, 0, 1, 'None', 0, 1000, 1602.55, -1684.01, 5.60395, 89.1857, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(49, 0, 'Nobody', 596, 0, 0, 0, 0, 'None', 0, 1000, 1602.48, -1687.99, 5.6048, 90.007, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(51, 0, 'Nobody', 599, 0, 0, 0, 0, 'None', 0, 1000, 1602.47, -1704.11, 5.96423, 89.5296, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(52, 0, 'Nobody', 599, 0, 0, 0, 0, 'None', 0, 1000, 1602.75, -1700.24, 5.96359, 90.8179, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(54, 0, 'Nobody', 416, 0, 0, 0, 0, 'None', 0, 1000, 1146.08, -1315.51, 13.5153, 91.8413, 1, 126, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(55, 0, 'Nobody', 596, 0, 0, 0, 0, 'None', 0, 1000, 1602.4, -1692.07, 5.60408, 89.0467, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(56, 0, 'Nobody', 416, 0, 0, 0, 0, 'None', 0, 1000, 1145.96, -1311.99, 13.5373, 90.3498, 1, 126, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(57, 0, 'Nobody', 599, 0, 0, 0, 0, 'None', 0, 1000, 1602.6, -1695.95, 5.96412, 90.0674, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58, 0, 'Nobody', 416, 0, 0, 0, 0, 'None', 0, 1000, 1146, -1308.37, 13.5436, 90.0126, 1, 126, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(59, 0, 'Nobody', 416, 0, 0, 0, 0, 'None', 0, 1000, 1146, -1304.26, 13.5394, 88.6465, 1, 126, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(60, 0, 'Nobody', 416, 0, 0, 0, 0, 'None', 0, 1000, 1146.06, -1300.37, 13.5319, 89.172, 1, 126, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(61, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 616.936, 892.688, -43.3577, 52.6098, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(62, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 616.506, 891.557, -43.3494, 60.4642, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(63, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 615.548, 890.021, -43.3902, 60.2569, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(64, 0, 'Nobody', 416, 0, 0, 0, 0, 'None', 0, 1000, 1146.1, -1296.88, 13.5268, 90.0147, 1, 126, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(65, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 614.642, 888.436, -43.4195, 62.6243, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(66, 0, 'Nobody', 416, 0, 0, 0, 0, 'None', 0, 1000, 1146.09, -1293.08, 13.5194, 89.9023, 1, 126, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(71, 0, 'Nobody', 461, 0, 0, 0, 0, 'None', 0, 1000, 1174.03, -1306.58, 13.5848, 267.147, 126, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(72, 0, 'Nobody', 461, 0, 0, 0, 0, 'None', 0, 1000, 1174.02, -1307.97, 13.5809, 263.043, 126, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(73, 0, 'Nobody', 461, 0, 0, 0, 1, 'None', 0, 1000, 1174.04, -1309.24, 13.5772, 264.725, 126, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(74, 0, 'Nobody', 461, 0, 0, 0, 1, 'None', 0, 1000, 1173.93, -1310.65, 13.5761, 271.188, 126, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(75, 0, 'Nobody', 510, 0, 0, 0, 0, 'None', 0, 1000, 1174.36, -1336.61, 13.5616, 271.165, 126, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(76, 0, 'Nobody', 510, 0, 0, 0, 0, 'None', 0, 1000, 1174.33, -1337.63, 13.5975, 273.855, 126, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(77, 0, 'Nobody', 510, 0, 0, 0, 0, 'None', 0, 1000, 1174.33, -1335.8, 13.5959, 272.173, 126, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(78, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 2302.53, 2443.13, 10.4198, 268.766, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(79, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 2302.49, 2440.99, 10.4199, 270.355, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(80, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 2302.43, 2439.03, 10.4199, 270.715, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(81, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 2302.46, 2437, 10.4206, 271.293, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(82, 0, 'Nobody', 408, 0, 0, 0, 0, 'None', 0, 1000, 738.471, -1335, 14.0777, 180.625, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(83, 0, 'Nobody', 408, 0, 0, 0, 0, 'None', 0, 1000, 744.08, -1334.87, 14.0917, 180.625, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(85, 0, 'Nobody', 408, 0, 0, 0, 0, 'None', 0, 1000, 749.663, -1334.83, 14.0955, 180, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(89, 0, 'Nobody', 408, 0, 0, 0, 0, 'None', 0, 1000, 755.713, -1334.78, 14.0828, 179.466, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(90, 0, 'Nobody', 408, 0, 0, 0, 0, 'None', 0, 1000, 761.629, -1334.69, 14.0926, 179.275, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(91, 0, 'Nobody', 563, 0, 0, 0, 0, 'None', 0, 1000, 1163.83, -1377.3, 27.3208, 272.62, 126, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(92, 0, 'Nobody', 563, 0, 0, 0, 0, 'None', 0, 1000, 1163.74, -1362.57, 27.3783, 266.229, 126, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0),
(93, 0, 'Nobody', 408, 0, 0, 0, 0, 'None', 0, 1000, 767.651, -1334.86, 14.0931, 179.785, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(97, 0, 'Nobody', 497, 0, 0, 0, 0, 'None', 0, 1000, 1565.43, -1644.34, 28.6521, 91.4219, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(98, 0, 'Nobody', 497, 0, 0, 0, 0, 'None', 0, 1000, 1568.09, -1704.33, 28.6448, 86.659, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(99, 0, 'Nobody', 525, 0, 0, 0, 0, 'None', 0, 1000, 1066.24, -877.815, 43.2116, 89.5444, 1, 6, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0),
(100, 0, 'Nobody', 525, 0, 0, 0, 0, 'None', 0, 1000, 1066.53, -873.568, 43.1991, 89.3552, 1, 6, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0),
(101, 0, 'Nobody', 525, 0, 0, 0, 0, 'None', 0, 1000, 1056.03, -870.215, 43.3936, 176.485, 1, 6, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0),
(102, 0, 'Nobody', 525, 0, 0, 0, 0, 'None', 0, 1000, 1060.25, -869.522, 43.3249, 180.301, 1, 6, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0),
(103, 0, 'Nobody', 552, 0, 0, 0, 0, 'None', 0, 1000, -41.6889, -1155.29, 0.774434, 335.092, 1, 3, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(104, 0, 'Nobody', 552, 0, 0, 0, 0, 'None', 0, 1000, -46.1639, -1153.3, 0.769879, 335.225, 1, 3, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(105, 0, 'Nobody', 552, 0, 0, 0, 0, 'None', 0, 1000, -50.9271, -1151.5, 0.77496, 335.623, 1, 3, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(106, 0, 'Nobody', 552, 0, 0, 0, 0, 'None', 0, 1000, -55.3258, -1149.64, 0.772203, 336.063, 1, 3, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(107, 0, 'Nobody', 552, 0, 0, 0, 0, 'None', 0, 1000, -59.4881, -1147.85, 0.780594, 335.828, 1, 3, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(108, 0, 'Nobody', 552, 0, 0, 0, 0, 'None', 0, 1000, -63.6365, -1145.88, 0.771628, 334.449, 1, 3, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(109, 157, 'Sheldorn_Saleevan', 509, 0, 0, 0, 0, 'None', 50, 1000, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(110, 194, 'Forrest_Domin', 509, 0, 0, 0, 1, 'None', 50, 1000, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(111, 195, 'Gaz_Moore', 509, 0, 0, 0, 0, 'None', 50, 1000, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(125, 202, 'Jamal_Crafood', 509, 0, 0, 0, 0, 'None', 50, 982.278, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(126, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, -540.955, -81.2916, 62.6337, 181.779, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(127, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, -542.53, -81.1908, 62.648, 179.098, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(128, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, -544.3, -81.0732, 62.7193, 174.881, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(129, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, -545.967, -81.1367, 62.8194, 186.14, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(130, 151, 'Nathan_Wingin', 509, 0, 0, 0, 0, 'None', 50, 1000, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(131, 149, 'Hugo_Wingin', 509, 0, 0, 0, 0, 'None', 50, 1000, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(132, 151, 'Nathan_Wingin', 509, 0, 0, 0, 0, 'None', 50, 1000, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(133, 159, 'Zee_Mo', 509, 0, 0, 0, 0, 'None', 50, 987.419, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(134, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1214.31, -1424.99, 12.9828, 2.0622, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(135, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1216.11, -1424.92, 12.9629, 2.43209, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(136, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1217.87, -1424.94, 12.9443, 1.77142, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(137, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1219.48, -1424.94, 12.924, 359.575, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(138, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1221.08, -1424.97, 12.9267, 5.7622, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(139, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1222.7, -1424.95, 12.9569, 2.95777, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(141, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1906.37, 173.949, 36.7983, 69.8501, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(142, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1905.87, 172.242, 36.778, 71.4202, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(143, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1905.3, 170.544, 36.7557, 72.6712, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(144, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 1904.76, 168.89, 36.7409, 72.8062, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(145, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 842.937, -2074.61, 12.5416, 1.83722, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(146, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 844.569, -2074.6, 12.5407, 358.64, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(147, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 846.293, -2074.55, 12.5407, 3.26381, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(148, 0, 'Nobody', 462, 0, 0, 0, 0, 'None', 0, 1000, 848.006, -2074.5, 12.5425, 1.25589, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(149, 151, 'Nathan_Wingin', 509, 0, 0, 0, 0, 'None', 50, 1000, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(150, 169, 'Alex_Goodwin', 509, 0, 0, 0, 0, 'None', 50, 1000, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(151, 176, 'Martin_Bronson', 509, 0, 0, 0, 0, 'None', 50, 1000, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(152, 149, 'Hugo_Wingin', 467, 0, 0, 0, 0, 'None', 49.96, 1000, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(153, 170, 'Armin_Williams', 549, 0, 0, 0, 0, 'None', 12.4, 953, 557.867, -1283.98, 17.0007, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1010, 0, 1076, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(154, 186, 'Conner_Rainford', 422, 0, 0, 0, 0, 'None', 61.28, 993.77, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(155, 150, 'William_Aaron', 543, 0, 0, 0, 1, 'None', 47.07, 915.037, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0),
(156, 179, 'Daniel_Dragon', 600, 0, 0, 0, 0, 'None', 35.56, 973.999, 557.867, -1283.98, 17.0007, 0, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0);

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
  MODIFY `arrestID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `atm`
--
ALTER TABLE `atm`
  MODIFY `atmID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `business`
--
ALTER TABLE `business`
  MODIFY `businessID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `callcar`
--
ALTER TABLE `callcar`
  MODIFY `callcarID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `contactID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=227;

--
-- AUTO_INCREMENT for table `entrances`
--
ALTER TABLE `entrances`
  MODIFY `entranceID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=322;

--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `factions`
  MODIFY `factionID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=233;

--
-- AUTO_INCREMENT for table `garages`
--
ALTER TABLE `garages`
  MODIFY `garageID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `gps`
--
ALTER TABLE `gps`
  MODIFY `gpsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=148;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `invID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=962;

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `playerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=260;

--
-- AUTO_INCREMENT for table `safezonedata`
--
ALTER TABLE `safezonedata`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=150;

--
-- AUTO_INCREMENT for table `shops`
--
ALTER TABLE `shops`
  MODIFY `shopID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=167;

--
-- AUTO_INCREMENT for table `skinshop`
--
ALTER TABLE `skinshop`
  MODIFY `SkinshopID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `carID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
