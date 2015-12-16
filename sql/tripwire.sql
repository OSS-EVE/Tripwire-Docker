-- phpMyAdmin SQL Dump
-- version 4.3.8
-- http://www.phpmyadmin.net
--
-- Host: 10.132.118.131
-- Generation Time: Nov 12, 2015 at 01:28 AM
-- Server version: 5.6.26-74.0
-- PHP Version: 5.5.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tripwire`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(11) NOT NULL,
  `username` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` char(60) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ban` tinyint(1) NOT NULL DEFAULT '0',
  `super` tinyint(1) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM AUTO_INCREMENT=21513 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `active`
--

CREATE TABLE IF NOT EXISTS `active` (
  `ip` char(42) NOT NULL,
  `instance` decimal(13,3) unsigned NOT NULL DEFAULT '0.000',
  `session` char(50) NOT NULL,
  `userID` mediumint(8) unsigned NOT NULL,
  `maskID` decimal(12,1) NOT NULL,
  `characterID` int(10) unsigned DEFAULT NULL,
  `characterName` char(50) DEFAULT NULL,
  `systemID` int(8) unsigned DEFAULT NULL,
  `systemName` char(50) DEFAULT NULL,
  `shipID` bigint(14) unsigned DEFAULT NULL,
  `shipName` char(50) DEFAULT NULL,
  `shipTypeID` int(10) unsigned DEFAULT NULL,
  `shipTypeName` char(50) DEFAULT NULL,
  `stationID` int(10) unsigned DEFAULT NULL,
  `stationName` char(100) DEFAULT NULL,
  `activity` char(25) DEFAULT NULL,
  `notify` char(150) DEFAULT NULL,
  `version` enum('tripwire','galileo') NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

--
-- Triggers `active`
--
DELIMITER $$
CREATE TRIGGER `jumpHistory` AFTER UPDATE ON `active`
 FOR EACH ROW BEGIN
	IF NEW.systemID <> OLD.systemID THEN
		INSERT INTO jumps (wormholeID, characterID, characterName, toID, toName, fromID, fromName, shipTypeID, shipType, maskID)
			VALUES ((SELECT id FROM signatures WHERE (systemID = NEW.systemID AND connectionID = OLD.systemID) OR (systemID = OLD.systemID AND connectionID = NEW.systemID)), NEW.characterID, NEW.characterName, NEW.systemID, NEW.systemName, OLD.systemID, OLD.systemName, NEW.shipTypeID, NEW.shipTypeName, NEW.maskID);
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE IF NOT EXISTS `characters` (
  `userID` int(11) NOT NULL,
  `characterID` int(10) unsigned NOT NULL,
  `characterName` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `corporationID` int(10) unsigned NOT NULL,
  `corporationName` varchar(60) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `ban` tinyint(1) NOT NULL DEFAULT '0',
  `added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(11) NOT NULL,
  `systemID` int(8) unsigned NOT NULL,
  `comment` text NOT NULL,
  `created` datetime NOT NULL,
  `createdBy` int(10) NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifiedBy` int(10) NOT NULL,
  `maskID` decimal(12,2) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=120358 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `flares`
--

CREATE TABLE IF NOT EXISTS `flares` (
  `maskID` decimal(12,1) NOT NULL,
  `systemID` int(8) unsigned NOT NULL,
  `flare` enum('red','yellow','green') CHARACTER SET latin1 NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `maskID` decimal(12,1) NOT NULL,
  `joined` tinyint(1) NOT NULL DEFAULT '0',
  `eveID` int(10) unsigned NOT NULL,
  `eveType` smallint(5) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jumps`
--

