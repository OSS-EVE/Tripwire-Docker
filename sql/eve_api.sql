-- phpMyAdmin SQL Dump
-- version 4.3.8
-- http://www.phpmyadmin.net
--
-- Host: 10.132.118.131
-- Generation Time: Nov 12, 2015 at 01:30 AM
-- Server version: 5.6.26-74.0
-- PHP Version: 5.5.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `eve_api`
--

-- --------------------------------------------------------

--
-- Table structure for table `cacheTime`
--

CREATE TABLE IF NOT EXISTS `cacheTime` (
  `type` enum('activity') NOT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `recentActivity`
--

CREATE TABLE IF NOT EXISTS `recentActivity` (
  `systemID` int(8) unsigned NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `shipJumps` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `shipKills` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `podKills` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `npcKills` mediumint(6) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 DELAY_KEY_WRITE=1;

-- --------------------------------------------------------

--
-- Table structure for table `serverStatus`
--

CREATE TABLE IF NOT EXISTS `serverStatus` (
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `players` mediumint(6) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 DELAY_KEY_WRITE=1;

-- --------------------------------------------------------

--
-- Table structure for table `systemActivity`
--

CREATE TABLE IF NOT EXISTS `systemActivity` (
  `systemID` int(8) unsigned NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `shipJumps` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `shipKills` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `podKills` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `npcKills` mediumint(6) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0;

--
-- Triggers `systemActivity`
--
DELIMITER $$
CREATE TRIGGER `recentUpdate` AFTER INSERT ON `systemActivity`
 FOR EACH ROW BEGIN 
	INSERT INTO recentActivity (
        systemID,
        time,
        shipJumps,
        shipKills,
        podKills,
        npcKills
    )
    VALUES (
        NEW.systemID,
        NEW.time,
        NEW.shipJumps,

        NEW.shipKills,
        NEW.podKills,
        NEW.npcKills
    )
    ON DUPLICATE KEY UPDATE
		time = NEW.time,
		shipJumps = NEW.shipJumps,
		shipKills = NEW.shipKills,
		podKills = NEW.podKills,
		npcKills = NEW.npcKills;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cacheTime`
--
ALTER TABLE `cacheTime`
  ADD PRIMARY KEY (`type`);

--
-- Indexes for table `recentActivity`
--
ALTER TABLE `recentActivity`
  ADD PRIMARY KEY (`systemID`);

--
-- Indexes for table `serverStatus`
--
ALTER TABLE `serverStatus`
  ADD PRIMARY KEY (`time`), ADD KEY `status` (`status`);

--
-- Indexes for table `systemActivity`
--
ALTER TABLE `systemActivity`
  ADD PRIMARY KEY (`systemID`,`time`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
