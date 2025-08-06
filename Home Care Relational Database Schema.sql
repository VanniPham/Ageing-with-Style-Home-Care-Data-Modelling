-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 10, 2023 at 06:50 AM
-- Server version: 10.3.35-MariaDB
-- PHP Version: 8.1.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vnpham`
--

-- --------------------------------------------------------

--
-- Table structure for table `ADDRESS`
--

CREATE TABLE `ADDRESS` (
  `AddressID` int(6) NOT NULL,
  `StreetNumber` int(6) NOT NULL,
  `StreetName` varchar(20) NOT NULL,
  `Suburb` varchar(20) NOT NULL,
  `Postcode` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ADDRESS`
--

INSERT INTO `ADDRESS` (`AddressID`, `StreetNumber`, `StreetName`, `Suburb`, `Postcode`) VALUES
(12000, 12, 'Elixabeth St', 'Sandy Bay', 7005),
(13000, 10, 'Collin St', 'Sandy Bay', 7005);

-- --------------------------------------------------------

--
-- Table structure for table `AFFECTS`
--

CREATE TABLE `AFFECTS` (
  `ClientID` int(6) NOT NULL,
  `DiagnosisCode` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `AFFECTS`
--

INSERT INTO `AFFECTS` (`ClientID`, `DiagnosisCode`) VALUES
(1001, 190),
(2005, 230);

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT`
--

CREATE TABLE `CLIENT` (
  `ClientID` int(6) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `AddressID` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CLIENT`
--

INSERT INTO `CLIENT` (`ClientID`, `Name`, `AddressID`) VALUES
(1001, 'John Smith', 12000),
(2005, 'Alex Lee', 13000);

-- --------------------------------------------------------

--
-- Table structure for table `DIAGNOSIS`
--

CREATE TABLE `DIAGNOSIS` (
  `DiagnosisCode` int(6) NOT NULL,
  `Description` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DIAGNOSIS`
--

INSERT INTO `DIAGNOSIS` (`DiagnosisCode`, `Description`) VALUES
(190, 'Alzheimer phase 1'),
(230, 'Dementia');

-- --------------------------------------------------------

--
-- Table structure for table `MEETS`
--

CREATE TABLE `MEETS` (
  `ClientID` int(6) NOT NULL,
  `StaffID` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `MEETS`
--

INSERT INTO `MEETS` (`ClientID`, `StaffID`) VALUES
(1001, 200),
(2005, 215);

-- --------------------------------------------------------

--
-- Table structure for table `QUALIFICATION`
--

CREATE TABLE `QUALIFICATION` (
  `QualificationName` varchar(50) NOT NULL,
  `Detail` varchar(8000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `QUALIFICATION`
--

INSERT INTO `QUALIFICATION` (`QualificationName`, `Detail`) VALUES
('Certificate III in Individual Support (CHC33015)', 'Reflects the role of workers in the community and/or residential setting who follow an individualised plan to provide person-centred support to people who may require support due to ageing, disability or some other reason.'),
('Certificate IV in Ageing Support (CHC40315)', 'Reflects the role of support workers who complete specialized tasks and functions in aged services.');

-- --------------------------------------------------------

--
-- Table structure for table `SERVICE`
--

CREATE TABLE `SERVICE` (
  `ServiceCode` smallint(3) NOT NULL,
  `ServiceKind` varchar(20) NOT NULL,
  `StaffID` int(6) NOT NULL,
  `DiagnosisCode` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SERVICE`
--

INSERT INTO `SERVICE` (`ServiceCode`, `ServiceKind`, `StaffID`, `DiagnosisCode`) VALUES
(1, 'Personal care', 200, 230),
(2, 'Domestic Cleaning', 215, 190);

-- --------------------------------------------------------

--
-- Table structure for table `STAFF`
--

CREATE TABLE `STAFF` (
  `StaffID` int(6) NOT NULL,
  `StaffName` varchar(20) NOT NULL,
  `Sex` char(1) NOT NULL,
  `Age` smallint(3) NOT NULL,
  `QualificationName` varchar(50) NOT NULL,
  `ManagerID` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `STAFF`
--

INSERT INTO `STAFF` (`StaffID`, `StaffName`, `Sex`, `Age`, `QualificationName`, `ManagerID`) VALUES
(200, 'Sandra Well', 'F', 37, 'Certificate IV in Ageing Support (CHC40315)', 215),
(210, 'Sara Huston', 'F', 32, 'Bachelor of Nursing', 200),
(215, 'Adam Cool', 'M', 30, 'Certificate IV in Ageing Support (CHC40315)', 200);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ADDRESS`
--
ALTER TABLE `ADDRESS`
  ADD PRIMARY KEY (`AddressID`);

--
-- Indexes for table `AFFECTS`
--
ALTER TABLE `AFFECTS`
  ADD PRIMARY KEY (`ClientID`,`DiagnosisCode`),
  ADD KEY `DiagnosisCode` (`DiagnosisCode`);

--
-- Indexes for table `CLIENT`
--
ALTER TABLE `CLIENT`
  ADD PRIMARY KEY (`ClientID`),
  ADD KEY `AddressID` (`AddressID`);

--
-- Indexes for table `DIAGNOSIS`
--
ALTER TABLE `DIAGNOSIS`
  ADD PRIMARY KEY (`DiagnosisCode`);

--
-- Indexes for table `MEETS`
--
ALTER TABLE `MEETS`
  ADD PRIMARY KEY (`ClientID`,`StaffID`),
  ADD KEY `StaffID` (`StaffID`);

--
-- Indexes for table `QUALIFICATION`
--
ALTER TABLE `QUALIFICATION`
  ADD PRIMARY KEY (`QualificationName`);

--
-- Indexes for table `SERVICE`
--
ALTER TABLE `SERVICE`
  ADD PRIMARY KEY (`ServiceCode`),
  ADD KEY `StaffID` (`StaffID`),
  ADD KEY `DiagnosisCode` (`DiagnosisCode`);

--
-- Indexes for table `STAFF`
--
ALTER TABLE `STAFF`
  ADD PRIMARY KEY (`StaffID`),
  ADD KEY `ManagerID` (`ManagerID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `AFFECTS`
--
ALTER TABLE `AFFECTS`
  ADD CONSTRAINT `AFFECTS_ibfk_1` FOREIGN KEY (`ClientID`) REFERENCES `CLIENT` (`ClientID`),
  ADD CONSTRAINT `AFFECTS_ibfk_2` FOREIGN KEY (`DiagnosisCode`) REFERENCES `DIAGNOSIS` (`DiagnosisCode`);

--
-- Constraints for table `CLIENT`
--
ALTER TABLE `CLIENT`
  ADD CONSTRAINT `CLIENT_ibfk_1` FOREIGN KEY (`AddressID`) REFERENCES `ADDRESS` (`AddressID`);

--
-- Constraints for table `MEETS`
--
ALTER TABLE `MEETS`
  ADD CONSTRAINT `MEETS_ibfk_1` FOREIGN KEY (`ClientID`) REFERENCES `CLIENT` (`ClientID`),
  ADD CONSTRAINT `MEETS_ibfk_2` FOREIGN KEY (`StaffID`) REFERENCES `STAFF` (`StaffID`);

--
-- Constraints for table `SERVICE`
--
ALTER TABLE `SERVICE`
  ADD CONSTRAINT `SERVICE_ibfk_1` FOREIGN KEY (`StaffID`) REFERENCES `STAFF` (`StaffID`),
  ADD CONSTRAINT `SERVICE_ibfk_2` FOREIGN KEY (`DiagnosisCode`) REFERENCES `DIAGNOSIS` (`DiagnosisCode`);

--
-- Constraints for table `STAFF`
--
ALTER TABLE `STAFF`
  ADD CONSTRAINT `STAFF_ibfk_1` FOREIGN KEY (`ManagerID`) REFERENCES `STAFF` (`StaffID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
