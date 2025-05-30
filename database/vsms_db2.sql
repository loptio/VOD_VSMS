-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2025-05-27 18:48:20
-- 服务器版本： 10.4.28-MariaDB
-- PHP 版本： 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `vsms_db2`
--

-- --------------------------------------------------------

--
-- 表的结构 `actors`
--

CREATE TABLE `actors` (
  `actor_name` varchar(255) NOT NULL,
  `birth_date` date NOT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `actors`
--

INSERT INTO `actors` (`actor_name`, `birth_date`, `nationality`, `gender`) VALUES
('Anya Taylor-Joy', '1996-04-16', 'American-British', 'Female'),
('Benedict Cumberbatch', '1976-07-19', 'British', 'Male'),
('Dwayne Johnson', '1972-05-02', 'American', 'Male'),
('Florence Pugh', '1996-01-03', 'British', 'Female'),
('Gal Gadot', '1985-04-30', 'Israeli', 'Female'),
('Hiroyuki Sanada', '1960-10-12', 'Japanese', 'Male'),
('Idris Elba', '1972-09-06', 'British', 'Male'),
('Keanu Reeves', '1964-09-02', 'Canadian', 'Male'),
('Leo Da', '2003-05-05', 'Mars', 'Male'),
('Leonardo DiCaprio', '1974-11-11', 'American', 'Male'),
('Margot Robbie', '1990-07-02', 'Australian', 'Female'),
('Ryan Reynolds', '1976-10-23', 'Canadian', 'Male'),
('Scarlett Johansson', '1984-11-22', 'American', 'Female'),
('Timothée Chalamet', '1995-12-27', 'American', 'Male'),
('Tom Hanks', '1956-07-09', 'American', 'Male'),
('Zendaya', '1996-09-01', 'American', 'Female');

-- --------------------------------------------------------

--
-- 表的结构 `act_in`
--

CREATE TABLE `act_in` (
  `movie_id` int(11) NOT NULL,
  `actor_name` varchar(255) NOT NULL,
  `birth_date` date NOT NULL,
  `role` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `act_in`
--

INSERT INTO `act_in` (`movie_id`, `actor_name`, `birth_date`, `role`) VALUES
(1, 'Tom Hanks', '1956-07-09', 'Forrest Gump'),
(2, 'Benedict Cumberbatch', '1976-07-19', 'Doctor Strange'),
(2, 'Scarlett Johansson', '1984-11-22', 'Black Widow'),
(2, 'Zendaya', '1996-09-01', 'JZ'),
(3, 'Tom Hanks', '1956-07-09', 'Curry'),
(4, 'Hiroyuki Sanada', '1960-10-12', 'Samurai Leader'),
(6, 'Keanu Reeves', '1964-09-02', 'Neo'),
(7, 'Leonardo DiCaprio', '1974-11-11', 'Dominick'),
(7, 'Margot Robbie', '1990-07-02', 'Vincent Vega'),
(8, 'Florence Pugh', '1996-01-03', 'Princess Irulan'),
(8, 'Timothée Chalamet', '1995-12-27', 'Paul Atreides'),
(9, 'Gal Gadot', '1985-04-30', 'Wonder Woman'),
(10, 'Dwayne Johnson', '1972-05-02', 'Ken'),
(10, 'Margot Robbie', '1990-07-02', 'Barbie'),
(10, 'Ryan Reynolds', '1976-10-23', 'Barbie’s Neighbor'),
(11, 'Benedict Cumberbatch', '1976-07-19', 'Lewis Strauss'),
(11, 'Florence Pugh', '1996-01-03', 'Jean Tatlock'),
(11, 'Keanu Reeves', '1964-09-02', 'Magic'),
(12, 'Florence Pugh', '1996-01-03', 'Trump'),
(12, 'Zendaya', '1996-09-01', 'Waymond Wang'),
(13, 'Idris Elba', '1972-09-06', 'Chris Washington'),
(13, 'Ryan Reynolds', '1976-10-23', 'Wade'),
(14, 'Benedict Cumberbatch', '1976-07-19', 'Lead Mathematician'),
(15, 'Benedict Cumberbatch', '1976-07-19', 'Detective Miles Corbin'),
(15, 'Hiroyuki Sanada', '1960-10-12', 'Samurai Mentor'),
(15, 'Tom Hanks', '1956-07-09', 'Michael'),
(16, 'Benedict Cumberbatch', '1976-07-19', 'Professor Aris Thorne'),
(16, 'Idris Elba', '1972-09-06', 'General Kael'),
(17, 'Gal Gadot', '1985-04-30', 'Curry'),
(17, 'Timothée Chalamet', '1995-12-27', 'Julian Blackwood'),
(17, 'Zendaya', '1996-09-01', 'Commander Rayna'),
(18, 'Benedict Cumberbatch', '1976-07-19', 'Marco Polo Jr.'),
(18, 'Scarlett Johansson', '1984-11-22', 'Agent Red'),
(19, 'Benedict Cumberbatch', '1976-07-19', 'Dr. Orion Nebula'),
(19, 'Hiroyuki Sanada', '1960-10-12', 'Captain Kenji'),
(19, 'Idris Elba', '1972-09-06', 'X'),
(20, 'Benedict Cumberbatch', '1976-07-19', 'Master Alchemist Elias'),
(20, 'Florence Pugh', '1996-01-03', 'Kara the Apprentice'),
(20, 'Idris Elba', '1972-09-06', 'Lebron'),
(20, 'Keanu Reeves', '1964-09-02', 'Durant'),
(21, 'Benedict Cumberbatch', '1976-07-19', 'Sergeant Graves'),
(21, 'Ryan Reynolds', '1976-10-23', 'Kobe'),
(22, 'Benedict Cumberbatch', '1976-07-19', 'Agent 00X'),
(22, 'Dwayne Johnson', '1972-05-02', 'Harden'),
(22, 'Florence Pugh', '1996-01-03', 'Shaq'),
(22, 'Timothée Chalamet', '1995-12-27', 'Michael'),
(22, 'Zendaya', '1996-09-01', 'Jordan'),
(23, 'Benedict Cumberbatch', '1976-07-19', 'Archivist Kael');

-- --------------------------------------------------------

--
-- 表的结构 `address`
--

CREATE TABLE `address` (
  `address_id` int(11) NOT NULL,
  `country` varchar(100) NOT NULL,
  `state_province` varchar(100) DEFAULT NULL,
  `city` varchar(100) NOT NULL,
  `street` varchar(255) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `house_number` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `address`
--

INSERT INTO `address` (`address_id`, `country`, `state_province`, `city`, `street`, `postal_code`, `house_number`) VALUES
(1, 'USA', 'California', 'Los Angeles', 'Hollywood Blvd', '90028', '123'),
(2, 'USA', 'New York', 'New York City', 'Broadway St', '10007', '456'),
(3, 'UK', 'London', 'London', 'Abbey Road', 'NW8 9AY', '3'),
(4, 'Canada', 'Ontario', 'Toronto', 'Queen Street West', 'M5V 2A1', '789'),
(5, 'Japan', 'Tokyo', 'Tokyo', 'Shibuya Crossing', '150-0042', '10-1'),
(6, 'USA', 'Georgia', 'Atlanta', 'Peachtree Street', '30303', 'P.O. Box 100'),
(7, 'France', 'Paris', 'Paris', 'Champs-Élysées', '75008', '101 A'),
(8, 'Germany', 'Berlin', 'Berlin', 'Unter den Linden', '10117', '77');

-- --------------------------------------------------------

--
-- 表的结构 `company`
--

CREATE TABLE `company` (
  `company_name` varchar(255) NOT NULL,
  `address_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `company`
--

INSERT INTO `company` (`company_name`, `address_id`) VALUES
('Miramax', 1),
('Paramount Pictures', 1),
('Universal Pictures', 1),
('Focus Features', 2),
('Warner Bros.', 2),
('20th Century Studios', 3),
('Marvel Studios', 3),
('Studio Ghibli', 5),
('Sony Pictures', 6),
('Lionsgate', 7),
('A24', 8);

-- --------------------------------------------------------

--
-- 表的结构 `director`
--

CREATE TABLE `director` (
  `director_name` varchar(255) NOT NULL,
  `birth_date` date NOT NULL,
  `gender` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `director`
--

INSERT INTO `director` (`director_name`, `birth_date`, `gender`) VALUES
('Anthony Russo', '1970-02-03', 'Male'),
('Chloe Zhao', '1982-03-31', 'Female'),
('Christopher Nolan', '1970-07-30', 'Male'),
('Denis Villeneuve', '1967-10-03', 'Male'),
('Greta Gerwig', '1983-08-04', 'Female'),
('Hayao Miyazaki', '1941-01-05', 'Male'),
('Joe Russo', '1971-07-18', 'Male'),
('Jordan Peele', '1979-02-21', 'Male'),
('Patty Jenkins', '1971-07-24', 'Female'),
('Quentin Tarantino', '1963-03-27', 'Male'),
('Robert Zemeckis', '1952-05-14', 'Male'),
('Steven Spielberg', '1946-12-18', 'Male'),
('Taika Waititi', '1975-08-16', 'Male');

-- --------------------------------------------------------

--
-- 表的结构 `direct_movie`
--

CREATE TABLE `direct_movie` (
  `movie_id` int(11) NOT NULL,
  `director_name` varchar(255) NOT NULL,
  `birth_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `direct_movie`
--

INSERT INTO `direct_movie` (`movie_id`, `director_name`, `birth_date`) VALUES
(1, 'Robert Zemeckis', '1952-05-14'),
(2, 'Anthony Russo', '1970-02-03'),
(2, 'Joe Russo', '1971-07-18'),
(3, 'Christopher Nolan', '1970-07-30'),
(4, 'Hayao Miyazaki', '1941-01-05'),
(6, 'Christopher Nolan', '1970-07-30'),
(7, 'Quentin Tarantino', '1963-03-27'),
(8, 'Denis Villeneuve', '1967-10-03'),
(9, 'Patty Jenkins', '1971-07-24'),
(10, 'Greta Gerwig', '1983-08-04'),
(11, 'Christopher Nolan', '1970-07-30'),
(12, 'Jordan Peele', '1979-02-21'),
(13, 'Jordan Peele', '1979-02-21'),
(14, 'Hayao Miyazaki', '1941-01-05'),
(15, 'Anthony Russo', '1970-02-03'),
(16, 'Christopher Nolan', '1970-07-30'),
(17, 'Denis Villeneuve', '1967-10-03'),
(18, 'Quentin Tarantino', '1963-03-27'),
(19, 'Robert Zemeckis', '1952-05-14'),
(20, 'Christopher Nolan', '1970-07-30'),
(21, 'Quentin Tarantino', '1963-03-27'),
(22, 'Chloe Zhao', '1982-03-31'),
(23, 'Hayao Miyazaki', '1941-01-05');

-- --------------------------------------------------------

--
-- 表的结构 `download`
--

CREATE TABLE `download` (
  `download_id` int(11) NOT NULL,
  `member_id` int(11) DEFAULT NULL,
  `movie_id` int(11) DEFAULT NULL,
  `download_timestamp` datetime NOT NULL,
  `purchase_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `download`
--

INSERT INTO `download` (`download_id`, `member_id`, `movie_id`, `download_timestamp`, `purchase_id`) VALUES
(1, 1, 1, '2024-01-20 10:30:00', 1),
(2, 1, 3, '2024-01-22 15:00:00', 2),
(3, 2, 4, '2024-02-01 18:45:00', 7),
(4, 4, 2, '2023-12-25 20:00:00', 11),
(5, 1, 5, '2023-06-15 11:00:00', 3),
(6, 1, 6, '2024-02-10 12:00:00', 4),
(7, 1, 8, '2023-11-05 19:30:00', 5),
(8, 2, 10, '2024-01-05 14:00:00', 8),
(9, 2, 13, '2023-10-28 22:00:00', 9),
(10, 3, 1, '2023-01-01 10:00:00', 10),
(11, 4, 7, '2024-03-01 09:15:00', 12),
(12, 4, 11, '2024-02-15 21:00:00', 13),
(13, 4, 12, '2023-09-10 17:00:00', 14),
(14, 5, 9, '2024-01-25 16:20:00', 16),
(15, 6, 2, '2023-08-10 11:00:00', 17),
(16, 6, 13, '2023-10-30 23:50:00', 18),
(17, 7, 3, '2024-02-20 13:00:00', 19),
(18, 7, 6, '2023-07-01 10:00:00', 20),
(19, 7, 8, '2024-03-03 03:00:00', 21),
(20, 7, 11, '2023-11-15 18:30:00', 22),
(21, 8, 1, '2024-01-10 08:00:00', 23),
(22, 9, 4, '2023-12-01 14:30:00', 24),
(23, 9, 12, '2024-02-28 19:00:00', 25),
(24, 10, 5, '2023-05-01 12:12:12', 26),
(25, 11, 10, '2024-02-14 20:00:00', 27),
(26, 11, 13, '2023-10-01 10:00:00', 28),
(27, 12, 2, '2024-01-01 00:01:00', 29),
(28, 12, 6, '2023-10-10 10:10:10', 30),
(29, 12, 9, '2024-03-05 17:45:00', 31),
(30, 12, 13, '2023-08-15 21:30:00', 32),
(31, 13, 5, '2024-02-05 16:00:00', 33),
(32, 13, 11, '2023-12-20 19:00:00', 34),
(33, 1, 13, '2023-09-05 10:00:00', 6),
(34, 4, 13, '2023-09-15 12:00:00', 15),
(35, 1, 13, '2023-11-01 11:00:00', 6),
(36, 6, 13, '2023-11-20 13:00:00', 18);

-- --------------------------------------------------------

--
-- 表的结构 `genre_type`
--

CREATE TABLE `genre_type` (
  `genre_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `genre_type`
--

INSERT INTO `genre_type` (`genre_name`) VALUES
('Action'),
('Animation'),
('Comedy'),
('Documentary'),
('Drama'),
('Fantasy'),
('Horror'),
('Romance'),
('Sci-Fi'),
('Thriller');

-- --------------------------------------------------------

--
-- 表的结构 `has_genre`
--

CREATE TABLE `has_genre` (
  `movie_id` int(11) NOT NULL,
  `genre_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `has_genre`
--

INSERT INTO `has_genre` (`movie_id`, `genre_name`) VALUES
(1, 'Drama'),
(1, 'Romance'),
(2, 'Action'),
(2, 'Sci-Fi'),
(3, 'Sci-Fi'),
(3, 'Thriller'),
(4, 'Animation'),
(4, 'Fantasy'),
(5, 'Drama'),
(6, 'Action'),
(6, 'Sci-Fi'),
(7, 'Drama'),
(7, 'Thriller'),
(8, 'Action'),
(8, 'Drama'),
(8, 'Sci-Fi'),
(9, 'Action'),
(9, 'Fantasy'),
(10, 'Comedy'),
(10, 'Drama'),
(10, 'Fantasy'),
(11, 'Drama'),
(11, 'Horror'),
(12, 'Action'),
(12, 'Comedy'),
(12, 'Sci-Fi'),
(13, 'Documentary'),
(13, 'Thriller'),
(14, 'Drama'),
(14, 'Thriller'),
(15, 'Documentary'),
(15, 'Thriller'),
(16, 'Sci-Fi'),
(16, 'Thriller'),
(17, 'Documentary'),
(17, 'Fantasy'),
(18, 'Action'),
(18, 'Drama'),
(19, 'Horror'),
(19, 'Sci-Fi'),
(20, 'Action'),
(20, 'Fantasy'),
(21, 'Drama'),
(21, 'Horror'),
(22, 'Action'),
(22, 'Thriller'),
(23, 'Drama'),
(23, 'Sci-Fi');

-- --------------------------------------------------------

--
-- 表的结构 `members`
--

CREATE TABLE `members` (
  `member_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `balance` decimal(10,2) DEFAULT 0.00 CHECK (`balance` >= 0),
  `email` varchar(255) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `registration_date` date NOT NULL,
  `StatusID` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `members`
--

INSERT INTO `members` (`member_id`, `name`, `balance`, `email`, `phone`, `registration_date`, `StatusID`) VALUES
(1, 'John Smith', 50.00, 'john.smith@example.com', '555-1234', '2023-01-15', 1),
(2, 'Alice Wonderland', 25.50, 'alice.w@example.com', '555-5678', '2022-11-01', 1),
(3, 'Bob The Builder', 0.00, 'bob.builder@example.com', '555-8765', '2023-03-10', 2),
(4, 'Eve Moneybags', 200.00, 'eve.m@example.com', '555-4321', '2021-05-20', 1),
(5, 'Charlie Brown', 10.00, 'charlie.b@example.com', '555-0000', '2023-05-01', 1),
(6, 'Diana Prince', 75.20, 'diana.p@example.net', '555-1122', '2022-08-22', 1),
(7, 'Bruce Wayne', 150.00, 'bruce.w@example.org', '555-3344', '2020-12-01', 1),
(8, 'Clark Kent', 30.75, 'clark.k@example.com', '555-5566', '2023-02-28', 1),
(9, 'Lucy Liu', 15.00, 'lucy.l@example.net', '555-7788', '2023-04-10', 1),
(10, 'Peter Parker', 5.50, 'peter.p@example.org', '555-9900', '2023-06-05', 2),
(11, 'Mary Jane Watson', 40.00, 'mary.jane@example.com', '555-2468', '2022-07-19', 1),
(12, 'Harry Potter', 99.99, 'harry.p@example.net', '555-1357', '2021-09-01', 1),
(13, 'Hermione Granger', 60.25, 'hermione.g@example.org', '555-8642', '2021-09-01', 1),
(14, 'Sabi', 999999.00, 'trump@gmail.com', '999-9999', '2018-01-01', 1),
(15, 'Charlie Albert', 9.00, 'zhd@icloud.com', '000-0000', '2025-05-30', 3);

-- --------------------------------------------------------

--
-- 表的结构 `MemberStatusTypes`
--

CREATE TABLE `MemberStatusTypes` (
  `StatusID` int(11) NOT NULL,
  `StatusName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `MemberStatusTypes`
--

INSERT INTO `MemberStatusTypes` (`StatusID`, `StatusName`) VALUES
(1, 'Active'),
(3, 'Closed'),
(2, 'Suspended');

-- --------------------------------------------------------

--
-- 表的结构 `movies`
--

CREATE TABLE `movies` (
  `movie_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `release_date` date DEFAULT NULL,
  `charge_per_download` decimal(10,2) NOT NULL CHECK (`charge_per_download` >= 0),
  `company_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `movies`
--

INSERT INTO `movies` (`movie_id`, `title`, `release_date`, `charge_per_download`, `company_name`) VALUES
(1, 'Forrest Gump', '1994-07-06', 3.99, 'Paramount Pictures'),
(2, 'Avengers: Endgame', '2019-04-26', 4.99, 'Marvel Studios'),
(3, 'Inception', '2010-07-16', 4.99, 'Warner Bros.'),
(4, 'Spirited Away', '2001-07-20', 3.50, 'Studio Ghibli'),
(5, 'The Shawshank Redemption', '1994-09-23', 4.25, 'Warner Bros.'),
(6, 'The Matrix', '1999-03-31', 4.50, 'Warner Bros.'),
(7, 'Pulp Fiction', '1994-10-14', 3.99, 'Miramax'),
(8, 'Dune', '2021-10-22', 6.99, 'Warner Bros.'),
(9, 'Wonder Woman', '2017-06-02', 5.50, 'Warner Bros.'),
(10, 'Barbie', '2023-07-21', 7.99, 'Warner Bros.'),
(11, 'Oppenheimer', '2023-07-21', 7.99, 'Universal Pictures'),
(12, 'Everything Everywhere All at Once', '2022-03-11', 6.50, 'A24'),
(13, 'Get Out', '2017-02-24', 4.99, 'Universal Pictures'),
(14, 'The Enigma Cipher', '2006-03-15', 3.50, 'Focus Features'),
(15, 'Victorian Shadows', '2007-09-22', 4.00, 'Focus Features'),
(16, 'Quantum Paradox', '2008-11-05', 4.50, 'Sony Pictures'),
(17, 'The Crimson Quill', '2009-04-10', 3.90, '20th Century Studios'),
(18, 'Silk Road Trader', '2010-07-01', 4.10, 'Lionsgate'),
(19, 'Celestial Cartographer', '2011-02-18', 4.30, 'A24'),
(20, 'The Alchemist\'s Secret', '2012-08-30', 4.70, 'Universal Pictures'),
(21, 'Forgotten Frontlines', '2013-10-12', 4.60, 'Sony Pictures'),
(22, 'Midnight Espionage', '2014-05-25', 4.40, '20th Century Studios'),
(23, 'The Last Chronicle', '2015-11-20', 4.20, 'Warner Bros.');

-- --------------------------------------------------------

--
-- 表的结构 `purchase`
--

CREATE TABLE `purchase` (
  `purchase_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `purchase_date` datetime NOT NULL DEFAULT current_timestamp(),
  `amount` decimal(10,2) NOT NULL CHECK (`amount` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 转存表中的数据 `purchase`
--

INSERT INTO `purchase` (`purchase_id`, `member_id`, `movie_id`, `purchase_date`, `amount`) VALUES
(1, 1, 1, '2024-01-20 10:30:00', 3.99),
(2, 1, 3, '2024-01-22 15:00:00', 4.99),
(3, 1, 5, '2023-06-15 11:00:00', 2.99),
(4, 1, 6, '2024-02-10 12:00:00', 4.50),
(5, 1, 8, '2023-11-05 19:30:00', 6.99),
(6, 1, 13, '2023-09-05 10:00:00', 4.99),
(7, 2, 4, '2024-02-01 18:45:00', 3.50),
(8, 2, 10, '2024-01-05 14:00:00', 7.99),
(9, 2, 13, '2023-10-28 22:00:00', 4.99),
(10, 3, 1, '2023-01-01 10:00:00', 3.99),
(11, 4, 2, '2023-12-25 20:00:00', 5.99),
(12, 4, 7, '2024-03-01 09:15:00', 3.99),
(13, 4, 11, '2024-02-15 21:00:00', 7.99),
(14, 4, 12, '2023-09-10 17:00:00', 6.50),
(15, 4, 13, '2023-09-15 12:00:00', 4.99),
(16, 5, 9, '2024-01-25 16:20:00', 5.50),
(17, 6, 2, '2023-08-10 11:00:00', 5.99),
(18, 6, 13, '2023-10-30 23:50:00', 4.99),
(19, 7, 3, '2024-02-20 13:00:00', 4.99),
(20, 7, 6, '2023-07-01 10:00:00', 4.50),
(21, 7, 8, '2024-03-03 03:00:00', 6.99),
(22, 7, 11, '2023-11-15 18:30:00', 7.99),
(23, 8, 1, '2024-01-10 08:00:00', 3.99),
(24, 9, 4, '2023-12-01 14:30:00', 3.50),
(25, 9, 12, '2024-02-28 19:00:00', 6.50),
(26, 10, 5, '2023-05-01 12:12:12', 2.99),
(27, 11, 10, '2024-02-14 20:00:00', 7.99),
(28, 11, 13, '2023-10-01 10:00:00', 4.99),
(29, 12, 2, '2024-01-01 00:01:00', 5.99),
(30, 12, 6, '2023-10-10 10:10:10', 4.50),
(31, 12, 9, '2024-03-05 17:45:00', 5.50),
(32, 12, 13, '2023-08-15 21:30:00', 4.99),
(33, 13, 5, '2024-02-05 16:00:00', 2.99),
(34, 13, 11, '2023-12-20 19:00:00', 7.99),
(64, 1, 1, '2024-01-20 10:30:00', 3.99),
(65, 1, 3, '2024-01-22 15:00:00', 4.99),
(66, 1, 5, '2023-06-15 11:00:00', 2.99),
(67, 1, 6, '2024-02-10 12:00:00', 4.50),
(68, 1, 8, '2023-11-05 19:30:00', 6.99),
(69, 1, 13, '2023-09-05 10:00:00', 4.99),
(70, 2, 4, '2024-02-01 18:45:00', 3.50),
(71, 2, 10, '2024-01-05 14:00:00', 7.99),
(72, 2, 13, '2023-10-28 22:00:00', 4.99),
(73, 3, 1, '2023-01-01 10:00:00', 3.99),
(74, 4, 2, '2023-12-25 20:00:00', 5.99),
(75, 4, 7, '2024-03-01 09:15:00', 3.99),
(76, 4, 11, '2024-02-15 21:00:00', 7.99),
(77, 4, 12, '2023-09-10 17:00:00', 6.50),
(78, 4, 13, '2023-09-15 12:00:00', 4.99),
(79, 5, 9, '2024-01-25 16:20:00', 5.50),
(80, 6, 2, '2023-08-10 11:00:00', 5.99),
(81, 6, 13, '2023-10-30 23:50:00', 4.99),
(82, 7, 3, '2024-02-20 13:00:00', 4.99),
(83, 7, 6, '2023-07-01 10:00:00', 4.50),
(84, 7, 8, '2024-03-03 03:00:00', 6.99),
(85, 7, 11, '2023-11-15 18:30:00', 7.99),
(86, 8, 1, '2024-01-10 08:00:00', 3.99),
(87, 9, 4, '2023-12-01 14:30:00', 3.50),
(88, 9, 12, '2024-02-28 19:00:00', 6.50),
(89, 10, 5, '2023-05-01 12:12:12', 2.99),
(90, 11, 10, '2024-02-14 20:00:00', 7.99),
(91, 11, 13, '2023-10-01 10:00:00', 4.99),
(92, 12, 2, '2024-01-01 00:01:00', 5.99),
(93, 12, 6, '2023-10-10 10:10:10', 4.50),
(94, 12, 9, '2024-03-05 17:45:00', 5.50),
(95, 12, 13, '2023-08-15 21:30:00', 4.99),
(96, 13, 5, '2024-02-05 16:00:00', 2.99),
(97, 13, 11, '2023-12-20 19:00:00', 7.99);

--
-- 转储表的索引
--

--
-- 表的索引 `actors`
--
ALTER TABLE `actors`
  ADD PRIMARY KEY (`actor_name`,`birth_date`);

--
-- 表的索引 `act_in`
--
ALTER TABLE `act_in`
  ADD PRIMARY KEY (`movie_id`,`actor_name`,`birth_date`),
  ADD KEY `actor_name` (`actor_name`,`birth_date`);

--
-- 表的索引 `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_id`);

--
-- 表的索引 `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`company_name`),
  ADD KEY `address_id` (`address_id`);

--
-- 表的索引 `director`
--
ALTER TABLE `director`
  ADD PRIMARY KEY (`director_name`,`birth_date`);

--
-- 表的索引 `direct_movie`
--
ALTER TABLE `direct_movie`
  ADD PRIMARY KEY (`movie_id`,`director_name`,`birth_date`),
  ADD KEY `director_name` (`director_name`,`birth_date`);

--
-- 表的索引 `download`
--
ALTER TABLE `download`
  ADD PRIMARY KEY (`download_id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `movie_id` (`movie_id`),
  ADD KEY `fk_download_purchase` (`purchase_id`);

--
-- 表的索引 `genre_type`
--
ALTER TABLE `genre_type`
  ADD PRIMARY KEY (`genre_name`);

--
-- 表的索引 `has_genre`
--
ALTER TABLE `has_genre`
  ADD PRIMARY KEY (`movie_id`,`genre_name`),
  ADD KEY `genre_name` (`genre_name`);

--
-- 表的索引 `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`member_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `StatusID` (`StatusID`);

--
-- 表的索引 `MemberStatusTypes`
--
ALTER TABLE `MemberStatusTypes`
  ADD PRIMARY KEY (`StatusID`),
  ADD UNIQUE KEY `StatusName` (`StatusName`);

--
-- 表的索引 `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`movie_id`),
  ADD KEY `company_name` (`company_name`);

--
-- 表的索引 `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`purchase_id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `movie_id` (`movie_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `address`
--
ALTER TABLE `address`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- 使用表AUTO_INCREMENT `download`
--
ALTER TABLE `download`
  MODIFY `download_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- 使用表AUTO_INCREMENT `members`
--
ALTER TABLE `members`
  MODIFY `member_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- 使用表AUTO_INCREMENT `MemberStatusTypes`
--
ALTER TABLE `MemberStatusTypes`
  MODIFY `StatusID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用表AUTO_INCREMENT `movies`
--
ALTER TABLE `movies`
  MODIFY `movie_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- 使用表AUTO_INCREMENT `purchase`
--
ALTER TABLE `purchase`
  MODIFY `purchase_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- 限制导出的表
--

--
-- 限制表 `act_in`
--
ALTER TABLE `act_in`
  ADD CONSTRAINT `act_in_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `act_in_ibfk_2` FOREIGN KEY (`actor_name`,`birth_date`) REFERENCES `actors` (`actor_name`, `birth_date`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `company`
--
ALTER TABLE `company`
  ADD CONSTRAINT `company_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- 限制表 `direct_movie`
--
ALTER TABLE `direct_movie`
  ADD CONSTRAINT `direct_movie_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `direct_movie_ibfk_2` FOREIGN KEY (`director_name`,`birth_date`) REFERENCES `director` (`director_name`, `birth_date`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `download`
--
ALTER TABLE `download`
  ADD CONSTRAINT `download_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `download_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_download_purchase` FOREIGN KEY (`purchase_id`) REFERENCES `purchase` (`purchase_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- 限制表 `has_genre`
--
ALTER TABLE `has_genre`
  ADD CONSTRAINT `has_genre_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `has_genre_ibfk_2` FOREIGN KEY (`genre_name`) REFERENCES `genre_type` (`genre_name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `members`
--
ALTER TABLE `members`
  ADD CONSTRAINT `members_ibfk_1` FOREIGN KEY (`StatusID`) REFERENCES `MemberStatusTypes` (`StatusID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- 限制表 `movies`
--
ALTER TABLE `movies`
  ADD CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`company_name`) REFERENCES `company` (`company_name`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- 限制表 `purchase`
--
ALTER TABLE `purchase`
  ADD CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`),
  ADD CONSTRAINT `purchase_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
