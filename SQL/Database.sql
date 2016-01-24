SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `Luna` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;

USE `Luna`;

DROP TABLE IF EXISTS `servers`;
DROP TABLE IF EXISTS `postcards`;
DROP TABLE IF EXISTS `puffles`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `igloos`;
DROP TABLE IF EXISTS `paypal_payments`;
DROP TABLE IF EXISTS `paypal_products`;

CREATE TABLE IF NOT EXISTS `servers` (
  `servType` varchar(10) NOT NULL DEFAULT 'game',
  `servPort` int(5) NOT NULL,
  `servName` char(20) NOT NULL,
  `servIP` mediumblob NOT NULL,
  `curPop` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`servType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `paypal_payments` (
 `payment_id` int(6) NOT NULL,
 `product_id` int(6) NOT NULL,
 PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `paypal_products` (
 `itemprice` int(6) NOT NULL,
 `shipping` int(6) NOT NULL,
 `product_id` int(6) NOT NULL,
 `tax` int(6) NOT NULL,
 `currencycode` varchar(5) NOT NULL,
 PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE IF NOT EXISTS `puffles` (
  `puffleID` int(11) NOT NULL AUTO_INCREMENT,
  `ownerID` int(2) NOT NULL,
  `puffleName` char(10) NOT NULL,
  `puffleType` int(2) NOT NULL,
  `puffleEnergy` int(3) NOT NULL DEFAULT '100',
  `puffleHealth` int(3) NOT NULL DEFAULT '100',
  `puffleRest` int(3) NOT NULL DEFAULT '100',
  PRIMARY KEY (`puffleID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `postcards` (
  `postcardID` int(10) NOT NULL AUTO_INCREMENT,
  `recepient` int(10) NOT NULL,
  `mailerName` char(12) NOT NULL,
  `mailerID` int(10) NOT NULL,
  `notes` char(12) NOT NULL,
  `timestamp` int(8) NOT NULL,
  `postcardType` int(5) NOT NULL,
  `isRead` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`postcardID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

INSERT INTO `postcards` (`recepient`, `mailerName`, `mailerID`, `notes`, `timestamp`, `postcardType`) VALUES ('1', 'Luna', '0', 'Welcome To Luna', UNIX_TIMESTAMP(TIMESTAMP), '125');

CREATE TABLE IF NOT EXISTS `igloos` (
  `ID` int(11) NOT NULL,
  `username` char(20) NOT NULL,
  `igloo` int(10) NOT NULL DEFAULT '1',
  `floor` int(10) NOT NULL DEFAULT '0',
  `music` int(10) NOT NULL DEFAULT '0',
  `furniture` longblob NOT NULL,
  `ownedFurns` longblob NOT NULL,
  `ownedIgloos` longblob NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `igloos` (`ID`, `username`) VALUES ('1', 'Isis');

CREATE TABLE IF NOT EXISTS `users` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `username` char(20) NOT NULL,
  `nickname` char(20) NOT NULL,
  `password` char(32) NOT NULL,
  `spin` int(6) NOT NULL,
  `loginKey` char(32) NOT NULL,
  `ipAddr` mediumblob NOT NULL,
  `email` mediumblob NOT NULL,
  `age` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LastLogin` timestamp,
  `active` int(1) NOT NULL DEFAULT '1',
  `bitMask` int(1) NOT NULL DEFAULT '1',
  `isBanned` varchar(10) NOT NULL DEFAULT '0',
  `banCount` int(1) NOT NULL DEFAULT '0',
  `invalidLogins` int(3) NOT NULL DEFAULT '0',
  `inventory` longblob NOT NULL,
  `head` int(10) NOT NULL DEFAULT '0',
  `face` int(10) NOT NULL DEFAULT '0',
  `neck` int(10) NOT NULL DEFAULT '0',
  `body` int(10) NOT NULL DEFAULT '0',
  `hand` int(10) NOT NULL DEFAULT '0',
  `feet` int(10) NOT NULL DEFAULT '0',
  `photo` int(10) NOT NULL DEFAULT '0',
  `flag` int(10) NOT NULL DEFAULT '0',
  `colour` int(10) NOT NULL DEFAULT '1',
  `coins` int(11) NOT NULL,
  `isMuted` int(1) NOT NULL DEFAULT '0',
  `isVIP` int(1) NOT NULL DEFAULT '0',
  `isStaff` int(1) NOT NULL DEFAULT '0',
  `isAdmin` int(1) NOT NULL DEFAULT '0',
  `rank` int(1) NOT NULL DEFAULT '1',  
  `buddies` longblob NOT NULL,
  `ignored` longblob NOT NULL,
  `isEPF` int(1) NOT NULL DEFAULT '0',
  `fieldOPStatus` int(1) NOT NULL DEFAULT '0',
  `epfPoints` int(10) NOT NULL DEFAULT '20',
  `totalEPFPoints` int(10) NOT NULL DEFAULT '100',
  `stamps` longblob NOT NULL,
  `cover` longblob NOT NULL,
  `restamps` longblob NOT NULL,
  `nameglow` mediumblob NOT NULL,
  `namecolour` mediumblob NOT NULL,
  `bubbletext` mediumblob NOT NULL,
  `bubblecolour` mediumblob NOT NULL,
  `ringcolour` mediumblob NOT NULL,
  `speed` int(3) NOT NULL DEFAULT '4',
  `mood` char(100) NOT NULL,
  `penguin_size` int(3) NOT NULL,
  `penguin_blend` mediumblob NOT NULL,
  `penguin_alpha` int(3) NOT NULL,
  `botIsFollow` int(1) NOT NULL DEFAULT '0',
  `isMirror` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

INSERT INTO `users` (`username`, `nickname`, `password`, `colour`, `stamps`) VALUES ('Isis', 'Isis', 'f666dc0363010318799f42c48de7a41a', '4', '31|7|33|8|32|35|34|36|290|358|448');
