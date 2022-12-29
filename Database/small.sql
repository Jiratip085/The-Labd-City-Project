-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2020 at 05:52 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `small`
--

-- --------------------------------------------------------

--
-- Table structure for table `911 calls`
--

CREATE TABLE `911 calls` (
  `ID` int(11) NOT NULL,
  `Timestamp` varchar(36) DEFAULT NULL,
  `Caller` int(6) NOT NULL,
  `Incident` varchar(128) NOT NULL,
  `Location` varchar(128) NOT NULL,
  `Service` int(2) NOT NULL,
  `Number` int(8) NOT NULL,
  `IGTime` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=tis620;

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `SQLID` int(32) NOT NULL,
  `Username` varchar(24) NOT NULL,
  `Password` varchar(129) NOT NULL,
  `Status` int(2) NOT NULL,
  `Admin` int(2) NOT NULL,
  `RegisterIP` varchar(16) DEFAULT NULL,
  `RegisterDate` varchar(36) DEFAULT NULL,
  `ExemptIP` int(2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`SQLID`, `Username`, `Password`, `Status`, `Admin`, `RegisterIP`, `RegisterDate`, `ExemptIP`) VALUES
(1, 'Justinz', '0B0893C88DD41CEC0F16D2A0F27AC372F85AB7C701EB066D41FD6E0F63DBC148EE803158F09B525493A1449F496F1FB5F506715DA9E662158CAB9557E4A9DC3A', 0, 1339, '::1', '24/05/2020 05:43:16', 0),
(2, 'Melio', 'A4086C938B9591B2DE9377354F00FC3C0C1C8CE9CB357BA8879F3D5A0B9D8C29C0BD1618AAC2AEC0A3A7254194705A9375542A623784E0D630893B5ACDC6061D', 0, 1339, '103.129.77.2', '24/05/2020, 17:54:25', 0),
(3, 'Test1', '0B0893C88DD41CEC0F16D2A0F27AC372F85AB7C701EB066D41FD6E0F63DBC148EE803158F09B525493A1449F496F1FB5F506715DA9E662158CAB9557E4A9DC3A', 0, 0, '::1', '26/05/2020 10:16:23', 0),
(4, 'Test2', '0B0893C88DD41CEC0F16D2A0F27AC372F85AB7C701EB066D41FD6E0F63DBC148EE803158F09B525493A1449F496F1FB5F506715DA9E662158CAB9557E4A9DC3A', 0, 0, '::1', '29/05/2020 05:58:04', 0);

-- --------------------------------------------------------

--
-- Table structure for table `apples`
--

CREATE TABLE `apples` (
  `AppleID` int(12) NOT NULL,
  `AppleX` varchar(255) NOT NULL,
  `AppleY` varchar(255) NOT NULL,
  `AppleZ` varchar(255) NOT NULL,
  `AppleHealth` int(12) NOT NULL DEFAULT 5
) ENGINE=InnoDB DEFAULT CHARSET=tis620;

--
-- Dumping data for table `apples`
--

INSERT INTO `apples` (`AppleID`, `AppleX`, `AppleY`, `AppleZ`, `AppleHealth`) VALUES
(1, '-1094.36743', '-1665.14404', '75.23540', 20),
(2, '-1088.94141', '-1671.61389', '75.23540', 20),
(3, '-1086.87732', '-1680.44080', '75.23540', 20),
(4, '-1092.74146', '-1682.43701', '75.23540', 20),
(5, '-1094.75171', '-1675.35388', '75.23540', 20),
(6, '-1089.28186', '-1664.48145', '75.23540', 20),
(7, '-1084.22046', '-1666.41382', '75.23540', 20),
(8, '-1080.57593', '-1671.30188', '75.23540', 20),
(9, '-1078.27832', '-1665.02319', '75.23540', 20),
(10, '-1085.48486', '-1685.93115', '74.99540', 20),
(11, '-1078.00073', '-1680.53357', '74.99540', 20),
(12, '-1073.00635', '-1673.04968', '74.99540', 20),
(13, '-1078.84192', '-1689.59949', '74.99540', 20),
(14, '-1092.67737', '-1689.93457', '74.99540', 20),
(15, '-1084.79773', '-1690.66809', '74.99540', 20);

-- --------------------------------------------------------

--
-- Table structure for table `applestorage`
--

CREATE TABLE `applestorage` (
  `appleID` int(12) NOT NULL,
  `appleCount` int(12) NOT NULL DEFAULT 0,
  `applePosX` float NOT NULL DEFAULT 0,
  `applePosY` float NOT NULL DEFAULT 0,
  `applePosZ` float NOT NULL DEFAULT 0,
  `appleInterior` int(12) NOT NULL DEFAULT 0,
  `appleWorld` int(12) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=tis620;

--
-- Dumping data for table `applestorage`
--

INSERT INTO `applestorage` (`appleID`, `appleCount`, `applePosX`, `applePosY`, `applePosZ`, `appleInterior`, `appleWorld`) VALUES
(1, 0, -20.7601, 1175.88, 19.5634, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE `bans` (
  `ID` int(11) NOT NULL,
  `PlayerName` varchar(26) NOT NULL,
  `IP` varchar(18) NOT NULL,
  `C_ID` int(11) NOT NULL,
  `A_ID` int(11) NOT NULL,
  `Timestamp` varchar(36) DEFAULT NULL,
  `BannedBy` varchar(26) NOT NULL,
  `Reason` varchar(128) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

-- --------------------------------------------------------

--
-- Table structure for table `businesses`
--

CREATE TABLE `businesses` (
  `bizID` int(12) NOT NULL,
  `bizName` varchar(32) DEFAULT NULL,
  `bizOwner` int(12) DEFAULT 0,
  `bizType` int(12) DEFAULT 0,
  `bizPrice` int(12) DEFAULT 0,
  `bizPosX` float DEFAULT 0,
  `bizPosY` float DEFAULT 0,
  `bizPosZ` float DEFAULT 0,
  `bizPosA` float DEFAULT 0,
  `bizIntX` float DEFAULT 0,
  `bizIntY` float DEFAULT 0,
  `bizIntZ` float DEFAULT 0,
  `bizIntA` float DEFAULT 0,
  `bizInterior` int(12) DEFAULT 0,
  `bizExterior` int(12) DEFAULT 0,
  `bizExteriorVW` int(12) DEFAULT 0,
  `bizLocked` int(4) DEFAULT 0,
  `bizVault` int(12) DEFAULT 0,
  `bizProducts` int(12) DEFAULT 0,
  `bizPrice1` int(12) DEFAULT 0,
  `bizPrice2` int(12) DEFAULT 0,
  `bizPrice3` int(12) DEFAULT 0,
  `bizPrice4` int(12) DEFAULT 0,
  `bizPrice5` int(12) DEFAULT 0,
  `bizPrice6` int(12) DEFAULT 0,
  `bizPrice7` int(12) DEFAULT 0,
  `bizPrice8` int(12) DEFAULT 0,
  `bizPrice9` int(12) DEFAULT 0,
  `bizPrice10` int(12) DEFAULT 0,
  `bizSpawnX` float DEFAULT 0,
  `bizSpawnY` float DEFAULT 0,
  `bizSpawnZ` float DEFAULT 0,
  `bizSpawnA` float DEFAULT 0,
  `bizDeliverX` float DEFAULT 0,
  `bizDeliverY` float DEFAULT 0,
  `bizDeliverZ` float DEFAULT 0,
  `bizMessage` varchar(128) DEFAULT NULL,
  `bizPrice11` int(12) DEFAULT 0,
  `bizPrice12` int(12) DEFAULT 0,
  `bizPrice13` int(12) DEFAULT 0,
  `bizPrice14` int(12) DEFAULT 0,
  `bizPrice15` int(12) DEFAULT 0,
  `bizPrice16` int(12) DEFAULT 0,
  `bizPrice17` int(12) DEFAULT 0,
  `bizPrice18` int(12) DEFAULT 0,
  `bizPrice19` int(12) DEFAULT 0,
  `bizPrice20` int(12) DEFAULT 0,
  `bizShipment` int(4) DEFAULT 0,
  `bizTime` int(12) DEFAULT 0,
  `bizIcon` int(12) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `businesses`
--

INSERT INTO `businesses` (`bizID`, `bizName`, `bizOwner`, `bizType`, `bizPrice`, `bizPosX`, `bizPosY`, `bizPosZ`, `bizPosA`, `bizIntX`, `bizIntY`, `bizIntZ`, `bizIntA`, `bizInterior`, `bizExterior`, `bizExteriorVW`, `bizLocked`, `bizVault`, `bizProducts`, `bizPrice1`, `bizPrice2`, `bizPrice3`, `bizPrice4`, `bizPrice5`, `bizPrice6`, `bizPrice7`, `bizPrice8`, `bizPrice9`, `bizPrice10`, `bizSpawnX`, `bizSpawnY`, `bizSpawnZ`, `bizSpawnA`, `bizDeliverX`, `bizDeliverY`, `bizDeliverZ`, `bizMessage`, `bizPrice11`, `bizPrice12`, `bizPrice13`, `bizPrice14`, `bizPrice15`, `bizPrice16`, `bizPrice17`, `bizPrice18`, `bizPrice19`, `bizPrice20`, `bizShipment`, `bizTime`, `bizIcon`) VALUES
(1, '24/7', 99999999, 1, 100000, -181.184, 1034.86, 19.742, 272.318, -27.3073, -30.874, 1003.56, 0, 4, 0, 0, 0, 442, 92, 75, 125, 15, 100, 3, 2, 0, 0, 0, 0, -181.184, 1034.86, 19.742, 272.318, 0, 0, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 'Business New', 99999999, 7, 5000, -205.084, 1062.39, 19.7421, 92.5499, -2240.5, 128.377, 1035.42, 270, 6, 0, 0, 0, 2, 99, 75, 115, 15, 95, 3, 2, 10, 100, 20, 10, -205.084, 1062.39, 19.7421, 92.5499, 0, 0, 0, '', 140, 190, 150, 60, 50, 5, 10, 5, 0, 0, 0, 0, 0),
(3, 'Gas Station Fort Cason', 99999999, 6, 50000, 59.1594, 1223.92, 18.8703, 92.3193, -27.3383, -57.6908, 1003.55, 0, 6, 0, 0, 0, 0, 100, 75, 115, 15, 90, 3, 2, 10, 90, 20, 10, 59.1594, 1223.92, 18.8703, 92.3193, 0, 0, 0, '', 140, 150, 50, 5, 10, 5, 5, 150, 10, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `carID` int(12) NOT NULL,
  `carModel` int(12) DEFAULT 0,
  `carOwner` int(12) DEFAULT 0,
  `carPosX` float DEFAULT 0,
  `carPosY` float DEFAULT 0,
  `carPosZ` float DEFAULT 0,
  `carPosR` float DEFAULT 0,
  `carColor1` int(12) DEFAULT 0,
  `carColor2` int(12) DEFAULT 0,
  `carPaintjob` int(12) DEFAULT -1,
  `carLocked` int(4) DEFAULT 0,
  `carMod1` int(12) DEFAULT 0,
  `carMod2` int(12) DEFAULT 0,
  `carMod3` int(12) DEFAULT 0,
  `carMod4` int(12) DEFAULT 0,
  `carMod5` int(12) DEFAULT 0,
  `carMod6` int(12) DEFAULT 0,
  `carMod7` int(12) DEFAULT 0,
  `carMod8` int(12) DEFAULT 0,
  `carMod9` int(12) DEFAULT 0,
  `carMod10` int(12) DEFAULT 0,
  `carMod11` int(12) DEFAULT 0,
  `carMod12` int(12) DEFAULT 0,
  `carMod13` int(12) DEFAULT 0,
  `carMod14` int(12) DEFAULT 0,
  `carImpounded` int(12) DEFAULT 0,
  `carWeapon1` int(12) DEFAULT 0,
  `carAmmo1` int(12) DEFAULT 0,
  `carWeapon2` int(12) DEFAULT 0,
  `carAmmo2` int(12) DEFAULT 0,
  `carWeapon3` int(12) DEFAULT 0,
  `carAmmo3` int(12) DEFAULT 0,
  `carWeapon4` int(12) DEFAULT 0,
  `carAmmo4` int(12) DEFAULT 0,
  `carWeapon5` int(12) DEFAULT 0,
  `carAmmo5` int(12) DEFAULT 0,
  `carImpoundPrice` int(12) DEFAULT 0,
  `carFaction` int(12) DEFAULT 0,
  `truncated` tinyint(1) DEFAULT 0,
  `carJob` int(12) DEFAULT 0,
  `carFuel` int(12) DEFAULT 100,
  `carInsurance` int(11) DEFAULT 0,
  `carDamage1` int(11) DEFAULT 0,
  `carDamage2` int(11) DEFAULT 0,
  `carDamage3` int(11) DEFAULT 0,
  `carDamage4` int(11) DEFAULT 0,
  `carDeathTime` int(11) DEFAULT 0,
  `carDestroyed` int(11) DEFAULT 0,
  `carHealth` float DEFAULT 0,
  `carLock` int(11) DEFAULT 0,
  `carMileage` int(12) DEFAULT 0,
  `carGPS` int(11) DEFAULT 0,
  `carImmob` int(11) DEFAULT 0,
  `carBatteryL` int(11) NOT NULL DEFAULT 500,
  `carEngineL` int(11) NOT NULL DEFAULT 500,
  `carPlate` varchar(32) NOT NULL,
  `carDonator` int(3) NOT NULL DEFAULT 0,
  `carRent` int(4) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`carID`, `carModel`, `carOwner`, `carPosX`, `carPosY`, `carPosZ`, `carPosR`, `carColor1`, `carColor2`, `carPaintjob`, `carLocked`, `carMod1`, `carMod2`, `carMod3`, `carMod4`, `carMod5`, `carMod6`, `carMod7`, `carMod8`, `carMod9`, `carMod10`, `carMod11`, `carMod12`, `carMod13`, `carMod14`, `carImpounded`, `carWeapon1`, `carAmmo1`, `carWeapon2`, `carAmmo2`, `carWeapon3`, `carAmmo3`, `carWeapon4`, `carAmmo4`, `carWeapon5`, `carAmmo5`, `carImpoundPrice`, `carFaction`, `truncated`, `carJob`, `carFuel`, `carInsurance`, `carDamage1`, `carDamage2`, `carDamage3`, `carDamage4`, `carDeathTime`, `carDestroyed`, `carHealth`, `carLock`, `carMileage`, `carGPS`, `carImmob`, `carBatteryL`, `carEngineL`, `carPlate`, `carDonator`, `carRent`) VALUES
(7, 596, 0, -227.977, 996.504, 19.5625, 269.5, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 99, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 499, 500, 'NTD-678', 0, 0),
(9, 478, 0, -1115.66, -1653.96, 76.3671, 264.261, 1, 1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 500, 500, 'SXQ-656', 0, 0),
(10, 478, 0, -1116.34, -1662.01, 76.3671, 273.577, 2, 2, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 500, 500, 'FRJ-437', 0, 0),
(12, 547, 0, -135.501, 1184.62, 19.4853, 91.0266, 75, 38, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 98, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 498, 500, 'ANE-002', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `ID` int(6) NOT NULL,
  `A_ID` int(6) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `RegisterIP` varchar(16) NOT NULL,
  `RegisterDate` varchar(36) DEFAULT NULL,
  `LatestIP` varchar(16) NOT NULL,
  `Birthday` varchar(129) DEFAULT NULL,
  `Level` int(5) NOT NULL DEFAULT 1,
  `Cash` int(11) NOT NULL DEFAULT 1000,
  `Skin` int(3) NOT NULL DEFAULT 161,
  `PosX` float NOT NULL DEFAULT -129.683,
  `PosY` float NOT NULL DEFAULT 1209.04,
  `PosZ` float NOT NULL DEFAULT 19.7422,
  `Angle` float NOT NULL DEFAULT 175.468,
  `VWorld` int(4) NOT NULL,
  `Interior` int(2) NOT NULL,
  `Age` int(3) NOT NULL,
  `Gender` int(2) NOT NULL,
  `Kicks` int(5) NOT NULL,
  `Muted` int(2) NOT NULL,
  `Health` float NOT NULL DEFAULT 100,
  `Armour` float NOT NULL,
  `Bank` int(12) NOT NULL DEFAULT 3000,
  `ExemptIP` int(11) NOT NULL,
  `LastOnline` varchar(36) DEFAULT NULL,
  `Spawn` int(1) NOT NULL DEFAULT 1,
  `Faction` int(12) DEFAULT -1,
  `FactionRank` int(12) DEFAULT 0,
  `Entrance` int(12) DEFAULT 0,
  `Business` int(12) DEFAULT -1,
  `Job` int(12) DEFAULT 0,
  `House` int(12) DEFAULT -1,
  `Capacity` int(12) DEFAULT 35,
  `Exp` int(12) DEFAULT 0,
  `Savings` int(12) DEFAULT 0,
  `Paycheck` int(12) DEFAULT 0,
  `Minutes` int(12) DEFAULT 0,
  `Playerhours` int(12) DEFAULT 0,
  `Injured` int(4) DEFAULT 0,
  `Channel` int(12) DEFAULT 0,
  `ChannelSlot` int(12) DEFAULT 0,
  `Phone` int(12) DEFAULT 0,
  `ConfirmChar` int(12) NOT NULL DEFAULT 1,
  `Wood` int(12) NOT NULL DEFAULT 0,
  `Apple` int(12) NOT NULL DEFAULT 0,
  `Pumpkin` int(12) NOT NULL DEFAULT 0,
  `Pumpkin2` int(12) NOT NULL DEFAULT 0,
  `Orange` int(12) NOT NULL DEFAULT 0,
  `Orange2` int(12) NOT NULL DEFAULT 0,
  `WaitStats` int(12) NOT NULL DEFAULT 0,
  `ConfirmBy` varchar(129) DEFAULT NULL,
  `PlayerdePosX` float NOT NULL,
  `PlayerdePosY` float NOT NULL,
  `PlayerdePosZ` float NOT NULL,
  `PlayerdePosA` float NOT NULL,
  `PlayerdeInt` int(12) NOT NULL DEFAULT 0,
  `PlayerdeWorld` int(12) NOT NULL DEFAULT 0,
  `CowMilk` int(12) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `characters`
--

INSERT INTO `characters` (`ID`, `A_ID`, `Name`, `RegisterIP`, `RegisterDate`, `LatestIP`, `Birthday`, `Level`, `Cash`, `Skin`, `PosX`, `PosY`, `PosZ`, `Angle`, `VWorld`, `Interior`, `Age`, `Gender`, `Kicks`, `Muted`, `Health`, `Armour`, `Bank`, `ExemptIP`, `LastOnline`, `Spawn`, `Faction`, `FactionRank`, `Entrance`, `Business`, `Job`, `House`, `Capacity`, `Exp`, `Savings`, `Paycheck`, `Minutes`, `Playerhours`, `Injured`, `Channel`, `ChannelSlot`, `Phone`, `ConfirmChar`, `Wood`, `Apple`, `Pumpkin`, `Pumpkin2`, `Orange`, `Orange2`, `WaitStats`, `ConfirmBy`, `PlayerdePosX`, `PlayerdePosY`, `PlayerdePosZ`, `PlayerdePosA`, `PlayerdeInt`, `PlayerdeWorld`, `CowMilk`) VALUES
(2, 1, 'Justin_Cotner', '::1', '01/06/2020 05:51:03', '127.0.0.1', '01/12/1996', 1, 1000, 161, -64.6087, 28.7729, 3.1094, 86.1679, 0, 0, 24, 1, 0, 0, 90, 0, 3000, 0, '01/06/2020, 18:23:36', 1, -1, 0, 0, -1, 5, -1, 35, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Justinz', 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `confirmchar`
--

CREATE TABLE `confirmchar` (
  `ID` int(12) NOT NULL,
  `A_ID` int(12) NOT NULL DEFAULT 0,
  `Username` varchar(129) DEFAULT NULL,
  `Name` varchar(129) DEFAULT NULL,
  `Birthday` varchar(129) DEFAULT NULL,
  `Story` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=tis620;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `ID` int(12) NOT NULL,
  `contactID` int(12) NOT NULL,
  `contactName` varchar(32) DEFAULT NULL,
  `contactNumber` int(12) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`ID`, `contactID`, `contactName`, `contactNumber`) VALUES
(2, 0, 'Test', 845125),
(1, 0, 'Heang', 94452);

-- --------------------------------------------------------

--
-- Table structure for table `dropped`
--

CREATE TABLE `dropped` (
  `ID` int(12) NOT NULL,
  `itemName` varchar(32) DEFAULT NULL,
  `itemModel` int(12) DEFAULT 0,
  `itemX` float DEFAULT 0,
  `itemY` float DEFAULT 0,
  `itemZ` float DEFAULT 0,
  `itemInt` int(12) DEFAULT 0,
  `itemWorld` int(12) DEFAULT 0,
  `itemQuantity` int(12) DEFAULT 0,
  `itemExtended` int(12) DEFAULT 0,
  `itemPlayer` varchar(24) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

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
  `entranceLocked` int(12) DEFAULT 0,
  `entranceCustom` int(4) DEFAULT 0,
  `entranceWorld` int(12) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `entrances`
--

INSERT INTO `entrances` (`entranceID`, `entranceName`, `entranceIcon`, `entrancePosX`, `entrancePosY`, `entrancePosZ`, `entrancePosA`, `entranceIntX`, `entranceIntY`, `entranceIntZ`, `entranceIntA`, `entranceInterior`, `entranceExterior`, `entranceExteriorVW`, `entranceType`, `entranceLocked`, `entranceCustom`, `entranceWorld`) VALUES
(4, 'Bank', 0, -180.078, 1087.72, 19.742, 227.336, 389.169, 173.733, 1008.38, 90.221, 3, 0, 0, 2, 0, 0, 7004),
(5, 'Sheriff Depoartment', 30, -217.715, 979.153, 19.5032, 90.8554, 246.805, 62.3273, 1003.64, 179.782, 6, 0, 0, 0, 0, 0, 7005),
(6, 'Medic Department', 0, -318.847, 1048.86, 20.3402, 179.948, -204.506, -1736.05, 675.769, 181.182, 3, 0, 0, 0, 0, 0, 7006);

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
  `factionLockerX` float DEFAULT 0,
  `factionLockerY` float DEFAULT 0,
  `factionLockerZ` float DEFAULT 0,
  `factionLockerInt` int(12) DEFAULT 0,
  `factionLockerWorld` int(12) DEFAULT 0,
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
  `SpawnX` float NOT NULL,
  `SpawnY` float NOT NULL,
  `SpawnZ` float NOT NULL,
  `SpawnInterior` int(11) NOT NULL,
  `SpawnVW` int(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `factions`
--

INSERT INTO `factions` (`factionID`, `factionName`, `factionColor`, `factionType`, `factionRanks`, `factionLockerX`, `factionLockerY`, `factionLockerZ`, `factionLockerInt`, `factionLockerWorld`, `factionRank1`, `factionRank2`, `factionRank3`, `factionRank4`, `factionRank5`, `factionRank6`, `factionRank7`, `factionRank8`, `factionRank9`, `factionRank10`, `factionRank11`, `factionRank12`, `factionRank13`, `factionRank14`, `factionRank15`, `factionSkin1`, `factionSkin2`, `factionSkin3`, `factionSkin4`, `factionSkin5`, `factionSkin6`, `factionSkin7`, `factionSkin8`, `SpawnX`, `SpawnY`, `SpawnZ`, `SpawnInterior`, `SpawnVW`) VALUES
(1, 'Sheriff Department', -1920073729, 1, 15, 254.264, 79.1794, 1003.64, 6, 7005, 'Cadet', 'Rank 2', 'Rank 3', 'Rank 4', 'Rank 5', 'Rank 6', 'Rank 7', 'Rank 8', 'Rank 9', 'Rank 10', 'Rank 11', 'Rank 12', 'Rank 13', 'Rank 14', 'Chief Of Sheriff', 288, 285, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 'Medic Department', -6723158, 3, 15, -196.505, -1748.86, 675.769, 3, 7006, 'Rank 1', 'Rank 2', 'Rank 3', 'Rank 4', 'Rank 5', 'Rank 6', 'Rank 7', 'Rank 8', 'Rank 9', 'Rank 10', 'Rank 11', 'Rank 12', 'Rank 13', 'Rank 14', 'Rank 15', 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fields`
--

CREATE TABLE `fields` (
  `fieldID` int(12) NOT NULL,
  `fieldOwner` int(12) DEFAULT 0,
  `fieldPrice` int(12) DEFAULT 0,
  `fieldPosX` float DEFAULT 0,
  `fieldPosY` float DEFAULT 0,
  `fieldPosZ` float DEFAULT 0,
  `fieldPosA` float DEFAULT 0,
  `fieldInterior` int(12) DEFAULT 0,
  `fieldWorld` int(12) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `fields`
--

INSERT INTO `fields` (`fieldID`, `fieldOwner`, `fieldPrice`, `fieldPosX`, `fieldPosY`, `fieldPosZ`, `fieldPosA`, `fieldInterior`, `fieldWorld`) VALUES
(2, 0, 5000, -137.301, 1016.32, 19.7421, 358.158, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `foods`
--

CREATE TABLE `foods` (
  `foodID` int(12) NOT NULL,
  `foodPosX` float DEFAULT 0,
  `foodPosY` float DEFAULT 0,
  `foodPosZ` float DEFAULT 0,
  `foodInterior` int(12) DEFAULT 0,
  `foodWorld` int(12) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `foods`
--

INSERT INTO `foods` (`foodID`, `foodPosX`, `foodPosY`, `foodPosZ`, `foodInterior`, `foodWorld`) VALUES
(0, 377.507, -67.5718, 1001.52, 10, 6004);

-- --------------------------------------------------------

--
-- Table structure for table `furniture`
--

CREATE TABLE `furniture` (
  `ID` int(12) NOT NULL DEFAULT 0,
  `furnitureID` int(12) NOT NULL,
  `furnitureName` varchar(32) DEFAULT NULL,
  `furnitureModel` int(12) DEFAULT 0,
  `furnitureX` float DEFAULT 0,
  `furnitureY` float DEFAULT 0,
  `furnitureZ` float DEFAULT 0,
  `furnitureRX` float DEFAULT 0,
  `furnitureRY` float DEFAULT 0,
  `furnitureRZ` float DEFAULT 0,
  `furnitureInt` int(6) NOT NULL,
  `furnitureVW` int(6) NOT NULL,
  `furnitureType` int(12) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

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
  `houseMoney` int(12) DEFAULT 0,
  `houseRank` int(12) DEFAULT 1,
  `houseMaxFurniture` int(12) DEFAULT 10
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `houses`
--

INSERT INTO `houses` (`houseID`, `houseOwner`, `housePrice`, `houseAddress`, `housePosX`, `housePosY`, `housePosZ`, `housePosA`, `houseIntX`, `houseIntY`, `houseIntZ`, `houseIntA`, `houseInterior`, `houseExterior`, `houseExteriorVW`, `houseLocked`, `houseWeapon1`, `houseAmmo1`, `houseWeapon2`, `houseAmmo2`, `houseWeapon3`, `houseAmmo3`, `houseWeapon4`, `houseAmmo4`, `houseWeapon5`, `houseAmmo5`, `houseWeapon6`, `houseAmmo6`, `houseWeapon7`, `houseAmmo7`, `houseWeapon8`, `houseAmmo8`, `houseWeapon9`, `houseAmmo9`, `houseWeapon10`, `houseAmmo10`, `houseMoney`, `houseRank`, `houseMaxFurniture`) VALUES
(1, 0, 20000, 'test1', -45.0214, 1081.74, 20.9398, 178.369, 2269.88, -1210.32, 1047.56, 90, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 10),
(2, 1, 10000, 'test2', -35.9682, 1115.19, 20.9398, 1.5858, 2269.88, -1210.32, 1047.56, 90, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 10),
(3, 2, 500, '181/1', -18.242, 1115.67, 20.9398, 0.2858, 2269.88, -1210.32, 1047.56, 90, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 10),
(4, 2, 500, 'ADS', -247.813, 1001.07, 20.9398, 177.803, 2269.88, -1210.32, 1047.56, 90, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 10);

-- --------------------------------------------------------

--
-- Table structure for table `housestorage`
--

CREATE TABLE `housestorage` (
  `ID` int(12) DEFAULT 0,
  `itemID` int(12) NOT NULL,
  `itemName` varchar(32) DEFAULT NULL,
  `itemModel` int(12) DEFAULT 0,
  `itemQuantity` int(12) DEFAULT 0,
  `itemExtended` int(12) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

-- --------------------------------------------------------

--
-- Table structure for table `invfurniture`
--

CREATE TABLE `invfurniture` (
  `ID` int(12) NOT NULL DEFAULT 0,
  `invID` int(12) NOT NULL,
  `invItem` varchar(32) DEFAULT NULL,
  `invModel` int(12) DEFAULT 0,
  `invQuantity` int(12) DEFAULT 0,
  `invExtended` int(12) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `jobID` int(12) NOT NULL,
  `jobName` varchar(32) DEFAULT NULL,
  `jobPosX` float DEFAULT 0,
  `jobPosY` float DEFAULT 0,
  `jobPosZ` float DEFAULT 0,
  `jobPointX` float DEFAULT 0,
  `jobPointY` float DEFAULT 0,
  `jobPointZ` float DEFAULT 0,
  `jobDeliverX` float DEFAULT 0,
  `jobDeliverY` float DEFAULT 0,
  `jobDeliverZ` float DEFAULT 0,
  `jobInterior` int(12) DEFAULT 0,
  `jobType` int(12) DEFAULT 0,
  `jobWorld` int(12) DEFAULT 0,
  `jobPointInt` int(12) DEFAULT 0,
  `jobPointWorld` int(12) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`jobID`, `jobName`, `jobPosX`, `jobPosY`, `jobPosZ`, `jobPointX`, `jobPointY`, `jobPointZ`, `jobDeliverX`, `jobDeliverY`, `jobDeliverZ`, `jobInterior`, `jobType`, `jobWorld`, `jobPointInt`, `jobPointWorld`) VALUES
(1, 'คนส่งของ', -62.61, -1121.68, 1.2364, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0),
(2, 'ช่างยนต์', 99.9913, -159.565, 2.5852, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0),
(3, 'คนตัดไม้', -542.696, -181.523, 78.4062, -535.307, -177.907, 78.4046, -179.617, 1011.77, 19.7421, 0, 3, 0, 0, 0),
(4, 'ขนส่งผลไม้', -1109.48, -1667.72, 76.3671, -1106.12, -1671.51, 76.3671, -19.1984, 1175.96, 19.5633, 0, 4, 0, 0, 0),
(5, 'รีดนมวัว', -62.7695, 30.2548, 3.1092, -71.5251, 32.5694, 3.1171, -156.163, 1228.27, 19.7421, 0, 5, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `messagebox`
--

CREATE TABLE `messagebox` (
  `ID` int(12) NOT NULL,
  `A_ID` int(12) NOT NULL,
  `SendTo` varchar(129) DEFAULT NULL,
  `SendBy` varchar(129) DEFAULT NULL,
  `Msg` varchar(129) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=tis620;

-- --------------------------------------------------------

--
-- Table structure for table `money_log`
--

CREATE TABLE `money_log` (
  `id` int(12) NOT NULL,
  `charid` int(12) NOT NULL,
  `charName` varchar(32) NOT NULL,
  `reason` varchar(200) NOT NULL,
  `amount` int(12) NOT NULL,
  `date` varchar(36) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `money_log`
--

INSERT INTO `money_log` (`id`, `charid`, `charName`, `reason`, `amount`, `date`) VALUES
(0, 82, 'James_Force', 'buy biz id 0', -50000, '26/01/2020, 13:49:09'),
(0, 82, 'James_Force', 'buy biz id 1', -5000, '26/01/2020, 14:03:40'),
(0, 82, 'James_Force', 'buy phone from biz 0', -75, '26/01/2020, 14:14:53'),
(0, 82, 'James_Force', 'buy portableradio from biz 0', -15, '26/01/2020, 14:15:01'),
(0, 82, 'James_Force', 'buy clothes from biz 1', -10, '26/01/2020, 14:24:12'),
(0, 82, 'James_Force', 'buy clothes from biz 1', -15, '26/01/2020, 14:24:15'),
(0, 82, 'James_Force', 'buy phone from biz 0', -100, '26/01/2020, 14:38:40'),
(0, 82, 'James_Force', 'buy portableradio from biz 0', -15, '26/01/2020, 14:38:48'),
(0, 82, 'James_Force', 'Refill Fuel from pump 0', -7, '26/01/2020, 16:09:24'),
(0, 82, 'James_Force', 'Refill Fuel from pump 0', -15, '27/01/2020, 22:18:18'),
(0, 82, 'James_Force', 'Job Machanic from Test Test', 500, '07/02/2020, 23:14:41'),
(0, 85, 'Test_Test', 'Job Machanic to James Force', -500, '07/02/2020, 23:14:41'),
(0, 82, 'James_Force', 'Job Machanic from Test Test', 500, '07/02/2020, 23:15:25'),
(0, 85, 'Test_Test', 'Job Machanic to James Force', -500, '07/02/2020, 23:15:25'),
(0, 82, 'James_Force', 'Job Machanic from Test Test', 500, '07/02/2020, 23:16:04'),
(0, 85, 'Test_Test', 'Job Machanic to James Force', -500, '07/02/2020, 23:16:04'),
(0, 82, 'James_Force', 'buy house id 0', -5000, '08/02/2020, 13:51:25'),
(0, 82, 'James_Force', 'buy biz id 0', -50000, '08/02/2020, 14:04:01'),
(0, 82, 'James_Force', 'buy biz id 2', -500, '08/02/2020, 14:22:01'),
(0, 82, 'James_Force', 'buy biz id 2', -500, '08/02/2020, 14:23:48'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -75, '08/02/2020, 14:26:55'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -60, '08/02/2020, 14:26:59'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -100, '08/02/2020, 14:27:12'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -115, '08/02/2020, 14:28:29'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -75, '08/02/2020, 14:32:32'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -150, '08/02/2020, 14:32:35'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -60, '08/02/2020, 14:32:39'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -95, '08/02/2020, 14:47:51'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -150, '08/02/2020, 14:47:54'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -100, '08/02/2020, 14:49:00'),
(0, 85, 'Test_Test', 'buy house id 1', -200, '08/02/2020, 15:47:41'),
(0, 85, 'Test_Test', 'buy furniture from biz 2', -15, '08/02/2020, 15:47:59'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -3, '08/02/2020, 15:48:42'),
(0, 82, 'James_Force', 'deposit house id 0', -20000, '08/02/2020, 16:43:08'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -2, '08/02/2020, 16:45:08'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -2, '08/02/2020, 16:50:59'),
(0, 82, 'James_Force', 'deposit house id 0', -2000, '08/02/2020, 16:53:54'),
(0, 82, 'James_Force', 'withdraw house id 0', 1000, '08/02/2020, 16:56:25'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -10, '08/02/2020, 17:07:37'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -190, '08/02/2020, 17:07:40'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -95, '08/02/2020, 17:07:42'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -15, '08/02/2020, 17:07:44'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -115, '08/02/2020, 17:07:46'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -75, '08/02/2020, 17:07:49'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -100, '08/02/2020, 17:07:51'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -150, '08/02/2020, 17:07:54'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -75, '08/02/2020, 17:23:59'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -140, '08/02/2020, 17:24:04'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -100, '08/02/2020, 17:24:06'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -140, '08/02/2020, 17:24:08'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -3, '08/02/2020, 17:24:10'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -95, '08/02/2020, 17:24:13'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -115, '08/02/2020, 17:24:15'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -2, '08/02/2020, 17:24:18'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -100, '08/02/2020, 17:24:21'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -150, '08/02/2020, 17:24:23'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -150, '08/02/2020, 17:24:25'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -75, '08/02/2020, 17:28:45'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -100, '08/02/2020, 17:28:47'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -60, '08/02/2020, 17:28:49'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -140, '08/02/2020, 17:28:52'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -100, '08/02/2020, 17:28:53'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -75, '08/02/2020, 17:30:46'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -115, '08/02/2020, 17:33:53'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -95, '08/02/2020, 17:33:55'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -10, '08/02/2020, 17:33:58'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -20, '08/02/2020, 17:34:00'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -10, '08/02/2020, 17:34:02'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -150, '08/02/2020, 17:34:05'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -140, '08/02/2020, 17:34:07'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -100, '08/02/2020, 17:34:09'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -15, '08/02/2020, 17:34:12'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -190, '08/02/2020, 17:34:14'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -10, '08/02/2020, 17:34:17'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -75, '08/02/2020, 17:40:22'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -100, '08/02/2020, 17:41:04'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -100, '08/02/2020, 17:41:06'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -100, '08/02/2020, 18:00:51'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -75, '08/02/2020, 18:00:53'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -95, '08/02/2020, 18:00:56'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -190, '08/02/2020, 18:00:58'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -140, '08/02/2020, 18:01:00'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -20, '08/02/2020, 18:01:02'),
(0, 82, 'James_Force', 'buy furniture from biz 2', -2, '08/02/2020, 18:01:04'),
(0, 82, 'James_Force', 'buy house id 2', -200, '08/02/2020, 18:57:22'),
(0, 82, 'James_Force', 'buy house id 0', -5000, '08/02/2020, 18:57:55'),
(0, 1, 'James_Force', 'buy house id 0', -2000, '09/02/2020, 20:27:13'),
(0, 1, 'James_Force', 'buy furniture from biz 2', -150, '09/02/2020, 20:27:28'),
(0, 1, 'James_Force', 'buy furniture from biz 2', -60, '09/02/2020, 20:27:31'),
(0, 1, 'James_Force', 'buy phone from biz 1', -30, '23/02/2020, 14:36:42'),
(0, 1, 'James_Force', 'buy portableradio from biz 1', -10, '23/02/2020, 14:45:03'),
(0, 1, 'James_Force', 'buy phone from biz 0', -100, '23/02/2020, 15:01:23'),
(0, 1, 'James_Force', 'buy portableradio from biz 0', -15, '23/02/2020, 15:01:26'),
(0, 1, 'James_Force', 'buy boombox from biz 0', -100, '23/02/2020, 15:10:59'),
(0, 1, 'James_Force', 'buy furniture from biz 2', -115, '23/02/2020, 15:11:15'),
(0, 1, 'James_Force', 'buy furniture from biz 2', -75, '23/02/2020, 15:12:54'),
(0, 2, 'Emma_Force', 'buy water from biz 3', -2, '10/03/2020, 19:16:33'),
(0, 2, 'Emma_Force', 'buy water from biz 3', -2, '10/03/2020, 19:21:59'),
(0, 2, 'Emma_Force', 'buy phone from biz 0', -100, '10/03/2020, 19:33:14'),
(0, 2, 'Emma_Force', 'buy spray from biz 0', -125, '10/03/2020, 19:33:23'),
(0, 2, 'Emma_Force', 'buy portableradio from biz 0', -15, '10/03/2020, 19:33:31'),
(0, 2, 'Emma_Force', 'buy Basball from biz 0', -3, '10/03/2020, 19:33:35'),
(0, 2, 'Emma_Force', 'buy water from biz 3', -5, '10/03/2020, 19:34:35'),
(0, 3, 'Test_Test', 'buy phone from biz 0', -100, '10/03/2020, 20:59:04'),
(0, 1, 'James_Park', 'buy phone from biz 0', -100, '10/04/2020, 17:23:36'),
(0, 1, 'James_Park', 'buy water from biz 3', -5, '20/04/2020, 02:41:26'),
(0, 1, 'James_Park', 'buy phone from biz 0', -100, '20/04/2020, 02:49:33'),
(0, 1, 'James_Park', 'Sell Wood', 100, '23/04/2020, 17:52:31'),
(0, 1, 'James_Park', 'Sell Wood', 100, '23/04/2020, 17:53:04'),
(0, 1, 'James_Park', 'Sell Wood', 100, '23/04/2020, 18:19:41'),
(0, 1, 'James_Park', 'Sell Wood', 100, '23/04/2020, 18:25:25'),
(0, 1, 'James_Park', 'BuyWood', -900, '23/04/2020, 18:43:06'),
(0, 1, 'James_Park', 'BuyWood', -600, '23/04/2020, 18:50:25'),
(0, 1, 'James_Park', 'BuyWood', -900, '23/04/2020, 18:53:35'),
(0, 1, 'James_Park', 'BuyWood', -2100, '23/04/2020, 18:53:47'),
(0, 1, 'James_Park', 'BuyWood', -3000, '23/04/2020, 18:57:19'),
(0, 1, 'James_Park', 'Sell Wood', 100, '24/04/2020, 17:45:14'),
(0, 1, 'James_Park', 'BuyWood', -30, '24/04/2020, 17:48:38'),
(0, 1, 'James_Park', 'buy spray from biz 0', -125, '24/04/2020, 20:33:59'),
(0, 1, 'James_Park', 'buy portableradio from biz 0', -15, '24/04/2020, 20:36:12'),
(0, 2, 'Jay_Park', 'Sell Wood', 100, '25/04/2020, 19:10:07'),
(0, 2, 'Jay_Park', 'BuyWood', -30, '25/04/2020, 19:10:27'),
(0, 1, 'James_Park', 'Sell Wood', 100, '27/04/2020, 00:11:47'),
(0, 2, 'Jay_Park', 'Rentcar', -2500, '27/04/2020, 23:44:28'),
(0, 2, 'Jay_Park', 'BuyWood', -30, '28/04/2020, 20:29:27'),
(0, 2, 'Jay_Park', 'Sell Wood', 100, '28/04/2020, 21:26:36'),
(0, 2, 'Jay_Park', 'Sell Wood', 100, '28/04/2020, 21:26:59'),
(0, 2, 'Jay_Park', 'Sell Wood', 100, '28/04/2020, 21:27:13'),
(0, 2, 'Jay_Park', 'Sell Wood', 100, '28/04/2020, 21:27:43'),
(0, 2, 'Jay_Park', 'Sell Wood', 100, '28/04/2020, 21:28:04'),
(0, 2, 'Jay_Park', 'Sell Wood', 100, '28/04/2020, 21:28:43'),
(0, 2, 'Jay_Park', 'Sell Wood', 100, '28/04/2020, 21:29:04'),
(0, 2, 'Jay_Park', 'Sell Wood', 100, '28/04/2020, 21:29:47'),
(0, 2, 'Jay_Park', 'Sell Wood', 100, '28/04/2020, 21:30:33'),
(0, 2, 'Jay_Park', 'buy Basball from biz 0', -3, '28/04/2020, 21:32:41'),
(0, 2, 'Jay_Park', 'Sell Fruit', 100, '01/05/2020, 19:07:03'),
(0, 2, 'Jay_Park', 'BuyApple', -60, '01/05/2020, 19:10:35'),
(0, 2, 'Jay_Park', 'BuyWood', -270, '03/05/2020, 02:43:48'),
(0, 1, 'Justin_Cotner', 'Sell Fruit', 100, '06/05/2020, 01:51:40'),
(0, 1, 'Justin_Cotner', 'Sell Fruit', 100, '06/05/2020, 01:52:03'),
(0, 2, 'dfgfg_dfgdgdf', 'Sell Fruit', 100, '06/05/2020, 01:52:17'),
(0, 1, 'Justin_Cotner', 'Sell Fruit', 100, '06/05/2020, 01:52:42'),
(0, 1, 'Justin_Cotner', 'buy phone from biz 0', -75, '06/05/2020, 01:55:56'),
(0, 2, 'dfgfg_dfgdgdf', 'buy phone from biz 0', -75, '06/05/2020, 01:56:09'),
(0, 1, 'Justin_Cotner', 'SMS', -1, '06/05/2020, 01:57:02'),
(0, 4, 'Oliver_Jone', 'buy phone from biz 0', -75, '06/05/2020, 02:06:18'),
(0, 11, 'Jay_Park', 'BuyApple', -240, '06/05/2020, 21:17:21'),
(0, 1, 'Justin_Cotner', 'buy house id 0', -5000, '11/05/2020, 18:57:03'),
(0, 1, 'Justin_Cotner', 'buy house id 1', -5000, '11/05/2020, 19:07:21'),
(0, 1, 'Justin_Cotner', 'buy field id 0', -5000, '11/05/2020, 19:47:21'),
(0, 68, 'Test_Test', 'buy field id 1', -3000, '11/05/2020, 19:52:35'),
(0, 1, 'Justin_Cotner', 'Sell Field', 2500, '11/05/2020, 21:52:43'),
(0, 1, 'Justin_Cotner', 'buy field id 0', -5000, '11/05/2020, 21:57:34'),
(0, 1, 'Justin_Cotner', 'Sell Field', 2500, '14/05/2020, 18:46:36'),
(0, 1, 'Justin_Cotner', 'buy field id 0', -5000, '14/05/2020, 18:47:05'),
(0, 2, 'Wish_Morgan', 'buy phone from biz 0', -75, '14/05/2020, 23:10:23'),
(0, 1, 'Justin_Cotner', 'buy phone from biz 0', -75, '14/05/2020, 23:11:01'),
(0, 2, 'Wish_Morgan', 'buy field id 0', -5000, '14/05/2020, 23:12:56'),
(0, 1, 'Justin_Cotner', 'buy field id 1', -5000, '14/05/2020, 23:13:30'),
(0, 1, 'Justin_Cotner', 'buy field id 0', -5000, '17/05/2020, 12:22:20'),
(0, 47, 'Justin_Cotner', 'Sell Fruit', 100, '24/05/2020, 02:07:02'),
(0, 4, 'Pong_Deagle', 'Sell Fruit', 100, '24/05/2020, 02:07:40'),
(0, 4, 'Pong_Deagle', 'BuyApple', -120, '24/05/2020, 02:07:58'),
(0, 4, 'Pong_Deagle', 'buy house id 2', -500, '24/05/2020, 02:10:22'),
(0, 4, 'Pong_Deagle', 'buy furniture from biz 1', -2, '24/05/2020, 02:12:57'),
(0, 1, 'Justin_Cotner', 'buy house id 0', -20000, '24/05/2020, 02:45:16'),
(0, 1, 'Justin_Cotner', 'buy house id 1', -10000, '24/05/2020, 18:23:34'),
(0, 2, 'Covid_Virus', 'buy house id 3', -500, '24/05/2020, 18:43:10'),
(0, 2, 'Covid_Virus', 'Rentcar', -2500, '24/05/2020, 18:44:22'),
(0, 2, 'Covid_Virus', 'buy house id 2', -500, '24/05/2020, 18:45:18'),
(0, 2, 'Covid_Virus', 'Rentcar', -2500, '26/05/2020, 02:40:09'),
(0, 1, 'Justin_Cotner', 'Sell CowMilk', 400, '28/05/2020, 20:52:00'),
(0, 1, 'Justin_Cotner', 'Sell CowMilk', 100, '28/05/2020, 21:11:01'),
(0, 1, 'Justin_Cotner', 'buy house id 1', -10000, '30/05/2020, 09:37:50'),
(0, 1, 'Justin_Cotner', 'buy house id 0', -20000, '30/05/2020, 09:40:37'),
(0, 1, 'Justin_Cotner', 'buy house id 1', -10000, '30/05/2020, 09:42:36'),
(0, 1, 'Justin_Cotner', 'buy house id 0', -20000, '30/05/2020, 09:42:47'),
(0, 1, 'Justin_Cotner', 'buy house id 0', -20000, '30/05/2020, 10:03:43'),
(0, 1, 'Justin_Cotner', 'buy house id 1', -10000, '30/05/2020, 10:03:57'),
(0, 1, 'Justin_Cotner', 'buy house id 1', -10000, '30/05/2020, 10:05:18');

-- --------------------------------------------------------

--
-- Table structure for table `objects`
--

CREATE TABLE `objects` (
  `SQLID` int(11) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Model` int(11) NOT NULL,
  `PosX` float NOT NULL,
  `PosY` float NOT NULL,
  `PosZ` float NOT NULL,
  `AngX` float NOT NULL,
  `AngY` float NOT NULL,
  `AngZ` float NOT NULL,
  `World` int(6) NOT NULL,
  `Interior` int(6) NOT NULL,
  `Movable` int(1) NOT NULL,
  `NewX` float NOT NULL,
  `NewY` float NOT NULL,
  `NewZ` float NOT NULL,
  `aNewX` float NOT NULL,
  `aNewY` float NOT NULL,
  `aNewZ` float NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `objects`
--

INSERT INTO `objects` (`SQLID`, `Name`, `Model`, `PosX`, `PosY`, `PosZ`, `AngX`, `AngY`, `AngZ`, `World`, `Interior`, `Movable`, `NewX`, `NewY`, `NewZ`, `aNewX`, `aNewY`, `aNewZ`) VALUES
(76, 'test', 1331, 59.094, 1221.66, 18.602, 0, 0, -92.8, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `plants`
--

CREATE TABLE `plants` (
  `plantID` int(12) NOT NULL,
  `plantType` int(12) NOT NULL DEFAULT 0,
  `plantValue` int(12) DEFAULT 0,
  `plantWater` int(12) DEFAULT 0,
  `plantPosX` float DEFAULT 0,
  `plantPosY` float DEFAULT 0,
  `plantPosZ` float DEFAULT 0,
  `plantPosA` float DEFAULT 0,
  `plantInterior` int(12) DEFAULT 0,
  `plantWorld` int(12) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `productID` int(12) NOT NULL,
  `productPosX` float DEFAULT 0,
  `productPosY` float DEFAULT 0,
  `productPosZ` float DEFAULT 0,
  `productInterior` int(12) DEFAULT 0,
  `productWorld` int(12) DEFAULT 0,
  `productType` int(12) DEFAULT 0,
  `productAmount` int(12) DEFAULT 100,
  `productPrice` int(12) DEFAULT 0,
  `productPointX` float DEFAULT 0,
  `productPointY` float DEFAULT 0,
  `productPointZ` float DEFAULT 0,
  `productPointWorld` int(12) DEFAULT 0,
  `productPointInt` int(12) DEFAULT 0,
  `productPointAmount` int(12) DEFAULT 0,
  `productPointPrice` int(12) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`productID`, `productPosX`, `productPosY`, `productPosZ`, `productInterior`, `productWorld`, `productType`, `productAmount`, `productPrice`, `productPointX`, `productPointY`, `productPointZ`, `productPointWorld`, `productPointInt`, `productPointAmount`, `productPointPrice`) VALUES
(1, 94.3575, -165.077, 2.5937, 0, 0, 3, 10000, 300, 0, 0, 0, 0, 0, 0, 0),
(2, -857.676, 1535.68, 22.5869, 0, 0, 1, 100, 250, 33.9593, 488.04, 11.6622, 0, 0, 100, 300),
(3, -159.185, -283.672, 3.9052, 0, 0, 2, 100, 250, 28.7239, 487.795, 11.6622, 0, 0, 100, 300);

-- --------------------------------------------------------

--
-- Table structure for table `pumps`
--

CREATE TABLE `pumps` (
  `ID` int(12) DEFAULT 0,
  `pumpID` int(12) NOT NULL,
  `pumpPosX` float DEFAULT 0,
  `pumpPosY` float DEFAULT 0,
  `pumpPosZ` float DEFAULT 0,
  `pumpPosA` float DEFAULT 0,
  `pumpFuel` int(12) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `pumps`
--

INSERT INTO `pumps` (`ID`, `pumpID`, `pumpPosX`, `pumpPosY`, `pumpPosZ`, `pumpPosA`, `pumpFuel`) VALUES
(2, 10, 67.2239, 1217.58, 19.6466, 256.667, 1988),
(3, 11, 67.2349, 1217.64, 19.5281, 254.333, 2000),
(3, 12, 68.1196, 1220.6, 19.5266, 254.042, 2000),
(3, 13, 73.6658, 1219.13, 19.5539, 73.6002, 2000),
(3, 14, 72.8278, 1216.08, 19.5324, 73.3078, 2000);

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
) ENGINE=MyISAM DEFAULT CHARSET=tis620;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`ID`, `Name`, `Version`, `Locked`, `Password`, `Weather`) VALUES
(0, 'World Of Roleplay Thailand', 'WO:RP 1.2', 0, '15321532', 1);

-- --------------------------------------------------------

--
-- Table structure for table `woods`
--

CREATE TABLE `woods` (
  `woodsID` int(11) NOT NULL,
  `WoodX` varchar(255) CHARACTER SET latin1 NOT NULL,
  `WoodY` varchar(255) CHARACTER SET latin1 NOT NULL,
  `WoodZ` varchar(255) CHARACTER SET latin1 NOT NULL,
  `WoodHealth` int(12) NOT NULL DEFAULT 100
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `woods`
--

INSERT INTO `woods` (`woodsID`, `WoodX`, `WoodY`, `WoodZ`, `WoodHealth`) VALUES
(1, '-559.343505', '-157.530792', '75.929718', 100),
(2, '-565.318359', '-152.527526', '75.625946', 100),
(3, '-564.467224', '-127.366493', '68.839965', 100),
(4, '-596.454345', '-153.916915', '75.882553', 100),
(5, '-607.319396', '-123.490455', '67.844787', 100),
(6, '-598.903320', '-122.410980', '68.653762', 100),
(7, '-532.095825', '-134.814697', '69.740806', 100),
(8, '-607.258728', '-130.959381', '69.729965', 100),
(9, '-589.595275', '-128.559463', '70.057708', 100),
(10, '-503.358032', '-165.139892', '74.430831', 100),
(11, '-600.107849', '-135.832565', '72.057456', 100),
(12, '-616.256958', '-129.962432', '67.206733', 100),
(13, '-533.058288', '-119.593070', '65.739967', 100),
(14, '-581.219238', '-207.989486', '76.190849', 100),
(15, '-545.397033', '-218.628402', '75.753410', 100),
(16, '-507.353393', '-209.787475', '76.826248', 100),
(17, '-467.286895', '-206.847045', '76.202758', 100),
(18, '-572.884216', '-138.528533', '73.198432', 100),
(19, '-582.128479', '-134.429931', '71.997444', 100),
(20, '-569.335266', '-123.969108', '68.671180', 100),
(21, '-578.793518', '-128.825363', '70.388542', 100),
(22, '-589.143188', '-203.501144', '77.295303', 100),
(23, '-570.149230', '-208.048171', '76.956100', 100),
(24, '-571.950134', '-212.824172', '76.187515', 100),
(25, '-578.057189', '-210.820556', '76.123268', 100),
(26, '-564.462646', '-212.430374', '76.853080', 100),
(27, '-554.265747', '-208.542556', '77.464683', 100),
(28, '-546.912597', '-208.745117', '77.496253', 100),
(29, '-541.605346', '-206.271987', '77.466278', 100),
(30, '-542.908569', '-213.158554', '77.346267', 100),
(31, '-445.944154', '-139.764573', '68.057801', 100),
(33, '-440.394958', '-138.654800', '68.362579', 100),
(34, '-439.811401', '-131.648041', '65.530411', 100),
(35, '-445.020844', '-123.574860', '63.418945', 100),
(36, '-441.194855', '-117.275719', '61.743053', 100),
(37, '-436.295288', '-108.781067', '60.219482', 100),
(38, '-445.559937', '-107.800316', '60.459782', 100),
(39, '-449.894623', '-114.786057', '61.723373', 100),
(40, '-453.876190', '-130.038162', '65.488907', 100),
(41, '-452.238739', '-109.909103', '61.066975', 100),
(42, '-449.720917', '-95.573753', '58.739147', 100),
(43, '-443.185242', '-98.553078', '58.923878', 100),
(44, '-436.139038', '-98.539459', '58.622002', 100);

-- --------------------------------------------------------

--
-- Table structure for table `woodstorage`
--

CREATE TABLE `woodstorage` (
  `wsID` int(12) NOT NULL,
  `wsCount` int(12) NOT NULL DEFAULT 0,
  `wsPosX` float NOT NULL DEFAULT 0,
  `wsPosY` float NOT NULL DEFAULT 0,
  `wsPosZ` float NOT NULL DEFAULT 0,
  `wsInterior` int(12) NOT NULL DEFAULT 0,
  `wsWorld` int(12) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=tis620;

--
-- Dumping data for table `woodstorage`
--

INSERT INTO `woodstorage` (`wsID`, `wsCount`, `wsPosX`, `wsPosY`, `wsPosZ`, `wsInterior`, `wsWorld`) VALUES
(1, 0, -179.295, 1010.11, 19.7422, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `911 calls`
--
ALTER TABLE `911 calls`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`SQLID`),
  ADD UNIQUE KEY `SQLID` (`SQLID`);

--
-- Indexes for table `apples`
--
ALTER TABLE `apples`
  ADD PRIMARY KEY (`AppleID`);

--
-- Indexes for table `applestorage`
--
ALTER TABLE `applestorage`
  ADD PRIMARY KEY (`appleID`);

--
-- Indexes for table `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `businesses`
--
ALTER TABLE `businesses`
  ADD PRIMARY KEY (`bizID`);

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`carID`);

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Username` (`Name`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indexes for table `confirmchar`
--
ALTER TABLE `confirmchar`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `dropped`
--
ALTER TABLE `dropped`
  ADD PRIMARY KEY (`ID`);

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
-- Indexes for table `fields`
--
ALTER TABLE `fields`
  ADD PRIMARY KEY (`fieldID`);

--
-- Indexes for table `foods`
--
ALTER TABLE `foods`
  ADD PRIMARY KEY (`foodID`);

--
-- Indexes for table `furniture`
--
ALTER TABLE `furniture`
  ADD PRIMARY KEY (`furnitureID`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`houseID`);

--
-- Indexes for table `housestorage`
--
ALTER TABLE `housestorage`
  ADD PRIMARY KEY (`itemID`);

--
-- Indexes for table `invfurniture`
--
ALTER TABLE `invfurniture`
  ADD PRIMARY KEY (`invID`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`jobID`);

--
-- Indexes for table `messagebox`
--
ALTER TABLE `messagebox`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `objects`
--
ALTER TABLE `objects`
  ADD PRIMARY KEY (`SQLID`);

--
-- Indexes for table `plants`
--
ALTER TABLE `plants`
  ADD PRIMARY KEY (`plantID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productID`);

--
-- Indexes for table `pumps`
--
ALTER TABLE `pumps`
  ADD PRIMARY KEY (`pumpID`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indexes for table `woods`
--
ALTER TABLE `woods`
  ADD PRIMARY KEY (`woodsID`);

--
-- Indexes for table `woodstorage`
--
ALTER TABLE `woodstorage`
  ADD PRIMARY KEY (`wsID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `911 calls`
--
ALTER TABLE `911 calls`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `SQLID` int(32) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `apples`
--
ALTER TABLE `apples`
  MODIFY `AppleID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `applestorage`
--
ALTER TABLE `applestorage`
  MODIFY `appleID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bans`
--
ALTER TABLE `bans`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `businesses`
--
ALTER TABLE `businesses`
  MODIFY `bizID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
  MODIFY `carID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `ID` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `confirmchar`
--
ALTER TABLE `confirmchar`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `dropped`
--
ALTER TABLE `dropped`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `entrances`
--
ALTER TABLE `entrances`
  MODIFY `entranceID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `factions`
  MODIFY `factionID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `fields`
--
ALTER TABLE `fields`
  MODIFY `fieldID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `furniture`
--
ALTER TABLE `furniture`
  MODIFY `furnitureID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `houseID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `housestorage`
--
ALTER TABLE `housestorage`
  MODIFY `itemID` int(12) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invfurniture`
--
ALTER TABLE `invfurniture`
  MODIFY `invID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `jobID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `messagebox`
--
ALTER TABLE `messagebox`
  MODIFY `ID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `objects`
--
ALTER TABLE `objects`
  MODIFY `SQLID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `plants`
--
ALTER TABLE `plants`
  MODIFY `plantID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `productID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pumps`
--
ALTER TABLE `pumps`
  MODIFY `pumpID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `woods`
--
ALTER TABLE `woods`
  MODIFY `woodsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `woodstorage`
--
ALTER TABLE `woodstorage`
  MODIFY `wsID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
