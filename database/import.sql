-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 16, 2023 at 12:56 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

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

CREATE TABLE `skinshop` (
  `skinshopID` int(12) NOT NULL,
  `skinshopModel` int(12) DEFAULT 0,
  `skinshopPrice` int(12) DEFAULT 0,
  `skinshopType` int(12) DEFAULT 0,
  `skinshopTotal` int(12) DEFAULT 0


) ENGINE=InnoDB DEFAULT CHARSET=tis620 COLLATE=tis620_thai_ci;


--
-- Dumping data for table `players`
--

-- --------------------------------------------------------

-- Dumping data for table `arrestpoints`
--


-- --------------------------------------------------------

--
-- Indexes for dumped tables
--

--
-- Indexes for table `players`
--
ALTER TABLE `skinshop`
  ADD PRIMARY KEY (`SkinshopID`);


ALTER TABLE `skinshop`
  MODIFY `SkinshopID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
