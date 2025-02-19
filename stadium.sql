-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 02, 2025 at 11:41 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `s`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_match` (IN `in_match_id` INT)   BEGIN
    DELETE FROM matches WHERE match_id = in_match_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user` (IN `in_user_id` INT)   BEGIN
    DELETE FROM user WHERE user_id = in_user_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `food_orders`
--

CREATE TABLE `food_orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `match_id` int(11) NOT NULL,
  `food_item` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `order_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `food_orders`
--

INSERT INTO `food_orders` (`order_id`, `user_id`, `match_id`, `food_item`, `quantity`, `total_price`, `order_date`) VALUES
(1, 101, 1, 'Burger', 2, 300.00, '2025-02-01'),
(2, 102, 1, 'Pizza', 1, 300.00, '2025-02-01'),
(3, 103, 2, 'Hot Dog', 3, 300.00, '2025-02-02'),
(4, 104, 2, 'Soft Drink', 2, 100.00, '2025-02-02'),
(5, 105, 3, ' Popcorn', 1, 80.00, '2025-02-03'),
(6, 106, 3, 'Pizza', 2, 600.00, '2025-02-03'),
(7, 107, 4, 'Hot Dog', 5, 500.00, '2025-02-04'),
(8, 108, 4, 'Soft Dring', 1, 50.00, '2025-02-04'),
(9, 109, 5, 'Pizza', 3, 900.00, '2025-02-05'),
(10, 110, 5, 'Burger', 5, 750.00, '2025-02-05');


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
  `match_time` varchar(15) NOT NULL,
  `total_ticket` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `matches`
--

INSERT INTO `matches` (`match_id`, `match_name`, `series_tournament_name`, `match_format`, `match_date`, `match_time`, `total_ticket`) VALUES
(1, 'India vs Australia', 'Border-Gavaskar Trophy', 'Test', '2025-02-10', '10:00 AM', 50),
(2, 'India vs England', 'Test Series', 'Test', '2025-02-15', '10:00 AM', 50),
(3, 'India vs Pakistan', 'Asia Cup', 'ODI', '2025-03-01', '02:30 PM', 50),
(4, 'India vs Sri Lanka', 'Asia Cup', 'ODI', '2025-03-05', '02:30 PM', 50),
(5, 'India vs South Africa', 'Bilateral Series', 'ODI', '2025-03-12', '02:30 PM', 50),
(6, 'India vs New Zealand', 'Bilateral Series', 'T20', '2025-03-20', '07:00 PM', 50),
(7, 'India vs West Indies', 'Bilateral Series', 'T20', '2025-03-25', '07:00 PM', 50),
(8, 'CSK vs MI', 'IPL 2025', 'T20', '2025-04-01', '07:30 PM', 50),
(9, 'RCB vs KKR', 'IPL 2025', 'T20', '2025-04-05', '07:30 PM', 50),
(10, 'SRH vs DC', 'IPL 2025', 'T20', '2025-04-10', '07:30 PM', 50),
(11, 'GT vs LSG', 'IPL 2025', 'T20', '2025-04-15', '07:30 PM', 50),
(12, 'RR vs PBKS', 'IPL 2025', 'T20', '2025-04-20', '07:30 PM', 50),
(13, 'India vs Australia', 'World Cup 2025', 'ODI', '2025-05-01', '02:30 PM', 50),
(14, 'India vs England', 'World Cup 2025', 'ODI', '2025-05-05', '02:30 PM', 50),
(15, 'India vs Pakistan', 'World Cup 2025', 'ODI', '2025-05-10', '02:30 PM', 50);


-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `password`) VALUES
(2218, '2218'),
(4433, '4433'),
(7890, '7890'),
(8921, '8921'),
(9032, '9032'),
(1045, '1045'),
(1156, '1156'),
(1267, '1267');

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `ticket_id` int(11) NOT NULL,
  `match_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stand` varchar(1) NOT NULL,
  `ticket_price` int(11) NOT NULL,
  `no_of_tickets` int(11) NOT NULL,
  `total_payments` double NOT NULL,
  `payment_method` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`ticket_id`, `match_id`, `user_id`, `stand`, `ticket_price`, `no_of_tickets`, `total_payments`, `payment_method`) VALUES
