-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 22, 2025 at 06:32 AM
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
-- Database: `stadium`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_match` (IN `mid` INT)   BEGIN
    DELETE FROM ticket WHERE match_id = mid;
    DELETE FROM matches WHERE match_id = mid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user` (IN `uid` INT)   BEGIN
    DELETE FROM ticket WHERE user_id = uid;
    DELETE FROM user WHERE user_id = uid;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `matches`
--

CREATE TABLE `matches` (
  `match_id` int(11) NOT NULL,
  `match_name` varchar(50) NOT NULL,
  `series_tournament_name` varchar(50) NOT NULL,
  `match_format` varchar(10) NOT NULL,
  `match_date` varchar(15) NOT NULL,
  `match_time` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `matches`
--

INSERT INTO `matches` (`match_id`, `match_name`, `series_tournament_name`, `match_format`, `match_date`, `match_time`) VALUES
(120, 'IND vs PAK', 'PAK tour of IND', 'T20', '02/08/2009', '07:30:00'),
(121, 'CSK vs GT', 'IPL', 'T20', '30/03/2022', '07:30:00'),
(122, 'CSK vs SRH', 'IPL', 'T20', '07/08/2022', '06:12:09'),
(123, 'GT vs SRH', 'IPL', 'T20', '02/02/2002', '07:30:00'),
(124, 'MI vs RCB', 'IPL', 'T20', '15/04/2023', '08:00:00'),
(125, 'AUS vs ENG', 'Ashes Series', 'Test', '05/07/2019', '10:00:00'),
(126, 'SA vs NZ', 'World Cup', 'ODI', '12/06/2015', '02:30:00'),
(127, 'BAN vs WI', 'Tri-Nation Series', 'ODI', '21/05/2017', '09:45:00'),
(128, 'IND vs AUS', 'Border-Gavaskar Trophy', 'Test', '10/12/2018', '09:00:00'),
(129, 'ENG vs NZ', 'World Cup', 'ODI', '14/07/2019', '03:00:00'),
(130, 'KKR vs DC', 'IPL', 'T20', '25/04/2022', '07:30:00'),
(131, 'RCB vs SRH', 'IPL', 'T20', '18/05/2022', '07:30:00'),
(132, 'PAK vs ENG', 'World Cup', 'ODI', '23/06/2019', '10:30:00'),
(133, 'SL vs IND', 'Asia Cup', 'ODI', '17/09/2023', '03:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `password`) VALUES
(1045, '1045'),
(1156, '1156'),
(1267, '1267'),
(1378, '1378'),
(1489, '1489'),
(2218, '2218'),
(4433, '4433'),
(7890, '7890'),
(8921, '8921'),
(9032, '9032');

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `ticket_id` int(11) NOT NULL,
  `match_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stand` varchar(5) NOT NULL,
  `ticket_price` int(11) NOT NULL,
  `no_of_tickets` int(11) NOT NULL,
  `total_payments` int(11) NOT NULL,
  `payment_method` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`ticket_id`, `match_id`, `user_id`, `stand`, `ticket_price`, `no_of_tickets`, `total_payments`, `payment_method`) VALUES
(1, 120, 6344, 'D', 10000, 5, 50000, 'UPI'),
(2, 121, 889, 'C', 5000, 4, 20000, 'Netbanking'),
(3, 122, 889, 'A', 1000, 19, 19000, 'Debit Card'),
(4, 123, 4937, 'C', 5000, 5, 25000, 'Debit Card'),
(5, 124, 4937, 'D', 10000, 4, 40000, 'UPI'),
(6, 125, 2003, 'A', 1000, 2, 2000, 'UPI'),
(7, 126, 1122, 'D', 10000, 1, 10000, 'UPI'),
(8, 127, 1112, 'C', 5000, 3, 15000, 'Netbanking'),
(9, 128, 7733, 'D', 10000, 1, 10000, 'UPI'),
(10, 129, 4455, 'D', 10000, 5, 50000, 'UPI'),
(11, 130, 5432, 'B', 7000, 2, 14000, 'Credit Card'),
(12, 131, 7654, 'A', 1000, 10, 10000, 'Debit Card'),
(13, 120, 8765, 'C', 5000, 3, 15000, 'UPI'),
(14, 121, 4321, 'B', 7000, 4, 28000, 'Netbanking'),
(15, 122, 6344, 'D', 10000, 2, 20000, 'UPI'),
(16, 123, 6543, 'A', 1000, 8, 8000, 'UPI'),
(17, 124, 7891, 'C', 5000, 6, 30000, 'Credit Card'),
(18, 122, 9087, 'A', 1000, 12, 12000, 'Debit Card'),
(19, 121, 6677, 'D', 10000, 3, 30000, 'UPI'),
(20, 123, 7654, 'B', 7000, 1, 7000, 'Netbanking');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `mobile_no` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `password`, `mobile_no`) VALUES
(889, 'Urmik', 'Urmik@', '9227083370'),
(1112, 'tirth', 'tirth@', '7984792591'),
(1122, 'Shubham', 'Shubham@112', '9245781345'),
(1203, 'Karan', 'Karan@321', '9198765432'),
(2003, 'Raj', 'Ramani009', '8238626628'),
(4321, 'Vishal', 'Vishal@2023', '8887776666'),
(4455, 'smit', 'smit@', '7698373886'),
(4937, 'bharat', 'bharat@', '9979731902'),
(5432, 'Manish', 'Manish@123', '9123456789'),
(6344, 'Ansh', '6433', '8849827943'),
(6543, 'Rina', 'Rina@456', '9054326789'),
(6677, 'Nisha', 'Nisha@234', '9182736450'),
(7654, 'Sanya', 'Sanya@007', '9978556634'),
(7733, 'Ruchit', 'Ruchit@', '1234567890'),
(7891, 'Tanu', 'Tanu@234', '9178364532'),
(8765, 'Priya', 'Priya@567', '9212345678'),
(8890, 'Aarav', 'Aarav@123', '9876543210'),
(9087, 'Siddharth', 'Siddharth@890', '9234567891'),
(9901, 'Neha', 'Neha@2022', '8123456789');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `matches`
--
ALTER TABLE `matches`
  ADD PRIMARY KEY (`match_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `match_id` (`match_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`match_id`) REFERENCES `matches` (`match_id`),
  ADD CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
