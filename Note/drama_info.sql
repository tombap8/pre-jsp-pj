-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- 생성 시간: 22-11-25 04:11
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
-- 테이블 구조 `drama_info`
--

CREATE TABLE `drama_info` (
  `idx` int(6) UNSIGNED NOT NULL,
  `dname` varchar(100) NOT NULL,
  `actors` varchar(100) NOT NULL,
  `broad` varchar(50) NOT NULL,
  `gubun` varchar(10) NOT NULL,
  `stime` varchar(50) NOT NULL,
  `total` varchar(20) NOT NULL,
  `idate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 테이블의 덤프 데이터 `drama_info`
--

INSERT INTO `drama_info` (`idx`, `dname`, `actors`, `broad`, `gubun`, `stime`, `total`, `idate`) VALUES
(1, '타인은 지옥일까?', '임시완,이동욱', 'OCN', '토,일', '10:30', '10부작', '2022-11-22 05:00:43'),
(2, '열여덟의 순간', '옹성우,김향기', 'JTBC', '월,화', '09:30', '16부작', '2022-11-11 06:52:19'),
(3, '펜트하우스2', '유진,김소연', 'SBS', '금,토', '10:00', '20부작', '2022-11-11 06:52:19'),
(4, '선배, 그 립스틱 바르지 마요', '로운,원진아', 'JTBC', '월,화', '09:00', '16부작', '2022-11-11 06:52:19'),
(8, '강남미인', '김사랑', 'tvN', '토일', '10시', '12부작', '2022-11-17 05:56:20'),
(10, '나의 해방일지', '김석구', 'KBS', '수목', '10시', '12부작', '2022-11-18 04:41:46'),
(11, '슈룹', '김혜수', 'tvN', '토일', '9시10분', '16부작', '2022-11-22 05:09:48'),
(12, '디 엠파이어: 법의 제국', '김선아,안재욱', 'JTBC', '토일', '10시30분', '16부작', '2022-11-18 05:33:55'),
(13, '금수저', '육성재,이종원', 'MBC', '금토', '9시50분', '16부작', '2022-11-18 05:34:49'),
(14, '천원짜리 변호사', '남궁민,김지은', 'SBS', '금토', '10시', '12부작', '2022-11-18 05:35:43'),
(15, '블라인드', '옥태연,하석진', 'tvN', '금토', '10시40분', '16부작', '2022-11-18 05:36:49'),
(16, '연예인 매니저로 살아남기', '이서진,곽선영', 'tvN', '월화', '10시30분', '16부작', '2022-11-18 05:38:20'),
(17, '나는 나야', '김혜수', 'KBS', '월화', '9시', '16부작', '2022-11-18 05:42:31'),
(18, '오냐 어서오거라!', '하정우', 'KBS', '월화', '9시10분', '16부작', '2022-11-18 07:07:21'),
(19, '하야하야하야', '김혜수', 'KBS', '금토', '9시10분', '16부작', '2022-11-18 08:07:02'),
(20, '우리마눌', '김선아,안재욱', 'KBS', '금토', '9시10분', '12부작', '2022-11-18 08:07:28');

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `drama_info`
--
ALTER TABLE `drama_info`
  ADD PRIMARY KEY (`idx`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `drama_info`
--
ALTER TABLE `drama_info`
  MODIFY `idx` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
