-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 25, 2018 at 11:16 AM
-- Server version: 5.7.21
-- PHP Version: 5.6.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `student`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `laxman`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `laxman` (IN `ID` INT, IN `per` INT)  NO SQL
update entries set percentage=per where id=ID$$

DROP PROCEDURE IF EXISTS `ram`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ram` (IN `id` INT, IN `marks1` INT, IN `marks2` INT, IN `marks3` INT)  BEGIN
		 
         
         set @per=(marks1+marks2+marks3)/3;
         insert into entries values(id,@per);
        END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
CREATE TABLE IF NOT EXISTS `entries` (
  `id` int(11) NOT NULL,
  `percentage` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entries`
--

INSERT INTO `entries` (`id`, `percentage`) VALUES
(2, '53.67'),
(4, '100.00'),
(3, '89.33'),
(1, '99.33');

-- --------------------------------------------------------

--
-- Table structure for table `marks`
--

DROP TABLE IF EXISTS `marks`;
CREATE TABLE IF NOT EXISTS `marks` (
  `id` int(11) NOT NULL,
  `marks1` int(11) DEFAULT NULL,
  `marks2` int(11) DEFAULT NULL,
  `marks3` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `marks`
--

INSERT INTO `marks` (`id`, `marks1`, `marks2`, `marks3`) VALUES
(4, 100, 100, 100),
(2, 79, 33, 49),
(3, 100, 69, 99),
(1, 98, 100, 100);

--
-- Triggers `marks`
--
DROP TRIGGER IF EXISTS `delete cascade`;
DELIMITER $$
CREATE TRIGGER `delete cascade` AFTER DELETE ON `marks` FOR EACH ROW DELETE from entries where id=old.id
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `disp`;
DELIMITER $$
CREATE TRIGGER `disp` AFTER INSERT ON `marks` FOR EACH ROW BEGIN
        	
           
           CALL ram(new.id,new.marks1,new.marks2,new.marks3);
            
     END
$$
DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
