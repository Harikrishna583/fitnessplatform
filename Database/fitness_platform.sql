-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 07, 2025 at 03:48 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fitness_platform`
--

-- --------------------------------------------------------

--
-- Table structure for table `friend_list`
--

CREATE TABLE `friend_list` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `friend_id` int(11) NOT NULL,
  `user_min` int(11) GENERATED ALWAYS AS (least(`user_id`,`friend_id`)) STORED,
  `user_max` int(11) GENERATED ALWAYS AS (greatest(`user_id`,`friend_id`)) STORED,
  `status` enum('pending','accepted','blocked') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `friend_list`
--

INSERT INTO `friend_list` (`id`, `user_id`, `friend_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 'accepted', '2025-08-01 04:30:00', '2025-08-18 07:22:21'),
(2, 1, 22, 'pending', '2025-08-02 05:30:00', '2025-08-18 07:23:33'),
(3, 89, 94, 'accepted', '2025-08-01 04:30:00', '2025-08-01 04:30:00'),
(4, 90, 94, 'accepted', '2025-08-03 04:00:00', '2025-08-03 04:00:00'),
(5, 94, 93, 'pending', '2025-08-02 05:30:00', '2025-08-02 05:30:00'),
(6, 90, 93, 'accepted', '2025-08-04 08:30:00', '2025-08-04 08:30:00'),
(7, 89, 92, 'accepted', '2025-08-03 04:00:00', '2025-08-03 04:00:00'),
(8, 90, 1, 'accepted', '2025-08-04 08:30:00', '2025-08-04 08:30:00'),
(9, 89, 2, 'accepted', '2025-08-06 06:30:00', '2025-08-06 06:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `snack_options`
--

CREATE TABLE `snack_options` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `added_by` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `snack_options`
--

INSERT INTO `snack_options` (`id`, `name`, `added_by`, `created_at`) VALUES
(1, '5 gms protein powder', 'admin', '2025-05-11 05:54:37'),
(2, '10 gms roasted soya nuts', 'admin', '2025-05-11 05:54:37'),
(3, '20 ml unsweetened soya milk', 'admin', '2025-05-11 05:54:37'),
(4, '5 pcs soya chunks', 'admin', '2025-05-11 05:54:37'),
(5, '20 gms tofu', 'admin', '2025-05-11 05:54:37'),
(6, '1 slice fat free cheese', 'admin', '2025-05-11 05:54:37'),
(7, '20 gms fat free curds', 'admin', '2025-05-11 05:54:37'),
(8, '20 ml slim milk', 'admin', '2025-05-11 05:54:37'),
(9, '30 ml fat free butter milk', 'admin', '2025-05-11 05:54:37'),
(10, '1 egg white', 'admin', '2025-05-11 05:54:37'),
(11, '10 gms chicken', 'admin', '2025-05-11 05:54:37'),
(12, '10 gms mutton', 'admin', '2025-05-11 05:54:37'),
(13, '10 gms fish', 'admin', '2025-05-11 05:54:37');

--
-- Triggers `snack_options`
--
DELIMITER $$
CREATE TRIGGER `snack_delete_trigger` AFTER DELETE ON `snack_options` FOR EACH ROW BEGIN
  INSERT INTO snack_option_history (snack_id, name, action_type, performed_by)
  VALUES (OLD.id, OLD.name, 'DELETE', OLD.added_by);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `snack_insert_trigger` AFTER INSERT ON `snack_options` FOR EACH ROW BEGIN
  INSERT INTO snack_option_history (snack_id, name, action_type, performed_by)
  VALUES (NEW.id, NEW.name, 'INSERT', NEW.added_by);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `snack_update_trigger` AFTER UPDATE ON `snack_options` FOR EACH ROW BEGIN
  INSERT INTO snack_option_history (snack_id, name, action_type, performed_by)
  VALUES (NEW.id, NEW.name, 'UPDATE', NEW.added_by);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `snack_option_history`
--

CREATE TABLE `snack_option_history` (
  `history_id` int(11) NOT NULL,
  `snack_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `performed_by` varchar(100) DEFAULT NULL,
  `action_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `snack_option_history`
--

INSERT INTO `snack_option_history` (`history_id`, `snack_id`, `name`, `action_type`, `performed_by`, `action_time`) VALUES
(1, 1, '5 gms protein powder', 'INSERT', 'admin', '2025-05-11 05:54:37'),
(2, 2, '10 gms roasted soya nuts', 'INSERT', 'admin', '2025-05-11 05:54:37'),
(3, 3, '20 ml unsweetened soya milk', 'INSERT', 'admin', '2025-05-11 05:54:37'),
(4, 4, '5 pcs soya chunks', 'INSERT', 'admin', '2025-05-11 05:54:37'),
(5, 5, '20 gms tofu', 'INSERT', 'admin', '2025-05-11 05:54:37'),
(6, 6, '1 slice fat free cheese', 'INSERT', 'admin', '2025-05-11 05:54:37'),
(7, 7, '20 gms fat free curds', 'INSERT', 'admin', '2025-05-11 05:54:37'),
(8, 8, '20 ml slim milk', 'INSERT', 'admin', '2025-05-11 05:54:37'),
(9, 9, '30 ml fat free butter milk', 'INSERT', 'admin', '2025-05-11 05:54:37'),
(10, 10, '1 egg white', 'INSERT', 'admin', '2025-05-11 05:54:37'),
(11, 11, '10 gms chicken', 'INSERT', 'admin', '2025-05-11 05:54:37'),
(12, 12, '10 gms mutton', 'INSERT', 'admin', '2025-05-11 05:54:37'),
(13, 13, '10 gms fish', 'INSERT', 'admin', '2025-05-11 05:54:37');

-- --------------------------------------------------------

--
-- Table structure for table `supplement_fields`
--

CREATE TABLE `supplement_fields` (
  `id` int(11) NOT NULL,
  `valuePrefix` varchar(50) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `added_by` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supplement_fields`
--

INSERT INTO `supplement_fields` (`id`, `valuePrefix`, `name`, `added_by`, `created_at`) VALUES
(1, 'p', 'Protein', 'admin', '2025-05-11 16:16:08'),
(2, 'mv', 'Multi Vitamin', 'admin', '2025-05-11 16:16:08'),
(3, 'omega3', 'Omega 3', 'admin', '2025-05-11 16:16:08'),
(4, 'cal', 'Calcium', 'admin', '2025-05-11 16:16:08'),
(5, 'vb', 'Vitamin B', 'admin', '2025-05-11 16:16:08'),
(6, 'vc', 'Vitamin C', 'admin', '2025-05-11 16:16:08'),
(7, 'fiber', 'Fiber', 'admin', '2025-05-11 16:16:08'),
(8, 'triphala', 'Triphala', 'admin', '2025-05-11 16:16:08'),
(9, 'o1', 'Madhunashini', 'admin', '2025-05-11 16:16:08'),
(10, 'o2', '', 'admin', '2025-05-11 16:16:08'),
(11, 'o3', '', 'admin', '2025-05-11 16:16:08');

--
-- Triggers `supplement_fields`
--
DELIMITER $$
CREATE TRIGGER `trg_supplement_delete` AFTER DELETE ON `supplement_fields` FOR EACH ROW BEGIN
  INSERT INTO supplement_fields_history (supplement_id, valuePrefix, name, added_by, action_type)
  VALUES (OLD.id, OLD.valuePrefix, OLD.name, OLD.added_by, 'DELETE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_supplement_insert` AFTER INSERT ON `supplement_fields` FOR EACH ROW BEGIN
  INSERT INTO supplement_fields_history (supplement_id, valuePrefix, name, added_by, action_type)
  VALUES (NEW.id, NEW.valuePrefix, NEW.name, NEW.added_by, 'INSERT');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_supplement_update` AFTER UPDATE ON `supplement_fields` FOR EACH ROW BEGIN
  INSERT INTO supplement_fields_history (supplement_id, valuePrefix, name, added_by, action_type)
  VALUES (NEW.id, NEW.valuePrefix, NEW.name, NEW.added_by, 'UPDATE');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `supplement_fields_history`
--

CREATE TABLE `supplement_fields_history` (
  `history_id` int(11) NOT NULL,
  `supplement_id` int(11) DEFAULT NULL,
  `valuePrefix` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `added_by` varchar(100) DEFAULT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `action_timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supplement_fields_history`
--

INSERT INTO `supplement_fields_history` (`history_id`, `supplement_id`, `valuePrefix`, `name`, `added_by`, `action_type`, `action_timestamp`) VALUES
(1, 1, 'p', 'Protein', 'admin', 'INSERT', '2025-05-11 16:16:08'),
(2, 2, 'mv', 'Multi Vitamin', 'admin', 'INSERT', '2025-05-11 16:16:08'),
(3, 3, 'omega3', 'Omega 3', 'admin', 'INSERT', '2025-05-11 16:16:08'),
(4, 4, 'cal', 'Calcium', 'admin', 'INSERT', '2025-05-11 16:16:08');

-- --------------------------------------------------------

--
-- Table structure for table `tf_admin`
--

CREATE TABLE `tf_admin` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobilenumber` varchar(12) NOT NULL,
  `password` varchar(20) NOT NULL,
  `created_date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tf_admin`
--

INSERT INTO `tf_admin` (`id`, `name`, `email`, `mobilenumber`, `password`, `created_date`) VALUES
(1, 'John Admin', '', '9876543210', 'admin123', '2025-05-01'),
(2, 'Sarah Manager', '', '8765432109', 'manager456', '2025-05-02');

-- --------------------------------------------------------

--
-- Table structure for table `tf_blogsubscribe`
--

CREATE TABLE `tf_blogsubscribe` (
  `id` int(11) NOT NULL,
  `tdate` datetime NOT NULL DEFAULT current_timestamp(),
  `emailid` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_blogsubscribe`
--

INSERT INTO `tf_blogsubscribe` (`id`, `tdate`, `emailid`) VALUES
(1, '2025-05-01 10:00:00', 'john.doe@example.com'),
(2, '2025-05-02 12:00:00', 'jane.smith@example.com');

-- --------------------------------------------------------

--
-- Table structure for table `tf_coaches`
--

CREATE TABLE `tf_coaches` (
  `id` bigint(20) NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `coachid` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `mobilenumber` varchar(15) NOT NULL,
  `email` varchar(255) NOT NULL,
  `teamid` varchar(20) DEFAULT NULL,
  `address` varchar(512) DEFAULT NULL,
  `country` varchar(50) DEFAULT 'India',
  `city` varchar(50) DEFAULT 'Bangalore',
  `pincode` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `programslist` varchar(256) DEFAULT 'weightloss',
  `rating` varchar(20) DEFAULT NULL,
  `issubcoach` int(11) DEFAULT NULL,
  `maincoach` varchar(20) DEFAULT NULL,
  `isspouse` int(11) DEFAULT NULL,
  `spouseid` varchar(20) DEFAULT NULL,
  `referral_link` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `state` varchar(100) DEFAULT 'Karnataka',
  `profilepic` varchar(100) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  `youtube` varchar(100) DEFAULT NULL,
  `twitter` varchar(100) DEFAULT NULL,
  `instagram` varchar(100) DEFAULT NULL,
  `facebook` varchar(100) DEFAULT NULL,
  `linkedin` varchar(100) DEFAULT NULL,
  `whatsapp` varchar(100) DEFAULT NULL,
  `telegram` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_coaches`
--

INSERT INTO `tf_coaches` (`id`, `date`, `coachid`, `name`, `lastname`, `dob`, `mobilenumber`, `email`, `teamid`, `address`, `country`, `city`, `pincode`, `password`, `programslist`, `rating`, `issubcoach`, `maincoach`, `isspouse`, `spouseid`, `referral_link`, `phone`, `state`, `profilepic`, `website`, `youtube`, `twitter`, `instagram`, `facebook`, `linkedin`, `whatsapp`, `telegram`) VALUES
(1, '2025-05-01 09:00:00', 'COACH001', 'Mike', 'Wilson', '1985-03-15', '9876543211', 'coach1@example.com', 'TEAM01', '123 Fitness St', 'India', 'Bangalore', '560001', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 'weightloss,fitness', '4.5', 0, NULL, 0, NULL, 'ref001', '9876543211', 'Karnataka', 'mike.jpg', 'www.mikecoach.com', NULL, NULL, 'mike_coach', NULL, NULL, '9876543211', NULL),
(2, '2025-05-02 10:00:00', 'COACH002', 'Lisa', 'Brown', '1990-07-22', '8765432108', 'lisa.brown@example.com', 'TEAM02', '456 Health Ave', 'India', 'Bangalore', '560002', '123456', 'weightloss', '4.8', 1, 'COACH001', 0, NULL, 'ref002', '8765432108', 'Karnataka', 'lisa.jpg', NULL, NULL, NULL, 'lisa_coach', NULL, NULL, '8765432108', NULL),
(89, '2025-08-15 00:00:00', 'COACH003', 'John', 'Doe', '1980-01-15', '9876543210', 'john@coach.com', '1', '123 Street', 'India', 'Hyderabad', '500001', '12345', 'Weight Loss, Yoga', '5', 0, NULL, 0, NULL, 'https://referral.com/COACH003', '9876543210', 'Telangana', NULL, 'https://johnswebsite.com', 'https://youtube.com/john', 'https://twitter.com/john', 'https://instagram.com/john', 'https://facebook.com/john', 'https://linkedin.com/john', '9876543210', '9876543210');

-- --------------------------------------------------------

--
-- Table structure for table `tf_coaches_history`
--

CREATE TABLE `tf_coaches_history` (
  `history_id` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `date` datetime DEFAULT NULL,
  `coachid` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `mobilenumber` varchar(15) NOT NULL,
  `emailid` varchar(50) DEFAULT NULL,
  `teamid` varchar(20) DEFAULT NULL,
  `address` varchar(512) DEFAULT NULL,
  `country` varchar(50) DEFAULT 'India',
  `city` varchar(50) DEFAULT 'Bangalore',
  `pincode` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT '123456',
  `programslist` varchar(256) DEFAULT 'weightloss',
  `rating` varchar(20) DEFAULT NULL,
  `issubcoach` int(11) DEFAULT NULL,
  `maincoach` varchar(20) DEFAULT NULL,
  `isspouse` int(11) DEFAULT NULL,
  `spouseid` varchar(20) DEFAULT NULL,
  `referral_link` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `state` varchar(100) DEFAULT 'Karnataka',
  `profilepic` varchar(100) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  `youtube` varchar(100) DEFAULT NULL,
  `twitter` varchar(100) DEFAULT NULL,
  `instagram` varchar(100) DEFAULT NULL,
  `facebook` varchar(100) DEFAULT NULL,
  `linkedin` varchar(100) DEFAULT NULL,
  `whatsapp` varchar(100) DEFAULT NULL,
  `telegram` varchar(100) DEFAULT NULL,
  `history_action` enum('UPDATE','DELETE') NOT NULL,
  `history_timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_coaches_history`
--

INSERT INTO `tf_coaches_history` (`history_id`, `id`, `date`, `coachid`, `name`, `lastname`, `dob`, `mobilenumber`, `emailid`, `teamid`, `address`, `country`, `city`, `pincode`, `password`, `programslist`, `rating`, `issubcoach`, `maincoach`, `isspouse`, `spouseid`, `referral_link`, `phone`, `state`, `profilepic`, `website`, `youtube`, `twitter`, `instagram`, `facebook`, `linkedin`, `whatsapp`, `telegram`, `history_action`, `history_timestamp`) VALUES
(1, 90, '2025-08-15 00:00:00', 'COACH004', 'Jane', 'Smith', '1985-02-20', '9876543211', 'jane@coach.com', '1', '456 Avenue', 'India', 'Mumbai', '400001', '12345', 'Muscle Gain, Cardio', '4', 0, NULL, 0, NULL, 'https://referral.com/COACH004', '9876543211', 'Maharashtra', NULL, 'https://janeswebsite.com', 'https://youtube.com/jane', 'https://twitter.com/jane', 'https://instagram.com/jane', 'https://facebook.com/jane', 'https://linkedin.com/jane', '9876543211', '9876543211', 'DELETE', '2025-08-25 16:34:56'),
(2, 91, '2025-08-15 00:00:00', 'COACH005', 'Raj', 'Kumar', '1978-03-10', '9876543212', 'raj@coach.com', '1', '789 Road', 'India', 'Chennai', '600001', '12345', 'Yoga, Meditation', '5', 0, NULL, 0, NULL, 'https://referral.com/COACH005', '9876543212', 'Tamil Nadu', NULL, 'https://rajswebsite.com', 'https://youtube.com/raj', 'https://twitter.com/raj', 'https://instagram.com/raj', 'https://facebook.com/raj', 'https://linkedin.com/raj', '9876543212', '9876543212', 'DELETE', '2025-08-25 16:34:56'),
(3, 92, '2025-08-15 00:00:00', 'COACH006', 'Priya', 'Sharma', '1990-04-05', '9876543213', 'priya@coach.com', '2', '12 Colony', 'India', 'Delhi', '110001', '12345', 'Cardio, Strength Training', '4', 0, NULL, 0, NULL, 'https://referral.com/COACH006', '9876543213', 'Delhi', NULL, 'https://priyaswebsite.com', 'https://youtube.com/priya', 'https://twitter.com/priya', 'https://instagram.com/priya', 'https://facebook.com/priya', 'https://linkedin.com/priya', '9876543213', '9876543213', 'DELETE', '2025-08-25 16:34:56'),
(4, 93, '2025-08-15 00:00:00', 'COACH007', 'Amit', 'Singh', '1982-05-12', '9876543214', 'amit@coach.com', '2', '34 Block', 'India', 'Pune', '411001', '12345', 'Strength Training, HIIT', '5', 0, NULL, 0, NULL, 'https://referral.com/COACH007', '9876543214', 'Maharashtra', NULL, 'https://amitswebsite.com', 'https://youtube.com/amit', 'https://twitter.com/amit', 'https://instagram.com/amit', 'https://facebook.com/amit', 'https://linkedin.com/amit', '9876543214', '9876543214', 'DELETE', '2025-08-25 16:34:56'),
(5, 94, '2025-08-15 00:00:00', 'COACH008', 'Sneha', 'Patel', '1988-06-07', '9876543215', 'sneha@coach.com', '2', '56 Lane', 'India', 'Ahmedabad', '380001', '12345', 'Weight Loss, Nutrition', '4', 0, NULL, 0, NULL, 'https://referral.com/COACH008', '9876543215', 'Gujarat', NULL, 'https://snehaswebsite.com', 'https://youtube.com/sneha', 'https://twitter.com/sneha', 'https://instagram.com/sneha', 'https://facebook.com/sneha', 'https://linkedin.com/sneha', '9876543215', '9876543215', 'DELETE', '2025-08-25 16:34:56');

-- --------------------------------------------------------

--
-- Table structure for table `tf_dietsheet`
--

CREATE TABLE `tf_dietsheet` (
  `id` int(11) NOT NULL,
  `Cust_ID` int(11) NOT NULL,
  `dayofprogram` int(11) NOT NULL,
  `ddate` date NOT NULL,
  `breakfast` varchar(512) DEFAULT '""',
  `bf_supplement` varchar(512) DEFAULT '""',
  `lunch` varchar(512) DEFAULT '""',
  `l_supplement` varchar(512) DEFAULT '""',
  `dinner` varchar(512) DEFAULT '""',
  `d_supplement` varchar(512) DEFAULT '""',
  `snacks` varchar(512) DEFAULT '""',
  `water` varchar(128) DEFAULT '""',
  `soson` varchar(10) NOT NULL DEFAULT 'NO',
  `active` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_dietsheet`
--

INSERT INTO `tf_dietsheet` (`id`, `Cust_ID`, `dayofprogram`, `ddate`, `breakfast`, `bf_supplement`, `lunch`, `l_supplement`, `dinner`, `d_supplement`, `snacks`, `water`, `soson`, `active`) VALUES
(1, 1, 1, '2025-05-03', 'Oats with milk', 'Multivitamin', 'Rice and dal', 'Omega-3', 'Roti with vegetables', 'Calcium', 'Nuts', '2L', 'NO', 1),
(2, 2, 1, '2025-05-03', 'Egg omelette', 'Vitamin D', 'Chicken curry with rice', 'Protein shake', 'Grilled fish with salad', 'Magnesium', 'Fruit', '2.5L', 'YES', 1);

--
-- Triggers `tf_dietsheet`
--
DELIMITER $$
CREATE TRIGGER `tf_dietsheet_before_delete` BEFORE DELETE ON `tf_dietsheet` FOR EACH ROW BEGIN
  INSERT INTO `tf_dietsheet_history` (
    `id`, `Cust_ID`, `dayofprogram`, `ddate`, `breakfast`, `bf_supplement`, `lunch`, `l_supplement`, `dinner`,
    `d_supplement`, `snacks`, `water`, `soson`, `active`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`Cust_ID`, OLD.`dayofprogram`, OLD.`ddate`, OLD.`breakfast`, OLD.`bf_supplement`, OLD.`lunch`,
    OLD.`l_supplement`, OLD.`dinner`, OLD.`d_supplement`, OLD.`snacks`, OLD.`water`, OLD.`soson`, OLD.`active`,
    'DELETE', NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tf_dietsheet_before_update` BEFORE UPDATE ON `tf_dietsheet` FOR EACH ROW BEGIN
  INSERT INTO `tf_dietsheet_history` (
    `id`, `Cust_ID`, `dayofprogram`, `ddate`, `breakfast`, `bf_supplement`, `lunch`, `l_supplement`, `dinner`,
    `d_supplement`, `snacks`, `water`, `soson`, `active`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`Cust_ID`, OLD.`dayofprogram`, OLD.`ddate`, OLD.`breakfast`, OLD.`bf_supplement`, OLD.`lunch`,
    OLD.`l_supplement`, OLD.`dinner`, OLD.`d_supplement`, OLD.`snacks`, OLD.`water`, OLD.`soson`, OLD.`active`,
    'UPDATE', NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tf_dietsheet_history`
--

CREATE TABLE `tf_dietsheet_history` (
  `history_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `Cust_ID` int(11) NOT NULL,
  `dayofprogram` int(11) NOT NULL,
  `ddate` date NOT NULL,
  `breakfast` varchar(512) DEFAULT '""',
  `bf_supplement` varchar(512) DEFAULT '""',
  `lunch` varchar(512) DEFAULT '""',
  `l_supplement` varchar(512) DEFAULT '""',
  `dinner` varchar(512) DEFAULT '""',
  `d_supplement` varchar(512) DEFAULT '""',
  `snacks` varchar(512) DEFAULT '""',
  `water` varchar(128) DEFAULT '""',
  `soson` varchar(10) NOT NULL DEFAULT 'NO',
  `active` int(11) NOT NULL DEFAULT 1,
  `history_action` enum('UPDATE','DELETE') NOT NULL,
  `history_timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tf_events`
--

CREATE TABLE `tf_events` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=Active | 0=Inactive',
  `eventlink` varchar(516) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tf_events`
--

INSERT INTO `tf_events` (`id`, `title`, `date`, `created`, `modified`, `status`, `eventlink`) VALUES
(1, 'Fitness Webinar', '2025-05-10', '2025-05-01 10:00:00', '2025-05-01 10:00:00', 1, 'https://example.com/webinar'),
(2, 'Nutrition Workshop', '2025-05-15', '2025-05-02 11:00:00', '2025-05-02 11:00:00', 1, 'https://example.com/workshop');

-- --------------------------------------------------------

--
-- Table structure for table `tf_leads`
--

CREATE TABLE `tf_leads` (
  `Cust_ID` int(11) NOT NULL,
  `Lead_ID` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) DEFAULT ' ',
  `password` varchar(255) DEFAULT '123456',
  `mobile` bigint(20) NOT NULL,
  `email` varchar(55) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `pincode` varchar(8) DEFAULT NULL,
  `reffered_by` varchar(100) DEFAULT '',
  `programs` varchar(100) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` varchar(30) DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `targetweight` double DEFAULT NULL,
  `active_type` varchar(50) DEFAULT NULL,
  `healthreport` varchar(20) DEFAULT 'NO',
  `diettype` varchar(25) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `profession` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `other_info` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `status` varchar(50) DEFAULT 'Registered',
  `coachid` varchar(20) DEFAULT '',
  `connectedon` datetime DEFAULT NULL,
  `toreconnecton` datetime DEFAULT NULL,
  `leadtype` varchar(20) DEFAULT NULL,
  `conversations` text DEFAULT NULL,
  `tflead` int(11) NOT NULL DEFAULT 0,
  `isreferralurl` int(11) DEFAULT 0,
  `coachname` varchar(50) DEFAULT NULL,
  `referrer_name` varchar(50) DEFAULT NULL,
  `referrer_mobilenumber` varchar(20) DEFAULT NULL,
  `referralcode` varchar(50) DEFAULT NULL,
  `referralby` varchar(50) DEFAULT NULL,
  `iscoachadded` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_leads`
--

INSERT INTO `tf_leads` (`Cust_ID`, `Lead_ID`, `first_name`, `last_name`, `password`, `mobile`, `email`, `address`, `city`, `state`, `pincode`, `reffered_by`, `programs`, `age`, `gender`, `height`, `weight`, `targetweight`, `active_type`, `healthreport`, `diettype`, `dob`, `profession`, `is_active`, `other_info`, `created_at`, `status`, `coachid`, `connectedon`, `toreconnecton`, `leadtype`, `conversations`, `tflead`, `isreferralurl`, `coachname`, `referrer_name`, `referrer_mobilenumber`, `referralcode`, `referralby`, `iscoachadded`) VALUES
(1, 1, 'Amit', 'Sharma', '123456', 9123456789, 'amit.sharma@example.com', '789 Wellness Rd', 'Bangalore', 'Karnataka', '560003', 'ThinkFit', 'weightloss', 30, 'Male', 175.5, 85, 75, 'Moderate', 'NO', 'Vegetarian', '1995-04-10', 'Engineer', 1, NULL, '2025-05-01 11:00:00', 'Registered', 'COACH001', '2025-05-01 12:00:00', NULL, 'Direct', NULL, 0, 0, 'Mike Wilson', NULL, NULL, NULL, '0', 1),
(2, 2, 'Priya', 'Mehta', '123456', 9234567890, 'priya.mehta@example.com', '101 Fit Lane', 'Bangalore', 'Karnataka', '560004', 'COACH001', 'weightloss', 28, 'Female', 160, 65, 55, 'Sedentary', 'YES', 'Non-Vegetarian', '1997-08-15', 'Teacher', 1, NULL, '2025-05-02 09:00:00', 'Registered', 'COACH002', '2025-05-02 10:00:00', NULL, 'Referral', NULL, 0, 1, 'Lisa Brown', 'Amit Sharma', '9123456789', 'ref001', '1', 1),
(54, 54, 'user3', 'user3', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 9876543210, 'user3@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-06 19:36:29', 'New', 'COACH001', '2025-09-06 19:36:29', '2025-10-06 19:36:29', 'Lead', 'Initial consultation scheduled', 1, 0, 'COACH001', 'Ravi Kumar', '9123456789', 'REF12345', 'App Referral', 1),
(60, 60, 'Abhi', 'Abhi', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 9876543210, 'Abhi@gmail.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-15 20:07:04', 'New', 'COACH001', '2025-09-15 20:07:04', '2025-10-15 20:07:04', 'Lead', 'Initial consultation scheduled', 1, 0, 'COACH001', 'Ravi Kumar', '9123456789', 'REF12345', 'App Referral', 1),
(89, 89, 'John', 'Doe', '12345', 9876543210, 'john@example.com', '123 Street', 'Hyderabad', 'Telangana', '500001', 'REF001', 'Weight Loss', 28, 'male', 175, 75, 68, 'Active', 'Healthy', 'Veg', '1997-05-20', 'Engineer', 1, 'None', '2025-08-15 10:00:00', 'active', 'COACH003', '2025-08-01 00:00:00', '2025-08-20 00:00:00', 'Hot', 'First conversation', 1, 0, 'John Doe', 'Ref A', '9999999990', 'CODE1', 'COACH003', 1),
(90, 90, 'Jane', 'Smith', '12345', 9876543211, 'jane@example.com', '456 Avenue', 'Mumbai', 'Maharashtra', '400001', 'REF002', 'Muscle Gain', 32, 'female', 165, 60, 58, 'Moderate', 'Good', 'Non-Veg', '1993-11-15', 'Designer', 1, 'Allergic to peanuts', '2025-08-15 10:05:00', 'active', NULL, '2025-08-01 00:00:00', '2025-08-20 00:00:00', 'Warm', 'Second conversation', 2, 0, 'Jane Smith', 'Ref B', '9999999991', 'CODE2', 'COACH004', 1),
(91, 91, 'Raj', 'Kumar', '12345', 9876543212, 'raj@example.com', '789 Road', 'Chennai', 'Tamil Nadu', '600001', 'REF003', 'Yoga', 40, 'male', 180, 82, 78, 'Active', 'Excellent', 'Veg', '1985-04-10', 'Trainer', 1, 'Yoga specialist', '2025-08-15 10:10:00', 'active', NULL, '2025-08-01 00:00:00', '2025-08-20 00:00:00', 'Cold', 'Third conversation', 3, 0, 'Raj Kumar', 'Ref C', '9999999992', 'CODE3', 'COACH005', 1),
(92, 92, 'Priya', 'Sharma', '12345', 9876543213, 'priya@example.com', '12 Colony', 'Delhi', 'Delhi', '110001', 'REF004', 'Cardio', 25, 'female', 160, 55, 52, 'Low', 'Average', 'Veg', '2000-02-25', 'Student', 1, 'Prefers morning workouts', '2025-08-15 10:15:00', 'inactive', NULL, '2025-08-01 00:00:00', '2025-08-20 00:00:00', 'Hot', 'Fourth conversation', 4, 0, 'Priya Sharma', 'Ref D', '9999999993', 'CODE4', 'COACH006', 1),
(93, 93, 'Amit', 'Singh', '12345', 9876543214, 'amit@example.com', '34 Block', 'Pune', 'Maharashtra', '411001', 'REF005', 'Strength Training', 30, 'male', 170, 78, 75, 'Active', 'Good', 'Non-Veg', '1995-09-12', 'Developer', 1, 'Knee injury history', '2025-08-15 10:20:00', 'active', NULL, '2025-08-01 00:00:00', '2025-08-20 00:00:00', 'Warm', 'Fifth conversation', 5, 0, 'Amit Singh', 'Ref E', '9999999994', 'CODE5', 'COACH007', 1),
(94, 94, 'Sneha', 'Patel', '12345', 9876543215, 'sneha@example.com', '56 Lane', 'Ahmedabad', 'Gujarat', '380001', 'REF006', 'Weight Loss', 27, 'female', 158, 62, 55, 'Moderate', 'Good', 'Veg', '1998-07-07', 'Teacher', 1, 'Diabetic', '2025-08-15 10:25:00', 'active', NULL, '2025-08-01 00:00:00', '2025-08-20 00:00:00', 'Cold', 'Sixth conversation', 6, 0, 'Sneha Patel', 'Ref F', '9999999995', 'CODE6', 'COACH008', 1),
(98, 98, 'Abhiram', 'Kumar', '123456', 9876543211, 'Abhiram@gmail.com', NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NO', NULL, NULL, NULL, 1, NULL, '2025-05-04 16:07:46', 'Registered', 'COACH001', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, '0', 0),
(99, 99, 'Hari', 'krishna', '12345', 9876543210, 'abhiram@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 17:08:56', 'New', 'COACH001', '2025-09-04 17:08:56', '2025-10-04 17:08:56', 'Lead', 'Initial consultation scheduled', 1, 0, 'COACH001', 'Ravi Kumar', '9123456789', 'REF12345', 'App Referral', 1),
(0, 103, 'Abhiram', 'Yalapalli', '12345', 9876543210, 'abhiram@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No major issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 12:57:24', 'New', NULL, '2025-09-04 12:57:24', '2025-10-04 12:57:24', 'Lead', 'Initial consultation scheduled', 1, 0, 'Ravi Kumar', 'Ravi Kumar', '9123456789', 'REF12345', 'App Referral', 1),
(222, 222, 'Abhiram', 'Yalapalli', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 9876543210, 'abhiram@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 17:52:24', 'New', 'COACH001', '2025-09-04 17:52:24', '2025-10-04 17:52:24', 'Lead', 'Initial consultation scheduled', 1, 0, 'COACH001', 'Ravi Kumar', '9123456789', 'REF12345', 'App Referral', 1),
(224, 224, 'Demo', 'Demo', '12345', 9876543210, 'demo@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 17:54:50', 'New', 'COACH001', '2025-09-04 17:54:50', '2025-10-04 17:54:50', 'Lead', 'Initial consultation scheduled', 1, 0, 'COACH001', 'Ravi Kumar', '9123456789', 'REF12345', 'App Referral', 1),
(333, 333, 'demo3', 'demo3', '12345', 9876543210, 'demo3@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 17:57:05', 'New', 'COACH001', '2025-09-04 17:57:05', '2025-10-04 17:57:05', 'Lead', 'Initial consultation scheduled', 1, 0, 'COACH001', 'Ravi Kumar', '9123456789', 'REF12345', 'App Referral', 1),
(444, 444, 'demo4', 'demo4', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 9876543210, 'demo4@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 17:57:50', 'New', 'COACH001', '2025-09-04 17:57:50', '2025-10-04 17:57:50', 'Lead', 'Initial consultation scheduled', 1, 0, 'COACH001', 'Ravi Kumar', '9123456789', 'REF12345', 'App Referral', 1);

--
-- Triggers `tf_leads`
--
DELIMITER $$
CREATE TRIGGER `after_lead_insert` AFTER INSERT ON `tf_leads` FOR EACH ROW BEGIN
    INSERT INTO tf_users (
        user_id,
        Lead_ID,
        first_name,
        last_name,
        password,
        mobile,
        email,
        address,
        city,
        state,
        pincode,
        referred_by,
        programs,
        age,
        gender,
        height,
        weight,
        targetweight,
        active_type,
        healthreport,
        diettype,
        dob,
        profession,
        is_active,
        other_info,
        created_at,
        status,
        coachid,
        tflead
    ) VALUES (
        CONCAT(NEW.Lead_ID),   -- user_id = UL1001, UL1002, etc
        NEW.Lead_ID,
        NEW.first_name,
        NEW.last_name,
        NEW.password,
        NEW.mobile,
        NEW.email,
        NEW.address,
        NEW.city,
        NEW.state,
        NEW.pincode,
        NEW.reffered_by,
        NEW.programs,
        NEW.age,
        NEW.gender,
        NEW.height,
        NEW.weight,
        NEW.targetweight,
        NEW.active_type,
        NEW.healthreport,
        NEW.diettype,
        NEW.dob,
        NEW.profession,
        NEW.is_active,
        NEW.other_info,
        NEW.created_at,
        NEW.status,
        'COACH001',                 -- ✅ fixed coachid
        1                           -- tflead
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tf_leads_before_delete` BEFORE DELETE ON `tf_leads` FOR EACH ROW BEGIN
  INSERT INTO `tf_leads_history` (
    `Lead_ID`, `first_name`, `last_name`, `password`, `mobile`, `email`, `address`, `city`, `state`, `pincode`,
    `reffered_by`, `programs`, `age`, `gender`, `height`, `weight`, `targetweight`, `active_type`, `healthreport`,
    `diettype`, `dob`, `profession`, `is_active`, `other_info`, `created_at`, `status`, `coachid`, `connectedon`,
    `toreconnecton`, `leadtype`, `conversations`, `tflead`, `isreferralurl`, `coachname`, `referrer_name`,
    `referrer_mobilenumber`, `referralcode`, `referralby`, `iscoachadded`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`Lead_ID`, OLD.`first_name`, OLD.`last_name`, OLD.`password`, OLD.`mobile`, OLD.`email`, OLD.`address`,
    OLD.`city`, OLD.`state`, OLD.`pincode`, OLD.`reffered_by`, OLD.`programs`, OLD.`age`, OLD.`gender`, OLD.`height`,
    OLD.`weight`, OLD.`targetweight`, OLD.`active_type`, OLD.`healthreport`, OLD.`diettype`, OLD.`dob`, OLD.`profession`,
    OLD.`is_active`, OLD.`other_info`, OLD.`created_at`, OLD.`status`, OLD.`coachid`, OLD.`connectedon`,
    OLD.`toreconnecton`, OLD.`leadtype`, OLD.`conversations`, OLD.`tflead`, OLD.`isreferralurl`, OLD.`coachname`,
    OLD.`referrer_name`, OLD.`referrer_mobilenumber`, OLD.`referralcode`, OLD.`referralby`, OLD.`iscoachadded`,
    'DELETE', NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tf_leads_before_update` BEFORE UPDATE ON `tf_leads` FOR EACH ROW BEGIN
  INSERT INTO `tf_leads_history` (
    `Lead_ID`, `first_name`, `last_name`, `password`, `mobile`, `email`, `address`, `city`, `state`, `pincode`,
    `reffered_by`, `programs`, `age`, `gender`, `height`, `weight`, `targetweight`, `active_type`, `healthreport`,
    `diettype`, `dob`, `profession`, `is_active`, `other_info`, `created_at`, `status`, `coachid`, `connectedon`,
    `toreconnecton`, `leadtype`, `conversations`, `tflead`, `isreferralurl`, `coachname`, `referrer_name`,
    `referrer_mobilenumber`, `referralcode`, `referralby`, `iscoachadded`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`Lead_ID`, OLD.`first_name`, OLD.`last_name`, OLD.`password`, OLD.`mobile`, OLD.`email`, OLD.`address`,
    OLD.`city`, OLD.`state`, OLD.`pincode`, OLD.`reffered_by`, OLD.`programs`, OLD.`age`, OLD.`gender`, OLD.`height`,
    OLD.`weight`, OLD.`targetweight`, OLD.`active_type`, OLD.`healthreport`, OLD.`diettype`, OLD.`dob`, OLD.`profession`,
    OLD.`is_active`, OLD.`other_info`, OLD.`created_at`, OLD.`status`, OLD.`coachid`, OLD.`connectedon`,
    OLD.`toreconnecton`, OLD.`leadtype`, OLD.`conversations`, OLD.`tflead`, OLD.`isreferralurl`, OLD.`coachname`,
    OLD.`referrer_name`, OLD.`referrer_mobilenumber`, OLD.`referralcode`, OLD.`referralby`, OLD.`iscoachadded`,
    'UPDATE', NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tf_leads_history`
--

CREATE TABLE `tf_leads_history` (
  `history_id` int(11) NOT NULL,
  `Lead_ID` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) DEFAULT ' ',
  `password` varchar(255) DEFAULT '123456',
  `mobile` bigint(20) NOT NULL,
  `email` varchar(55) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `pincode` varchar(8) DEFAULT NULL,
  `reffered_by` varchar(100) DEFAULT '',
  `programs` varchar(100) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` varchar(30) DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `targetweight` double DEFAULT NULL,
  `active_type` varchar(50) DEFAULT NULL,
  `healthreport` varchar(20) DEFAULT 'NO',
  `diettype` varchar(25) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `profession` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `other_info` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Registered',
  `coachid` varchar(20) DEFAULT '',
  `connectedon` datetime DEFAULT NULL,
  `toreconnecton` datetime DEFAULT NULL,
  `leadtype` varchar(20) DEFAULT NULL,
  `conversations` text DEFAULT NULL,
  `tflead` int(11) NOT NULL DEFAULT 0,
  `isreferralurl` int(11) DEFAULT 0,
  `coachname` varchar(50) DEFAULT NULL,
  `referrer_name` varchar(50) DEFAULT NULL,
  `referrer_mobilenumber` varchar(20) DEFAULT NULL,
  `referralcode` varchar(50) DEFAULT NULL,
  `referralby` int(11) NOT NULL DEFAULT 0,
  `iscoachadded` int(11) DEFAULT 0,
  `history_action` enum('UPDATE','DELETE') NOT NULL,
  `history_timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_leads_history`
--

INSERT INTO `tf_leads_history` (`history_id`, `Lead_ID`, `first_name`, `last_name`, `password`, `mobile`, `email`, `address`, `city`, `state`, `pincode`, `reffered_by`, `programs`, `age`, `gender`, `height`, `weight`, `targetweight`, `active_type`, `healthreport`, `diettype`, `dob`, `profession`, `is_active`, `other_info`, `created_at`, `status`, `coachid`, `connectedon`, `toreconnecton`, `leadtype`, `conversations`, `tflead`, `isreferralurl`, `coachname`, `referrer_name`, `referrer_mobilenumber`, `referralcode`, `referralby`, `iscoachadded`, `history_action`, `history_timestamp`) VALUES
(1, 1, 'Amit', 'Sharma', '123456', 9123456789, 'amit.sharma@example.com', '789 Wellness Rd', 'Bangalore', 'Karnataka', '560003', 'ThinkFit', 'weightloss', 30, 'Male', 175.5, 85, 75, 'Moderate', 'NO', 'Vegetarian', '1995-04-10', 'Engineer', 1, NULL, '2025-05-01 11:00:00', 'Registered', 'COACH001', '2025-05-01 12:00:00', NULL, 'Direct', NULL, 0, 0, 'Mike Wilson', NULL, NULL, NULL, 0, 1, 'UPDATE', '2025-05-04 16:18:57'),
(2, 1, 'Amit', 'Sharma', '123456', 9123456789, 'amit.sharma@example.com', '789 Wellness Rd', 'Bangalore', 'Karnataka', '560003', 'ThinkFit', 'weightloss', 30, 'Male', 175.5, 85, 75, 'Moderate', 'NO', 'Vegetarian', '1995-04-10', 'Engineer', 1, NULL, '2025-05-01 11:00:00', 'Registered', 'COACH001', '2025-05-01 12:00:00', NULL, 'Direct', NULL, 0, 0, 'Mike Wilson', NULL, NULL, NULL, 0, 1, 'UPDATE', '2025-05-08 21:15:00'),
(3, 2, 'Priya', 'Mehta', '123456', 9234567890, 'priya.mehta@example.com', '101 Fit Lane', 'Bangalore', 'Karnataka', '560004', 'COACH001', 'weightloss', 28, 'Female', 160, 65, 55, 'Sedentary', 'YES', 'Non-Vegetarian', '1997-08-15', 'Teacher', 1, NULL, '2025-05-02 09:00:00', 'Registered', 'COACH002', '2025-05-02 10:00:00', NULL, 'Referral', NULL, 0, 1, 'Lisa Brown', 'Amit Sharma', '9123456789', 'ref001', 1, 1, 'UPDATE', '2025-05-08 21:15:00'),
(4, 98, 'Abhiram', 'Kumar', '123456', 9876543211, 'Abhiram@gmail.com', NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NO', NULL, NULL, NULL, 1, NULL, '2025-05-04 16:07:46', 'Registered', 'COACH001', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-05-08 21:15:00'),
(5, 100, 'Abhiram', 'Yalapalli', '$2b$10$abcdefghijk1234567890abcdEfghijklmnoPQrstuv', 9876543210, 'abhiram@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No major issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 12:39:01', 'New', NULL, '2025-09-04 12:39:01', '2025-10-04 12:39:01', 'Lead', 'Initial consultation scheduled', 0, 0, NULL, 'Ravi Kumar', '9123456789', 'REF12345', 0, 1, 'UPDATE', '2025-09-04 12:39:24'),
(6, 100, 'Abhiram', 'Yalapalli', '12345', 9876543210, 'abhiram@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No major issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 12:39:01', 'New', NULL, '2025-09-04 12:39:01', '2025-10-04 12:39:01', 'Lead', 'Initial consultation scheduled', 0, 0, NULL, 'Ravi Kumar', '9123456789', 'REF12345', 0, 1, 'DELETE', '2025-09-04 12:42:56'),
(7, 102, 'Abhiram', 'Yalapalli', '$2b$10$abcdefghijk1234567890abcdEfghijklmnoPQrstuv', 9876543210, 'abhiram@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No major issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 12:43:54', 'New', NULL, '2025-09-04 12:43:54', '2025-10-04 12:43:54', 'Lead', 'Initial consultation scheduled', 0, 0, NULL, 'Ravi Kumar', '9123456789', 'REF12345', 0, 1, 'UPDATE', '2025-09-04 12:44:07'),
(8, 102, 'Abhiram', 'Yalapalli', '12345', 9876543210, 'abhiram@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No major issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 12:43:54', 'New', NULL, '2025-09-04 12:43:54', '2025-10-04 12:43:54', 'Lead', 'Initial consultation scheduled', 0, 0, NULL, 'Ravi Kumar', '9123456789', 'REF12345', 0, 1, 'DELETE', '2025-09-04 12:50:55');

-- --------------------------------------------------------

--
-- Table structure for table `tf_messages`
--

CREATE TABLE `tf_messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `status` enum('sent','delivered','read') DEFAULT 'sent',
  `timestamp` datetime DEFAULT current_timestamp(),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_delivered` tinyint(1) DEFAULT 0,
  `is_read` tinyint(1) DEFAULT 0,
  `delivered_at` timestamp NULL DEFAULT NULL,
  `read_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tf_messages`
--

INSERT INTO `tf_messages` (`id`, `sender_id`, `receiver_id`, `message`, `file_path`, `file_type`, `status`, `timestamp`, `created_at`, `updated_at`, `is_delivered`, `is_read`, `delivered_at`, `read_at`) VALUES
(1, 1, 2, 'Hi Priya, how’s your program going?', NULL, NULL, 'sent', '2025-05-03 10:00:00', '2025-05-03 10:00:00', '2025-05-03 10:00:00', 0, 0, NULL, NULL),
(2, 2, 1, 'Hey Amit, it’s going well! Thanks for asking.', NULL, NULL, 'delivered', '2025-05-03 10:30:00', '2025-05-03 10:30:00', '2025-05-03 10:30:00', 1, 0, '2025-05-03 05:01:00', NULL),
(3, 1, 2, 'ssssss', NULL, 'text', 'sent', '2025-05-06 22:09:57', '2025-05-06 22:09:57', '2025-05-06 22:09:57', 0, 0, NULL, NULL),
(4, 1, 2, 'aaaa', NULL, 'text', 'sent', '2025-05-06 22:10:52', '2025-05-06 22:10:52', '2025-05-06 22:10:52', 0, 0, NULL, NULL),
(5, 1, 2, 'ssssss', NULL, 'text', 'sent', '2025-05-06 22:11:19', '2025-05-06 22:11:19', '2025-05-06 22:11:19', 0, 0, NULL, NULL),
(6, 1, 2, 'kkkkkkk', NULL, 'text', 'sent', '2025-05-06 22:12:26', '2025-05-06 22:12:26', '2025-05-06 22:12:26', 0, 0, NULL, NULL),
(7, 1, 2, 'ssssss', NULL, 'text', 'sent', '2025-05-06 22:13:13', '2025-05-06 22:13:13', '2025-05-06 22:13:13', 0, 0, NULL, NULL),
(8, 1, 2, 'kkkkkkk', NULL, 'text', 'sent', '2025-05-06 22:13:13', '2025-05-06 22:13:13', '2025-05-06 22:13:13', 0, 0, NULL, NULL),
(9, 1, 2, 'AAAA', NULL, 'text', 'sent', '2025-05-06 22:50:34', '2025-05-06 22:50:34', '2025-05-06 22:50:34', 0, 0, NULL, NULL),
(10, 2, 1, 'AAAA', NULL, 'text', 'sent', '2025-05-06 22:53:23', '2025-05-06 22:53:23', '2025-05-06 22:53:23', 0, 0, NULL, NULL),
(11, 1, 2, 'sss', NULL, 'text', 'sent', '2025-05-06 22:55:25', '2025-05-06 22:55:25', '2025-05-06 22:55:25', 0, 0, NULL, NULL),
(12, 2, 1, 'ssss', NULL, 'text', 'sent', '2025-05-06 22:59:00', '2025-05-06 22:59:00', '2025-05-06 22:59:00', 0, 0, NULL, NULL),
(13, 2, 1, 'ghhhh', NULL, 'text', 'sent', '2025-05-06 22:59:04', '2025-05-06 22:59:04', '2025-05-06 22:59:04', 0, 0, NULL, NULL),
(14, 1, 2, 'kjjj', NULL, 'text', 'sent', '2025-05-06 23:03:23', '2025-05-06 23:03:23', '2025-05-06 23:03:23', 0, 0, NULL, NULL),
(15, 2, 1, 'lkkkkk', NULL, 'text', 'sent', '2025-05-06 23:03:50', '2025-05-06 23:03:50', '2025-05-06 23:03:50', 0, 0, NULL, NULL),
(16, 2, 1, 'aaaaaa', NULL, 'text', 'sent', '2025-05-06 23:04:03', '2025-05-06 23:04:03', '2025-05-06 23:04:03', 0, 0, NULL, NULL),
(17, 2, 1, 'sdfsd', NULL, 'text', 'sent', '2025-05-06 23:18:06', '2025-05-06 23:18:06', '2025-05-06 23:18:06', 0, 0, NULL, NULL),
(18, 1, 2, 'aaaa', NULL, 'text', 'sent', '2025-05-06 23:18:21', '2025-05-06 23:18:21', '2025-05-06 23:18:21', 0, 0, NULL, NULL),
(19, 1, 2, 'ddd', NULL, 'text', 'sent', '2025-05-11 14:39:37', '2025-05-11 14:39:37', '2025-05-11 14:39:37', 0, 0, NULL, NULL),
(20, 1, 2, 'ddddddddddddddd', NULL, 'text', 'sent', '2025-05-11 14:39:47', '2025-05-11 14:39:47', '2025-05-11 14:39:47', 0, 0, NULL, NULL),
(21, 1, 2, 'dfdf', NULL, 'text', 'sent', '2025-05-11 15:57:28', '2025-05-11 15:57:28', '2025-05-11 15:57:28', 0, 0, NULL, NULL),
(22, 1, 2, 'aaaaaaaaa', NULL, 'text', 'sent', '2025-05-11 18:59:04', '2025-05-11 18:59:04', '2025-05-11 18:59:04', 0, 0, NULL, NULL),
(23, 1, 2, 'ssss', NULL, 'text', 'sent', '2025-05-11 19:24:50', '2025-05-11 19:24:50', '2025-05-11 19:24:50', 0, 0, NULL, NULL),
(24, 1, 2, 'aaaa', NULL, 'text', 'sent', '2025-05-11 19:27:46', '2025-05-11 19:27:46', '2025-05-11 19:27:46', 0, 0, NULL, NULL),
(25, 1, 2, 'ssss', NULL, 'text', 'read', '2025-05-11 19:29:14', '2025-05-11 19:29:14', '2025-05-11 20:42:55', 0, 0, NULL, NULL),
(26, 1, 2, 'aaa', NULL, 'text', 'sent', '2025-05-11 19:30:48', '2025-05-11 19:30:48', '2025-05-11 19:30:48', 0, 0, NULL, NULL),
(27, 1, 2, 'asdfsadf', NULL, 'text', 'sent', '2025-05-11 19:30:51', '2025-05-11 19:30:51', '2025-05-11 19:30:51', 0, 0, NULL, NULL),
(28, 1, 2, 'aaaa', NULL, 'text', 'sent', '2025-05-11 19:30:56', '2025-05-11 19:30:56', '2025-05-11 19:30:56', 0, 0, NULL, NULL),
(29, 1, 2, 'sss', NULL, 'text', 'sent', '2025-05-11 20:31:24', '2025-05-11 20:31:24', '2025-05-11 20:31:24', 0, 0, NULL, NULL),
(30, 1, 2, 'aaaaaaa', NULL, 'text', 'sent', '2025-05-11 20:34:19', '2025-05-11 20:34:19', '2025-05-11 20:34:19', 0, 0, NULL, NULL),
(31, 1, 2, 'aaa', NULL, 'text', 'sent', '2025-05-11 20:39:04', '2025-05-11 20:39:04', '2025-05-11 20:39:04', 0, 0, NULL, NULL),
(32, 1, 2, 'ssss', NULL, 'text', 'sent', '2025-05-11 20:41:32', '2025-05-11 20:41:32', '2025-05-11 20:41:32', 0, 0, NULL, NULL),
(33, 1, 2, 'aaaabbbbbbb', NULL, 'text', 'delivered', '2025-05-11 20:43:14', '2025-05-11 20:43:14', '2025-05-11 20:43:27', 0, 0, NULL, NULL),
(34, 1, 2, 'xxxxxxx', NULL, 'text', 'sent', '2025-05-11 20:48:24', '2025-05-11 20:48:24', '2025-05-11 20:48:24', 0, 0, NULL, NULL),
(35, 1, 2, 'daa', NULL, 'text', 'sent', '2025-05-11 20:52:43', '2025-05-11 20:52:43', '2025-05-11 20:52:43', 0, 0, NULL, NULL),
(36, 1, 2, 'aaaa', NULL, 'text', 'sent', '2025-05-11 20:53:33', '2025-05-11 20:53:33', '2025-05-11 20:53:33', 0, 0, NULL, NULL),
(37, 1, 2, 'aaa', NULL, 'text', 'sent', '2025-05-11 21:00:33', '2025-05-11 21:00:33', '2025-05-11 21:00:33', 0, 0, NULL, NULL),
(38, 2, 1, 'aaaaaa', NULL, 'text', 'sent', '2025-05-11 21:05:41', '2025-05-11 21:05:41', '2025-05-11 21:05:41', 0, 0, NULL, NULL),
(39, 1, 2, 'dddddddddghfghfhdg', NULL, 'text', 'sent', '2025-05-11 21:07:11', '2025-05-11 21:07:11', '2025-05-11 21:07:11', 0, 0, NULL, NULL),
(40, 1, 2, 'nm,bnk', NULL, 'text', 'sent', '2025-05-11 21:10:33', '2025-05-11 21:10:33', '2025-05-11 21:10:33', 0, 0, NULL, NULL),
(41, 2, 1, 'jooooooooooo', NULL, 'text', 'sent', '2025-05-11 21:13:45', '2025-05-11 21:13:45', '2025-05-11 21:13:45', 0, 0, NULL, NULL),
(42, 1, 2, 'het', NULL, 'text', 'sent', '2025-05-11 21:14:00', '2025-05-11 21:14:00', '2025-05-11 21:14:00', 0, 0, NULL, NULL),
(43, 1, 2, 'ytutyutyutyutyutyu', NULL, 'text', 'sent', '2025-05-11 21:14:10', '2025-05-11 21:14:10', '2025-05-11 21:14:10', 0, 0, NULL, NULL),
(44, 1, 2, 'uyuyutyu', NULL, 'text', 'sent', '2025-05-11 21:14:35', '2025-05-11 21:14:35', '2025-05-11 21:14:35', 0, 0, NULL, NULL),
(45, 1, 2, 'dsfsdfsdifgyishfgs shshd ifs dgijsdhg  hisha ahg sdhaighsid gisah gishgi i hsighishgis shgyis hgisjbgjis gjsghhhg hgi hgi  gshis shgi h igijsh sh', NULL, 'text', 'sent', '2025-05-11 23:05:20', '2025-05-11 23:05:20', '2025-05-11 23:05:20', 0, 0, NULL, NULL),
(46, 1, 2, 'ghghgh', NULL, 'text', 'sent', '2025-05-11 23:28:43', '2025-05-11 23:28:43', '2025-05-11 23:28:43', 0, 0, NULL, NULL),
(47, 1, 2, 's', NULL, 'text', 'sent', '2025-05-11 23:46:48', '2025-05-11 23:46:48', '2025-05-11 23:46:48', 0, 0, NULL, NULL),
(48, 1, 2, 's', NULL, 'text', 'sent', '2025-05-11 23:46:56', '2025-05-11 23:46:56', '2025-05-11 23:46:56', 0, 0, NULL, NULL),
(49, 1, 2, 'fdfdf', NULL, 'text', 'sent', '2025-05-11 23:57:42', '2025-05-11 23:57:42', '2025-05-11 23:57:42', 0, 0, NULL, NULL),
(50, 1, 2, 'dsadsad', NULL, 'text', 'sent', '2025-05-12 00:04:15', '2025-05-12 00:04:15', '2025-05-12 00:04:15', 0, 0, NULL, NULL),
(51, 1, 2, 'gfdgffdg', NULL, 'text', 'sent', '2025-05-12 00:20:32', '2025-05-12 00:20:32', '2025-05-12 00:20:32', 0, 0, NULL, NULL),
(52, 1, 2, NULL, '/uploads/1746990322161-60548349.sql', 'file', 'sent', '2025-05-12 00:35:24', '2025-05-12 00:35:24', '2025-05-12 00:35:24', 0, 0, NULL, NULL),
(53, 1, 2, NULL, '/uploads/1746990346607-908033645.jpeg', 'image', 'sent', '2025-05-12 00:35:47', '2025-05-12 00:35:47', '2025-05-12 00:35:47', 0, 0, NULL, NULL),
(54, 1, 2, 'dsadsad', NULL, 'text', 'sent', '2025-05-12 22:07:22', '2025-05-12 22:07:22', '2025-05-12 22:07:22', 0, 0, NULL, NULL),
(55, 1, 2, 'hiiii', NULL, 'text', 'sent', '2025-05-25 14:53:44', '2025-05-25 14:53:44', '2025-05-25 14:53:44', 0, 0, NULL, NULL),
(56, 2, 1, 'ssdfsdf', NULL, 'text', 'sent', '2025-05-25 14:56:14', '2025-05-25 14:56:14', '2025-05-25 14:56:14', 0, 0, NULL, NULL),
(57, 1, 2, 'dsfgdgdfg', NULL, 'text', 'sent', '2025-05-25 14:56:30', '2025-05-25 14:56:30', '2025-05-25 14:56:30', 0, 0, NULL, NULL),
(58, 2, 1, 'kkkkkkk', NULL, 'text', 'sent', '2025-05-25 14:56:48', '2025-05-25 14:56:48', '2025-05-25 14:56:48', 0, 0, NULL, NULL),
(59, 1, 2, 'aaaaaaaaa', NULL, 'text', 'sent', '2025-05-25 14:56:59', '2025-05-25 14:56:59', '2025-05-25 14:56:59', 0, 0, NULL, NULL),
(60, 1, 2, 'hii', NULL, 'text', 'sent', '2025-05-27 22:40:35', '2025-05-27 22:40:35', '2025-05-27 22:40:35', 0, 0, NULL, NULL),
(61, 2, 1, 'okay', NULL, 'text', 'sent', '2025-05-27 22:42:31', '2025-05-27 22:42:31', '2025-05-27 22:42:31', 0, 0, NULL, NULL),
(62, 1, 2, NULL, '/uploads/1748366016252-696314576.jpeg', 'image', 'sent', '2025-05-27 22:43:37', '2025-05-27 22:43:37', '2025-05-27 22:43:37', 0, 0, NULL, NULL),
(63, 1, 2, NULL, '/uploads/1748366031482-611303631.pdf', 'file', 'sent', '2025-05-27 22:43:53', '2025-05-27 22:43:53', '2025-05-27 22:43:53', 0, 0, NULL, NULL),
(64, 1, 2, 'HIiiii priya', NULL, 'text', 'sent', '2025-06-03 21:57:28', '2025-06-03 21:57:28', '2025-06-03 21:57:28', 0, 0, NULL, NULL),
(65, 2, 1, NULL, '/uploads/1748968067448-451105291.pdf', 'file', 'sent', '2025-06-03 21:57:48', '2025-06-03 21:57:48', '2025-06-03 21:57:48', 0, 0, NULL, NULL),
(66, 1, 2, NULL, '/uploads/1748968089229-735762055.PNG', 'image', 'sent', '2025-06-03 21:58:11', '2025-06-03 21:58:11', '2025-06-03 21:58:11', 0, 0, NULL, NULL),
(67, 1, 2, 'ddd', NULL, 'text', 'sent', '2025-08-15 12:52:44', '2025-08-15 12:52:44', '2025-08-15 12:52:44', 0, 0, NULL, NULL),
(68, 2, 89, 'hiii', NULL, 'text', 'sent', '2025-08-15 19:41:22', '2025-08-15 19:41:22', '2025-08-15 19:41:22', 0, 0, NULL, NULL),
(69, 2, 89, 'hiii', NULL, 'text', 'sent', '2025-08-15 19:43:36', '2025-08-15 19:43:36', '2025-08-15 19:43:36', 0, 0, NULL, NULL),
(70, 2, 89, 'hii', NULL, 'text', 'sent', '2025-08-15 19:44:46', '2025-08-15 19:44:46', '2025-08-15 19:44:46', 0, 0, NULL, NULL),
(71, 2, 89, 'hiiii', NULL, 'text', 'sent', '2025-08-15 19:50:23', '2025-08-15 19:50:23', '2025-08-15 19:50:23', 0, 0, NULL, NULL),
(72, 2, 89, 'hiii', NULL, 'text', 'sent', '2025-08-15 19:52:48', '2025-08-15 19:52:48', '2025-08-15 19:52:48', 0, 0, NULL, NULL),
(73, 2, 89, 'hiiiiii', NULL, 'text', 'sent', '2025-08-15 19:55:07', '2025-08-15 19:55:07', '2025-08-15 19:55:07', 0, 0, NULL, NULL),
(74, 2, 89, 'hii', NULL, 'text', 'sent', '2025-08-15 19:57:57', '2025-08-15 19:57:57', '2025-08-15 19:57:57', 0, 0, NULL, NULL),
(75, 1, 2, 'hiiii', NULL, 'text', 'sent', '2025-08-18 12:53:50', '2025-08-18 12:53:50', '2025-08-18 12:53:50', 0, 0, NULL, NULL),
(76, 2, 1, 'hiii', NULL, 'text', 'sent', '2025-08-18 12:54:04', '2025-08-18 12:54:04', '2025-08-18 12:54:04', 0, 0, NULL, NULL),
(77, 2, 1, 'hiiii', NULL, 'text', 'sent', '2025-08-18 12:54:32', '2025-08-18 12:54:32', '2025-08-18 12:54:32', 0, 0, NULL, NULL),
(78, 2, 1, 'hiiii', NULL, 'text', 'sent', '2025-08-18 12:54:43', '2025-08-18 12:54:43', '2025-08-18 12:54:43', 0, 0, NULL, NULL),
(79, 1, 2, 'hiii', NULL, 'text', 'sent', '2025-08-18 12:59:07', '2025-08-18 12:59:07', '2025-08-18 12:59:07', 0, 0, NULL, NULL),
(80, 2, 1, 'Abhi-Aug-18-1303', NULL, 'text', 'sent', '2025-08-18 13:03:10', '2025-08-18 13:03:10', '2025-08-18 13:03:10', 0, 0, NULL, NULL),
(82, 2, 1, 'hii', NULL, 'text', 'sent', '2025-08-18 13:42:53', '2025-08-18 13:42:53', '2025-08-18 13:42:53', 0, 0, NULL, NULL),
(83, 1, 2, 'Abhi-Aug-18-1402', NULL, 'text', 'sent', '2025-08-18 14:02:56', '2025-08-18 14:02:56', '2025-08-18 14:02:56', 0, 0, NULL, NULL),
(84, 2, 1, 'Abhi-Aug-18-1403', NULL, 'text', 'sent', '2025-08-18 14:03:59', '2025-08-18 14:03:59', '2025-08-18 14:03:59', 0, 0, NULL, NULL),
(85, 1, 2, 'sdsd', NULL, 'text', 'sent', '2025-09-15 18:09:55', '2025-09-15 18:09:55', '2025-09-15 18:09:55', 0, 0, NULL, NULL),
(86, 1, 2, 'hiiii', NULL, 'text', 'sent', '2025-09-15 18:18:28', '2025-09-15 18:18:28', '2025-09-15 18:18:28', 0, 0, NULL, NULL),
(87, 2, 1, 'ssss', NULL, 'text', 'sent', '2025-09-15 18:22:34', '2025-09-15 18:22:34', '2025-09-15 18:22:34', 0, 0, NULL, NULL),
(88, 2, 1, '123', NULL, 'text', 'sent', '2025-09-15 18:26:01', '2025-09-15 18:26:01', '2025-09-15 18:26:01', 0, 0, NULL, NULL),
(89, 1, 2, 'hiiii', NULL, 'text', 'sent', '2025-10-02 19:05:04', '2025-10-02 19:05:04', '2025-10-02 19:05:04', 0, 0, NULL, NULL);

--
-- Triggers `tf_messages`
--
DELIMITER $$
CREATE TRIGGER `tf_messages_before_delete` BEFORE DELETE ON `tf_messages` FOR EACH ROW BEGIN
  INSERT INTO `tf_messages_history` (
    `id`, `sender_id`, `receiver_id`, `message`, `file_path`, `file_type`, `status`, `timestamp`, `created_at`,
    `updated_at`, `is_delivered`, `is_read`, `delivered_at`, `read_at`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`sender_id`, OLD.`receiver_id`, OLD.`message`, OLD.`file_path`, OLD.`file_type`, OLD.`status`,
    OLD.`timestamp`, OLD.`created_at`, OLD.`updated_at`, OLD.`is_delivered`, OLD.`is_read`, OLD.`delivered_at`,
    OLD.`read_at`, 'DELETE', NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tf_messages_before_update` BEFORE UPDATE ON `tf_messages` FOR EACH ROW BEGIN
  INSERT INTO `tf_messages_history` (
    `id`, `sender_id`, `receiver_id`, `message`, `file_path`, `file_type`, `status`, `timestamp`, `created_at`,
    `updated_at`, `is_delivered`, `is_read`, `delivered_at`, `read_at`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`sender_id`, OLD.`receiver_id`, OLD.`message`, OLD.`file_path`, OLD.`file_type`, OLD.`status`,
    OLD.`timestamp`, OLD.`created_at`, OLD.`updated_at`, OLD.`is_delivered`, OLD.`is_read`, OLD.`delivered_at`,
    OLD.`read_at`, 'UPDATE', NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tf_messages_history`
--

CREATE TABLE `tf_messages_history` (
  `history_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `status` enum('sent','delivered','read') DEFAULT 'sent',
  `timestamp` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_delivered` tinyint(1) DEFAULT 0,
  `is_read` tinyint(1) DEFAULT 0,
  `delivered_at` timestamp NULL DEFAULT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `history_action` enum('UPDATE','DELETE') NOT NULL,
  `history_timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tf_messages_history`
--

INSERT INTO `tf_messages_history` (`history_id`, `id`, `sender_id`, `receiver_id`, `message`, `file_path`, `file_type`, `status`, `timestamp`, `created_at`, `updated_at`, `is_delivered`, `is_read`, `delivered_at`, `read_at`, `history_action`, `history_timestamp`) VALUES
(1, 25, 1, 2, 'ssss', NULL, 'text', 'sent', '2025-05-11 19:29:14', '2025-05-11 19:29:14', '2025-05-11 19:29:14', 0, 0, NULL, NULL, 'UPDATE', '2025-05-11 20:42:27'),
(2, 25, 1, 2, 'ssss', NULL, 'text', 'delivered', '2025-05-11 19:29:14', '2025-05-11 19:29:14', '2025-05-11 20:42:27', 0, 0, NULL, NULL, 'UPDATE', '2025-05-11 20:42:55'),
(3, 33, 1, 2, 'aaaabbbbbbb', NULL, 'text', 'sent', '2025-05-11 20:43:14', '2025-05-11 20:43:14', '2025-05-11 20:43:14', 0, 0, NULL, NULL, 'UPDATE', '2025-05-11 20:43:27');

-- --------------------------------------------------------

--
-- Table structure for table `tf_notifications`
--

CREATE TABLE `tf_notifications` (
  `ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `COUCH_ID` int(11) NOT NULL,
  `USER_NAME` varchar(255) NOT NULL,
  `TITLE` varchar(255) NOT NULL,
  `USER_R` int(11) DEFAULT 0,
  `COUCH_R` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tf_payments`
--

CREATE TABLE `tf_payments` (
  `id` bigint(20) NOT NULL,
  `tdate` datetime NOT NULL DEFAULT current_timestamp(),
  `Cust_ID` int(11) NOT NULL,
  `coachid` varchar(15) NOT NULL,
  `program` varchar(25) NOT NULL,
  `amount` int(11) NOT NULL,
  `paid` varchar(20) NOT NULL,
  `method` varchar(20) NOT NULL,
  `referenceid` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_payments`
--

INSERT INTO `tf_payments` (`id`, `tdate`, `Cust_ID`, `coachid`, `program`, `amount`, `paid`, `method`, `referenceid`) VALUES
(1, '2025-05-01 12:00:00', 1, 'COACH001', 'weightloss', 5000, 'YES', 'UPI', 'PAY001'),
(2, '2025-05-02 13:00:00', 2, 'COACH002', 'weightloss', 6000, 'YES', 'Card', 'PAY002');

--
-- Triggers `tf_payments`
--
DELIMITER $$
CREATE TRIGGER `tf_payments_before_delete` BEFORE DELETE ON `tf_payments` FOR EACH ROW BEGIN
  INSERT INTO `tf_payments_history` (
    `id`, `tdate`, `Cust_ID`, `coachid`, `program`, `amount`, `paid`, `method`, `referenceid`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`tdate`, OLD.`Cust_ID`, OLD.`coachid`, OLD.`program`, OLD.`amount`, OLD.`paid`, OLD.`method`,
    OLD.`referenceid`, 'DELETE', NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tf_payments_before_update` BEFORE UPDATE ON `tf_payments` FOR EACH ROW BEGIN
  INSERT INTO `tf_payments_history` (
    `id`, `tdate`, `Cust_ID`, `coachid`, `program`, `amount`, `paid`, `method`, `referenceid`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`tdate`, OLD.`Cust_ID`, OLD.`coachid`, OLD.`program`, OLD.`amount`, OLD.`paid`, OLD.`method`,
    OLD.`referenceid`, 'UPDATE', NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tf_payments_history`
--

CREATE TABLE `tf_payments_history` (
  `history_id` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `tdate` datetime NOT NULL DEFAULT current_timestamp(),
  `Cust_ID` int(11) NOT NULL,
  `coachid` varchar(15) NOT NULL,
  `program` varchar(25) NOT NULL,
  `amount` int(11) NOT NULL,
  `paid` varchar(20) NOT NULL,
  `method` varchar(20) NOT NULL,
  `referenceid` varchar(50) NOT NULL,
  `history_action` enum('UPDATE','DELETE') NOT NULL,
  `history_timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tf_referral`
--

CREATE TABLE `tf_referral` (
  `id` int(11) NOT NULL,
  `tdate` datetime NOT NULL DEFAULT current_timestamp(),
  `referrer_name` varchar(50) NOT NULL,
  `referrer_mobilenumber` varchar(20) NOT NULL,
  `coachname` varchar(50) NOT NULL,
  `coachid` varchar(20) NOT NULL,
  `referralcode` varchar(60) DEFAULT NULL,
  `iscoach` int(11) DEFAULT 2
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_referral`
--

INSERT INTO `tf_referral` (`id`, `tdate`, `referrer_name`, `referrer_mobilenumber`, `coachname`, `coachid`, `referralcode`, `iscoach`) VALUES
(1, '2025-05-01 14:00:00', 'Amit Sharma', '9123456789', 'Mike Wilson', 'COACH001', 'ref001', 0),
(2, '2025-05-02 15:00:00', 'Priya Mehta', '9234567890', 'Lisa Brown', 'COACH002', 'ref002', 0);

--
-- Triggers `tf_referral`
--
DELIMITER $$
CREATE TRIGGER `tf_referral_before_delete` BEFORE DELETE ON `tf_referral` FOR EACH ROW BEGIN
  INSERT INTO `tf_referral_history` (
    `id`, `tdate`, `referrer_name`, `referrer_mobilenumber`, `coachname`, `coachid`, `referralcode`, `iscoach`,
    `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`tdate`, OLD.`referrer_name`, OLD.`referrer_mobilenumber`, OLD.`coachname`, OLD.`coachid`,
    OLD.`referralcode`, OLD.`iscoach`, 'DELETE', NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tf_referral_before_update` BEFORE UPDATE ON `tf_referral` FOR EACH ROW BEGIN
  INSERT INTO `tf_referral_history` (
    `id`, `tdate`, `referrer_name`, `referrer_mobilenumber`, `coachname`, `coachid`, `referralcode`, `iscoach`,
    `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`tdate`, OLD.`referrer_name`, OLD.`referrer_mobilenumber`, OLD.`coachname`, OLD.`coachid`,
    OLD.`referralcode`, OLD.`iscoach`, 'UPDATE', NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tf_referral_history`
--

CREATE TABLE `tf_referral_history` (
  `history_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `tdate` datetime NOT NULL DEFAULT current_timestamp(),
  `referrer_name` varchar(50) NOT NULL,
  `referrer_mobilenumber` varchar(20) NOT NULL,
  `coachname` varchar(50) NOT NULL,
  `coachid` varchar(20) NOT NULL,
  `referralcode` varchar(60) DEFAULT NULL,
  `iscoach` int(11) DEFAULT 2,
  `history_action` enum('UPDATE','DELETE') NOT NULL,
  `history_timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tf_session_token`
--

CREATE TABLE `tf_session_token` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `Cust_ID` int(11) NOT NULL,
  `session_token` varchar(255) NOT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `device_info` text DEFAULT NULL,
  `status` varchar(250) NOT NULL DEFAULT 'Login',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_session_token`
--

INSERT INTO `tf_session_token` (`id`, `user_id`, `Cust_ID`, `session_token`, `ip_address`, `device_info`, `status`, `created_at`) VALUES
(1, 1, 1, 'token-uuid-1234-5678-9012-345678901234', '192.168.1.10', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0.0.0', 'Login', '2025-05-04 04:30:00'),
(2, 2, 2, 'token-uuid-5678-9012-3456-789012345678', '192.168.1.11', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Safari/17.0', 'Login', '2025-05-04 05:30:00'),
(3, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3NDYzNTc1NzIsImV4cCI6MTc0NjM2MTE3Mn0._VRPlJ-bFKe8NBmxFknSweZmZ2-LePsoeHie91dSmbs', '157.48.161.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-04 11:19:32'),
(4, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2MzU3ODQzLCJleHAiOjE3NDYzNjE0NDN9.LVawP-AJv-TvFIwtBfi0KNf810e8AxruQIvdC4taoGc', '157.48.161.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-04 11:24:04'),
(35, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ2NTUyMTkyLCJleHAiOjE3NDY1NTU3OTJ9.oS7_YkT_LX7dvvxgx5-pGsvXemdRP8PaUOQgm1ziAy4', '117.99.203.82', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-06 17:23:13'),
(78, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3MTQxNDIzLCJleHAiOjE3NDcxNDUwMjN9.5TVPFVcuRebzsBgUDBqk4MZxPev_qjIX7666w_8aL3w', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-13 13:04:04'),
(79, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ3MTk0NDA3LCJleHAiOjE3NDcxOTgwMDd9.aJccxN_6ZN9poCARc9TA0AGKPmavuLMdbQu1zVtVhlc', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-14 03:47:09'),
(80, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ3MTk1NzE1LCJleHAiOjE3NDcxOTkzMTV9.o1SGJ-LD0kQNmjsrTBox3-Wu0FgxlnDDKyUWaPFdhVs', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-14 04:08:57'),
(81, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ3MTk1NzE2LCJleHAiOjE3NDcxOTkzMTZ9.zRNdsD0ndrfUl8ek8zcsxFg5zV694ERI7oSHvGObntg', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-14 04:08:57'),
(82, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ3MTk1NzIxLCJleHAiOjE3NDcxOTkzMjF9.DIxcPPgkwbPJ3_cz6TMO8TQjooxKpRrUdndxpCjb62I', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-14 04:09:02'),
(83, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ3Mjg3NTQ2LCJleHAiOjE3NDcyOTExNDZ9.5qKJ_jfH8JMM1ydr9eSF3TFsswFL_UivGc3vZy4MOqM', '106.195.74.15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-15 05:39:06'),
(84, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ3Mjg3NzI3LCJleHAiOjE3NDcyOTEzMjd9.wHFgHcAjJeP03tl5GeA9wLTYybWF8EI6pfh4X5hE6oM', '106.195.74.15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-15 05:42:08'),
(85, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3MzAzNzQ5LCJleHAiOjE3NDczMDczNDl9.L1UKjCBbfzEqcOmJkaKPX7e21sqaO_TI8s1I4hkAWUU', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-15 10:09:30'),
(86, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3MzAzNzUyLCJleHAiOjE3NDczMDczNTJ9.nT0dd4nYMSKTA3G2nSeHhaEEhWgZtjq8sgaoL0kNxfU', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-15 10:09:33'),
(87, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3MzAzNzU5LCJleHAiOjE3NDczMDczNTl9.fowO_g8ltdgnAlsjnwRGe8GrlIx0m0bfdIuiiqPqlco', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-15 10:09:40'),
(88, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3MzAzNzYwLCJleHAiOjE3NDczMDczNjB9.4zj9yweVhTIQEXhqX7ToSHODOxyYgpz-A4xIvrNB3Vk', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-15 10:09:41'),
(90, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3MzAzNzYxLCJleHAiOjE3NDczMDczNjF9.dYaMaOfKV38AerGDXc5_X3QClfBfJWTpu7dcNzy9jpE', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-15 10:09:42'),
(93, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3MzAzNzgxLCJleHAiOjE3NDczMDczODF9.PnobM8Q7TkzEkiTfXLURk-sYidUdb7IzkZJte3Y0WS4', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-15 10:10:02'),
(95, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3MzAzNzgyLCJleHAiOjE3NDczMDczODJ9.3zksKsBkuJJgUGSXQsw43BQRcLD7hjMddZHn5uv_ikU', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-15 10:10:03'),
(99, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3NDE4MTgyLCJleHAiOjE3NDc0MjE3ODJ9.AXWTU4TgL0j9EX1v6wsihh7vQRuADXcpHPPUgO2XyrE', '27.59.150.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-16 17:56:23'),
(100, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3NTQyMDk2LCJleHAiOjE3NDc1NDU2OTZ9.INE37Bpl4ooxRR-lJLxXuoscsTgi4-CsYLm1yEgp4I0', '106.216.195.245', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-18 04:21:37'),
(101, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4MTEzMTk1LCJleHAiOjE3NDgxMTY3OTV9.Eh9ss8Bryn0zLUrTJChiYWk7xCsTIo4dgJ6j1zyOiEU', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-24 19:00:16'),
(102, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4MTEzMjExLCJleHAiOjE3NDgxMTY4MTF9.i0XpJf9TpChjmCHDQTNcHcPaQfVwtDeYvdgs5ALU1kE', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-24 19:00:32'),
(103, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4MTEzNzAxLCJleHAiOjE3NDgxMTczMDF9.p336W8r6clJML1m9WNdloz1VbgA9J-lAgtn5gY9pwN4', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-24 19:08:42'),
(104, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4MTEzNzQ1LCJleHAiOjE3NDgxMTczNDV9.E0EML5aUTMnUATcFGLH-9i7f1IIn_dQ5tucOXuWoQrs', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-24 19:09:26'),
(105, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4MTE1NzgwLCJleHAiOjE3NDgxMTkzODB9.0ZzVOeKrNC6icSmJYlLuDAAxDzzAaAJLPr5HeA5yzrw', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-24 19:43:21'),
(106, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4MTE1Nzg1LCJleHAiOjE3NDgxMTkzODV9.Q1f6pWKimp1-RtdtWQqw9LGY0RkC4FZkXhysnl-dLsw', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-24 19:43:26'),
(107, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4MTE1Nzk3LCJleHAiOjE3NDgxMTkzOTd9.TW5KbzigkNkBvSJKb_SC50bWlp3hA6iiynb_VhIu_JY', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-24 19:43:38'),
(108, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4MTYyMjkwLCJleHAiOjE3NDgxNjU4OTB9.2w7k34bWSlM_QQLgBzZQG-D6tmyr1E8rtW_EGaTjfyM', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-25 08:38:31'),
(109, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4MTYyMjk2LCJleHAiOjE3NDgxNjU4OTZ9.wwFL1W6slc1vh8Xd4kgXFtjt8icAV7FbKnmLIwAQsdU', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-25 08:38:37'),
(110, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4MTYyMzA0LCJleHAiOjE3NDgxNjU5MDR9.fSd9SaEOSpyUedcJMUUqeYs51MEkRZTIvtSkzn-AvaM', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-25 08:38:45'),
(112, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ4MTY1MDgzLCJleHAiOjE3NDgxNjg2ODN9.D1oks5LvPRLFh3VoGvgWbzzJa6ibm07f3CrpMEeumsM', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-25 09:25:04'),
(113, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4MTY1MTM4LCJleHAiOjE3NDgxNjg3Mzh9.t2KbUDq89eGNsLwKCWPvj2CRGOT224-nNuj1eZvmoBk', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-25 09:25:59'),
(114, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4MzY0OTk0LCJleHAiOjE3NDgzNjg1OTR9.vNaW--CRdxZ4dTwvdy1rTM11MvqMlUvDt-8lrxLgPFM', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-27 16:56:46'),
(115, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4MzY1NjUxLCJleHAiOjE3NDgzNjkyNTF9.51hk02zIathqrQMx27wUhGiaOTkUU1TUV6LaUjxHJFw', '106.221.188.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-27 17:07:32'),
(116, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ4MzY1OTE5LCJleHAiOjE3NDgzNjk1MTl9.Cb0JQW-lwvSoFPeWI6q8Una6VlSTXLXBH2Fyel_yZeI', '106.221.188.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-27 17:12:00'),
(117, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4ODcwMDA2LCJleHAiOjE3NDg4NzM2MDZ9.ldDYgA2_Y-P2YXS-77mfRlH9h2_wUJhplCAL2qg82_I', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Login', '2025-06-02 13:13:26'),
(118, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4ODcwMjA3LCJleHAiOjE3NDg4NzM4MDd9.LpbdspD8ymHHlsX2jOurG0Dy8hYkSLHqUnk5bQSyCeU', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Login', '2025-06-02 13:16:47'),
(119, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ4OTY3MDIxLCJleHAiOjE3NDg5NzA2MjF9.IJf5w3XUeBbLRm_6Qx-Uh3EJ8vX7zdNWQXqS_cD5do0', '223.185.45.196', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Login', '2025-06-03 16:10:22'),
(120, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4OTY3MDI2LCJleHAiOjE3NDg5NzA2MjZ9.kD6KB7ZzP4o1zW9Q1jLcZdH5MbwkhxmMig1cmDB48sA', '223.185.45.196', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Login', '2025-06-03 16:10:26'),
(121, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4OTY3MjY1LCJleHAiOjE3NDg5NzA4NjV9.pxFznKf5ckWdZ2WFIG3_1zi6vNO5oprBSGgnMUQZgxM', '223.185.45.196', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Login', '2025-06-03 16:14:27'),
(122, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4OTY3NDUzLCJleHAiOjE3NDg5NzEwNTN9.3tFUcF6bThIHdZums92w1i7tcm6dAwv9xPuYFGFNJAQ', '223.185.45.196', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Login', '2025-06-03 16:17:34'),
(123, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ4OTY3NDYxLCJleHAiOjE3NDg5NzEwNjF9.nWst_Ams096X9lxBNAqyiv5N-1zlnCjmywpwnoyk4-M', '223.185.45.196', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Login', '2025-06-03 16:17:42'),
(124, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ4OTY3ODQwLCJleHAiOjE3NDg5NzE0NDB9.SsVH5pNOG2zHUYkvGiFPSocKOG3s0Vin6fY4VyQKyfY', '223.185.45.196', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Login', '2025-06-03 16:24:01'),
(125, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ4OTY3ODU0LCJleHAiOjE3NDg5NzE0NTR9.TjswcTTiWJVkj7AAG-fPV8epHdNWS3Sq-vPhJFAjrow', '223.185.45.196', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'Login', '2025-06-03 16:24:14'),
(126, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1MjQyNDg2LCJleHAiOjE3NTUyNDYwODZ9.zDy1XSTNvufM9mEokGHeToAKztDv4JVK9maJPqatnkQ', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-08-15 07:21:26'),
(127, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1MjQzMDE4LCJleHAiOjE3NTUyNDY2MTh9.EjhfdYsilx_JeOjmgLkasFEenAe7DijjBlgFVdzx_P0', '117.99.194.212', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-08-15 07:30:18'),
(128, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1MjQ0ODg1LCJleHAiOjE3NTUyNDg0ODV9.ijOWQKffNF7mbFrZoaLBXKUt4w7UdIHFgHHJSXw6NfA', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 08:01:26'),
(129, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1MjUwNTQ2LCJleHAiOjE3NTUyNTQxNDZ9.TV4oaFZ5b4WMkBLLp46hJ12JidYd14nHcFD7m7H3gdg', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 09:35:47'),
(130, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1MjUyMDgxLCJleHAiOjE3NTUyNTU2ODF9.Tgm5cn6_L9aRleSkZqUUV8OBvSzOvQX0JJd3mPCZRN0', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 10:01:21'),
(131, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1MjUyMTM4LCJleHAiOjE3NTUyNTU3Mzh9.v6ulbXJ2v6iQkjnVoPc0RIRl0AJnypcxZm_9oczuTNc', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 10:02:19'),
(132, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU1MjUyNTgxLCJleHAiOjE3NTUyNTYxODF9.H5eujZ7cVsqZ9x_oG3p-stmYc62iw-f7GkllgRomiKo', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 10:09:42'),
(133, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU1MjU0MDcwLCJleHAiOjE3NTUyNTc2NzB9.6asV-mkgPJg8_pivynQyn8ZDXHFLjPUPo-wQvQo1AT4', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 10:34:30'),
(134, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU1MjU3NzUwLCJleHAiOjE3NTUyNjEzNTB9.7Baund5T8gW8L0CgU_kP-Tv_S2nha1q2T5aza6C3y-U', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 11:35:52'),
(135, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU1MjU3NzUyLCJleHAiOjE3NTUyNjEzNTJ9.TkJmzmU2xG3OHSN1nz7osYn7gEeeeMDx8bpwIOyPhqo', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 11:35:52'),
(136, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU1MjU4MDMyLCJleHAiOjE3NTUyNjE2MzJ9.TLJSRZZAsz7uEXnqphRzufwrGvzifYml5cEKuCcZGJY', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 11:40:33'),
(137, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU1MjU4MjM1LCJleHAiOjE3NTUyNjE4MzV9.4lefokp6W3K_kkLa-qFXMt_92Cn8ozRxIknt03e339o', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 11:43:56'),
(138, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU1MjYwNDgxLCJleHAiOjE3NTUyNjQwODF9.dNlcbkxpJJUfY2md8rZx0ac77hxA20Q5B9rwBbBE7hc', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 12:21:22'),
(139, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU1MjYwNzkyLCJleHAiOjE3NTUyNjQzOTJ9.coyE_9p2l018kiJUO7-ksOoyh__0vhnFwR9_XG22kZw', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 12:26:33'),
(140, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU1MjYyNDUzLCJleHAiOjE3NTUyNjYwNTN9.8dLq1tuFE7laxtJsuXAR6W4rQ-FMTV4VNeLiZFT30u8', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 12:54:13'),
(141, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU1MjY1ODk2LCJleHAiOjE3NTUyNjk0OTZ9.2g7oExnFpoY-0mJ-yKYC4jNLbhnFkF65mHhywcbR6pw', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 13:51:37'),
(142, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1MjY1OTEzLCJleHAiOjE3NTUyNjk1MTN9.BIKAWmJylysEd-krP1zj8CjC3mqd4Owuu-Ym3g_vKWM', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 13:52:01'),
(143, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1MjY1OTExLCJleHAiOjE3NTUyNjk1MTF9.9wFp_iauW9kBCFqL94ALo982y8VrjN0SaQfw7hmRf9g', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 13:52:01'),
(144, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1MjY1OTE1LCJleHAiOjE3NTUyNjk1MTV9.rT-H3JNukuKADAITmYMLBQy6VDilOIABjDLyVgTesjc', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 13:52:02'),
(145, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1MjY1OTE3LCJleHAiOjE3NTUyNjk1MTd9.qdV1ZU4oL9oB-WfLNNAWGk4PKOsW45shGP3QEU1pLgc', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 13:52:02'),
(146, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1MjY1OTE4LCJleHAiOjE3NTUyNjk1MTh9.4S17GEE297UwcU_FILd-E5FW36B9r-lzHwgNVKX_rAk', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 13:52:02'),
(148, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1MjY1OTIyLCJleHAiOjE3NTUyNjk1MjJ9.ps5a1kkPeSYakGgpxQ1MCJRjZNaVPmC80m5_h1s454M', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 13:52:02'),
(153, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU1MjY1OTYwLCJleHAiOjE3NTUyNjk1NjB9.dvNkmhX3uPJwSp48hK-89_lK3V54m9-kFynTK_yOwB4', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 13:52:41'),
(154, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU1MjY2NjU3LCJleHAiOjE3NTUyNzAyNTd9.-nWh2RTWXJTt6sk6De2eNxZ3obu27-0qOYUYmQNs1wc', '223.185.48.216', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-15 14:04:18'),
(155, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1NTAwMjkzLCJleHAiOjE3NTU1MDM4OTN9.vH2CJHIgUA5lMbtRIR5-nGcppxaU1mlWVakXZAkPC30', '223.228.118.236', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-18 06:58:15'),
(156, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1NTAwMjk0LCJleHAiOjE3NTU1MDM4OTR9.VqpusrrxbMwRRUyFg3o1iXfqApeIqkjGtnxz-b4JRLk', 'Unknown', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-18 07:00:28'),
(157, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1NTAwNjA4LCJleHAiOjE3NTU1MDQyMDh9.YLktfuz_yz-QrwacN_2w-EoQ-bxMjlxFMrEP6z0UnMM', '223.228.118.236', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-18 07:03:28'),
(158, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1NTAwNjA2LCJleHAiOjE3NTU1MDQyMDZ9.VH69NZjlTKYAhyv69gz2lNsoV91SoIDfAxAtq6VNubs', 'Unknown', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-18 07:05:40'),
(159, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU1NTAxNjgwLCJleHAiOjE3NTU1MDUyODB9.VOtQ4wDsUpNb8MG2NYhbAEjWOkxNKlyBJ6SYq4FxyQA', '117.230.91.36', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-18 07:21:22'),
(160, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU1NTAxNjgyLCJleHAiOjE3NTU1MDUyODJ9.4FtvwSJ-N4EpJhUWaNlt3sDPBuw1REXnoMUlLBM8c7U', '117.230.91.36', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-18 07:21:23'),
(161, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1NTA0NDA2LCJleHAiOjE3NTU1MDgwMDZ9.WNqTULzAmQdR2HPRNCVBbYqwtZnshQnkgkm6lV33_H8', '223.228.113.236', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-18 08:06:47'),
(162, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1NTA0Mzk5LCJleHAiOjE3NTU1MDc5OTl9.fer1_3CQ1RrSVZsjInhy6y9wC9G9wccQ2lo3VzRalZw', 'Unknown', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-18 08:08:53'),
(163, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU1NTA0NDAyLCJleHAiOjE3NTU1MDgwMDJ9.cBgS8KryxLMZJMlyZl-0WPsBu2-TrT_Q2kSk_uc8O_A', 'Unknown', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-18 08:08:57'),
(164, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU1NTA2MDI1LCJleHAiOjE3NTU1MDk2MjV9.uKzfFkq0QAp0iVpRjCFYTrMtXpDOlKuM3sUFS0rHpf4', '223.228.118.184', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-08-18 08:33:46'),
(165, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU2MDM0OTE1LCJleHAiOjE3NTYwMzg1MTV9.yMYXWKnTpGjcbJbXYt_9APqU6AYFf2S6308Y22VuPJE', '117.99.195.35', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-08-24 11:28:36'),
(166, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU2MTE4NzM3LCJleHAiOjE3NTYxMjIzMzd9.bXCZqihJX18UUuaOIjQtXmOnDGRWhVkSGNmSUgGfA8w', '106.200.31.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-08-25 10:45:38'),
(167, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU2MTE5OTU5LCJleHAiOjE3NTYxMjM1NTl9.0_mPf0NGx-GpZHRVRJNj4UtOzpt9wzaD1zqdosST50g', '106.200.31.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-08-25 11:05:59'),
(168, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU2Nzk2MjkxLCJleHAiOjE3NTY3OTk4OTF9.CS_lJswnarO0G22TSrelqd_LZbmjP_aVdLeIUE912Iw', '106.200.31.147', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-02 06:58:12'),
(169, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU2OTE5NTcyLCJleHAiOjE3NTY5MjMxNzJ9.ygRk5IF06HpnoGyi06l9Nn0b5XiH3wZnKGRgkGE4Ws0', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-03 17:12:53'),
(172, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU2OTIxMDg1LCJleHAiOjE3NTY5MjQ2ODV9.DsBM0f69jY1eWYvJWmQpchFRVkt_LcZXNBclw42qc0I', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-03 17:38:05'),
(174, 98, 98, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OTgsImlhdCI6MTc1Njk3MDk0MSwiZXhwIjoxNzU2OTc0NTQxfQ.eO4JNefPd9RLjNFTVkl_jfnq5_e8u8E1K7icww5diZA', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-04 07:29:01'),
(175, 98, 98, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OTgsImlhdCI6MTc1Njk3MjUxOSwiZXhwIjoxNzU2OTc2MTE5fQ.00ZU_T1wNv0B_j4H6_paBx6SVjLdwtJqXLC4RHohEes', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-04 07:55:19'),
(176, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU2OTcyODY2LCJleHAiOjE3NTY5NzY0NjZ9.l3KS3pr7rtOnB5Zb07KBHTW7Bw3o3kPyGnq8XD0ebhM', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-04 08:01:07'),
(177, 98, 98, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OTgsImlhdCI6MTc1Njk3MzExMiwiZXhwIjoxNzU2OTc2NzEyfQ.uCgFJin0esKPq3OD9dnx6poSxpjMWuCN0oSvjDm0zZQ', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-04 08:05:13'),
(178, 98, 98, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OTgsImlhdCI6MTc1Njk4NTc4OSwiZXhwIjoxNzU2OTg5Mzg5fQ.LQjKAN6Hh4C3xmfO-MPZS-ffK75HGbOP_qtTCS1pc8o', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-04 11:36:29'),
(179, 99, 99, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OTksImlhdCI6MTc1Njk4NjA4MCwiZXhwIjoxNzU2OTg5NjgwfQ.URnqOtr6Gbl_DseSpfAzaAjVffl9qP8f9-0SCC5q4aY', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-04 11:41:21'),
(180, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU2OTg2ODY3LCJleHAiOjE3NTY5OTA0Njd9.yKNXUpOGZSMXcbjsBPaQrZzZgsUu2r_xFrM8kqUrRYQ', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-04 11:54:27'),
(181, 99, 99, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OTksImlhdCI6MTc1Njk4Njg4NiwiZXhwIjoxNzU2OTkwNDg2fQ.zCb4ZfIB6eij9E0tysrHnlDyOb2q0wzZB4GIH10pV38', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-04 11:54:47'),
(182, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU2OTg3MjQwLCJleHAiOjE3NTY5OTA4NDB9.C9fuH_BbCH7IIxEGxSTpJUsnibT3sgq_mUbRnJ4rIYU', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-04 12:00:41'),
(183, 99, 99, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OTksImlhdCI6MTc1Njk4NzMyNiwiZXhwIjoxNzU2OTkwOTI2fQ.0n1aAGCPyhN39tIY7VA3Wh7xQGOvzPQmSMAiqEn_ez0', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-04 12:02:06'),
(184, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU2OTg4NDQxLCJleHAiOjE3NTY5OTIwNDF9.U-tG3JyieItIFmgbFxf7oioUCtWG3TE9x52adXaHxEs', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-04 12:20:42'),
(185, 103, 103, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTAzLCJpYXQiOjE3NTY5ODg4NzcsImV4cCI6MTc1Njk5MjQ3N30.hIyLJ-zbl3bOJq8RloI947xOqwcckHuBBBSxbcgzUvU', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-04 12:27:58'),
(186, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU2OTg5MTk1LCJleHAiOjE3NTY5OTI3OTV9.EVkOZZskaDqZZde7Aoviph5gkBM55viQgTbl3x-s9xk', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-04 12:33:15'),
(187, 98, 98, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OTgsImlhdCI6MTc1NzAwMTQ4NiwiZXhwIjoxNzU3MDA1MDg2fQ.75RRB7pFOiS_0IRys8YJrm6RcacDOdGQHXkOlCJYfZ0', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-04 15:58:08'),
(188, 104, 104, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTA0LCJpYXQiOjE3NTcxNjc5NjEsImV4cCI6MTc1NzE3MTU2MX0.SE_HrdfdyG5NH3m7LcplZCyTSh-rJBebE9zxIOA0qf4', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-06 14:12:42'),
(189, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3MjQ2MzExLCJleHAiOjE3NTcyNDk5MTF9.QzbXVWmH8kyicwwpvQ7dfNlTc3hcweGBkMi1ck3I7U4', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-07 11:58:32'),
(190, 103, 103, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTAzLCJpYXQiOjE3NTcyNDYzNDMsImV4cCI6MTc1NzI0OTk0M30.uXZSChrpfvmMSn2PGBcMBKDznr6AcJp-CfKNtCrpuOg', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-07 11:59:03'),
(191, 104, 104, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTA0LCJpYXQiOjE3NTcyNDYzODYsImV4cCI6MTc1NzI0OTk4Nn0.kT3BZq0aKmQd7QPxF6YsnJ1gNZQvc9QazFJ3ha8kTuE', '223.185.48.14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-07 11:59:46'),
(192, 104, 104, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTA0LCJpYXQiOjE3NTcyNjAzMjIsImV4cCI6MTc1NzI2MzkyMn0.mw0j6xHJAc6XxCKj_RWNcmudLW0FbVsJ2AGNpsC0csg', '223.185.46.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'Login', '2025-09-07 15:52:04'),
(193, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTE5NTg3LCJleHAiOjE3NTc5MjMxODd9.o7f9pnkNqZIilp3dBw53EP3bwcAoxuIBdp5905HhNvA', '106.195.67.236', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 06:59:48'),
(194, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTE5NzYzLCJleHAiOjE3NTc5MjMzNjN9.D24zIgrA3ZE0nXIWsu9xUVCy_orp17pmlUzKlRU7XXc', '106.195.67.236', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 07:02:44'),
(195, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTIwMjI0LCJleHAiOjE3NTc5MjM4MjR9.foc6MuJ3CBrNJPte8AuTxS4-2axWxjKa9AguSYC1Bc0', '106.195.67.236', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 07:10:25'),
(196, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTIwNDIyLCJleHAiOjE3NTc5MjQwMjJ9.4IPdWiTXBzjYuG6BFT4xa8K9YBzFRo0HL8SrWrLE98E', '106.195.67.236', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 07:13:43'),
(197, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTMxNzUwLCJleHAiOjE3NTc5MzUzNTB9.yUivcVqWPUTOP5nhWKSgTLvCyyccXoLea9vSqGD3Twg', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 10:22:31'),
(198, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTMxOTk0LCJleHAiOjE3NTc5MzU1OTR9.PDvUzQTs2RNR8xCuGIJWA8ntrk-ITdB2-KWadE0IrGE', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 10:26:35'),
(199, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTMyMjMzLCJleHAiOjE3NTc5MzU4MzN9.f0N859MVjAiDh9cTxe0CmqoF1RTpJ-gxHu1U4778w2g', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 10:30:33'),
(200, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTMyMzI5LCJleHAiOjE3NTc5MzU5Mjl9.nTtebS5MppChlWf-Gs4TEmDGNWdGj3Bgc6SYtaF9zPE', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 10:32:10'),
(201, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTMyNDM2LCJleHAiOjE3NTc5MzYwMzZ9.oBMFqEh8Pu7EIk7Ola0YGa9SBN4ZxhmJ0yGXhfZ1GPg', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 10:33:57'),
(202, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTMyNzI5LCJleHAiOjE3NTc5MzYzMjl9.pkkuE8hIr9aF2KfCYv_7j2iJMUcxuWhHhQvALxb5CJw', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 10:38:49'),
(203, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTMyNzczLCJleHAiOjE3NTc5MzYzNzN9.O_sFRflmKEa2jnts6i5C5oYqEh2eZHb2I2H107k8-a0', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 10:39:33'),
(204, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTMyODI4LCJleHAiOjE3NTc5MzY0Mjh9._ccIhCPnwwsVlOeMvgh5nQy1sFdJQAz3xOqbAGmsp-4', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 10:40:28'),
(205, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTMyOTAzLCJleHAiOjE3NTc5MzY1MDN9.2oEmYeSFfvOSIQqKpveyzGo3gly35h3mBrAcr0ALPU4', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 10:41:44'),
(206, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTMzMDE4LCJleHAiOjE3NTc5MzY2MTh9.Jg99BVX_sijvk2cOgMNds_2YySWYsNvWZbm-xRIXVE4', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 10:43:39'),
(207, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTMzMjg2LCJleHAiOjE3NTc5MzY4ODZ9.PwD-wugoJlscOstL4OiS271zDVFxJqj13zeLn8CbqMw', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 10:48:07'),
(208, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTM0NjMxLCJleHAiOjE3NTc5MzgyMzF9.2SNmUSUQqgY9kvC27Y0reNW26903-nibWh-8fZdTaFI', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 11:10:32'),
(209, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTM1NTQ0LCJleHAiOjE3NTc5MzkxNDR9.YGRoI-XM1BUkML-5VF9NSxM_IOEYbz12Na0QUMotGrQ', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 11:25:45'),
(210, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTM1Njk4LCJleHAiOjE3NTc5MzkyOTh9.fkuJP2tYEpteiama7KyfgoS-Y7jy_bXsnmlKQnnJM3c', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 11:28:19'),
(211, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTM1OTgxLCJleHAiOjE3NTc5Mzk1ODF9.QTayw79pkVnjRK3eFH2z3a8Wyq8jSrLYKgEFzWLpI5M', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 11:33:02'),
(212, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTM2MzE3LCJleHAiOjE3NTc5Mzk5MTd9.WPhU-DiXna4uHEbxdymC4elOZJVZadVDLBu30xrUATc', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 11:38:38'),
(213, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTM2NDk3LCJleHAiOjE3NTc5NDAwOTd9.aJ7L42lHIzAwGRUqPqs-LaNAYqfbnFQ9UWYM8vhNW1c', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 11:41:38'),
(214, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTM2NzkyLCJleHAiOjE3NTc5NDAzOTJ9.gdqknWRnolg5P_Z-Cujnm6QBI3lWororCs3R26DmTtI', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 11:46:32'),
(215, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTM2ODU5LCJleHAiOjE3NTc5NDA0NTl9.zJEjBJ_cv_Ry52exrmVk0G5GJBxenlXbMKQox-Adw2c', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 11:47:40'),
(216, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTM3MTExLCJleHAiOjE3NTc5NDA3MTF9.TGFxihgDW3VE_HeCUyf00yeQV0hVBIMKGAAP14V74aI', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 11:51:52'),
(218, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTM3MTMzLCJleHAiOjE3NTc5NDA3MzN9.OCrJWatKhGrr5k0WhnOQiiv_0QEuLedtCUtpxuC-_3U', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 11:52:14'),
(219, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTM5OTU0LCJleHAiOjE3NTc5NDM1NTR9.S1FxAioIex57uYJFdz5iImshgAyZx3MGH8xCrEmVVPc', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 12:39:16'),
(220, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTQwMTQzLCJleHAiOjE3NTc5NDM3NDN9.kwZddnsGzUCoQo7Np_WkQb3xh2NREJHec7cNi9csoXs', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 12:42:23'),
(221, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU3OTQwNDcwLCJleHAiOjE3NTc5NDQwNzB9.WMnef5IS985SIiY7CG9wMMg_1j4norlkuR6D35MWC9s', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 12:47:51'),
(222, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTQwNTAwLCJleHAiOjE3NTc5NDQxMDB9.P87bLyv4NXlCXfdEo0LCO0JB3g_NyfWNVMCHUZx7rSk', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 12:48:20'),
(223, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTQxNTYwLCJleHAiOjE3NTc5NDUxNjB9.xAISNEf191sfG6lRLURW6woBgAaphtJebaKgRfRCxZU', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 13:06:00'),
(224, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzU3OTQxNTY2LCJleHAiOjE3NTc5NDUxNjZ9.hQmvKETnY50s8ChwQVyzSQ5xJ-6TdXK6zPkZcxRt3hU', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 13:06:06'),
(225, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTQyMzkwLCJleHAiOjE3NTc5NDU5OTB9.huvR7Gt-LPRxxjrO8UDf9pi3nxPxtsXJcvE06vxZqEE', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 13:19:51'),
(226, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTQ0MDk5LCJleHAiOjE3NTc5NDc2OTl9.DgEA4G4OTGvZxYv0SFYjGFUvVGFeKo6mDVDfslgggMM', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 13:48:19'),
(227, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTQ0MzM4LCJleHAiOjE3NTc5NDc5Mzh9.0PZpL8jv-kCDl2vxnQfcC32AakU2m5T5XweO-xiuFRg', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 13:52:19'),
(228, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTQ0Njg2LCJleHAiOjE3NTc5NDgyODZ9.POwdOUQ4rE-o5youunWs4K6wV7qJJ0ECPNiaP6nXgS0', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 13:58:06'),
(229, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTQ0NzI5LCJleHAiOjE3NTc5NDgzMjl9.mVJbdvb53yn20fP0x0CpzgvvZrEZvKobsbqM78_iRNE', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 13:58:50'),
(230, 98, 98, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OTgsImlhdCI6MTc1Nzk0NzQzNCwiZXhwIjoxNzU3OTUxMDM0fQ.qivtK8_lKsL1G10owJwtVIi7AhqEIV84mp6juXmQUiA', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 14:43:55'),
(231, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU3OTQ3NDkyLCJleHAiOjE3NTc5NTEwOTJ9.NesGYR3u3y0p2gg9GuFMO72PkZNgTlMWiHcpD_EQefw', '106.195.79.138', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-15 14:44:53'),
(232, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU5MjI3NTY0LCJleHAiOjE3NTkyMzExNjR9.r1txXQQAZpV8aQHVSXH2VOPbOAOyDF-JYIfoTid3aH8', '115.97.187.97', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-09-30 10:19:25'),
(233, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU5MzM5ODczLCJleHAiOjE3NTkzNDM0NzN9.iJ2aanHD7OfuG7jZ1GnAeAe28hylDWiZt3wWRfydvOI', '115.97.187.97', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-10-01 17:31:13'),
(234, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU5MzM5ODc0LCJleHAiOjE3NTkzNDM0NzR9.MQN83_AFnWVLDhkF9xj2NSrZKErbGfkqjI-MDSfhmlY', '115.97.187.97', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-10-01 17:31:15'),
(235, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU5MzM5OTIwLCJleHAiOjE3NTkzNDM1MjB9.WXODk8PuTFAcfUV0MS1eywLztdkPvxAvBT93hynYFDc', '115.97.187.97', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-10-01 17:32:00'),
(236, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU5MzkwNDk0LCJleHAiOjE3NTkzOTQwOTR9.UE6Tm3tVnepq8O00Lscfz3aTIZ49PLNMXcECyL-ektI', '115.97.187.97', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-10-02 07:34:54'),
(237, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU5NDExOTc5LCJleHAiOjE3NTk0MTU1Nzl9.KwXiy3OOQM1O2QIbky2cPnvJouDV0GnP4FN5DuvFZuA', '115.97.187.97', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-10-02 13:32:59'),
(238, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU5NDg4OTAyLCJleHAiOjE3NTk0OTI1MDJ9.nhfDJSZjnK_19AcnYSksYylzKOFuIGKfFgM8e71DHiI', '115.97.187.97', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-10-03 10:55:02'),
(239, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU5NDg4OTcyLCJleHAiOjE3NTk0OTI1NzJ9.X9V7qvhLUCpxRlPr-ymkYjDego4HG0ZzbFNqk09C6rI', '115.97.187.97', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-10-03 10:56:13'),
(240, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU5Njg2Mzg4LCJleHAiOjE3NTk2ODk5ODh9.VpJKTEr8RWzA1Gnd_g9u-JWhpvnBWjhbZHcO-hw7U4Y', '115.97.187.97', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'Login', '2025-10-05 17:46:29'),
(241, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU5NzUxMDM1LCJleHAiOjE3NTk3NTQ2MzV9.coqgSb6L0CjxuPdGjTYnNT_RB7IWIXMlStvTSKC7Rvo', '115.97.187.97', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-10-06 11:43:56'),
(242, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU5NzU0MTY3LCJleHAiOjE3NTk3NTc3Njd9.S2dfA_bSDxxSJdmEV14L3UKgB4Mv6HDqBm2eMS9b6YI', '115.97.187.97', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-10-06 12:36:07'),
(243, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU5NzU0NTMwLCJleHAiOjE3NTk3NTgxMzB9.TrFkXfIOWEJK7UaPzNAuC4nECY0NGwug6DgdsbgUuXY', '115.97.187.97', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-10-06 12:42:10'),
(244, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU5ODIyMDU1LCJleHAiOjE3NTk4MjU2NTV9.42Vh5rVn_PVYjOHVxw79903EwCon4Fo-g3FZ6_jcJjY', '115.97.187.97', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-10-07 07:27:36'),
(245, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzU5ODQyNjM1LCJleHAiOjE3NTk4NDYyMzV9.w_9d7c8Z8wi1XXj5ZCW2oy5ml8hC-oiBB7yufEtSl98', '115.97.187.97', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'Login', '2025-10-07 13:10:35');

--
-- Triggers `tf_session_token`
--
DELIMITER $$
CREATE TRIGGER `tf_session_token_before_delete` BEFORE DELETE ON `tf_session_token` FOR EACH ROW BEGIN
  INSERT INTO `tf_session_token_history` (
    `id`, `user_id`, `Cust_ID`, `session_token`, `ip_address`, `device_info`, `status`, `created_at`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`user_id`, OLD.`Cust_ID`, OLD.`session_token`, OLD.`ip_address`, OLD.`device_info`, OLD.`status`, OLD.`created_at`, 'DELETE', NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tf_session_token_history`
--

CREATE TABLE `tf_session_token_history` (
  `history_id` bigint(20) NOT NULL,
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `Cust_ID` int(11) NOT NULL,
  `session_token` varchar(255) NOT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `device_info` text DEFAULT NULL,
  `status` varchar(250) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `history_action` enum('DELETE') NOT NULL,
  `history_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_session_token_history`
--

INSERT INTO `tf_session_token_history` (`history_id`, `id`, `user_id`, `Cust_ID`, `session_token`, `ip_address`, `device_info`, `status`, `created_at`, `history_action`, `history_timestamp`) VALUES
(1, 14, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2MzYyMDg3LCJleHAiOjE3NDYzNjU2ODd9.ugonWrPKdaIa2G4O1Dnr7xhrMS-gGqvstQjjEmSxygc', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-04 12:35:08', 'DELETE', '2025-08-25 11:03:20'),
(2, 15, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2MzYyMTk1LCJleHAiOjE3NDYzNjU3OTV9.DVOgJtkM32kE0EwUMt33tOfbK63akuI4VdXyUUBoMb4', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-04 12:36:57', 'DELETE', '2025-08-25 11:03:20'),
(3, 16, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2Mzc0MTU1LCJleHAiOjE3NDYzNzc3NTV9.6ZEKAVeOlpkNMw8_sImTxH9_xiIHOXqEYQk6u7R3UXI', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-04 15:56:16', 'DELETE', '2025-08-25 11:03:20'),
(4, 17, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2Mzc0MTYyLCJleHAiOjE3NDYzNzc3NjJ9.cJYCMrCf4P-vWCUyOJuLCf5r6gZ__nnIHS7n_DqpTCU', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-04 15:56:23', 'DELETE', '2025-08-25 11:03:20'),
(5, 18, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NDIwMTIwLCJleHAiOjE3NDY0MjM3MjB9.KSQlhy-jQZoXsAt1ELMoQP-cFvMt3oluVOS06-X0oVM', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-05 04:42:00', 'DELETE', '2025-08-25 11:03:20'),
(6, 19, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NDIwNDEyLCJleHAiOjE3NDY0MjQwMTJ9.ALa4fRsN2eIgd5cgJeSWjDW2FhBF6-gbHWMGWRpqFSo', '117.99.203.55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-05 04:46:53', 'DELETE', '2025-08-25 11:03:20'),
(7, 20, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NDIyMTIzLCJleHAiOjE3NDY0MjU3MjN9.MOepQXUfy1tsKssB549WFw4m02gWXNCX13xKnOJsFCU', '117.99.203.55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-05 05:15:24', 'DELETE', '2025-08-25 11:03:20'),
(8, 21, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NDI5OTk0LCJleHAiOjE3NDY0MzM1OTR9.OyTQ5K7utlBOjWcXgYMFLpJOOWe-9SsPalpRBszuM3o', '117.99.203.55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-05 07:26:35', 'DELETE', '2025-08-25 11:03:20'),
(9, 22, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ2NDMwMDMwLCJleHAiOjE3NDY0MzM2MzB9._57RJYOnU6tGtbiMyV8ttePf_Z_4kRZdIEc3bgk58zw', '117.99.203.55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-05 07:27:11', 'DELETE', '2025-08-25 11:03:20'),
(10, 23, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NDMxMjU4LCJleHAiOjE3NDY0MzQ4NTh9.JIYk6b3sFfq9P5wMXfmXBIxqL12Tc1PxnJnESkpNsUM', '117.99.203.55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-05 07:47:39', 'DELETE', '2025-08-25 11:03:20'),
(11, 24, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NDQ2OTAzLCJleHAiOjE3NDY0NTA1MDN9.YwLBEu_uFqAPhzdFz3zpBEpjsfix5GoAIA6G1u3rQZQ', '117.99.204.55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-05 12:08:24', 'DELETE', '2025-08-25 11:03:20'),
(12, 25, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NDUyMTAyLCJleHAiOjE3NDY0NTU3MDJ9.UlWplNa83oY5LO5KHLUNJFgTDovMg93ADmB5LMt1Ses', '117.99.203.180', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-05 13:35:03', 'DELETE', '2025-08-25 11:03:20'),
(13, 26, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NDU4NTk5LCJleHAiOjE3NDY0NjIxOTl9.aLVN2-XR_7y5YVxJblKuQvUR_omcnA0uB7gv0x0F-Yc', '117.99.203.180', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-05 15:23:20', 'DELETE', '2025-08-25 11:03:20'),
(14, 27, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NDYyMTc1LCJleHAiOjE3NDY0NjU3NzV9._qFOMWxB347O4pXrROpyUTTf8o9VdLOyUl1ABU1Nl-0', '117.99.203.180', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-05 16:23:05', 'DELETE', '2025-08-25 11:03:20'),
(15, 28, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NDYyMTgxLCJleHAiOjE3NDY0NjU3ODF9.jTax2GamcDtNEsF39CEH6UYwhQm5O-fJRFw_zOP2C74', '117.99.203.180', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-05 16:23:14', 'DELETE', '2025-08-25 11:03:20'),
(16, 29, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NDY5Mzg1LCJleHAiOjE3NDY0NzI5ODV9.ejn82CA7cQKq3JqdS_zMEm5S2WvuQKsSxuiACbo5--Y', '117.99.205.180', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-05 18:23:06', 'DELETE', '2025-08-25 11:03:20'),
(17, 30, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NTE3NDYwLCJleHAiOjE3NDY1MjEwNjB9.fe8cf8Cdr8RwN2TbFHCMgVPKq9hIfDuvQHWLqx-O1jw', '117.99.200.215', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-06 07:44:22', 'DELETE', '2025-08-25 11:03:20'),
(18, 31, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NTM2NTExLCJleHAiOjE3NDY1NDAxMTF9.YVIA77WVaK1EJXRJDWOMSUSA4_A8JMI4HXyw2-sb3VU', '117.99.201.82', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-06 13:01:51', 'DELETE', '2025-08-25 11:03:20'),
(19, 32, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NTQ3MjQ2LCJleHAiOjE3NDY1NTA4NDZ9.3bj7JFfe2jtnow3xAx8oJE33xKi4JRh4UF5mGUbU_9U', '117.99.203.82', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-06 16:00:47', 'DELETE', '2025-08-25 11:03:20'),
(20, 33, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NTUyMDA4LCJleHAiOjE3NDY1NTU2MDh9.OCW3xQR-lvjfM04HK0JvyWjgT-vEe819NM0OlrJY3vA', '117.99.203.82', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-06 17:20:09', 'DELETE', '2025-08-25 11:03:20'),
(21, 34, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NTUyMTcyLCJleHAiOjE3NDY1NTU3NzJ9.lQkeR4k9lpa4UGEPygNvNoAZU46TnS8Ed_373LaUjfE', '117.99.203.82', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-06 17:22:53', 'DELETE', '2025-08-25 11:03:20'),
(22, 37, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ2NjE2NjQ3LCJleHAiOjE3NDY2MjAyNDd9.EGkepyUphlXV-QghAC7eePxU-As9tSuz4q4NRPO_Ni8', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-07 11:17:28', 'DELETE', '2025-08-25 11:03:40'),
(23, 38, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2ODk5NTQ0LCJleHAiOjE3NDY5MDMxNDR9.VAPaYuGbyJJUNJHzUJnGyQNnU_xmK_9YYUBVo5L1mnQ', '223.187.20.148', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-10 17:52:24', 'DELETE', '2025-08-25 11:03:40'),
(24, 39, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTQ2NjQzLCJleHAiOjE3NDY5NTAyNDN9.icAMAmGYteX_et-9aatk3bPEf5T2W6IXj5NqjnxgHGk', '::ffff:127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 06:57:23', 'DELETE', '2025-08-25 11:03:40'),
(25, 40, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTQ2NjM0LCJleHAiOjE3NDY5NTAyMzR9.uVVGPtxKY4xsZq9gmh9Iy_SR0yYispQ5ztwnN1RdgBg', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 06:57:35', 'DELETE', '2025-08-25 11:03:40'),
(26, 42, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTQ2NjM3LCJleHAiOjE3NDY5NTAyMzd9.nLAYHzqJq0Oo5runifARHXiewQH3rUcKgGG76Js8tB4', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 06:57:38', 'DELETE', '2025-08-25 11:03:40'),
(27, 43, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTU0NTQwLCJleHAiOjE3NDY5NTgxNDB9.ZpmlHYeN4xAn89F5k9d6X_z5WVLW-zmf0tft1ZhSYck', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 09:09:21', 'DELETE', '2025-08-25 11:03:40'),
(28, 44, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTU0NTQxLCJleHAiOjE3NDY5NTgxNDF9.3itrBfoqQhBrowOvoBM8fY97UjHiWfx33ZXl6U3yk0U', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 09:09:22', 'DELETE', '2025-08-25 11:03:40'),
(29, 45, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTU0NTQyLCJleHAiOjE3NDY5NTgxNDJ9.hv31mFlZUk1D5OXDVyI2a2PDX-ibho6v92el5jf8h2A', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 09:09:23', 'DELETE', '2025-08-25 11:03:40'),
(30, 48, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTU0NTQ4LCJleHAiOjE3NDY5NTgxNDh9.TTv-qDOjqCaPK_xuO7qEO5pv0rgcyzlS5gMe5-M96iQ', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 09:09:29', 'DELETE', '2025-08-25 11:03:40'),
(31, 49, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTU5MjM4LCJleHAiOjE3NDY5NjI4Mzh9.OUjbFn_nDxhGhY2i0W7OCLKOgBJrVB0bMPUlBX8nKqs', '157.48.152.154', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 10:27:19', 'DELETE', '2025-08-25 11:03:40'),
(32, 50, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTU5NjUyLCJleHAiOjE3NDY5NjMyNTJ9.vxe05cjkYy0eAktF_NflnsX02W_2tBwum8_D68rn8uI', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 10:34:17', 'DELETE', '2025-08-25 11:03:40'),
(33, 51, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTU5NjU2LCJleHAiOjE3NDY5NjMyNTZ9.cLxC4MYPNlqdSIM92iBwTDO1YH6c-oancC5JsOpJgSs', '157.48.152.154', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 10:34:17', 'DELETE', '2025-08-25 11:03:40'),
(34, 52, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTcwMTA3LCJleHAiOjE3NDY5NzM3MDd9.b8E0OuIeHXZcFrM7w36fLZw5_z_LeO1JtZcx7NPpCN8', '157.47.111.48', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 13:28:28', 'DELETE', '2025-08-25 11:03:40'),
(35, 53, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTc1NTU2LCJleHAiOjE3NDY5NzkxNTZ9.oLBZvfZYEF3Iw7Ma-gNHzzAqYGh00BHxrqWI6IIF6pU', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 14:59:38', 'DELETE', '2025-08-25 11:03:40'),
(36, 54, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTc1NTYyLCJleHAiOjE3NDY5NzkxNjJ9.2uyTXAX9Apqz3zCzcRm-25GAn6bJNxmnL7H_kQcXPjo', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 14:59:43', 'DELETE', '2025-08-25 11:03:40'),
(37, 55, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTc1NjA0LCJleHAiOjE3NDY5NzkyMDR9.IOTT7AduFThwADgRlYLhPTPVFrJWv8YtMLuikvnExYY', '::ffff:127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 15:00:04', 'DELETE', '2025-08-25 11:03:40'),
(38, 56, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ2OTc3Njc2LCJleHAiOjE3NDY5ODEyNzZ9.ND02XMMhOZ6fbc_knsLheG6bJSZkL4QIx9o-Q65WTK0', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 15:34:57', 'DELETE', '2025-08-25 11:03:40'),
(39, 57, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ2OTc3Njg1LCJleHAiOjE3NDY5ODEyODV9.qI8k-Ie0ghvcHRVwFfn53jOF99JxFhq4Q1OJ354q0Dc', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 15:35:06', 'DELETE', '2025-08-25 11:03:40'),
(40, 58, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTc3NzYyLCJleHAiOjE3NDY5ODEzNjJ9.CQrcFicEJpqwPNyI3WSDDSUzd6Ej6q2vtjrGOOUPIPs', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 15:36:23', 'DELETE', '2025-08-25 11:03:40'),
(41, 36, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2NTUyNjU0LCJleHAiOjE3NDY1NTYyNTR9.Uvy1XDTQ6uFiEOA317mvwj0gpDS2mLgwU8zZY_kO5nw', '117.99.203.82', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-06 17:30:54', 'DELETE', '2025-08-25 11:04:04'),
(42, 59, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTc3NzcyLCJleHAiOjE3NDY5ODEzNzJ9.MOqdsTtYrj1iVR6LAqGW3FupngMZZdMgPy_iMlW19PE', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 15:36:33', 'DELETE', '2025-08-25 11:04:04'),
(43, 60, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTc3NzgwLCJleHAiOjE3NDY5ODEzODB9.HSoK3k0dOOQ9rjAr4hNNj31VaXGYcPD3VkbWmZ2pwtY', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 15:36:41', 'DELETE', '2025-08-25 11:04:04'),
(44, 61, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ2OTc4MDY4LCJleHAiOjE3NDY5ODE2Njh9.PS-AcyUlbSNVRwaKTcZcc6c0XDICDAVw6XYLH774DS0', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 15:41:29', 'DELETE', '2025-08-25 11:04:04'),
(45, 62, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ2OTc4MDcyLCJleHAiOjE3NDY5ODE2NzJ9.LGM-trfbFbIQauPiG4y4q3RZoZeiy06Rq1gBASIzKhI', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 15:41:34', 'DELETE', '2025-08-25 11:04:04'),
(46, 63, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTc4MDgxLCJleHAiOjE3NDY5ODE2ODF9.fTuMtFYJ-zuuJXNQqt4TAJe-nbRalwVQhZ11yQQNFCI', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 15:41:42', 'DELETE', '2025-08-25 11:04:04'),
(47, 64, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTc4MTY5LCJleHAiOjE3NDY5ODE3Njl9.L3mKxBubP-pdqglEpqoGTm34H_seRLnaJiTPUlgy2cQ', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 15:43:11', 'DELETE', '2025-08-25 11:04:04'),
(48, 65, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ2OTc4MTcxLCJleHAiOjE3NDY5ODE3NzF9.FsJ-V-CG3TjUCkXNOKoqsWg0p1MxSzREI6laBvI1RZg', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 15:43:12', 'DELETE', '2025-08-25 11:04:04'),
(49, 66, 2, 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNzQ2OTc4MTg3LCJleHAiOjE3NDY5ODE3ODd9.fLWOaMonCReJXJRdXd9qgBG_pvfssMNH1Ou6Hx2q6cs', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 15:43:28', 'DELETE', '2025-08-25 11:04:04'),
(50, 67, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTc4MTg5LCJleHAiOjE3NDY5ODE3ODl9.i70d9MY4zDfEHRFRLn62V2LaUMc_9M13tQsU6IiPoAw', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 15:43:30', 'DELETE', '2025-08-25 11:04:04'),
(51, 68, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTgyMDIyLCJleHAiOjE3NDY5ODU2MjJ9.Fyom5NtwFeK4897953ZMG3kMYyBXj6J1V4PgU3Lqcjs', '::ffff:127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 16:47:02', 'DELETE', '2025-08-25 11:04:04'),
(52, 69, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTg1NjI3LCJleHAiOjE3NDY5ODkyMjd9.4d4PXVNDC8I6OwsayTYG6SjVVSOHMvV_EIbIS_uf6Pw', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 17:47:31', 'DELETE', '2025-08-25 11:04:04'),
(53, 70, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ2OTg5MjY0LCJleHAiOjE3NDY5OTI4NjR9.e_A-GAtLuRe3rF4sk9AvSnkP6ay-MT4LQackaxr7K5c', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-11 18:48:05', 'DELETE', '2025-08-25 11:04:04'),
(54, 71, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3MDIyNTU1LCJleHAiOjE3NDcwMjYxNTV9.pnqXkIxMLUFaj9UVhjjMsxDCiYOiVxR9-hQ4nAB9-28', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-12 04:02:56', 'DELETE', '2025-08-25 11:04:04'),
(55, 72, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3MDIyNTcwLCJleHAiOjE3NDcwMjYxNzB9.oBtDCINQOkOLQN_rLri1zR-Pf_Hf-_312uqcs-_fZKk', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-12 04:03:11', 'DELETE', '2025-08-25 11:04:04'),
(56, 73, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3MDI4Mjk4LCJleHAiOjE3NDcwMzE4OTh9.fHzkRFFQUGPrK_lzArxrJJZPjBZ5o8qD4WXjcJ1LCsc', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-12 05:38:39', 'DELETE', '2025-08-25 11:04:04'),
(57, 74, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3MDY3Nzc1LCJleHAiOjE3NDcwNzEzNzV9.EjQn3UQxk1czn5BpnFJsn3eqTD6UasDykMM1E5BRP90', '106.195.64.9', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-12 16:36:15', 'DELETE', '2025-08-25 11:04:04'),
(58, 75, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3MDc5MTk4LCJleHAiOjE3NDcwODI3OTh9.CsvJz56hILDyIu7B5ij06s3E6Z9P8OXygJDGemb2uPY', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-12 19:46:38', 'DELETE', '2025-08-25 11:04:04'),
(59, 76, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3MTQxNDA2LCJleHAiOjE3NDcxNDUwMDZ9.I0bCuMnGtVIPRQlpHJQzmhvxufoZafVCXkr062MkpSU', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-13 13:03:48', 'DELETE', '2025-08-25 11:04:04'),
(60, 77, 1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzQ3MTQxNDE2LCJleHAiOjE3NDcxNDUwMTZ9.3MXYlbqU-SJVTTB1ey4i-FZg8vNwb45soPKFjgBakpM', 'Unknown', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 'Login', '2025-05-13 13:03:57', 'DELETE', '2025-08-25 11:04:04');

-- --------------------------------------------------------

--
-- Table structure for table `tf_tfleads`
--

CREATE TABLE `tf_tfleads` (
  `Lead_ID` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(50) DEFAULT ' ',
  `password` varchar(50) DEFAULT '123456',
  `mobile` varchar(20) NOT NULL,
  `email` varchar(55) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `pincode` varchar(8) DEFAULT NULL,
  `reffered_by` varchar(50) DEFAULT 'ThinkFit',
  `programs` varchar(100) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` varchar(30) DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `targetweight` double DEFAULT NULL,
  `active_type` varchar(50) DEFAULT NULL,
  `healthreport` varchar(20) DEFAULT 'NO',
  `diettype` varchar(25) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `profession` varchar(256) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `other_info` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `status` varchar(50) DEFAULT 'Registered',
  `coachid` varchar(20) DEFAULT '',
  `connectedon` datetime DEFAULT NULL,
  `toreconnecton` datetime DEFAULT NULL,
  `leadtype` varchar(20) DEFAULT NULL,
  `conversations` text DEFAULT NULL,
  `tflead` int(11) NOT NULL DEFAULT 1,
  `phoneno` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_tfleads`
--

INSERT INTO `tf_tfleads` (`Lead_ID`, `first_name`, `last_name`, `password`, `mobile`, `email`, `address`, `city`, `state`, `pincode`, `reffered_by`, `programs`, `age`, `gender`, `height`, `weight`, `targetweight`, `active_type`, `healthreport`, `diettype`, `dob`, `profession`, `is_active`, `other_info`, `created_at`, `status`, `coachid`, `connectedon`, `toreconnecton`, `leadtype`, `conversations`, `tflead`, `phoneno`) VALUES
(1, 'Rahul', 'Verma', '123456', '9345678901', 'rahul.verma@example.com', '202 Health St', 'Bangalore', 'Karnataka', '560005', 'ThinkFit', 'weightloss', 35, 'Male', 180, 90, 80, 'Active', 'NO', 'Vegetarian', '1990-01-20', 'Manager', 1, NULL, '2025-05-03 10:00:00', 'Registered', 'COACH001', '2025-05-03 11:00:00', NULL, 'Direct', NULL, 1, '9345678901'),
(2, 'Sneha', 'Patel', '123456', '9456789012', 'sneha.patel@example.com', '303 Fit Rd', 'Bangalore', 'Karnataka', '560006', 'COACH002', 'weightloss', 26, 'Female', 155, 60, 50, 'Moderate', 'YES', 'Non-Vegetarian', '1999-03-25', 'Designer', 1, NULL, '2025-05-03 12:00:00', 'Registered', 'COACH002', '2025-05-03 13:00:00', NULL, 'Referral', NULL, 1, '9456789012');

--
-- Triggers `tf_tfleads`
--
DELIMITER $$
CREATE TRIGGER `tf_tfleads_before_delete` BEFORE DELETE ON `tf_tfleads` FOR EACH ROW BEGIN
  INSERT INTO `tf_tfleads_history` (
    `Lead_ID`, `first_name`, `last_name`, `password`, `mobile`, `email`, `address`, `city`, `state`, `pincode`,
    `reffered_by`, `programs`, `age`, `gender`, `height`, `weight`, `targetweight`, `active_type`, `healthreport`,
    `diettype`, `dob`, `profession`, `is_active`, `other_info`, `created_at`, `status`, `coachid`, `connectedon`,
    `toreconnecton`, `leadtype`, `conversations`, `tflead`, `phoneno`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`Lead_ID`, OLD.`first_name`, OLD.`last_name`, OLD.`password`, OLD.`mobile`, OLD.`email`, OLD.`address`,
    OLD.`city`, OLD.`state`, OLD.`pincode`, OLD.`reffered_by`, OLD.`programs`, OLD.`age`, OLD.`gender`, OLD.`height`,
    OLD.`weight`, OLD.`targetweight`, OLD.`active_type`, OLD.`healthreport`, OLD.`diettype`, OLD.`dob`, OLD.`profession`,
    OLD.`is_active`, OLD.`other_info`, OLD.`created_at`, OLD.`status`, OLD.`coachid`, OLD.`connectedon`,
    OLD.`toreconnecton`, OLD.`leadtype`, OLD.`conversations`, OLD.`tflead`, OLD.`phoneno`, 'DELETE', NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tf_tfleads_before_update` BEFORE UPDATE ON `tf_tfleads` FOR EACH ROW BEGIN
  INSERT INTO `tf_tfleads_history` (
    `Lead_ID`, `first_name`, `last_name`, `password`, `mobile`, `email`, `address`, `city`, `state`, `pincode`,
    `reffered_by`, `programs`, `age`, `gender`, `height`, `weight`, `targetweight`, `active_type`, `healthreport`,
    `diettype`, `dob`, `profession`, `is_active`, `other_info`, `created_at`, `status`, `coachid`, `connectedon`,
    `toreconnecton`, `leadtype`, `conversations`, `tflead`, `phoneno`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`Lead_ID`, OLD.`first_name`, OLD.`last_name`, OLD.`password`, OLD.`mobile`, OLD.`email`, OLD.`address`,
    OLD.`city`, OLD.`state`, OLD.`pincode`, OLD.`reffered_by`, OLD.`programs`, OLD.`age`, OLD.`gender`, OLD.`height`,
    OLD.`weight`, OLD.`targetweight`, OLD.`active_type`, OLD.`healthreport`, OLD.`diettype`, OLD.`dob`, OLD.`profession`,
    OLD.`is_active`, OLD.`other_info`, OLD.`created_at`, OLD.`status`, OLD.`coachid`, OLD.`connectedon`,
    OLD.`toreconnecton`, OLD.`leadtype`, OLD.`conversations`, OLD.`tflead`, OLD.`phoneno`, 'UPDATE', NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tf_tfleads_history`
--

CREATE TABLE `tf_tfleads_history` (
  `history_id` int(11) NOT NULL,
  `Lead_ID` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(50) DEFAULT ' ',
  `password` varchar(50) DEFAULT '123456',
  `mobile` varchar(20) NOT NULL,
  `email` varchar(55) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `pincode` varchar(8) DEFAULT NULL,
  `reffered_by` varchar(50) DEFAULT 'ThinkFit',
  `programs` varchar(100) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` varchar(30) DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `targetweight` double DEFAULT NULL,
  `active_type` varchar(50) DEFAULT NULL,
  `healthreport` varchar(20) DEFAULT 'NO',
  `diettype` varchar(25) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `profession` varchar(256) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `other_info` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Registered',
  `coachid` varchar(20) DEFAULT '',
  `connectedon` datetime DEFAULT NULL,
  `toreconnecton` datetime DEFAULT NULL,
  `leadtype` varchar(20) DEFAULT NULL,
  `conversations` text DEFAULT NULL,
  `tflead` int(11) NOT NULL DEFAULT 1,
  `phoneno` varchar(50) DEFAULT NULL,
  `history_action` enum('UPDATE','DELETE') NOT NULL,
  `history_timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tf_userhealthprofile`
--

CREATE TABLE `tf_userhealthprofile` (
  `id` int(11) NOT NULL,
  `tdate` datetime NOT NULL DEFAULT current_timestamp(),
  `Cust_ID` int(11) DEFAULT NULL,
  `Lead_ID` int(11) DEFAULT NULL,
  `personal_health` varchar(300) NOT NULL,
  `family_health` varchar(150) NOT NULL,
  `lifestyle` varchar(256) NOT NULL,
  `other_concern` varchar(256) NOT NULL,
  `food_choices` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_userhealthprofile`
--

INSERT INTO `tf_userhealthprofile` (`id`, `tdate`, `Cust_ID`, `Lead_ID`, `personal_health`, `family_health`, `lifestyle`, `other_concern`, `food_choices`) VALUES
(1, '2025-05-01 16:00:00', 1, 1, 'No major issues', 'Family history of diabetes', 'Moderate exercise', 'Stress management', 'Prefers home-cooked meals'),
(2, '2025-05-02 17:00:00', 2, 2, 'Mild asthma', 'No family issues', 'Sedentary job', 'Sleep issues', 'Likes fast food occasionally'),
(62, '2025-09-04 13:19:41', 98, 98, 'No major health issues, occasional headaches', 'Father has diabetes', 'Moderately active, goes for walks', 'Wants to improve sleep quality', 'Prefers non-veg, likes spicy food');

--
-- Triggers `tf_userhealthprofile`
--
DELIMITER $$
CREATE TRIGGER `tf_userhealthprofile_before_delete` BEFORE DELETE ON `tf_userhealthprofile` FOR EACH ROW BEGIN
  INSERT INTO `tf_userhealthprofile_history` (
    `id`, `tdate`, `Cust_ID`, `Lead_ID`, `personal_health`, `family_health`, `lifestyle`, `other_concern`,
    `food_choices`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`tdate`, OLD.`Cust_ID`, OLD.`Lead_ID`, OLD.`personal_health`, OLD.`family_health`, OLD.`lifestyle`,
    OLD.`other_concern`, OLD.`food_choices`, 'DELETE', NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tf_userhealthprofile_before_update` BEFORE UPDATE ON `tf_userhealthprofile` FOR EACH ROW BEGIN
  INSERT INTO `tf_userhealthprofile_history` (
    `id`, `tdate`, `Cust_ID`, `Lead_ID`, `personal_health`, `family_health`, `lifestyle`, `other_concern`,
    `food_choices`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`tdate`, OLD.`Cust_ID`, OLD.`Lead_ID`, OLD.`personal_health`, OLD.`family_health`, OLD.`lifestyle`,
    OLD.`other_concern`, OLD.`food_choices`, 'UPDATE', NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tf_userhealthprofile_history`
--

CREATE TABLE `tf_userhealthprofile_history` (
  `history_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `tdate` datetime NOT NULL DEFAULT current_timestamp(),
  `Cust_ID` int(11) DEFAULT NULL,
  `Lead_ID` int(11) DEFAULT NULL,
  `personal_health` varchar(300) NOT NULL,
  `family_health` varchar(150) NOT NULL,
  `lifestyle` varchar(256) NOT NULL,
  `other_concern` varchar(256) NOT NULL,
  `food_choices` varchar(300) NOT NULL,
  `history_action` enum('UPDATE','DELETE') NOT NULL,
  `history_timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tf_userprogram`
--

CREATE TABLE `tf_userprogram` (
  `id` int(11) NOT NULL,
  `tdate` datetime NOT NULL DEFAULT current_timestamp(),
  `Cust_ID` int(11) NOT NULL,
  `forprogram` varchar(60) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'RUNNING',
  `diettype` varchar(25) DEFAULT NULL,
  `programstartday` date NOT NULL,
  `total_program_days` varchar(250) NOT NULL DEFAULT '48',
  `number_of_snack` varchar(250) NOT NULL DEFAULT '10',
  `dayofprogram` int(11) NOT NULL DEFAULT 0,
  `weight` float DEFAULT NULL,
  `targetweight` float DEFAULT NULL,
  `cycletargetweight` float DEFAULT NULL,
  `noofcycle` int(11) NOT NULL DEFAULT 1,
  `sos_history` varchar(256) DEFAULT NULL,
  `reschedule_history` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_userprogram`
--

INSERT INTO `tf_userprogram` (`id`, `tdate`, `Cust_ID`, `forprogram`, `status`, `diettype`, `programstartday`, `total_program_days`, `number_of_snack`, `dayofprogram`, `weight`, `targetweight`, `cycletargetweight`, `noofcycle`, `sos_history`, `reschedule_history`) VALUES
(1, '2025-05-01 18:00:00', 1, 'weightloss', 'RUNNING', 'Vegetarian', '2025-05-01', '48', '10', 3, 85, 75, 80, 1, NULL, NULL),
(2, '2025-05-02 19:00:00', 2, 'weightloss', 'RUNNING', 'Non-Vegetarian', '2025-05-02', '48', '5', 2, 65, 55, 60, 1, NULL, NULL),
(25, '2025-09-04 13:08:15', 98, 'Weight Loss Program', 'RUNNING', 'Non-Veg', '2025-09-04', '48', '10', 0, 72.5, 65, 68, 1, NULL, NULL),
(29, '2025-09-06 19:42:17', 104, 'program_name_here', 'RUNNING', 'diet_type_here', '2025-09-06', '48', '10', 0, 70.5, 65, 63, 1, 'sos_history_data', 'reschedule_history_data');

--
-- Triggers `tf_userprogram`
--
DELIMITER $$
CREATE TRIGGER `tf_userprogram_before_delete` BEFORE DELETE ON `tf_userprogram` FOR EACH ROW BEGIN
  INSERT INTO `tf_userprogram_history` (
    `id`, `tdate`, `Cust_ID`, `forprogram`, `status`, `diettype`, `programstartday`, `dayofprogram`, `weight`,
    `targetweight`, `cycletargetweight`, `noofcycle`, `sos_history`, `reschedule_history`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`tdate`, OLD.`Cust_ID`, OLD.`forprogram`, OLD.`status`, OLD.`diettype`, OLD.`programstartday`,
    OLD.`dayofprogram`, OLD.`weight`, OLD.`targetweight`, OLD.`cycletargetweight`, OLD.`noofcycle`, OLD.`sos_history`,
    OLD.`reschedule_history`, 'DELETE', NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tf_userprogram_before_update` BEFORE UPDATE ON `tf_userprogram` FOR EACH ROW BEGIN
  INSERT INTO `tf_userprogram_history` (
    `id`, `tdate`, `Cust_ID`, `forprogram`, `status`, `diettype`, `programstartday`, `dayofprogram`, `weight`,
    `targetweight`, `cycletargetweight`, `noofcycle`, `sos_history`, `reschedule_history`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`tdate`, OLD.`Cust_ID`, OLD.`forprogram`, OLD.`status`, OLD.`diettype`, OLD.`programstartday`,
    OLD.`dayofprogram`, OLD.`weight`, OLD.`targetweight`, OLD.`cycletargetweight`, OLD.`noofcycle`, OLD.`sos_history`,
    OLD.`reschedule_history`, 'UPDATE', NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tf_userprogram_history`
--

CREATE TABLE `tf_userprogram_history` (
  `history_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `tdate` datetime NOT NULL DEFAULT current_timestamp(),
  `Cust_ID` int(11) NOT NULL,
  `forprogram` varchar(60) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'RUNNING',
  `diettype` varchar(25) DEFAULT NULL,
  `programstartday` date NOT NULL,
  `dayofprogram` int(11) NOT NULL DEFAULT 0,
  `weight` float DEFAULT NULL,
  `targetweight` float DEFAULT NULL,
  `cycletargetweight` float DEFAULT NULL,
  `noofcycle` int(11) NOT NULL DEFAULT 1,
  `sos_history` varchar(256) DEFAULT NULL,
  `reschedule_history` varchar(256) DEFAULT NULL,
  `history_action` enum('UPDATE','DELETE') NOT NULL,
  `history_timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_userprogram_history`
--

INSERT INTO `tf_userprogram_history` (`history_id`, `id`, `tdate`, `Cust_ID`, `forprogram`, `status`, `diettype`, `programstartday`, `dayofprogram`, `weight`, `targetweight`, `cycletargetweight`, `noofcycle`, `sos_history`, `reschedule_history`, `history_action`, `history_timestamp`) VALUES
(1, 2, '2025-05-02 19:00:00', 2, 'weightloss', 'RUNNING', 'Non-Vegetarian', '2025-05-02', 2, 65, 55, 60, 1, NULL, NULL, 'UPDATE', '2025-05-11 00:10:12'),
(2, 1, '2025-05-01 18:00:00', 1, 'weightloss', 'RUNNING', 'Vegetarian', '2025-05-01', 3, 85, 75, 80, 1, NULL, NULL, 'UPDATE', '2025-05-11 00:10:24'),
(3, 1, '2025-05-01 18:00:00', 1, 'weightloss', 'RUNNING', 'Vegetarian', '2025-06-01', 3, 85, 75, 80, 1, NULL, NULL, 'UPDATE', '2025-05-11 00:20:17'),
(4, 2, '2025-05-02 19:00:00', 2, 'weightloss', 'RUNNING', 'Non-Vegetarian', '2025-06-02', 2, 65, 55, 60, 1, NULL, NULL, 'UPDATE', '2025-05-11 00:20:35'),
(5, 2, '2025-05-02 19:00:00', 2, 'weightloss', 'RUNNING', 'Non-Vegetarian', '2025-05-02', 2, 65, 55, 60, 1, NULL, NULL, 'UPDATE', '2025-05-11 11:53:12'),
(6, 25, '2025-09-04 13:08:15', 98, 'Weight Loss Program', 'RUNNING', 'Non-Veg', '2025-09-05', 0, 72.5, 65, 68, 1, NULL, NULL, 'UPDATE', '2025-09-04 13:21:29');

-- --------------------------------------------------------

--
-- Table structure for table `tf_users`
--

CREATE TABLE `tf_users` (
  `id` varchar(20) DEFAULT NULL,
  `Cust_ID` int(11) NOT NULL,
  `user_id` varchar(100) NOT NULL,
  `Lead_ID` int(11) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) DEFAULT ' ',
  `full_name` varchar(100) GENERATED ALWAYS AS (case when `first_name` is not null and `last_name` is not null then concat(`first_name`,' ',`last_name`) when `first_name` is not null then `first_name` when `last_name` is not null then `last_name` else NULL end) VIRTUAL,
  `password` varchar(255) DEFAULT '123456',
  `is_online` tinyint(1) DEFAULT 0,
  `type` varchar(50) NOT NULL DEFAULT 'user',
  `last_seen` datetime DEFAULT NULL,
  `mobile` bigint(20) NOT NULL,
  `email` varchar(55) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `pincode` varchar(8) DEFAULT NULL,
  `referred_by` varchar(100) DEFAULT '',
  `programs` varchar(100) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` varchar(30) DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `targetweight` double DEFAULT NULL,
  `active_type` varchar(50) DEFAULT NULL,
  `healthreport` varchar(20) DEFAULT 'NO',
  `diettype` varchar(25) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `profession` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `other_info` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `status` varchar(50) DEFAULT 'RUNNING',
  `coachid` varchar(20) DEFAULT '',
  `noofcycle` int(11) DEFAULT 0,
  `tflead` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_users`
--

INSERT INTO `tf_users` (`id`, `Cust_ID`, `user_id`, `Lead_ID`, `first_name`, `last_name`, `password`, `is_online`, `type`, `last_seen`, `mobile`, `email`, `address`, `city`, `state`, `pincode`, `referred_by`, `programs`, `age`, `gender`, `height`, `weight`, `targetweight`, `active_type`, `healthreport`, `diettype`, `dob`, `profession`, `is_active`, `other_info`, `created_at`, `status`, `coachid`, `noofcycle`, `tflead`) VALUES
('1', 1, '1', 1, 'Amit', 'Sharma', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 0, 'user', '2025-05-03 08:00:00', 9123456789, 'amit.sharma@example.com', '789 Wellness Rd', 'Bangalore', 'Karnataka', '560003', 'ThinkFit', 'weightloss', 30, 'Male', 175.5, 85, 75, 'Moderate', 'NO', 'Vegetarian', '1995-04-10', 'Engineer', 1, NULL, '2025-05-01 11:00:00', 'RUNNING', 'COACH001', 1, 0),
('2', 2, '2', 2, 'Priya', 'Mehta', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 1, 'user', '2025-05-04 09:00:00', 9234567890, 'priya.mehta@example.com', '101 Fit Lane', 'Bangalore', 'Karnataka', '560004', 'COACH001', 'weightloss', 28, 'Female', 160, 65, 55, 'Sedentary', 'YES', 'Non-Vegetarian', '1997-08-15', 'Teacher', 1, NULL, '2025-05-02 09:00:00', 'RUNNING', 'COACH002', 1, 0),
(NULL, 89, '89', 89, 'John', 'Doe', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 1, 'member', '2025-08-15 10:00:00', 9876543210, 'john@example.com', '123 Street', 'Hyderabad', 'Telangana', '500001', 'REF001', 'Weight Loss', 28, 'male', 175, 75, 68, 'Active', 'Healthy', 'Veg', '1997-05-20', 'Engineer', 1, 'None', '2025-08-15 10:00:00', 'active', 'COACH003', 2, 1),
(NULL, 98, '103', 103, 'Abhiram', 'Yalapalli', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 0, 'user', NULL, 9876543210, 'abhiram@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No major issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 12:57:24', 'New', 'COACH001', 0, 1),
(NULL, 99, '99', 99, 'Hari', 'krishna', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 0, 'user', NULL, 9876543210, 'hari@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 17:08:56', 'New', 'COACH001', 0, 1),
(NULL, 100, '222', 222, 'Abhiram', 'Yalapalli', '12345', 0, 'user', NULL, 9876543210, 'abhiram@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 17:52:24', 'New', 'COACH001', 0, 1),
(NULL, 101, '224', 224, 'Demo', 'Demo', '12345', 0, 'user', NULL, 9876543210, 'demo@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 17:54:50', 'New', 'COACH001', 0, 1),
(NULL, 102, '333', 333, 'demo3', 'demo3', '12345', 0, 'user', NULL, 9876543210, 'demo3@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 17:57:05', 'New', 'COACH001', 0, 1),
(NULL, 103, '444', 444, 'demo4', 'demo4', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 0, 'user', NULL, 9876543210, 'demo4@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 17:57:50', 'New', 'COACH001', 0, 1),
(NULL, 104, '54', 54, 'user3', 'user3', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 0, 'user', NULL, 9876543210, 'user3@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-06 19:36:29', 'New', 'COACH001', 0, 1),
(NULL, 105, '60', 60, 'Abhi', 'Abhi', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 0, 'user', NULL, 9876543210, 'Abhi@gmail.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-15 20:07:04', 'New', 'COACH001', 0, 1);

--
-- Triggers `tf_users`
--
DELIMITER $$
CREATE TRIGGER `tf_users_before_delete` BEFORE DELETE ON `tf_users` FOR EACH ROW BEGIN
  INSERT INTO `tf_users_history` (
    `Cust_ID`, `Lead_ID`, `first_name`, `last_name`, `password`, `is_online`, `type`, `last_seen`, `mobile`, `email`,
    `address`, `city`, `state`, `pincode`, `referred_by`, `programs`, `age`, `gender`, `height`, `weight`, `targetweight`,
    `active_type`, `healthreport`, `diettype`, `dob`, `profession`, `is_active`, `other_info`, `created_at`, `status`,
    `coachid`, `noofcycle`, `tflead`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`Cust_ID`, OLD.`Lead_ID`, OLD.`first_name`, OLD.`last_name`, OLD.`password`, OLD.`is_online`, OLD.`type`,
    OLD.`last_seen`, OLD.`mobile`, OLD.`email`, OLD.`address`, OLD.`city`, OLD.`state`, OLD.`pincode`, OLD.`referred_by`,
    OLD.`programs`, OLD.`age`, OLD.`gender`, OLD.`height`, OLD.`weight`, OLD.`targetweight`, OLD.`active_type`,
    OLD.`healthreport`, OLD.`diettype`, OLD.`dob`, OLD.`profession`, OLD.`is_active`, OLD.`other_info`, OLD.`created_at`,
    OLD.`status`, OLD.`coachid`, OLD.`noofcycle`, OLD.`tflead`, 'DELETE', NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tf_users_before_update` BEFORE UPDATE ON `tf_users` FOR EACH ROW BEGIN
  INSERT INTO `tf_users_history` (
    `Cust_ID`, `Lead_ID`, `first_name`, `last_name`, `password`, `is_online`, `type`, `last_seen`, `mobile`, `email`,
    `address`, `city`, `state`, `pincode`, `referred_by`, `programs`, `age`, `gender`, `height`, `weight`, `targetweight`,
    `active_type`, `healthreport`, `diettype`, `dob`, `profession`, `is_active`, `other_info`, `created_at`, `status`,
    `coachid`, `noofcycle`, `tflead`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`Cust_ID`, OLD.`Lead_ID`, OLD.`first_name`, OLD.`last_name`, OLD.`password`, OLD.`is_online`, OLD.`type`,
    OLD.`last_seen`, OLD.`mobile`, OLD.`email`, OLD.`address`, OLD.`city`, OLD.`state`, OLD.`pincode`, OLD.`referred_by`,
    OLD.`programs`, OLD.`age`, OLD.`gender`, OLD.`height`, OLD.`weight`, OLD.`targetweight`, OLD.`active_type`,
    OLD.`healthreport`, OLD.`diettype`, OLD.`dob`, OLD.`profession`, OLD.`is_active`, OLD.`other_info`, OLD.`created_at`,
    OLD.`status`, OLD.`coachid`, OLD.`noofcycle`, OLD.`tflead`, 'UPDATE', NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tf_usersupplements`
--

CREATE TABLE `tf_usersupplements` (
  `id` bigint(20) NOT NULL,
  `tdate` datetime NOT NULL DEFAULT current_timestamp(),
  `Cust_ID` int(11) NOT NULL,
  `supplement1` varchar(50) NOT NULL,
  `supplement2` varchar(50) NOT NULL,
  `supplement3` varchar(50) NOT NULL,
  `supplement4` varchar(50) NOT NULL,
  `supplement5` varchar(50) NOT NULL,
  `supplement6` varchar(50) NOT NULL,
  `supplement7` varchar(50) NOT NULL,
  `supplement8` varchar(50) NOT NULL,
  `supplement9` varchar(50) NOT NULL,
  `supplement10` varchar(50) NOT NULL,
  `supplement11` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_usersupplements`
--

INSERT INTO `tf_usersupplements` (`id`, `tdate`, `Cust_ID`, `supplement1`, `supplement2`, `supplement3`, `supplement4`, `supplement5`, `supplement6`, `supplement7`, `supplement8`, `supplement9`, `supplement10`, `supplement11`) VALUES
(1, '2025-05-01 20:00:00', 1, 'Multivitamin', 'Omega-3', 'Calcium', '', '', '', '', '', '', '', ''),
(2, '2025-05-02 21:00:00', 2, 'Vitamin D', 'Protein', 'Magnesium', '', '', '', '', '', '', '', '');

--
-- Triggers `tf_usersupplements`
--
DELIMITER $$
CREATE TRIGGER `tf_usersupplements_before_delete` BEFORE DELETE ON `tf_usersupplements` FOR EACH ROW BEGIN
  INSERT INTO `tf_usersupplements_history` (
    `id`, `tdate`, `Cust_ID`, `supplement1`, `supplement2`, `supplement3`, `supplement4`, `supplement5`,
    `supplement6`, `supplement7`, `supplement8`, `supplement9`, `supplement10`, `supplement11`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`tdate`, OLD.`Cust_ID`, OLD.`supplement1`, OLD.`supplement2`, OLD.`supplement3`, OLD.`supplement4`,
    OLD.`supplement5`, OLD.`supplement6`, OLD.`supplement7`, OLD.`supplement8`, OLD.`supplement9`, OLD.`supplement10`,
    OLD.`supplement11`, 'DELETE', NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tf_usersupplements_before_update` BEFORE UPDATE ON `tf_usersupplements` FOR EACH ROW BEGIN
  INSERT INTO `tf_usersupplements_history` (
    `id`, `tdate`, `Cust_ID`, `supplement1`, `supplement2`, `supplement3`, `supplement4`, `supplement5`,
    `supplement6`, `supplement7`, `supplement8`, `supplement9`, `supplement10`, `supplement11`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`tdate`, OLD.`Cust_ID`, OLD.`supplement1`, OLD.`supplement2`, OLD.`supplement3`, OLD.`supplement4`,
    OLD.`supplement5`, OLD.`supplement6`, OLD.`supplement7`, OLD.`supplement8`, OLD.`supplement9`, OLD.`supplement10`,
    OLD.`supplement11`, 'UPDATE', NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tf_usersupplements_history`
--

CREATE TABLE `tf_usersupplements_history` (
  `history_id` int(11) NOT NULL,
  `id` bigint(20) NOT NULL,
  `tdate` datetime NOT NULL DEFAULT current_timestamp(),
  `Cust_ID` int(11) NOT NULL,
  `supplement1` varchar(50) NOT NULL,
  `supplement2` varchar(50) NOT NULL,
  `supplement3` varchar(50) NOT NULL,
  `supplement4` varchar(50) NOT NULL,
  `supplement5` varchar(50) NOT NULL,
  `supplement6` varchar(50) NOT NULL,
  `supplement7` varchar(50) NOT NULL,
  `supplement8` varchar(50) NOT NULL,
  `supplement9` varchar(50) NOT NULL,
  `supplement10` varchar(50) NOT NULL,
  `supplement11` varchar(50) NOT NULL,
  `history_action` enum('UPDATE','DELETE') NOT NULL,
  `history_timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tf_users_history`
--

CREATE TABLE `tf_users_history` (
  `history_id` int(11) NOT NULL,
  `Cust_ID` int(11) NOT NULL,
  `Lead_ID` int(11) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) DEFAULT ' ',
  `password` varchar(255) DEFAULT '123456',
  `is_online` tinyint(1) DEFAULT 0,
  `type` varchar(50) NOT NULL DEFAULT 'user',
  `last_seen` datetime DEFAULT NULL,
  `mobile` bigint(20) NOT NULL,
  `email` varchar(55) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `pincode` varchar(8) DEFAULT NULL,
  `referred_by` varchar(100) DEFAULT '',
  `programs` varchar(100) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` varchar(30) DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `targetweight` double DEFAULT NULL,
  `active_type` varchar(50) DEFAULT NULL,
  `healthreport` varchar(20) DEFAULT 'NO',
  `diettype` varchar(25) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `profession` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `other_info` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT 'RUNNING',
  `coachid` varchar(20) DEFAULT '',
  `noofcycle` int(11) DEFAULT 0,
  `tflead` int(11) NOT NULL DEFAULT 0,
  `history_action` enum('UPDATE','DELETE') NOT NULL,
  `history_timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_users_history`
--

INSERT INTO `tf_users_history` (`history_id`, `Cust_ID`, `Lead_ID`, `first_name`, `last_name`, `password`, `is_online`, `type`, `last_seen`, `mobile`, `email`, `address`, `city`, `state`, `pincode`, `referred_by`, `programs`, `age`, `gender`, `height`, `weight`, `targetweight`, `active_type`, `healthreport`, `diettype`, `dob`, `profession`, `is_active`, `other_info`, `created_at`, `status`, `coachid`, `noofcycle`, `tflead`, `history_action`, `history_timestamp`) VALUES
(1, 1, 1, 'Amit', 'Sharma', '123456', 0, 'user', '2025-05-03 08:00:00', 9123456789, 'amit.sharma@example.com', '789 Wellness Rd', 'Bangalore', 'Karnataka', '560003', 'ThinkFit', 'weightloss', 30, 'Male', 175.5, 85, 75, 'Moderate', 'NO', 'Vegetarian', '1995-04-10', 'Engineer', 1, NULL, '2025-05-01 11:00:00', 'RUNNING', 'COACH001', 1, 0, 'UPDATE', '2025-05-04 14:21:27'),
(2, 2, 2, 'Priya', 'Mehta', '123456', 1, 'user', '2025-05-04 09:00:00', 9234567890, 'priya.mehta@example.com', '101 Fit Lane', 'Bangalore', 'Karnataka', '560004', 'COACH001', 'weightloss', 28, 'Female', 160, 65, 55, 'Sedentary', 'YES', 'Non-Vegetarian', '1997-08-15', 'Teacher', 1, NULL, '2025-05-02 09:00:00', 'RUNNING', 'COACH002', 1, 0, 'UPDATE', '2025-05-04 14:21:30'),
(3, 1, 1, 'Amit', 'Sharma', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 0, 'user', '2025-05-03 08:00:00', 9123456789, 'amit.sharma@example.com', '789 Wellness Rd', 'Bangalore', 'Karnataka', '560003', 'ThinkFit', 'weightloss', 30, 'Male', 175.5, 85, 75, 'Moderate', 'NO', 'Vegetarian', '1995-04-10', 'Engineer', 1, NULL, '2025-05-01 11:00:00', 'RUNNING', 'COACH001', 1, 0, 'UPDATE', '2025-05-04 16:18:57'),
(22, 90, 90, 'Jane', 'Smith', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 0, 'member', '2025-08-14 09:30:00', 9876543211, 'jane@example.com', '456 Avenue', 'Mumbai', 'Maharashtra', '400001', 'REF002', 'Muscle Gain', 32, 'female', 165, 60, 58, 'Moderate', 'Good', 'Non-Veg', '1993-11-15', 'Designer', 1, 'Allergic to peanuts', '2025-08-15 10:05:00', 'active', 'COACH004', 3, 2, 'DELETE', '2025-08-25 16:32:44'),
(23, 91, 91, 'Raj', 'Kumar', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 1, 'coach', '2025-08-13 15:45:00', 9876543212, 'raj@example.com', '789 Road', 'Chennai', 'Tamil Nadu', '600001', 'REF003', 'Yoga', 40, 'male', 180, 82, 78, 'Active', 'Excellent', 'Veg', '1985-04-10', 'Trainer', 1, 'Yoga specialist', '2025-08-15 10:10:00', 'active', 'COACH005', 5, 3, 'DELETE', '2025-08-25 16:32:44'),
(24, 92, 92, 'Priya', 'Sharma', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 0, 'member', '2025-08-12 11:20:00', 9876543213, 'priya@example.com', '12 Colony', 'Delhi', 'Delhi', '110001', 'REF004', 'Cardio', 25, 'female', 160, 55, 52, 'Low', 'Average', 'Veg', '2000-02-25', 'Student', 1, 'Prefers morning workouts', '2025-08-15 10:15:00', 'inactive', 'COACH006', 1, 4, 'DELETE', '2025-08-25 16:32:44'),
(25, 93, 93, 'Amit', 'Singh', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 1, 'member', '2025-08-11 18:40:00', 9876543214, 'amit@example.com', '34 Block', 'Pune', 'Maharashtra', '411001', 'REF005', 'Strength Training', 30, 'male', 170, 78, 75, 'Active', 'Good', 'Non-Veg', '1995-09-12', 'Developer', 1, 'Knee injury history', '2025-08-15 10:20:00', 'active', 'COACH007', 4, 5, 'DELETE', '2025-08-25 16:32:44'),
(26, 94, 94, 'Sneha', 'Patel', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 0, 'member', '2025-08-10 07:55:00', 9876543215, 'sneha@example.com', '56 Lane', 'Ahmedabad', 'Gujarat', '380001', 'REF006', 'Weight Loss', 27, 'female', 158, 62, 55, 'Moderate', 'Good', 'Veg', '1998-07-07', 'Teacher', 1, 'Diabetic', '2025-08-15 10:25:00', 'active', 'COACH008', 2, 6, 'DELETE', '2025-08-25 16:32:44'),
(27, 97, NULL, 'Abhiram', '', '$2b$10$cKf9uODWxQ2Xyv5zJH4gEuXfzaWFToR9bKY0s2Z7LfCfwenegNnyO', 0, 'user', NULL, 0, 'Abhiram@gmail.com', NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NO', NULL, NULL, NULL, 1, NULL, '2025-09-03 23:01:06', 'RUNNING', 'COACH001', 0, 0, 'DELETE', '2025-09-04 12:39:46'),
(28, 5, 102, 'Abhiram', 'Yalapalli', '$2b$10$abcdefghijk1234567890abcdEfghijklmnoPQrstuv', 0, 'user', NULL, 9876543210, 'abhiram@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No major issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 12:43:54', 'New', NULL, 0, 1, 'UPDATE', '2025-09-04 12:44:22'),
(29, 5, 102, 'Abhiram', 'Yalapalli', '12345', 0, 'user', NULL, 9876543210, 'abhiram@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No major issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 12:43:54', 'New', NULL, 0, 1, 'UPDATE', '2025-09-04 12:44:36'),
(30, 5, 102, 'Abhiram', 'Yalapalli', '12345', 0, 'user', NULL, 9876543210, 'abhiram@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No major issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 12:43:54', 'New', NULL, 0, 1, 'UPDATE', '2025-09-04 12:45:53'),
(31, 5, 102, 'Abhiram', 'Yalapalli', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 0, 'user', NULL, 9876543210, 'abhiram@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No major issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 12:43:54', 'New', NULL, 0, 1, 'UPDATE', '2025-09-04 12:49:11'),
(32, 5, 102, 'Abhiram', 'Yalapalli', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 0, 'user', NULL, 9876543210, 'abhiram@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No major issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 12:43:54', 'New', 'COACH001', 0, 1, 'DELETE', '2025-09-04 12:50:41'),
(33, 98, 103, 'Abhiram', 'Yalapalli', '12345', 0, 'user', NULL, 9876543210, 'abhiram@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No major issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 12:57:24', 'New', 'COACH001', 0, 1, 'UPDATE', '2025-09-04 12:58:57'),
(34, 99, 99, 'Hari', 'krishna', '12345', 0, 'user', NULL, 9876543210, 'abhiram@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 17:08:56', 'New', 'COACH001', 0, 1, 'UPDATE', '2025-09-04 17:09:34'),
(35, 99, 99, 'Hari', 'krishna', '12345', 0, 'user', NULL, 9876543210, 'hari@example.com', '123 Main Street', 'Hyderabad', 'Telangana', '500001', 'Friend', 'Weight Loss Program', 25, 'Male', 168, 60, 55, 'Moderate', 'No issues', 'Non-Vegetarian', '2000-01-13', 'Software Engineer', 1, 'Loves fitness training', '2025-09-04 17:08:56', 'New', 'COACH001', 0, 1, 'UPDATE', '2025-09-04 17:10:56'),
(36, 1, 1, 'Amit', 'Sharma', '$2b$10$EpINIDZg/Wwvf9d8gEGcjeB0VBay/w3pVmWvm7QqUm8qRglsC/Nve', 0, 'user', '2025-05-03 08:00:00', 9123456789, 'amit.sharma@example.com', '789 Wellness Rd', 'Bangalore', 'Karnataka', '560003', 'ThinkFit', 'weightloss', 30, 'Male', 175.5, 85, 75, 'Moderate', 'NO', 'Vegetarian', '1995-04-10', 'Engineer', 1, NULL, '2025-05-01 11:00:00', 'RUNNING', 'COACH001', 1, 0, 'UPDATE', '2025-10-07 18:27:59');

-- --------------------------------------------------------

--
-- Table structure for table `tf_wldialydata`
--

CREATE TABLE `tf_wldialydata` (
  `id` int(11) NOT NULL,
  `tdate` datetime NOT NULL DEFAULT current_timestamp(),
  `Cust_ID` int(11) NOT NULL,
  `dayofprogram` int(11) NOT NULL,
  `dopdate` date NOT NULL,
  `weight` float DEFAULT NULL,
  `steps` int(11) DEFAULT NULL,
  `waterintake` float DEFAULT NULL,
  `p_m` tinyint(1) DEFAULT NULL,
  `p_a` tinyint(1) DEFAULT NULL,
  `p_e` tinyint(1) DEFAULT NULL,
  `mv_m` tinyint(1) DEFAULT NULL,
  `mv_a` tinyint(1) DEFAULT NULL,
  `mv_e` tinyint(1) DEFAULT NULL,
  `omega3_m` tinyint(1) DEFAULT NULL,
  `omega3_a` tinyint(1) DEFAULT NULL,
  `omega3_e` tinyint(1) DEFAULT NULL,
  `cal_m` tinyint(1) DEFAULT NULL,
  `cal_a` tinyint(1) DEFAULT NULL,
  `cal_e` tinyint(1) DEFAULT NULL,
  `vb_m` tinyint(1) DEFAULT NULL,
  `vb_a` tinyint(1) DEFAULT NULL,
  `vb_e` tinyint(1) DEFAULT NULL,
  `vc_m` tinyint(1) DEFAULT NULL,
  `vc_a` tinyint(1) DEFAULT NULL,
  `vc_e` tinyint(1) DEFAULT NULL,
  `fiber_m` tinyint(1) DEFAULT NULL,
  `fiber_a` tinyint(1) DEFAULT NULL,
  `fiber_e` tinyint(1) DEFAULT NULL,
  `triphala_m` tinyint(1) DEFAULT NULL,
  `triphala_a` tinyint(1) DEFAULT NULL,
  `triphala_e` tinyint(1) DEFAULT NULL,
  `others1name` varchar(25) DEFAULT NULL,
  `o1_m` tinyint(1) DEFAULT NULL,
  `o1_a` tinyint(1) DEFAULT NULL,
  `o1_e` tinyint(1) DEFAULT NULL,
  `others2name` varchar(25) DEFAULT NULL,
  `o2_m` tinyint(1) DEFAULT NULL,
  `o2_a` tinyint(1) DEFAULT NULL,
  `o2_e` tinyint(1) DEFAULT NULL,
  `others3name` varchar(25) DEFAULT NULL,
  `o3_m` tinyint(1) DEFAULT NULL,
  `o3_a` tinyint(1) DEFAULT NULL,
  `o3_e` tinyint(1) DEFAULT NULL,
  `snack1` varchar(50) DEFAULT NULL,
  `snack2` varchar(50) DEFAULT NULL,
  `snack3` varchar(50) DEFAULT NULL,
  `snack4` varchar(50) DEFAULT NULL,
  `snack5` varchar(50) DEFAULT NULL,
  `snack6` varchar(50) DEFAULT NULL,
  `snack7` varchar(50) DEFAULT NULL,
  `snack8` varchar(50) DEFAULT NULL,
  `snack9` varchar(50) DEFAULT NULL,
  `snack10` varchar(50) DEFAULT NULL,
  `breakfast_pic` varchar(100) DEFAULT NULL,
  `lunch_pic` varchar(100) DEFAULT NULL,
  `dinner_pic` varchar(100) DEFAULT NULL,
  `hdatasaved` int(11) NOT NULL DEFAULT 0,
  `snackssaved` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_wldialydata`
--

INSERT INTO `tf_wldialydata` (`id`, `tdate`, `Cust_ID`, `dayofprogram`, `dopdate`, `weight`, `steps`, `waterintake`, `p_m`, `p_a`, `p_e`, `mv_m`, `mv_a`, `mv_e`, `omega3_m`, `omega3_a`, `omega3_e`, `cal_m`, `cal_a`, `cal_e`, `vb_m`, `vb_a`, `vb_e`, `vc_m`, `vc_a`, `vc_e`, `fiber_m`, `fiber_a`, `fiber_e`, `triphala_m`, `triphala_a`, `triphala_e`, `others1name`, `o1_m`, `o1_a`, `o1_e`, `others2name`, `o2_m`, `o2_a`, `o2_e`, `others3name`, `o3_m`, `o3_a`, `o3_e`, `snack1`, `snack2`, `snack3`, `snack4`, `snack5`, `snack6`, `snack7`, `snack8`, `snack9`, `snack10`, `breakfast_pic`, `lunch_pic`, `dinner_pic`, `hdatasaved`, `snackssaved`) VALUES
(38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 29, 77, 4, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '5 gms protein powder', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms chicken', '/uploads/formFileLg-1759227617296-343451008.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', '/uploads/formFileLg-1757945889515-553507395.jpeg', 1, 0),
(39, '2025-09-03 13:25:00', 1, 2, '2025-05-02', 200, 300, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', '5 gms protein powder', '', '', '', '', '', '', '', '', '/uploads/formFileLg-1757936894666-610352675.jpeg', NULL, NULL, 1, 0),
(40, '2025-09-03 13:25:45', 1, 3, '2025-05-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0),
(41, '2025-09-03 14:01:05', 1, 15, '2025-05-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0),
(42, '2025-09-03 23:18:44', 1, 4, '2025-05-04', 50, 19, 7, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0),
(43, '2025-09-03 23:19:46', 1, 5, '2025-05-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0),
(44, '2025-09-03 23:22:52', 1, 6, '2025-05-06', 40, 40, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0),
(45, '2025-09-04 13:21:52', 98, 1, '2025-09-04', 10, 11, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0),
(46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms roasted soya nuts', '10 gms roasted soya nuts', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '10 gms chicken', '/uploads/formFileLg-1757482069873-359191508.jpeg', '/uploads/formFileLg-1757490943111-714007532.jpeg', NULL, 1, 0),
(47, '2025-09-07 22:03:35', 104, 2, '2025-09-07', 20, 20, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0),
(48, '2025-09-08 06:41:30', 104, 3, '2025-09-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0),
(49, '2025-09-10 10:58:01', 104, 5, '2025-09-10', 22, 222, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '1 egg white', '', '', '', '', '', '', '', '', '', NULL, NULL, NULL, 1, 0),
(50, '2025-09-15 18:10:23', 1, 8, '2025-05-08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0),
(51, '2025-09-15 19:12:15', 2, 1, '2025-05-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0),
(52, '2025-09-15 19:57:54', 1, 11, '2025-05-11', 11, 11, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0),
(53, '2025-09-15 20:15:17', 1, 48, '2025-06-17', 22, 222, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0);

--
-- Triggers `tf_wldialydata`
--
DELIMITER $$
CREATE TRIGGER `tf_wldialydata_before_delete` BEFORE DELETE ON `tf_wldialydata` FOR EACH ROW BEGIN
  INSERT INTO `tf_wldialydata_history` (
    `id`, `tdate`, `Cust_ID`, `dayofprogram`, `dopdate`, `weight`, `steps`, `waterintake`, `p_m`, `p_a`, `p_e`,
    `mv_m`, `mv_a`, `mv_e`, `omega3_m`, `omega3_a`, `omega3_e`, `cal_m`, `cal_a`, `cal_e`, `vb_m`, `vb_a`, `vb_e`,
    `vc_m`, `vc_a`, `vc_e`, `fiber_m`, `fiber_a`, `fiber_e`, `triphala_m`, `triphala_a`, `triphala_e`, `others1name`,
    `o1_m`, `o1_a`, `o1_e`, `others2name`, `o2_m`, `o2_a`, `o2_e`, `others3name`, `o3_m`, `o3_a`, `o3_e`, `snack1`,
    `snack2`, `snack3`, `snack4`, `snack5`, `snack6`, `snack7`, `snack8`, `snack9`, `snack10`, `breakfast_pic`,
    `lunch_pic`, `dinner_pic`, `hdatasaved`, `snackssaved`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`tdate`, OLD.`Cust_ID`, OLD.`dayofprogram`, OLD.`dopdate`, OLD.`weight`, OLD.`steps`, OLD.`waterintake`,
    OLD.`p_m`, OLD.`p_a`, OLD.`p_e`, OLD.`mv_m`, OLD.`mv_a`, OLD.`mv_e`, OLD.`omega3_m`, OLD.`omega3_a`, OLD.`omega3_e`,
    OLD.`cal_m`, OLD.`cal_a`, OLD.`cal_e`, OLD.`vb_m`, OLD.`vb_a`, OLD.`vb_e`, OLD.`vc_m`, OLD.`vc_a`, OLD.`vc_e`,
    OLD.`fiber_m`, OLD.`fiber_a`, OLD.`fiber_e`, OLD.`triphala_m`, OLD.`triphala_a`, OLD.`triphala_e`, OLD.`others1name`,
    OLD.`o1_m`, OLD.`o1_a`, OLD.`o1_e`, OLD.`others2name`, OLD.`o2_m`, OLD.`o2_a`, OLD.`o2_e`, OLD.`others3name`,
    OLD.`o3_m`, OLD.`o3_a`, OLD.`o3_e`, OLD.`snack1`, OLD.`snack2`, OLD.`snack3`, OLD.`snack4`, OLD.`snack5`,
    OLD.`snack6`, OLD.`snack7`, OLD.`snack8`, OLD.`snack9`, OLD.`snack10`, OLD.`breakfast_pic`, OLD.`lunch_pic`,
    OLD.`dinner_pic`, OLD.`hdatasaved`, OLD.`snackssaved`, 'DELETE', NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tf_wldialydata_before_update` BEFORE UPDATE ON `tf_wldialydata` FOR EACH ROW BEGIN
  INSERT INTO `tf_wldialydata_history` (
    `id`, `tdate`, `Cust_ID`, `dayofprogram`, `dopdate`, `weight`, `steps`, `waterintake`, `p_m`, `p_a`, `p_e`,
    `mv_m`, `mv_a`, `mv_e`, `omega3_m`, `omega3_a`, `omega3_e`, `cal_m`, `cal_a`, `cal_e`, `vb_m`, `vb_a`, `vb_e`,
    `vc_m`, `vc_a`, `vc_e`, `fiber_m`, `fiber_a`, `fiber_e`, `triphala_m`, `triphala_a`, `triphala_e`, `others1name`,
    `o1_m`, `o1_a`, `o1_e`, `others2name`, `o2_m`, `o2_a`, `o2_e`, `others3name`, `o3_m`, `o3_a`, `o3_e`, `snack1`,
    `snack2`, `snack3`, `snack4`, `snack5`, `snack6`, `snack7`, `snack8`, `snack9`, `snack10`, `breakfast_pic`,
    `lunch_pic`, `dinner_pic`, `hdatasaved`, `snackssaved`, `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`tdate`, OLD.`Cust_ID`, OLD.`dayofprogram`, OLD.`dopdate`, OLD.`weight`, OLD.`steps`, OLD.`waterintake`,
    OLD.`p_m`, OLD.`p_a`, OLD.`p_e`, OLD.`mv_m`, OLD.`mv_a`, OLD.`mv_e`, OLD.`omega3_m`, OLD.`omega3_a`, OLD.`omega3_e`,
    OLD.`cal_m`, OLD.`cal_a`, OLD.`cal_e`, OLD.`vb_m`, OLD.`vb_a`, OLD.`vb_e`, OLD.`vc_m`, OLD.`vc_a`, OLD.`vc_e`,
    OLD.`fiber_m`, OLD.`fiber_a`, OLD.`fiber_e`, OLD.`triphala_m`, OLD.`triphala_a`, OLD.`triphala_e`, OLD.`others1name`,
    OLD.`o1_m`, OLD.`o1_a`, OLD.`o1_e`, OLD.`others2name`, OLD.`o2_m`, OLD.`o2_a`, OLD.`o2_e`, OLD.`others3name`,
    OLD.`o3_m`, OLD.`o3_a`, OLD.`o3_e`, OLD.`snack1`, OLD.`snack2`, OLD.`snack3`, OLD.`snack4`, OLD.`snack5`,
    OLD.`snack6`, OLD.`snack7`, OLD.`snack8`, OLD.`snack9`, OLD.`snack10`, OLD.`breakfast_pic`, OLD.`lunch_pic`,
    OLD.`dinner_pic`, OLD.`hdatasaved`, OLD.`snackssaved`, 'UPDATE', NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tf_wldialydata_history`
--

CREATE TABLE `tf_wldialydata_history` (
  `history_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `tdate` datetime NOT NULL DEFAULT current_timestamp(),
  `Cust_ID` int(11) NOT NULL,
  `dayofprogram` int(11) NOT NULL,
  `dopdate` date NOT NULL,
  `weight` float DEFAULT NULL,
  `steps` int(11) DEFAULT NULL,
  `waterintake` float DEFAULT NULL,
  `p_m` tinyint(1) DEFAULT NULL,
  `p_a` tinyint(1) DEFAULT NULL,
  `p_e` tinyint(1) DEFAULT NULL,
  `mv_m` tinyint(1) DEFAULT NULL,
  `mv_a` tinyint(1) DEFAULT NULL,
  `mv_e` tinyint(1) DEFAULT NULL,
  `omega3_m` tinyint(1) DEFAULT NULL,
  `omega3_a` tinyint(1) DEFAULT NULL,
  `omega3_e` tinyint(1) DEFAULT NULL,
  `cal_m` tinyint(1) DEFAULT NULL,
  `cal_a` tinyint(1) DEFAULT NULL,
  `cal_e` tinyint(1) DEFAULT NULL,
  `vb_m` tinyint(1) DEFAULT NULL,
  `vb_a` tinyint(1) DEFAULT NULL,
  `vb_e` tinyint(1) DEFAULT NULL,
  `vc_m` tinyint(1) DEFAULT NULL,
  `vc_a` tinyint(1) DEFAULT NULL,
  `vc_e` tinyint(1) DEFAULT NULL,
  `fiber_m` tinyint(1) DEFAULT NULL,
  `fiber_a` tinyint(1) DEFAULT NULL,
  `fiber_e` tinyint(1) DEFAULT NULL,
  `triphala_m` tinyint(1) DEFAULT NULL,
  `triphala_a` tinyint(1) DEFAULT NULL,
  `triphala_e` tinyint(1) DEFAULT NULL,
  `others1name` varchar(25) DEFAULT NULL,
  `o1_m` tinyint(1) DEFAULT NULL,
  `o1_a` tinyint(1) DEFAULT NULL,
  `o1_e` tinyint(1) DEFAULT NULL,
  `others2name` varchar(25) DEFAULT NULL,
  `o2_m` tinyint(1) DEFAULT NULL,
  `o2_a` tinyint(1) DEFAULT NULL,
  `o2_e` tinyint(1) DEFAULT NULL,
  `others3name` varchar(25) DEFAULT NULL,
  `o3_m` tinyint(1) DEFAULT NULL,
  `o3_a` tinyint(1) DEFAULT NULL,
  `o3_e` tinyint(1) DEFAULT NULL,
  `snack1` varchar(50) DEFAULT NULL,
  `snack2` varchar(50) DEFAULT NULL,
  `snack3` varchar(50) DEFAULT NULL,
  `snack4` varchar(50) DEFAULT NULL,
  `snack5` varchar(50) DEFAULT NULL,
  `snack6` varchar(50) DEFAULT NULL,
  `snack7` varchar(50) DEFAULT NULL,
  `snack8` varchar(50) DEFAULT NULL,
  `snack9` varchar(50) DEFAULT NULL,
  `snack10` varchar(50) DEFAULT NULL,
  `breakfast_pic` varchar(100) DEFAULT NULL,
  `lunch_pic` varchar(100) DEFAULT NULL,
  `dinner_pic` varchar(100) DEFAULT NULL,
  `hdatasaved` int(11) NOT NULL DEFAULT 0,
  `snackssaved` int(11) NOT NULL DEFAULT 0,
  `history_action` enum('UPDATE','DELETE') NOT NULL,
  `history_timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_wldialydata_history`
--

INSERT INTO `tf_wldialydata_history` (`history_id`, `id`, `tdate`, `Cust_ID`, `dayofprogram`, `dopdate`, `weight`, `steps`, `waterintake`, `p_m`, `p_a`, `p_e`, `mv_m`, `mv_a`, `mv_e`, `omega3_m`, `omega3_a`, `omega3_e`, `cal_m`, `cal_a`, `cal_e`, `vb_m`, `vb_a`, `vb_e`, `vc_m`, `vc_a`, `vc_e`, `fiber_m`, `fiber_a`, `fiber_e`, `triphala_m`, `triphala_a`, `triphala_e`, `others1name`, `o1_m`, `o1_a`, `o1_e`, `others2name`, `o2_m`, `o2_a`, `o2_e`, `others3name`, `o3_m`, `o3_a`, `o3_e`, `snack1`, `snack2`, `snack3`, `snack4`, `snack5`, `snack6`, `snack7`, `snack8`, `snack9`, `snack10`, `breakfast_pic`, `lunch_pic`, `dinner_pic`, `hdatasaved`, `snackssaved`, `history_action`, `history_timestamp`) VALUES
(1, 2, '2025-05-03 09:00:00', 2, 1, '2025-05-03', 64.8, 6000, 2.5, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, NULL, 0, 0, 0, NULL, 0, 0, 0, NULL, 0, 0, 0, 'Yogurt', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'breakfast2.jpg', 'lunch2.jpg', 'dinner2.jpg', 1, 1, 'DELETE', '2025-05-12 12:09:39'),
(2, 181, '2025-05-12 12:08:49', 1, 10, '2025-05-10', 11, 11, 11, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'DELETE', '2025-05-12 12:09:39'),
(3, 182, '2025-05-12 12:09:59', 1, 1, '2023-04-11', 20, 20, 20, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-05-12 12:10:40'),
(4, 183, '2025-05-14 11:19:13', 2, 1, '2023-04-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '10 gms roasted soya nuts', '10 gms roasted soya nuts', '5 gms protein powder', '1 slice fat free cheese', '20 gms fat free curds', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-05-14 11:36:46'),
(26, 182, '2025-05-12 12:09:59', 1, 1, '2023-04-11', 13, 13, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-05-15 16:22:57'),
(47, 212, '2025-05-27 22:38:21', 1, 28, '2025-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-25 16:29:34'),
(48, 213, '2025-06-03 21:56:04', 1, 35, '2025-06-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-25 16:29:34'),
(49, 182, '2025-05-12 12:09:59', 1, 1, '2023-04-11', 13, 13, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-08-26 13:29:15'),
(50, 182, '2025-05-12 12:09:59', 1, 1, '2025-04-11', 13, 13, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-08-26 13:29:24'),
(55, 214, '2025-08-25 16:36:08', 1, 1, '2025-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-08-26 13:29:45'),
(56, 182, '2025-05-12 12:09:59', 1, 1, '2025-05-04', 13, 13, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-08-26 13:30:00'),
(57, 214, '2025-08-25 16:36:08', 1, 1, '2025-05-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-08-26 13:30:08'),
(58, 221, '2025-06-01 08:00:00', 1, 1, '2025-06-01', 85, 7500, 2, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'Nuts', 0, 0, 0, 'Fruit', 0, 0, 0, NULL, 0, 0, 0, 'SnackA', 'SnackB', 'SnackC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'breakfast1.jpg', 'lunch1.jpg', 'dinner1.jpg', 1, 1, 'UPDATE', '2025-08-26 13:30:13'),
(59, 215, '2025-05-01 08:00:00', 1, 1, '2025-05-01', 85, 7500, 2, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'Nuts', 0, 0, 0, 'Fruit', 0, 0, 0, NULL, 0, 0, 0, 'SnackA', 'SnackB', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'breakfast1.jpg', 'lunch1.jpg', 'dinner1.jpg', 1, 1, 'UPDATE', '2025-08-26 13:30:30'),
(60, 221, '2025-06-01 08:00:00', 1, 1, '2025-06-01', 88, 7500, 2, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'Nuts', 0, 0, 0, 'Fruit', 0, 0, 0, NULL, 0, 0, 0, 'SnackA', 'SnackB', 'SnackC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'breakfast1.jpg', 'lunch1.jpg', 'dinner1.jpg', 1, 1, 'UPDATE', '2025-08-26 13:30:38'),
(61, 222, '2025-06-02 08:00:00', 1, 2, '2025-06-02', 84.7, 7600, 2.1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 'Honey', 1, 0, 0, 'Nuts', 0, 1, 0, NULL, 0, 0, 0, 'SnackD', 'SnackE', 'SnackF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'breakfast2.jpg', 'lunch2.jpg', 'dinner2.jpg', 1, 1, 'UPDATE', '2025-08-26 13:30:47'),
(62, 223, '2025-06-03 08:00:00', 1, 3, '2025-06-03', 84.3, 7400, 1.8, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 'Fruit', 0, 1, 0, 'Honey', 0, 0, 1, NULL, 0, 0, 0, 'SnackG', 'SnackH', 'SnackI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'breakfast3.jpg', 'lunch3.jpg', 'dinner3.jpg', 1, 1, 'UPDATE', '2025-08-26 13:30:54'),
(63, 224, '2025-06-04 08:00:00', 1, 4, '2025-06-04', 83.9, 7700, 2.2, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 'Nuts', 1, 0, 0, 'Fruit', 1, 0, 0, NULL, 0, 0, 0, 'SnackJ', 'SnackK', 'SnackL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'breakfast4.jpg', 'lunch4.jpg', 'dinner4.jpg', 1, 1, 'UPDATE', '2025-08-26 13:31:03'),
(64, 225, '2025-06-05 08:00:00', 1, 5, '2025-06-05', 83.6, 7300, 2, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 'Honey', 0, 1, 0, 'Nuts', 0, 0, 1, NULL, 0, 0, 0, 'SnackM', 'SnackN', 'SnackO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'breakfast5.jpg', 'lunch5.jpg', 'dinner5.jpg', 1, 1, 'UPDATE', '2025-08-26 13:31:12'),
(65, 182, '2025-05-12 12:09:59', 1, 1, '2025-05-04', 85, 13, 13, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', '10 gms fish', NULL, NULL, NULL, 1, 0, 'DELETE', '2025-08-26 19:46:37'),
(66, 214, '2025-08-25 16:36:08', 1, 1, '2025-05-05', 86, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(67, 215, '2025-05-01 08:00:00', 1, 1, '2025-05-06', 85, 7500, 2, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'Nuts', 0, 0, 0, 'Fruit', 0, 0, 0, NULL, 0, 0, 0, 'SnackA', 'SnackB', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'breakfast1.jpg', 'lunch1.jpg', 'dinner1.jpg', 1, 1, 'DELETE', '2025-08-26 19:46:37'),
(68, 221, '2025-06-01 08:00:00', 1, 1, '2025-05-07', 88, 7500, 2, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'Nuts', 0, 0, 0, 'Fruit', 0, 0, 0, NULL, 0, 0, 0, 'SnackA', 'SnackB', 'SnackC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'breakfast1.jpg', 'lunch1.jpg', 'dinner1.jpg', 1, 1, 'DELETE', '2025-08-26 19:46:37'),
(69, 222, '2025-06-02 08:00:00', 1, 2, '2025-05-08', 84.7, 7600, 2.1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 'Honey', 1, 0, 0, 'Nuts', 0, 1, 0, NULL, 0, 0, 0, 'SnackD', 'SnackE', 'SnackF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'breakfast2.jpg', 'lunch2.jpg', 'dinner2.jpg', 1, 1, 'DELETE', '2025-08-26 19:46:37'),
(70, 223, '2025-06-03 08:00:00', 1, 3, '2025-05-09', 84.3, 7400, 1.8, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 'Fruit', 0, 1, 0, 'Honey', 0, 0, 1, NULL, 0, 0, 0, 'SnackG', 'SnackH', 'SnackI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'breakfast3.jpg', 'lunch3.jpg', 'dinner3.jpg', 1, 1, 'DELETE', '2025-08-26 19:46:37'),
(71, 224, '2025-06-04 08:00:00', 1, 4, '2025-05-10', 83.9, 7700, 2.2, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 'Nuts', 1, 0, 0, 'Fruit', 1, 0, 0, NULL, 0, 0, 0, 'SnackJ', 'SnackK', 'SnackL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'breakfast4.jpg', 'lunch4.jpg', 'dinner4.jpg', 1, 1, 'DELETE', '2025-08-26 19:46:37'),
(72, 225, '2025-06-05 08:00:00', 1, 5, '2025-05-11', 83.6, 7300, 2, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 'Honey', 0, 1, 0, 'Nuts', 0, 0, 1, NULL, 0, 0, 0, 'SnackM', 'SnackN', 'SnackO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'breakfast5.jpg', 'lunch5.jpg', 'dinner5.jpg', 1, 1, 'DELETE', '2025-08-26 19:46:37'),
(73, 226, '2025-06-03 00:00:00', 1, 1, '2025-06-03', 85, 7500, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(74, 227, '2025-06-09 00:00:00', 1, 2, '2025-06-09', 84.8, 7600, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(75, 228, '2025-06-15 00:00:00', 1, 3, '2025-06-15', 84.5, 7400, 1.9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(76, 229, '2025-06-22 00:00:00', 1, 4, '2025-06-22', 84.3, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(77, 230, '2025-06-28 00:00:00', 1, 5, '2025-06-28', 84, 7300, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(78, 231, '2025-07-02 00:00:00', 1, 6, '2025-07-02', 83.8, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(79, 232, '2025-07-08 00:00:00', 1, 7, '2025-07-08', 83.5, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(80, 233, '2025-07-14 00:00:00', 1, 8, '2025-07-14', 83.3, 7700, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(81, 234, '2025-07-20 00:00:00', 1, 9, '2025-07-20', 83.1, 7500, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(82, 235, '2025-07-27 00:00:00', 1, 10, '2025-07-27', 83, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(83, 236, '2025-08-04 00:00:00', 1, 11, '2025-08-04', 82.8, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(84, 237, '2025-08-10 00:00:00', 1, 12, '2025-08-10', 82.6, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(85, 238, '2025-08-16 00:00:00', 1, 13, '2025-08-16', 82.4, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(86, 239, '2025-08-22 00:00:00', 1, 14, '2025-08-22', 82.2, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(87, 240, '2025-08-29 00:00:00', 1, 15, '2025-08-29', 82, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(88, 241, '2025-09-05 00:00:00', 1, 16, '2025-09-05', 81.8, 7700, 2.4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:37'),
(89, 242, '2025-09-11 00:00:00', 1, 17, '2025-09-11', 81.6, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:59'),
(90, 243, '2025-09-17 00:00:00', 1, 18, '2025-09-17', 81.5, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:59'),
(91, 244, '2025-09-23 00:00:00', 1, 19, '2025-09-23', 81.3, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:59'),
(92, 245, '2025-09-29 00:00:00', 1, 20, '2025-09-29', 81.2, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:59'),
(93, 246, '2025-10-04 00:00:00', 1, 21, '2025-10-04', 81, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:59'),
(94, 247, '2025-10-10 00:00:00', 1, 22, '2025-10-10', 80.8, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:59'),
(95, 248, '2025-10-15 00:00:00', 1, 23, '2025-10-15', 80.6, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:59'),
(96, 249, '2025-10-21 00:00:00', 1, 24, '2025-10-21', 80.4, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:59'),
(97, 250, '2025-10-27 00:00:00', 1, 25, '2025-10-27', 80.3, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:59'),
(98, 251, '2025-11-03 00:00:00', 1, 26, '2025-11-03', 80.1, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:59'),
(99, 252, '2025-11-09 00:00:00', 1, 27, '2025-11-09', 80, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:59'),
(100, 253, '2025-11-15 00:00:00', 1, 28, '2025-11-15', 79.8, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:59'),
(101, 254, '2025-11-21 00:00:00', 1, 29, '2025-11-21', 79.6, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:59'),
(102, 255, '2025-11-27 00:00:00', 1, 30, '2025-11-27', 79.5, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:46:59'),
(103, 256, '2025-12-05 00:00:00', 1, 31, '2025-12-05', 79.3, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:00'),
(104, 257, '2025-12-11 00:00:00', 1, 32, '2025-12-11', 79.2, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:00'),
(105, 258, '2025-12-17 00:00:00', 1, 33, '2025-12-17', 79, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:00'),
(106, 259, '2025-12-23 00:00:00', 1, 34, '2025-12-23', 78.8, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:00'),
(107, 260, '2025-12-29 00:00:00', 1, 35, '2025-12-29', 78.7, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:00'),
(108, 261, '2026-01-06 00:00:00', 1, 36, '2026-01-06', 78.5, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:00'),
(109, 262, '2026-01-12 00:00:00', 1, 37, '2026-01-12', 78.4, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:00'),
(110, 263, '2026-01-18 00:00:00', 1, 38, '2026-01-18', 78.2, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:00'),
(111, 264, '2026-01-24 00:00:00', 1, 39, '2026-01-24', 78, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:00'),
(112, 265, '2026-01-30 00:00:00', 1, 40, '2026-01-30', 77.9, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:00'),
(113, 1, '2025-05-03 08:00:00', 1, 1, '2025-05-03', 84.5, 8000, 2, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, NULL, 0, 0, 0, NULL, 0, 0, 0, NULL, 0, 0, 0, 'Nuts', 'Fruit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'breakfast1.jpg', 'lunch1.jpg', 'dinner1.jpg', 1, 1, 'DELETE', '2025-08-26 19:47:32'),
(114, 266, '2026-02-05 00:00:00', 1, 41, '2026-02-05', 77.7, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:32'),
(115, 267, '2026-02-11 00:00:00', 1, 42, '2026-02-11', 77.6, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:32'),
(116, 268, '2026-02-17 00:00:00', 1, 43, '2026-02-17', 77.4, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:32'),
(117, 269, '2026-02-23 00:00:00', 1, 44, '2026-02-23', 77.2, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:32'),
(118, 270, '2026-02-28 00:00:00', 1, 45, '2026-02-28', 77, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:32'),
(119, 271, '2026-03-04 00:00:00', 1, 46, '2026-03-04', 76.9, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:32'),
(120, 272, '2026-03-10 00:00:00', 1, 47, '2026-03-10', 76.7, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:32'),
(121, 273, '2026-03-16 00:00:00', 1, 48, '2026-03-16', 76.6, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:32'),
(122, 274, '2026-03-22 00:00:00', 1, 49, '2026-03-22', 76.4, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:32'),
(123, 275, '2026-03-28 00:00:00', 1, 50, '2026-03-28', 76.2, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:32'),
(124, 276, '2026-04-03 00:00:00', 1, 51, '2026-04-03', 76, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:32'),
(125, 277, '2026-04-09 00:00:00', 1, 52, '2026-04-09', 75.9, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:32'),
(126, 278, '2026-04-15 00:00:00', 1, 53, '2026-04-15', 75.7, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:32'),
(127, 279, '2026-04-21 00:00:00', 1, 54, '2026-04-21', 75.5, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:32'),
(128, 280, '2026-04-27 00:00:00', 1, 55, '2026-04-27', 75.3, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:47:32'),
(129, 16, '2024-01-07 00:00:00', 1, 16, '2024-01-07', 82.5, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(130, 17, '2024-01-12 00:00:00', 1, 17, '2024-01-12', 82.4, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(131, 18, '2024-01-18 00:00:00', 1, 18, '2024-01-18', 82.3, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(132, 19, '2024-01-23 00:00:00', 1, 19, '2024-01-23', 82.2, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(133, 20, '2024-01-29 00:00:00', 1, 20, '2024-01-29', 82.1, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(134, 21, '2024-02-03 00:00:00', 1, 21, '2024-02-03', 82, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(135, 22, '2024-02-09 00:00:00', 1, 22, '2024-02-09', 81.9, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(136, 23, '2024-02-14 00:00:00', 1, 23, '2024-02-14', 81.8, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(137, 24, '2024-02-20 00:00:00', 1, 24, '2024-02-20', 81.7, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(138, 25, '2024-02-25 00:00:00', 1, 25, '2024-02-25', 81.6, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(139, 26, '2024-03-04 00:00:00', 1, 26, '2024-03-04', 81.5, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(140, 27, '2024-03-09 00:00:00', 1, 27, '2024-03-09', 81.4, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(141, 28, '2024-03-15 00:00:00', 1, 28, '2024-03-15', 81.3, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(142, 29, '2024-03-20 00:00:00', 1, 29, '2024-03-20', 81.2, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(143, 30, '2024-03-26 00:00:00', 1, 30, '2024-03-26', 81.1, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(144, 31, '2024-04-05 00:00:00', 1, 31, '2024-04-05', 81, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(145, 32, '2024-04-11 00:00:00', 1, 32, '2024-04-11', 80.9, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(146, 33, '2024-04-17 00:00:00', 1, 33, '2024-04-17', 80.8, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(147, 34, '2024-04-21 00:00:00', 1, 34, '2024-04-21', 80.7, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(148, 35, '2024-04-25 00:00:00', 1, 35, '2024-04-25', 80.6, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-08-26 19:56:44'),
(149, 37, '2025-09-03 13:14:17', 1, 4, '2025-05-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-09-03 13:14:34'),
(150, 1, '2025-01-05 00:00:00', 1, 1, '2025-01-05', 85, 7500, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-09-03 13:23:46'),
(151, 2, '2025-01-11 00:00:00', 1, 2, '2025-01-11', 84.8, 7600, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-09-03 13:23:46'),
(152, 3, '2025-01-17 00:00:00', 1, 3, '2025-01-17', 84.6, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-09-03 13:23:46'),
(153, 4, '2025-01-23 00:00:00', 1, 4, '2025-01-23', 84.4, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-09-03 13:23:46'),
(154, 5, '2025-01-29 00:00:00', 1, 5, '2025-01-29', 84.2, 7300, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-09-03 13:23:46'),
(155, 6, '2025-02-04 00:00:00', 1, 6, '2025-02-04', 84, 7600, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-09-03 13:23:46'),
(156, 7, '2025-02-10 00:00:00', 1, 7, '2025-02-10', 83.8, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-09-03 13:23:46'),
(157, 8, '2025-02-15 00:00:00', 1, 8, '2025-02-15', 83.6, 7700, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-09-03 13:23:46'),
(158, 9, '2025-02-21 00:00:00', 1, 9, '2025-02-21', 83.4, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-09-03 13:23:46'),
(159, 10, '2025-02-27 00:00:00', 1, 10, '2025-02-27', 83.2, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-09-03 13:23:46'),
(160, 11, '2025-03-01 00:00:00', 1, 11, '2025-03-01', 83, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-09-03 13:23:46'),
(161, 12, '2025-03-03 00:00:00', 1, 12, '2025-03-03', 82.9, 7500, 2.1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-09-03 13:23:46'),
(162, 13, '2025-03-05 00:00:00', 1, 13, '2025-03-05', 82.8, 7600, 2.2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-09-03 13:23:46'),
(163, 14, '2025-03-07 00:00:00', 1, 14, '2025-03-07', 82.7, 7700, 2.3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-09-03 13:23:46'),
(164, 15, '2025-03-09 00:00:00', 1, 15, '2025-03-09', 82.6, 7400, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-09-03 13:23:46'),
(165, 36, '2025-08-26 20:10:48', 1, 1, '2025-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-09-03 13:23:46'),
(166, 37, '2025-09-03 13:14:17', 1, 4, '2025-05-04', 78, 78, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 1, 0, 0, '', 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'DELETE', '2025-09-03 13:23:46'),
(167, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-09-03 13:24:36'),
(168, 39, '2025-09-03 13:25:00', 1, 2, '2025-05-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-09-03 13:25:30'),
(169, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 20, 30, 4, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-03 13:26:50'),
(170, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 60, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-03 13:27:25'),
(171, 42, '2025-09-03 23:18:44', 1, 4, '2025-05-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-09-03 23:19:01');
INSERT INTO `tf_wldialydata_history` (`history_id`, `id`, `tdate`, `Cust_ID`, `dayofprogram`, `dopdate`, `weight`, `steps`, `waterintake`, `p_m`, `p_a`, `p_e`, `mv_m`, `mv_a`, `mv_e`, `omega3_m`, `omega3_a`, `omega3_e`, `cal_m`, `cal_a`, `cal_e`, `vb_m`, `vb_a`, `vb_e`, `vc_m`, `vc_a`, `vc_e`, `fiber_m`, `fiber_a`, `fiber_e`, `triphala_m`, `triphala_a`, `triphala_e`, `others1name`, `o1_m`, `o1_a`, `o1_e`, `others2name`, `o2_m`, `o2_a`, `o2_e`, `others3name`, `o3_m`, `o3_a`, `o3_e`, `snack1`, `snack2`, `snack3`, `snack4`, `snack5`, `snack6`, `snack7`, `snack8`, `snack9`, `snack10`, `breakfast_pic`, `lunch_pic`, `dinner_pic`, `hdatasaved`, `snackssaved`, `history_action`, `history_timestamp`) VALUES
(172, 44, '2025-09-03 23:22:52', 1, 6, '2025-05-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-09-03 23:23:17'),
(173, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 60, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '/uploads/formFileLg-1756886245357-566072627.jpeg', NULL, NULL, 1, 0, 'UPDATE', '2025-09-04 13:31:39'),
(174, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 40, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '/uploads/formFileLg-1756886245357-566072627.jpeg', NULL, NULL, 1, 0, 'UPDATE', '2025-09-04 13:32:20'),
(175, 45, '2025-09-04 13:21:52', 98, 1, '2025-09-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-09-04 13:44:31'),
(176, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-09-06 19:43:11'),
(177, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 10, 20, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-06 20:26:03'),
(178, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 20, 20, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-06 20:27:44'),
(179, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 20, 20, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 15:59:15'),
(180, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 10, 2000, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 16:01:19'),
(181, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 22, 222, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 20:28:42'),
(182, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 22, 222, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 20:29:38'),
(183, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 11, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 20:33:33'),
(184, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 22, 111, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 20:40:18'),
(185, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 22, 111, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 20:44:22'),
(186, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 22, 111, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 20:46:30'),
(187, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 33, 111, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 20:51:29'),
(188, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 33, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 21:17:43'),
(189, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 33, 111, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 21:17:58'),
(190, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 33, 111, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 21:18:13'),
(191, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 33, 111, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 21:23:02'),
(192, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 33, 111, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 21:24:33'),
(193, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 33, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 21:31:04'),
(194, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 33, 111, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 21:31:18'),
(195, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 33, 111, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 21:33:53'),
(196, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 33, 111, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 21:34:17'),
(197, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 33, 111, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 21:34:30'),
(198, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 33, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 21:40:52'),
(199, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 21:44:06'),
(200, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 21:45:51'),
(201, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-07 21:49:22'),
(202, 47, '2025-09-07 22:03:35', 104, 2, '2025-09-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-09-07 22:08:45'),
(203, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-08 07:35:18'),
(204, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms roasted soya nuts', '10 gms roasted soya nuts', '5 gms protein powder', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-08 07:35:19'),
(205, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms roasted soya nuts', '10 gms roasted soya nuts', '5 gms protein powder', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-08 07:35:21'),
(206, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms roasted soya nuts', '10 gms roasted soya nuts', '5 gms protein powder', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-08 07:35:28'),
(207, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms roasted soya nuts', '10 gms roasted soya nuts', '5 gms protein powder', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-08 07:37:12'),
(208, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms roasted soya nuts', '10 gms roasted soya nuts', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '10 gms fish', NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-08 07:37:14'),
(209, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms roasted soya nuts', '10 gms roasted soya nuts', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '10 gms fish', NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-10 10:57:02'),
(210, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms roasted soya nuts', '10 gms roasted soya nuts', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '10 gms fish', NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-10 10:57:03'),
(211, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms roasted soya nuts', '10 gms roasted soya nuts', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '10 gms fish', NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-10 10:57:11'),
(212, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms roasted soya nuts', '10 gms roasted soya nuts', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '10 gms fish', NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-10 10:57:13'),
(213, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms roasted soya nuts', '10 gms roasted soya nuts', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '10 gms chicken', NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-10 10:57:15'),
(214, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms roasted soya nuts', '10 gms roasted soya nuts', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '10 gms chicken', NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-10 10:57:29'),
(215, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms roasted soya nuts', '10 gms roasted soya nuts', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '10 gms chicken', NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-10 10:57:49'),
(216, 49, '2025-09-10 10:58:01', 104, 5, '2025-09-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-09-10 10:58:07'),
(217, 49, '2025-09-10 10:58:01', 104, 5, '2025-09-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1 egg white', '', '', '', '', '', '', '', '', '', NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-09-10 10:58:13'),
(218, 49, '2025-09-10 10:58:01', 104, 5, '2025-09-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1 egg white', '', '', '', '', '', '', '', '', '', NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-09-10 10:58:27'),
(219, 49, '2025-09-10 10:58:01', 104, 5, '2025-09-10', 22, 222, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '1 egg white', '', '', '', '', '', '', '', '', '', NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-10 12:52:49'),
(220, 46, '2025-09-06 19:43:02', 104, 1, '2025-09-06', 44, 111, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms roasted soya nuts', '10 gms roasted soya nuts', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '5 gms protein powder', '10 gms chicken', '/uploads/formFileLg-1757482069873-359191508.jpeg', NULL, NULL, 1, 0, 'UPDATE', '2025-09-10 13:25:43'),
(221, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 40, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '/uploads/formFileLg-1756886245357-566072627.jpeg', NULL, NULL, 1, 0, 'UPDATE', '2025-09-15 12:44:08'),
(222, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 40, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms mutton', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms chicken', '10 gms chicken', '10 gms mutton', '10 gms mutton', '1 egg white', '10 gms chicken', '/uploads/formFileLg-1756886245357-566072627.jpeg', NULL, NULL, 1, 0, 'UPDATE', '2025-09-15 12:44:54'),
(223, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 40, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms mutton', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms chicken', '10 gms chicken', '10 gms mutton', '10 gms mutton', '1 egg white', '10 gms chicken', '/uploads/formFileLg-1756886245357-566072627.jpeg', '/uploads/formFileLg-1757920494979-734599822.jpeg', NULL, 1, 0, 'UPDATE', '2025-09-15 12:44:57'),
(224, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 40, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms mutton', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms chicken', '10 gms chicken', '10 gms mutton', '10 gms mutton', '1 egg white', '10 gms chicken', '/uploads/formFileLg-1756886245357-566072627.jpeg', '/uploads/formFileLg-1757920497326-859535137.jpeg', NULL, 1, 0, 'UPDATE', '2025-09-15 12:44:59'),
(225, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 40, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms mutton', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms chicken', '10 gms chicken', '10 gms mutton', '10 gms mutton', '1 egg white', '10 gms chicken', '/uploads/formFileLg-1756886245357-566072627.jpeg', '/uploads/formFileLg-1757920499740-513107048.jpeg', NULL, 1, 0, 'UPDATE', '2025-09-15 12:45:01'),
(226, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 40, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms mutton', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms chicken', '10 gms chicken', '10 gms mutton', '10 gms mutton', '1 egg white', '10 gms chicken', '/uploads/formFileLg-1756886245357-566072627.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', NULL, 1, 0, 'UPDATE', '2025-09-15 12:45:22'),
(227, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 40, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms mutton', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms chicken', '10 gms chicken', '10 gms mutton', '10 gms mutton', '1 egg white', '10 gms chicken', '/uploads/formFileLg-1757920522121-331682402.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', NULL, 1, 0, 'UPDATE', '2025-09-15 16:18:15'),
(228, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 40, 4, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms mutton', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms chicken', '10 gms chicken', '10 gms mutton', '10 gms mutton', '1 egg white', '10 gms chicken', '/uploads/formFileLg-1757920522121-331682402.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', NULL, 1, 0, 'UPDATE', '2025-09-15 16:40:40'),
(229, 39, '2025-09-03 13:25:00', 1, 2, '2025-05-02', 200, 300, 4, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-15 17:17:58'),
(230, 39, '2025-09-03 13:25:00', 1, 2, '2025-05-02', 200, 300, 4, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', '5 gms protein powder', '', '', '', '', '', '', '', '', NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-15 17:18:14'),
(231, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 40, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms mutton', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms chicken', '10 gms chicken', '10 gms mutton', '10 gms mutton', '1 egg white', '10 gms chicken', '/uploads/formFileLg-1757920522121-331682402.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', NULL, 1, 0, 'UPDATE', '2025-09-15 18:09:47'),
(232, 39, '2025-09-03 13:25:00', 1, 2, '2025-05-02', 200, 300, 4, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', 0, 0, 0, '', '5 gms protein powder', '', '', '', '', '', '', '', '', '/uploads/formFileLg-1757936894666-610352675.jpeg', NULL, NULL, 1, 0, 'UPDATE', '2025-09-15 18:42:44'),
(233, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 40, 4, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms mutton', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms chicken', '10 gms chicken', '10 gms mutton', '10 gms mutton', '1 egg white', '10 gms chicken', '/uploads/formFileLg-1757920522121-331682402.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', NULL, 1, 0, 'UPDATE', '2025-09-15 18:42:58'),
(234, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 40, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms mutton', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms chicken', '10 gms chicken', '10 gms mutton', '10 gms mutton', '1 egg white', '10 gms chicken', '/uploads/formFileLg-1757920522121-331682402.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', NULL, 1, 0, 'UPDATE', '2025-09-15 18:43:08'),
(235, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 90, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms mutton', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms chicken', '10 gms chicken', '10 gms mutton', '10 gms mutton', '1 egg white', '10 gms chicken', '/uploads/formFileLg-1757920522121-331682402.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', NULL, 1, 0, 'UPDATE', '2025-09-15 18:49:58'),
(236, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 90, 4, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms mutton', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms chicken', '10 gms chicken', '10 gms mutton', '10 gms mutton', '1 egg white', '10 gms chicken', '/uploads/formFileLg-1757920522121-331682402.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', NULL, 1, 0, 'UPDATE', '2025-09-15 19:36:42'),
(237, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 90, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms mutton', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms chicken', '10 gms chicken', '10 gms mutton', '10 gms mutton', '1 egg white', '10 gms chicken', '/uploads/formFileLg-1757920522121-331682402.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', NULL, 1, 0, 'UPDATE', '2025-09-15 19:46:24'),
(238, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 98, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '10 gms mutton', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms chicken', '10 gms chicken', '10 gms mutton', '10 gms mutton', '1 egg white', '10 gms chicken', '/uploads/formFileLg-1757920522121-331682402.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', NULL, 1, 0, 'UPDATE', '2025-09-15 19:47:59'),
(239, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 98, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '5 gms protein powder', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms chicken', '/uploads/formFileLg-1757920522121-331682402.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', NULL, 1, 0, 'UPDATE', '2025-09-15 19:48:09'),
(240, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 98, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '5 gms protein powder', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms chicken', '/uploads/formFileLg-1757920522121-331682402.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', '/uploads/formFileLg-1757945889515-553507395.jpeg', 1, 0, 'UPDATE', '2025-09-15 19:54:38'),
(241, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 98, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '5 gms protein powder', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms chicken', '/uploads/formFileLg-1757920522121-331682402.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', '/uploads/formFileLg-1757945889515-553507395.jpeg', 1, 0, 'UPDATE', '2025-09-15 19:54:47'),
(242, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 98, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '5 gms protein powder', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms chicken', '/uploads/formFileLg-1757920522121-331682402.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', '/uploads/formFileLg-1757945889515-553507395.jpeg', 1, 0, 'UPDATE', '2025-09-15 19:56:58'),
(243, 52, '2025-09-15 19:57:54', 1, 11, '2025-05-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-09-15 19:58:35'),
(244, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 40, 77, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 0, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '5 gms protein powder', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms chicken', '/uploads/formFileLg-1757920522121-331682402.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', '/uploads/formFileLg-1757945889515-553507395.jpeg', 1, 0, 'UPDATE', '2025-09-15 20:15:03'),
(245, 53, '2025-09-15 20:15:17', 1, 48, '2025-06-17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-09-15 20:15:27'),
(246, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 22, 77, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '5 gms protein powder', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms chicken', '/uploads/formFileLg-1757920522121-331682402.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', '/uploads/formFileLg-1757945889515-553507395.jpeg', 1, 0, 'UPDATE', '2025-09-30 15:50:17'),
(247, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 22, 77, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '5 gms protein powder', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms chicken', '/uploads/formFileLg-1759227617296-343451008.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', '/uploads/formFileLg-1757945889515-553507395.jpeg', 1, 0, 'UPDATE', '2025-09-30 15:50:20'),
(248, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 22, 77, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '5 gms protein powder', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms chicken', '/uploads/formFileLg-1759227617296-343451008.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', '/uploads/formFileLg-1757945889515-553507395.jpeg', 1, 0, 'UPDATE', '2025-09-30 15:50:29'),
(249, 38, '2025-09-03 13:24:18', 1, 1, '2025-05-01', 29, 77, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '', 1, 1, 1, '5 gms protein powder', '10 gms chicken', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms mutton', '10 gms chicken', '/uploads/formFileLg-1759227617296-343451008.jpeg', '/uploads/formFileLg-1757920501188-442097924.jpeg', '/uploads/formFileLg-1757945889515-553507395.jpeg', 1, 0, 'UPDATE', '2025-09-30 15:50:32');

-- --------------------------------------------------------

--
-- Table structure for table `tf_wlweeklydata`
--

CREATE TABLE `tf_wlweeklydata` (
  `id` int(11) NOT NULL,
  `tdate` datetime NOT NULL DEFAULT current_timestamp(),
  `Cust_ID` int(11) NOT NULL,
  `dayofprogram` int(11) NOT NULL DEFAULT 1,
  `dopdate` date DEFAULT NULL,
  `neck` float DEFAULT NULL,
  `chest` float DEFAULT NULL,
  `leftarm` float DEFAULT NULL,
  `rightarm` float DEFAULT NULL,
  `waist` float DEFAULT NULL,
  `hips` float DEFAULT NULL,
  `leftthigh` float DEFAULT NULL,
  `rightthigh` float DEFAULT NULL,
  `leftcalf` float DEFAULT NULL,
  `rightcalf` float DEFAULT NULL,
  `body_pic1` varchar(256) DEFAULT NULL,
  `body_pic2` varchar(256) DEFAULT NULL,
  `body_pic3` varchar(256) DEFAULT NULL,
  `body_pic4` varchar(256) DEFAULT NULL,
  `bc_weight` float DEFAULT NULL,
  `bc_bmi` float DEFAULT NULL,
  `bc_bodyfat_percentage` float DEFAULT NULL,
  `bc_fatfreeweight` float DEFAULT NULL,
  `bc_subcutaneousfat` float DEFAULT NULL,
  `bc_visceralfat_percentage` float DEFAULT NULL,
  `bc_bodywater` float DEFAULT NULL,
  `bc_skeletalmuscle` float DEFAULT NULL,
  `bc_leanmuscle` float DEFAULT NULL,
  `bc_bonemass` float DEFAULT NULL,
  `bc_protein` float DEFAULT NULL,
  `bc_bmr` float DEFAULT NULL,
  `bc_metabolicage` float DEFAULT NULL,
  `bmsaved` int(11) NOT NULL DEFAULT 0,
  `bcsaved` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_wlweeklydata`
--

INSERT INTO `tf_wlweeklydata` (`id`, `tdate`, `Cust_ID`, `dayofprogram`, `dopdate`, `neck`, `chest`, `leftarm`, `rightarm`, `waist`, `hips`, `leftthigh`, `rightthigh`, `leftcalf`, `rightcalf`, `body_pic1`, `body_pic2`, `body_pic3`, `body_pic4`, `bc_weight`, `bc_bmi`, `bc_bodyfat_percentage`, `bc_fatfreeweight`, `bc_subcutaneousfat`, `bc_visceralfat_percentage`, `bc_bodywater`, `bc_skeletalmuscle`, `bc_leanmuscle`, `bc_bonemass`, `bc_protein`, `bc_bmr`, `bc_metabolicage`, `bmsaved`, `bcsaved`) VALUES
(24, '2025-05-25 14:47:14', 1, 5, '2025-05-04', 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 'uploads\\formFileSm-1748164716083-14735137.jpeg', 'uploads\\formFileSm-1748164730018-800408731.jpeg', NULL, NULL, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1, 1),
(25, '2025-05-27 22:39:06', 1, 28, '2025-05-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0),
(26, '2025-05-27 22:39:42', 1, 1, '2025-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0),
(27, '2025-06-03 19:29:37', 1, 1, '2025-06-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0),
(28, '2025-08-15 12:52:16', 1, 1, '2025-08-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0),
(29, '2025-08-18 12:29:15', 1, 1, '2025-08-18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0),
(30, '2025-08-26 20:10:56', 1, 1, '2025-08-26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0),
(31, '2025-09-03 23:19:54', 1, 1, '2025-09-03', 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0),
(32, '2025-09-15 12:47:02', 1, 1, '2025-09-15', 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0),
(33, '2025-09-30 15:50:40', 1, 1, '2025-09-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0);

--
-- Triggers `tf_wlweeklydata`
--
DELIMITER $$
CREATE TRIGGER `tf_wlweeklydata_before_delete` BEFORE DELETE ON `tf_wlweeklydata` FOR EACH ROW BEGIN
  INSERT INTO `tf_wlweeklydata_history` (
    `id`, `tdate`, `Cust_ID`, `dayofprogram`, `dopdate`, `neck`, `chest`, `leftarm`, `rightarm`, `waist`, `hips`,
    `leftthigh`, `rightthigh`, `leftcalf`, `rightcalf`, `body_pic1`, `body_pic2`, `body_pic3`, `body_pic4`, `bc_weight`,
    `bc_bmi`, `bc_bodyfat_percentage`, `bc_fatfreeweight`, `bc_subcutaneousfat`, `bc_visceralfat_percentage`, `bc_bodywater`,
    `bc_skeletalmuscle`, `bc_leanmuscle`, `bc_bonemass`, `bc_protein`, `bc_bmr`, `bc_metabolicage`, `bmsaved`, `bcsaved`,
    `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`tdate`, OLD.`Cust_ID`, OLD.`dayofprogram`, OLD.`dopdate`, OLD.`neck`, OLD.`chest`, OLD.`leftarm`,
    OLD.`rightarm`, OLD.`waist`, OLD.`hips`, OLD.`leftthigh`, OLD.`rightthigh`, OLD.`leftcalf`, OLD.`rightcalf`,
    OLD.`body_pic1`, OLD.`body_pic2`, OLD.`body_pic3`, OLD.`body_pic4`, OLD.`bc_weight`, OLD.`bc_bmi`,
    OLD.`bc_bodyfat_percentage`, OLD.`bc_fatfreeweight`, OLD.`bc_subcutaneousfat`, OLD.`bc_visceralfat_percentage`,
    OLD.`bc_bodywater`, OLD.`bc_skeletalmuscle`, OLD.`bc_leanmuscle`, OLD.`bc_bonemass`, OLD.`bc_protein`, OLD.`bc_bmr`,
    OLD.`bc_metabolicage`, OLD.`bmsaved`, OLD.`bcsaved`, 'DELETE', NOW()
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tf_wlweeklydata_before_update` BEFORE UPDATE ON `tf_wlweeklydata` FOR EACH ROW BEGIN
  INSERT INTO `tf_wlweeklydata_history` (
    `id`, `tdate`, `Cust_ID`, `dayofprogram`, `dopdate`, `neck`, `chest`, `leftarm`, `rightarm`, `waist`, `hips`,
    `leftthigh`, `rightthigh`, `leftcalf`, `rightcalf`, `body_pic1`, `body_pic2`, `body_pic3`, `body_pic4`, `bc_weight`,
    `bc_bmi`, `bc_bodyfat_percentage`, `bc_fatfreeweight`, `bc_subcutaneousfat`, `bc_visceralfat_percentage`, `bc_bodywater`,
    `bc_skeletalmuscle`, `bc_leanmuscle`, `bc_bonemass`, `bc_protein`, `bc_bmr`, `bc_metabolicage`, `bmsaved`, `bcsaved`,
    `history_action`, `history_timestamp`
  ) VALUES (
    OLD.`id`, OLD.`tdate`, OLD.`Cust_ID`, OLD.`dayofprogram`, OLD.`dopdate`, OLD.`neck`, OLD.`chest`, OLD.`leftarm`,
    OLD.`rightarm`, OLD.`waist`, OLD.`hips`, OLD.`leftthigh`, OLD.`rightthigh`, OLD.`leftcalf`, OLD.`rightcalf`,
    OLD.`body_pic1`, OLD.`body_pic2`, OLD.`body_pic3`, OLD.`body_pic4`, OLD.`bc_weight`, OLD.`bc_bmi`,
    OLD.`bc_bodyfat_percentage`, OLD.`bc_fatfreeweight`, OLD.`bc_subcutaneousfat`, OLD.`bc_visceralfat_percentage`,
    OLD.`bc_bodywater`, OLD.`bc_skeletalmuscle`, OLD.`bc_leanmuscle`, OLD.`bc_bonemass`, OLD.`bc_protein`, OLD.`bc_bmr`,
    OLD.`bc_metabolicage`, OLD.`bmsaved`, OLD.`bcsaved`, 'UPDATE', NOW()
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tf_wlweeklydata_history`
--

CREATE TABLE `tf_wlweeklydata_history` (
  `history_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `tdate` datetime NOT NULL DEFAULT current_timestamp(),
  `Cust_ID` int(11) NOT NULL,
  `dayofprogram` int(11) NOT NULL DEFAULT 1,
  `dopdate` date DEFAULT NULL,
  `neck` float DEFAULT NULL,
  `chest` float DEFAULT NULL,
  `leftarm` float DEFAULT NULL,
  `rightarm` float DEFAULT NULL,
  `waist` float DEFAULT NULL,
  `hips` float DEFAULT NULL,
  `leftthigh` float DEFAULT NULL,
  `rightthigh` float DEFAULT NULL,
  `leftcalf` float DEFAULT NULL,
  `rightcalf` float DEFAULT NULL,
  `body_pic1` varchar(256) DEFAULT NULL,
  `body_pic2` varchar(256) DEFAULT NULL,
  `body_pic3` varchar(256) DEFAULT NULL,
  `body_pic4` varchar(256) DEFAULT NULL,
  `bc_weight` float DEFAULT NULL,
  `bc_bmi` float DEFAULT NULL,
  `bc_bodyfat_percentage` float DEFAULT NULL,
  `bc_fatfreeweight` float DEFAULT NULL,
  `bc_subcutaneousfat` float DEFAULT NULL,
  `bc_visceralfat_percentage` float DEFAULT NULL,
  `bc_bodywater` float DEFAULT NULL,
  `bc_skeletalmuscle` float DEFAULT NULL,
  `bc_leanmuscle` float DEFAULT NULL,
  `bc_bonemass` float DEFAULT NULL,
  `bc_protein` float DEFAULT NULL,
  `bc_bmr` float DEFAULT NULL,
  `bc_metabolicage` float DEFAULT NULL,
  `bmsaved` int(11) NOT NULL DEFAULT 0,
  `bcsaved` int(11) NOT NULL DEFAULT 0,
  `history_action` enum('UPDATE','DELETE') NOT NULL,
  `history_timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tf_wlweeklydata_history`
--

INSERT INTO `tf_wlweeklydata_history` (`history_id`, `id`, `tdate`, `Cust_ID`, `dayofprogram`, `dopdate`, `neck`, `chest`, `leftarm`, `rightarm`, `waist`, `hips`, `leftthigh`, `rightthigh`, `leftcalf`, `rightcalf`, `body_pic1`, `body_pic2`, `body_pic3`, `body_pic4`, `bc_weight`, `bc_bmi`, `bc_bodyfat_percentage`, `bc_fatfreeweight`, `bc_subcutaneousfat`, `bc_visceralfat_percentage`, `bc_bodywater`, `bc_skeletalmuscle`, `bc_leanmuscle`, `bc_bonemass`, `bc_protein`, `bc_bmr`, `bc_metabolicage`, `bmsaved`, `bcsaved`, `history_action`, `history_timestamp`) VALUES
(1, 11, '2025-05-25 01:13:35', 1, 5, '2025-05-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-05-25 14:16:05'),
(2, 15, '2025-05-25 14:09:13', 1, 5, '2025-05-04', 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-05-25 14:16:05'),
(3, 11, '2025-05-25 01:13:35', 1, 5, '2025-05-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads\\formFileSm-1748162765741-105921253.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-05-25 14:19:20'),
(4, 15, '2025-05-25 14:09:13', 1, 5, '2025-05-04', 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 'uploads\\formFileSm-1748162765741-105921253.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-05-25 14:19:20'),
(5, 11, '2025-05-25 01:13:35', 1, 5, '2025-05-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads\\formFileSm-1748162960085-683442372.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-05-25 14:20:51'),
(26, 18, '2025-05-25 14:37:30', 1, 10, '2025-05-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uploads\\formFileSm-1748164165472-846237070.jpeg', 'uploads\\formFileSm-1748164167691-126385716.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-05-25 14:41:36'),
(27, 19, '2025-05-25 14:37:53', 1, 10, '2025-05-09', 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 'uploads\\formFileSm-1748164165472-846237070.jpeg', 'uploads\\formFileSm-1748164167691-126385716.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'DELETE', '2025-05-25 14:41:36'),
(28, 20, '2025-05-25 14:41:44', 1, 5, '2025-05-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-05-25 14:44:55'),
(29, 21, '2025-05-25 14:44:34', 1, 5, '2025-05-04', 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'DELETE', '2025-05-25 14:44:55'),
(30, 22, '2025-05-25 14:45:11', 1, 10, '2025-05-09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'DELETE', '2025-05-25 14:47:00'),
(31, 23, '2025-05-25 14:45:30', 1, 10, '2025-05-09', 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'DELETE', '2025-05-25 14:47:00'),
(32, 24, '2025-05-25 14:47:14', 1, 5, '2025-05-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-05-25 14:48:14'),
(33, 24, '2025-05-25 14:47:14', 1, 5, '2025-05-04', 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-05-25 14:48:36'),
(34, 24, '2025-05-25 14:47:14', 1, 5, '2025-05-04', 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 'uploads\\formFileSm-1748164716083-14735137.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-05-25 14:48:50'),
(35, 24, '2025-05-25 14:47:14', 1, 5, '2025-05-04', 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 'uploads\\formFileSm-1748164716083-14735137.jpeg', 'uploads\\formFileSm-1748164730018-800408731.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-05-25 14:49:14'),
(36, 31, '2025-09-03 23:19:54', 1, 1, '2025-09-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-09-03 23:20:14'),
(37, 32, '2025-09-15 12:47:02', 1, 1, '2025-09-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'UPDATE', '2025-09-15 16:27:59'),
(38, 32, '2025-09-15 12:47:02', 1, 1, '2025-09-15', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'UPDATE', '2025-09-15 16:29:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `friend_list`
--
ALTER TABLE `friend_list`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_friend_pair` (`user_min`,`user_max`);

--
-- Indexes for table `snack_options`
--
ALTER TABLE `snack_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `snack_option_history`
--
ALTER TABLE `snack_option_history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `supplement_fields`
--
ALTER TABLE `supplement_fields`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `valuePrefix` (`valuePrefix`);

--
-- Indexes for table `supplement_fields_history`
--
ALTER TABLE `supplement_fields_history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `tf_admin`
--
ALTER TABLE `tf_admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tf_blogsubscribe`
--
ALTER TABLE `tf_blogsubscribe`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tf_coaches`
--
ALTER TABLE `tf_coaches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `coachid` (`coachid`),
  ADD KEY `fk_tf_coaches_maincoach` (`maincoach`),
  ADD KEY `fk_tf_coaches_spouseid` (`spouseid`);

--
-- Indexes for table `tf_coaches_history`
--
ALTER TABLE `tf_coaches_history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `tf_dietsheet`
--
ALTER TABLE `tf_dietsheet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tf_dietsheet_cust_id` (`Cust_ID`);

--
-- Indexes for table `tf_dietsheet_history`
--
ALTER TABLE `tf_dietsheet_history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `tf_events`
--
ALTER TABLE `tf_events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tf_leads`
--
ALTER TABLE `tf_leads`
  ADD PRIMARY KEY (`Lead_ID`),
  ADD KEY `fk_tf_leads_coachid` (`coachid`);

--
-- Indexes for table `tf_leads_history`
--
ALTER TABLE `tf_leads_history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `tf_messages`
--
ALTER TABLE `tf_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tf_messages_sender_id` (`sender_id`),
  ADD KEY `fk_tf_messages_receiver_id` (`receiver_id`);

--
-- Indexes for table `tf_messages_history`
--
ALTER TABLE `tf_messages_history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `tf_notifications`
--
ALTER TABLE `tf_notifications`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tf_payments`
--
ALTER TABLE `tf_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tf_payments_cust_id` (`Cust_ID`),
  ADD KEY `fk_tf_payments_coachid` (`coachid`);

--
-- Indexes for table `tf_payments_history`
--
ALTER TABLE `tf_payments_history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `tf_referral`
--
ALTER TABLE `tf_referral`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tf_referral_coachid` (`coachid`);

--
-- Indexes for table `tf_referral_history`
--
ALTER TABLE `tf_referral_history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `tf_session_token`
--
ALTER TABLE `tf_session_token`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_token` (`session_token`),
  ADD KEY `fk_session_token_user_id` (`user_id`),
  ADD KEY `fk_session_token_cust_id` (`Cust_ID`);

--
-- Indexes for table `tf_session_token_history`
--
ALTER TABLE `tf_session_token_history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `tf_tfleads`
--
ALTER TABLE `tf_tfleads`
  ADD PRIMARY KEY (`Lead_ID`),
  ADD KEY `fk_tf_tfleads_coachid` (`coachid`);

--
-- Indexes for table `tf_tfleads_history`
--
ALTER TABLE `tf_tfleads_history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `tf_userhealthprofile`
--
ALTER TABLE `tf_userhealthprofile`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tf_userhealthprofile_cust_id` (`Cust_ID`),
  ADD KEY `fk_tf_userhealthprofile_lead_id` (`Lead_ID`);

--
-- Indexes for table `tf_userhealthprofile_history`
--
ALTER TABLE `tf_userhealthprofile_history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `tf_userprogram`
--
ALTER TABLE `tf_userprogram`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tf_userprogram_cust_id` (`Cust_ID`);

--
-- Indexes for table `tf_userprogram_history`
--
ALTER TABLE `tf_userprogram_history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `tf_users`
--
ALTER TABLE `tf_users`
  ADD PRIMARY KEY (`Cust_ID`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `fk_tf_users_lead_id` (`Lead_ID`),
  ADD KEY `fk_tf_users_coachid` (`coachid`);

--
-- Indexes for table `tf_usersupplements`
--
ALTER TABLE `tf_usersupplements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tf_usersupplements_cust_id` (`Cust_ID`);

--
-- Indexes for table `tf_usersupplements_history`
--
ALTER TABLE `tf_usersupplements_history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `tf_users_history`
--
ALTER TABLE `tf_users_history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `tf_wldialydata`
--
ALTER TABLE `tf_wldialydata`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_cust_dopdate` (`Cust_ID`,`dopdate`);

--
-- Indexes for table `tf_wldialydata_history`
--
ALTER TABLE `tf_wldialydata_history`
  ADD PRIMARY KEY (`history_id`);

--
-- Indexes for table `tf_wlweeklydata`
--
ALTER TABLE `tf_wlweeklydata`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tf_wlweeklydata_cust_id` (`Cust_ID`);

--
-- Indexes for table `tf_wlweeklydata_history`
--
ALTER TABLE `tf_wlweeklydata_history`
  ADD PRIMARY KEY (`history_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `friend_list`
--
ALTER TABLE `friend_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `snack_options`
--
ALTER TABLE `snack_options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `snack_option_history`
--
ALTER TABLE `snack_option_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `supplement_fields`
--
ALTER TABLE `supplement_fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `supplement_fields_history`
--
ALTER TABLE `supplement_fields_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tf_admin`
--
ALTER TABLE `tf_admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tf_blogsubscribe`
--
ALTER TABLE `tf_blogsubscribe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tf_coaches`
--
ALTER TABLE `tf_coaches`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `tf_coaches_history`
--
ALTER TABLE `tf_coaches_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tf_dietsheet`
--
ALTER TABLE `tf_dietsheet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1153;

--
-- AUTO_INCREMENT for table `tf_dietsheet_history`
--
ALTER TABLE `tf_dietsheet_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tf_events`
--
ALTER TABLE `tf_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tf_leads`
--
ALTER TABLE `tf_leads`
  MODIFY `Lead_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=445;

--
-- AUTO_INCREMENT for table `tf_leads_history`
--
ALTER TABLE `tf_leads_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tf_messages`
--
ALTER TABLE `tf_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `tf_messages_history`
--
ALTER TABLE `tf_messages_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tf_payments`
--
ALTER TABLE `tf_payments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `tf_payments_history`
--
ALTER TABLE `tf_payments_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tf_referral`
--
ALTER TABLE `tf_referral`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `tf_referral_history`
--
ALTER TABLE `tf_referral_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tf_session_token`
--
ALTER TABLE `tf_session_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=246;

--
-- AUTO_INCREMENT for table `tf_session_token_history`
--
ALTER TABLE `tf_session_token_history`
  MODIFY `history_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `tf_tfleads`
--
ALTER TABLE `tf_tfleads`
  MODIFY `Lead_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tf_tfleads_history`
--
ALTER TABLE `tf_tfleads_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tf_userhealthprofile`
--
ALTER TABLE `tf_userhealthprofile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `tf_userhealthprofile_history`
--
ALTER TABLE `tf_userhealthprofile_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tf_userprogram`
--
ALTER TABLE `tf_userprogram`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `tf_userprogram_history`
--
ALTER TABLE `tf_userprogram_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tf_users`
--
ALTER TABLE `tf_users`
  MODIFY `Cust_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `tf_usersupplements`
--
ALTER TABLE `tf_usersupplements`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `tf_usersupplements_history`
--
ALTER TABLE `tf_usersupplements_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tf_users_history`
--
ALTER TABLE `tf_users_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `tf_wldialydata`
--
ALTER TABLE `tf_wldialydata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `tf_wldialydata_history`
--
ALTER TABLE `tf_wldialydata_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=250;

--
-- AUTO_INCREMENT for table `tf_wlweeklydata`
--
ALTER TABLE `tf_wlweeklydata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `tf_wlweeklydata_history`
--
ALTER TABLE `tf_wlweeklydata_history`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tf_coaches`
--
ALTER TABLE `tf_coaches`
  ADD CONSTRAINT `fk_tf_coaches_maincoach` FOREIGN KEY (`maincoach`) REFERENCES `tf_coaches` (`coachid`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tf_coaches_spouseid` FOREIGN KEY (`spouseid`) REFERENCES `tf_coaches` (`coachid`) ON DELETE SET NULL;

--
-- Constraints for table `tf_dietsheet`
--
ALTER TABLE `tf_dietsheet`
  ADD CONSTRAINT `fk_tf_dietsheet_cust_id` FOREIGN KEY (`Cust_ID`) REFERENCES `tf_users` (`Cust_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tf_leads`
--
ALTER TABLE `tf_leads`
  ADD CONSTRAINT `fk_tf_leads_coachid` FOREIGN KEY (`coachid`) REFERENCES `tf_coaches` (`coachid`) ON DELETE SET NULL;

--
-- Constraints for table `tf_messages`
--
ALTER TABLE `tf_messages`
  ADD CONSTRAINT `fk_tf_messages_receiver_id` FOREIGN KEY (`receiver_id`) REFERENCES `tf_users` (`Cust_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tf_messages_sender_id` FOREIGN KEY (`sender_id`) REFERENCES `tf_users` (`Cust_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tf_payments`
--
ALTER TABLE `tf_payments`
  ADD CONSTRAINT `fk_tf_payments_coachid` FOREIGN KEY (`coachid`) REFERENCES `tf_coaches` (`coachid`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tf_payments_cust_id` FOREIGN KEY (`Cust_ID`) REFERENCES `tf_users` (`Cust_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tf_referral`
--
ALTER TABLE `tf_referral`
  ADD CONSTRAINT `fk_tf_referral_coachid` FOREIGN KEY (`coachid`) REFERENCES `tf_coaches` (`coachid`) ON DELETE CASCADE;

--
-- Constraints for table `tf_session_token`
--
ALTER TABLE `tf_session_token`
  ADD CONSTRAINT `fk_session_token_cust_id` FOREIGN KEY (`Cust_ID`) REFERENCES `tf_users` (`Cust_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_session_token_user_id` FOREIGN KEY (`user_id`) REFERENCES `tf_users` (`Cust_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tf_tfleads`
--
ALTER TABLE `tf_tfleads`
  ADD CONSTRAINT `fk_tf_tfleads_coachid` FOREIGN KEY (`coachid`) REFERENCES `tf_coaches` (`coachid`) ON DELETE SET NULL;

--
-- Constraints for table `tf_userhealthprofile`
--
ALTER TABLE `tf_userhealthprofile`
  ADD CONSTRAINT `fk_tf_userhealthprofile_cust_id` FOREIGN KEY (`Cust_ID`) REFERENCES `tf_users` (`Cust_ID`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tf_userhealthprofile_lead_id` FOREIGN KEY (`Lead_ID`) REFERENCES `tf_leads` (`Lead_ID`) ON DELETE SET NULL;

--
-- Constraints for table `tf_userprogram`
--
ALTER TABLE `tf_userprogram`
  ADD CONSTRAINT `fk_tf_userprogram_cust_id` FOREIGN KEY (`Cust_ID`) REFERENCES `tf_users` (`Cust_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tf_users`
--
ALTER TABLE `tf_users`
  ADD CONSTRAINT `fk_tf_users_coachid` FOREIGN KEY (`coachid`) REFERENCES `tf_coaches` (`coachid`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tf_users_lead_id` FOREIGN KEY (`Lead_ID`) REFERENCES `tf_leads` (`Lead_ID`) ON DELETE SET NULL;

--
-- Constraints for table `tf_usersupplements`
--
ALTER TABLE `tf_usersupplements`
  ADD CONSTRAINT `fk_tf_usersupplements_cust_id` FOREIGN KEY (`Cust_ID`) REFERENCES `tf_users` (`Cust_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tf_wldialydata`
--
ALTER TABLE `tf_wldialydata`
  ADD CONSTRAINT `fk_tf_wldialydata_cust_id` FOREIGN KEY (`Cust_ID`) REFERENCES `tf_users` (`Cust_ID`) ON DELETE CASCADE;

--
-- Constraints for table `tf_wlweeklydata`
--
ALTER TABLE `tf_wlweeklydata`
  ADD CONSTRAINT `fk_tf_wlweeklydata_cust_id` FOREIGN KEY (`Cust_ID`) REFERENCES `tf_users` (`Cust_ID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
