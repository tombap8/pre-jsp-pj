-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- 생성 시간: 22-12-04 13:02
-- 서버 버전: 10.4.25-MariaDB
-- PHP 버전: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 데이터베이스: `mydb`
--

-- --------------------------------------------------------

--
-- 테이블 구조 `member`
--

CREATE TABLE `member` (
  `idx` int(11) NOT NULL,
  `mid` varchar(20) NOT NULL,
  `mpw` varchar(100) NOT NULL,
  `name` varchar(20) NOT NULL,
  `gen` char(1) NOT NULL,
  `email1` varchar(20) NOT NULL,
  `email2` varchar(20) NOT NULL,
  `regdate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `auth` char(1) DEFAULT 'M'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `member`
--

INSERT INTO `member` (`idx`, `mid`, `mpw`, `name`, `gen`, `email1`, `email2`, `regdate`, `auth`) VALUES
(1, 'tomtom', '0a435caa448ab73c73b2284d1cc9d273c896ff5f025971804970233eca2ce0b1', '김수현', 'o', 'kimsu', '', '2022-12-04 09:02:29', 'M'),
(2, 'tomtom7', '0a435caa448ab73c73b2284d1cc9d273c896ff5f025971804970233eca2ce0b1', '공유', 'o', 'gongu', '', '2022-12-04 09:02:29', 'M'),
(3, 'tomtom3', '0a435caa448ab73c73b2284d1cc9d273c896ff5f025971804970233eca2ce0b1', '로운', 'o', 'lowoon', 'save.com', '2022-12-04 09:02:29', 'M'),
(4, 'tomtom5', '0a435caa448ab73c73b2284d1cc9d273c896ff5f025971804970233eca2ce0b1', '강지환', 'o', 'kangj', '', '2022-12-04 09:02:29', 'M'),
(5, 'tomtom9', '0a435caa448ab73c73b2284d1cc9d273c896ff5f025971804970233eca2ce0b1', '김지은', 'o', 'kimj', '', '2022-12-04 09:02:29', 'M'),
(6, 'tomtom2', '0a435caa448ab73c73b2284d1cc9d273c896ff5f025971804970233eca2ce0b1', '조수미', 'o', 'josumi', 'seoul.co.kr', '2022-12-04 09:02:29', 'M'),
(7, 'angelina', '0a435caa448ab73c73b2284d1cc9d273c896ff5f025971804970233eca2ce0b1', '안젤리나 졸리', 'o', 'angelina', 'america.com', '2022-12-04 09:02:49', 'S'),
(8, 'naverk', '0a435caa448ab73c73b2284d1cc9d273c896ff5f025971804970233eca2ce0b1', '김효령', 'o', 'kimhyo', '', '2022-12-04 09:02:29', 'M'),
(9, 'nothings', '0a435caa448ab73c73b2284d1cc9d273c896ff5f025971804970233eca2ce0b1', '아무개', 'o', 'nothing', '', '2022-12-04 09:02:29', 'M'),
(10, 'jayjay', '0a435caa448ab73c73b2284d1cc9d273c896ff5f025971804970233eca2ce0b1', '제이제이', 'o', 'jayjay', '', '2022-12-04 09:02:29', 'M'),
(11, 'kaykay', '0a435caa448ab73c73b2284d1cc9d273c896ff5f025971804970233eca2ce0b1', '케이케이', 'o', 'kaykay', '', '2022-12-04 09:02:29', 'M'),
(12, 'saysay', '0a435caa448ab73c73b2284d1cc9d273c896ff5f025971804970233eca2ce0b1', '세이세이', 'o', 'saysay', '', '2022-12-04 09:39:38', 'A'),
(13, 'kimkim', '0a435caa448ab73c73b2284d1cc9d273c896ff5f025971804970233eca2ce0b1', '김승현', 'w', 'kimkim', 'gmail.com', '2022-12-04 09:01:18', 'M');

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`idx`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `member`
--
ALTER TABLE `member`
  MODIFY `idx` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