(1, 1, 101, 'A', 1500, 2, 3000.00, 'Credit Card'),
(2, 2, 102, 'B', 1200, 3, 3600.00, 'UPI'),
(3, 3, 103, 'C', 1800, 1, 1800.00, 'Debit Card'),
(4, 4, 104, 'D', 2000, 2, 4000.00, 'Net Banking'),
(5, 5, 105, 'A', 1500, 1, 1500.00, 'Credit Card'),
(6, 6, 106, 'B', 1200, 2, 2400.00, 'UPI'),
(7, 7, 107, 'C', 1800, 3, 5400.00, 'Cash'),
(8, 8, 108, 'D', 2000, 1, 2000.00, 'Debit Card'),
(9, 9, 109, 'A', 1500, 2, 3000.00, 'UPI'),
(10, 10, 110, 'B', 1200, 4, 4800.00, 'Credit Card'),
(11, 11, 111, 'C', 1800, 2, 3600.00, 'Net Banking'),
(12, 12, 112, 'D', 2000, 1, 2000.00, 'Debit Card'),
(13, 13, 113, 'A', 1500, 3, 4500.00, 'UPI'),
(14, 14, 114, 'B', 1200, 2, 2400.00, 'Cash'),
(15, 15, 115, 'C', 1800, 1, 1800.00, 'Credit Card');
(16, 1, 116, 'D', 2000, 12, 24000.00, 'UPI'),
(17, 2, 117, 'A', 1500, 10, 15000.00, 'Credit Card'),
(18, 3, 118, 'B', 1200, 30, 36000.00, 'Debit Card'),
(19, 4, 119, 'C', 1800, 20, 36000.00, 'Net Banking'),
(20, 5, 120, 'D', 2000, 10, 20000.00, 'Cash'),
(21, 6, 121, 'A', 1500, 20, 30000.00, 'UPI'),
(22, 7, 122, 'B', 1200, 20, 24000.00, 'Credit Card'),
(23, 8, 123, 'C', 1800, 10, 18000.00, 'Debit Card'),
(24, 9, 124, 'D', 2000, 15, 30000.00, 'Net Banking'),
(25, 10, 125, 'A', 1500, 20, 30000.00, 'Cash'),
(26, 11, 126, 'B', 1200, 10, 12000.00, 'UPI'),
(27, 12, 127, 'C', 1800, 40, 72000.00, 'Credit Card'),
(28, 13, 128, 'D', 2000, 20, 40000.00, 'Debit Card'),
(29, 14, 129, 'A', 1500, 10, 25000.00, 'Net Banking'),
(30, 15, 130, 'B', 1200, 15, 18000.00, 'Cash');


-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `mobile_no` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `password`, `mobile_no`) VALUES
(101, 'Amit Sharma', 'pass123', '9876543210'),
(102, 'Rahul Verma', 'rahul@123', '9876504321'),
(103, 'Priya Singh', 'priya789', '9876123456'),
(104, 'Sneha Patel', 'sneha@456', '9876234567'),
(105, 'Vikram Das', 'vikram007', '9876345678'),
(106, 'Anjali Mehta', 'anjali321', '9876456789'),
(107, 'Rohit Malhotra', 'rohit@567', '9876567890'),
(108, 'Pooja Iyer', 'pooja890', '9876678901'),
(109, 'Suresh Raina', 'suresh@999', '9876789012'),
(110, 'Meena Kapoor', 'meena123', '9876890123'),
(111, 'Kunal Bansal', 'kunal!@#', '9876901234'),
(112, 'Divya Nair', 'divya$123', '9877012345'),
(113, 'Alok Jaiswal', 'alok@234', '9877123456'),
(114, 'Kriti Sen', 'kriti#789', '9877234567'),
(115, 'Varun Yadav', 'varun@555', '9877345678');


--
-- Indexes for dumped tables
--

--
-- Indexes for table `food_orders`
--
ALTER TABLE `food_orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `match_id` (`match_id`);

--
-- Indexes for table `matches`
--
ALTER TABLE `matches`
  ADD KEY `match_id` (`match_id`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`ticket_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `food_orders`
--
ALTER TABLE `food_orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `food_orders`
--
ALTER TABLE `food_orders`
  ADD CONSTRAINT `food_orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `food_orders_ibfk_2` FOREIGN KEY (`match_id`) REFERENCES `matches` (`match_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