CREATE TABLE IF NOT EXISTS `jumps` (
  `wormholeID` int(10) unsigned NOT NULL,
  `characterID` int(10) unsigned NOT NULL,
  `characterName` varchar(50) NOT NULL,
  `fromID` int(8) unsigned NOT NULL,
  `fromName` varchar(20) DEFAULT NULL,
  `toID` int(8) unsigned NOT NULL,
  `toName` varchar(20) DEFAULT NULL,
  `shipTypeID` int(10) unsigned DEFAULT NULL,
  `shipType` varchar(50) DEFAULT NULL,
  `maskID` decimal(12,1) NOT NULL DEFAULT '0.0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `masks`
--

CREATE TABLE IF NOT EXISTS `masks` (
  `maskID` decimal(12,1) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `ownerID` int(10) unsigned NOT NULL,
  `ownerType` smallint(5) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Table structure for table `preferences`
--

CREATE TABLE IF NOT EXISTS `preferences` (
  `userID` int(10) unsigned NOT NULL,
  `options` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `signatures`
--

CREATE TABLE IF NOT EXISTS `signatures` (
  `id` int(8) unsigned NOT NULL,
  `signatureID` char(3) NOT NULL,
  `system` char(20) DEFAULT NULL,
  `systemID` int(8) unsigned NOT NULL,
  `type` char(8) NOT NULL,
  `class` char(2) DEFAULT NULL,
  `classBM` char(1) DEFAULT NULL,
  `typeBM` char(1) DEFAULT NULL,
  `nth` tinyint(1) unsigned DEFAULT NULL,
  `sig2ID` char(3) DEFAULT NULL,
  `sig2Type` char(8) DEFAULT NULL,
  `class2` char(2) DEFAULT NULL,
  `class2BM` char(1) DEFAULT NULL,
  `type2BM` char(1) DEFAULT NULL,
  `nth2` tinyint(1) unsigned DEFAULT NULL,
  `connection` char(20) DEFAULT NULL,
  `connectionID` int(8) unsigned DEFAULT NULL,
  `life` enum('','Critical','Stable') DEFAULT NULL,
  `lifeTime` datetime NOT NULL,
  `lifeLeft` datetime NOT NULL,
  `lifeLength` enum('0','16','24','48','72','168','672','4032') NOT NULL DEFAULT '0',
  `mass` enum('','Stable','Critical','Destab','Half-Crit') DEFAULT NULL,
  `name` char(50) DEFAULT NULL,
  `mask` decimal(12,1) unsigned NOT NULL DEFAULT '0.0',
  `userID` int(11) NOT NULL,
  `time` datetime NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=4193309 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Triggers `signatures`
--
DELIMITER $$
CREATE TRIGGER `logDelete` BEFORE DELETE ON `signatures`
 FOR EACH ROW IF @disable_trigger IS NULL THEN
	DELETE FROM jumps WHERE wormholeID = OLD.id;
    INSERT INTO _history_signatures (SELECT null AS historyID, signatures.*, 'delete' AS status FROM signatures WHERE id = OLD.id);
END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `logInsert` AFTER INSERT ON `signatures`
 FOR EACH ROW IF @disable_trigger IS NULL THEN
    INSERT INTO _history_signatures (SELECT null AS historyID, signatures.*, 'add' AS status FROM signatures WHERE id = NEW.id);
END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `logUpdate` AFTER UPDATE ON `signatures`
 FOR EACH ROW IF @disable_trigger IS NULL THEN
    IF NEW.time <> OLD.time THEN
            INSERT INTO _history_signatures (SELECT null AS historyID, signatures.*, 'update' AS status FROM signatures WHERE id = OLD.id);
    END IF;
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `systemVisits`
--

CREATE TABLE IF NOT EXISTS `systemVisits` (
  `systemID` int(10) unsigned NOT NULL,
  `userID` int(10) unsigned NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `userStats`
--

CREATE TABLE IF NOT EXISTS `userStats` (
  `userID` int(10) unsigned NOT NULL,
  `lastLogin` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sigCount` int(10) unsigned NOT NULL DEFAULT '0',
  `systemsVisited` int(10) unsigned NOT NULL DEFAULT '0',
  `systemsViewed` int(10) unsigned NOT NULL DEFAULT '0',
  `loginCount` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `_history_login`
--

CREATE TABLE IF NOT EXISTS `_history_login` (
  `ip` varchar(42) NOT NULL,
  `username` varchar(25) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `method` enum('user','api','cookie') NOT NULL,
  `result` enum('success','fail') NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `_history_signatures`
--

CREATE TABLE IF NOT EXISTS `_history_signatures` (
  `historyID` int(11) NOT NULL,
  `id` int(8) unsigned NOT NULL,
  `signatureID` char(3) NOT NULL,
  `system` char(20) DEFAULT NULL,
  `systemID` int(8) unsigned NOT NULL,
  `type` char(8) NOT NULL,
  `class` char(2) DEFAULT NULL,
  `classBM` char(1) DEFAULT NULL,
  `typeBM` char(1) DEFAULT NULL,
  `nth` tinyint(1) unsigned DEFAULT NULL,
  `sig2ID` char(3) DEFAULT NULL,
  `sig2Type` char(8) DEFAULT NULL,
  `class2` char(2) DEFAULT NULL,
  `class2BM` char(1) DEFAULT NULL,
  `type2BM` char(1) DEFAULT NULL,
  `nth2` tinyint(1) unsigned DEFAULT NULL,
  `connection` char(20) DEFAULT NULL,
  `connectionID` int(8) unsigned DEFAULT NULL,
  `life` enum('','Critical','Stable') DEFAULT NULL,
  `lifeTime` datetime NOT NULL,
  `lifeLeft` datetime NOT NULL,
  `lifeLength` enum('0','16','24','48','72','168','672','4032') NOT NULL DEFAULT '0',
  `mass` enum('','Stable','Critical','Destab','Half-Crit') DEFAULT NULL,
  `name` char(50) DEFAULT NULL,
  `mask` decimal(12,1) unsigned NOT NULL DEFAULT '0.0',
  `userID` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `status` enum('add','update','delete','undo:add','undo:update','undo:delete') NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=3942830 DEFAULT CHARSET=utf8 DELAY_KEY_WRITE=1 ROW_FORMAT=FIXED;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `username` (`username`), ADD KEY `ban` (`ban`);

--
-- Indexes for table `active`
--
ALTER TABLE `active`
  ADD PRIMARY KEY (`ip`,`instance`,`session`,`userID`);

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`userID`), ADD UNIQUE KEY `characterID` (`characterID`), ADD KEY `ban` (`ban`), ADD KEY `admin` (`admin`), ADD KEY `corporationID` (`corporationID`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`), ADD KEY `systemID` (`systemID`,`maskID`);

--
-- Indexes for table `flares`
--
ALTER TABLE `flares`
  ADD PRIMARY KEY (`maskID`,`systemID`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`maskID`,`eveID`,`eveType`), ADD KEY `joined` (`joined`);

--
-- Indexes for table `masks`
--
ALTER TABLE `masks`
  ADD PRIMARY KEY (`maskID`), ADD UNIQUE KEY `name` (`name`,`ownerID`,`ownerType`);

--
-- Indexes for table `preferences`
--
ALTER TABLE `preferences`
  ADD PRIMARY KEY (`userID`);

--
-- Indexes for table `signatures`
--
ALTER TABLE `signatures`
  ADD PRIMARY KEY (`id`), ADD KEY `mask` (`mask`), ADD KEY `life` (`life`), ADD KEY `systemID` (`systemID`), ADD KEY `connectionID` (`connectionID`);

--
-- Indexes for table `systemVisits`
--
ALTER TABLE `systemVisits`
  ADD PRIMARY KEY (`systemID`,`userID`);

--
-- Indexes for table `userStats`
--
ALTER TABLE `userStats`
  ADD PRIMARY KEY (`userID`);

--
-- Indexes for table `_history_login`
--
ALTER TABLE `_history_login`
  ADD PRIMARY KEY (`ip`,`time`), ADD KEY `username` (`username`);

--
-- Indexes for table `_history_signatures`
--
ALTER TABLE `_history_signatures`
  ADD PRIMARY KEY (`historyID`), ADD KEY `mask` (`mask`), ADD KEY `systemID` (`systemID`), ADD KEY `connectionID` (`connectionID`), ADD KEY `status` (`status`), ADD KEY `time` (`time`), ADD KEY `userID` (`userID`), ADD KEY `id` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21513;
--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=120358;
--
-- AUTO_INCREMENT for table `signatures`
--
ALTER TABLE `signatures`
  MODIFY `id` int(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4193309;
--
-- AUTO_INCREMENT for table `_history_signatures`
--
ALTER TABLE `_history_signatures`
  MODIFY `historyID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3942830;
DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `flaresClean` ON SCHEDULE EVERY 1 HOUR STARTS '2014-08-21 03:15:55' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM flares WHERE DATE_ADD(time, INTERVAL 24 HOUR) < NOW()$$

CREATE DEFINER=`root`@`localhost` EVENT `sigDelete` ON SCHEDULE EVERY 1 MINUTE STARTS '2014-08-21 03:17:16' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN

UPDATE signatures SET userID = 0 WHERE (lifeLeft < NOW() AND life IS NULL OR life = "Critical" AND lifeLength <> '0' AND DATE_ADD(lifeLeft, INTERVAL 1 HOUR) < NOW());

DELETE FROM signatures WHERE lifeLength <> '0' AND (lifeLeft < NOW() AND life IS NULL OR life = "Critical" AND DATE_ADD(lifeLeft, INTERVAL 1 HOUR) < NOW());

END$$

CREATE DEFINER=`root`@`localhost` EVENT `activeClean` ON SCHEDULE EVERY 10 SECOND STARTS '2014-09-27 23:42:27' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM active WHERE DATE_ADD(time, INTERVAL 10 SECOND) < NOW()$$

CREATE DEFINER=`root`@`localhost` EVENT `whCritical` ON SCHEDULE EVERY 1 MINUTE STARTS '2014-08-21 03:16:46' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE signatures SET life = "Critical", userID = 0, time = NOW() WHERE life = "Stable" AND lifeLength <> '0' AND DATE_SUB(lifeLeft, INTERVAL 4 HOUR) < NOW()$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
