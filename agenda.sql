-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Temps de generació: 10-11-2022 a les 16:35:25
-- Versió del servidor: 10.4.17-MariaDB
-- Versió de PHP: 7.4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de dades: `agenda`
--

-- --------------------------------------------------------

--
-- Estructura de la taula `contacte`
--

CREATE TABLE `contacte` (
  `idContacte` int(11) NOT NULL,
  `nom` varchar(15) NOT NULL,
  `cognom` varchar(15) NOT NULL,
  `email` varchar(30) NOT NULL,
  `telefon` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Bolcament de dades per a la taula `contacte`
--

INSERT INTO `contacte` (`idContacte`, `nom`, `cognom`, `email`, `telefon`) VALUES
(1, 'Carme', 'Lopez', 'mlopez@gmail.com', '977620316'),
(2, 'Marcel', 'Tomas', 'mtomas@gmail.com', '977620317'),
(3, 'Marc', 'Barberà', 'mbarbera@gmail.com', '977620311'),
(4, 'Giuseppe', 'Peronni', 'pperoni@gmail.com', '977432311'),
(5, 'Joan', 'Dalmau San', 'jdalma10@xtec.cat', '977620314'),
(6, 'Joan', 'ewewwewe', 'jdalma10@xtec.cat', '977620314');

-- --------------------------------------------------------

--
-- Estructura de la taula `contactesusuari`
--

CREATE TABLE `contactesusuari` (
  `idContUser` int(11) NOT NULL,
  `idUsuari` int(11) NOT NULL,
  `idContacte` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Bolcament de dades per a la taula `contactesusuari`
--

INSERT INTO `contactesusuari` (`idContUser`, `idUsuari`, `idContacte`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 2, 4),
(5, 2, 3),
(6, 1, 3),
(7, 2, 1),
(8, 1, 5),
(9, 2, 6);

-- --------------------------------------------------------

--
-- Estructura de la taula `usuari`
--

CREATE TABLE `usuari` (
  `idUsuari` int(11) NOT NULL,
  `username` varchar(10) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Bolcament de dades per a la taula `usuari`
--

INSERT INTO `usuari` (`idUsuari`, `username`, `pass`, `isAdmin`) VALUES
(1, 'joan', '827ccb0eea8a706c4c34a16891f84e7b', 1),
(2, 'pere', '827ccb0eea8a706c4c34a16891f84e7b', 0);

-- --------------------------------------------------------

--
-- Estructura de suport per a vistes `vistausuari`
-- (mireu a sota per a la visualització real)
--
CREATE TABLE `vistausuari` (
`idContacte` int(11)
,`nom` varchar(15)
,`cognom` varchar(15)
,`email` varchar(30)
,`telefon` varchar(9)
);

-- --------------------------------------------------------

--
-- Estructura per a vista `vistausuari`
--
DROP TABLE IF EXISTS `vistausuari`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vistausuari`  AS SELECT `contacte`.`idContacte` AS `idContacte`, `contacte`.`nom` AS `nom`, `contacte`.`cognom` AS `cognom`, `contacte`.`email` AS `email`, `contacte`.`telefon` AS `telefon` FROM `contacte` WHERE `contacte`.`idContacte` in (select `contactesusuari`.`idContacte` from `contactesusuari` where `contactesusuari`.`idUsuari` in (select `usuari`.`idUsuari` from `usuari` where `usuari`.`username` = 'joan')) ;

--
-- Índexs per a les taules bolcades
--

--
-- Índexs per a la taula `contacte`
--
ALTER TABLE `contacte`
  ADD PRIMARY KEY (`idContacte`);

--
-- Índexs per a la taula `contactesusuari`
--
ALTER TABLE `contactesusuari`
  ADD PRIMARY KEY (`idContUser`),
  ADD KEY `usuariFK` (`idUsuari`),
  ADD KEY `contacteFK` (`idContacte`);

--
-- Índexs per a la taula `usuari`
--
ALTER TABLE `usuari`
  ADD PRIMARY KEY (`idUsuari`);

--
-- AUTO_INCREMENT per les taules bolcades
--

--
-- AUTO_INCREMENT per la taula `contacte`
--
ALTER TABLE `contacte`
  MODIFY `idContacte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT per la taula `contactesusuari`
--
ALTER TABLE `contactesusuari`
  MODIFY `idContUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT per la taula `usuari`
--
ALTER TABLE `usuari`
  MODIFY `idUsuari` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restriccions per a les taules bolcades
--

--
-- Restriccions per a la taula `contactesusuari`
--
ALTER TABLE `contactesusuari`
  ADD CONSTRAINT `contacteFK` FOREIGN KEY (`idContacte`) REFERENCES `contacte` (`idContacte`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usuariFK` FOREIGN KEY (`idUsuari`) REFERENCES `usuari` (`idUsuari`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
