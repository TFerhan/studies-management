-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3308
-- Généré le : mar. 12 déc. 2023 à 01:54
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `mydb`
--

-- --------------------------------------------------------

--
-- Structure de la table `admins`
--

CREATE TABLE `admins` (
  `id_admin` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `admins`
--

INSERT INTO `admins` (`id_admin`, `username`, `password`) VALUES
(1, 'youness', '12345678'),
(2, 'taha', 'mdp');

-- --------------------------------------------------------

--
-- Structure de la table `cours`
--

CREATE TABLE `cours` (
  `idcours` int(11) NOT NULL,
  `nom_course` varchar(45) NOT NULL,
  `prix_cours` int(11) NOT NULL,
  `formation_idformation` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `cours`
--

INSERT INTO `cours` (`idcours`, `nom_course`, `prix_cours`, `formation_idformation`) VALUES
(9, 'francais', 150, 2),
(10, 'anglais', 150, 2),
(11, 'allemand', 150, 2),
(12, 'Public Speaking', 150, 3),
(13, 'Team Management', 150, 3),
(14, 'Agile', 150, 3),
(15, 'maths 2 bac', 150, 4),
(16, 'physique 2 bac', 150, 4),
(17, 'philo 2 bac', 150, 4),
(18, 'arabe 1 bac', 150, 4),
(19, 'français 1 bac', 150, 4),
(20, 'Histoire/geographie 1 bac', 150, 4),
(21, 'Web Dev', 150, 5),
(22, 'Mobile Dev', 150, 5),
(23, ' Embedded systems Dev', 150, 5);

-- --------------------------------------------------------

--
-- Structure de la table `eleve`
--

CREATE TABLE `eleve` (
  `id_eleve` int(11) NOT NULL,
  `prenom_ev` varchar(45) NOT NULL,
  `nom_ev` varchar(45) NOT NULL,
  `email_ev` varchar(45) DEFAULT NULL,
  `phone_ev` varchar(20) DEFAULT NULL COMMENT 'numéro de télephone de l''élève\n',
  `numtel_par` varchar(20) NOT NULL COMMENT 'numéro de télephone du parent\n',
  `date_inscrit` date NOT NULL,
  `test` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `eleve`
--

INSERT INTO `eleve` (`id_eleve`, `prenom_ev`, `nom_ev`, `email_ev`, `phone_ev`, `numtel_par`, `date_inscrit`, `test`) VALUES
(39, 'okfo', 'ffplp', 'fofk@gmf.c', '04848485', '04548', '2023-12-05', 0),
(40, 'lkf', 'lklk', 'ffk@v.v', '58844', '5584', '2023-12-12', 0),
(41, 'okfo', 'klckl', 'kfkf@f.f', '0445', '04545', '2023-12-27', 0),
(43, 'lklk', 'kjkjk', 'llkl@g.v', '084485', '05448', '2023-12-06', 0),
(45, 'fkgkg', 'ghhggok', 'lgkog@g.b', '0154', '02151', '2023-12-07', 0),
(46, 'kjkj', 'kjkjkl', 'oioi@g.b', '021515', '021515', '2023-12-05', 0),
(47, 'ngngngg', 'bnnhh', 'gngg@g.b', '02512202', '0211212', '2023-12-13', 0),
(48, 'Youssef', 'Ait Ben Ali', 'youssef@gmail.com', '0612345678', '0612345678', '2023-12-11', 0),
(49, 'Hassan', 'El Fassi', 'hassan@gmail.com', '0623456789', '0623456789', '2023-12-12', 0),
(50, 'Fatima', 'Zahra', 'fatimazahra@gmail.com', '0634567890', '0634567890', '2023-12-13', 0),
(51, 'Mohamed', 'Ait Oussaid', 'mohamed@gmail.com', '0645678901', '0645678901', '2023-12-14', 0),
(52, 'Karima', 'Bouhaddi', 'karima@gmail.com', '0656789012', '0656789012', '2023-12-15', 0),
(53, 'Ahmed', 'Ezzaki', 'ahmed@gmail.com', '0667890123', '0667890123', '2023-12-16', 0),
(54, 'Nadia', 'Cherkaoui', 'nadia@gmail.com', '0678901234', '0678901234', '2023-12-17', 0),
(55, 'Abdel', 'Nour', 'abdelnour@gmail.com', '0689012345', '0689012345', '2023-12-18', 0),
(56, 'Omar', 'Tazi', 'omar@gmail.com', '0690123456', '0690123456', '2023-12-19', 0),
(57, 'Nawal', 'El Mekki', 'nawal@gmail.com', '0601234567', '0601234567', '2023-12-20', 0),
(58, 'Ali', 'Berrada', 'ali@gmail.com', '0612345678', '0612345678', '2023-12-21', 0),
(59, 'Amina', 'Zaoui', 'amina@gmail.com', '0623456789', '0623456789', '2023-12-22', 0),
(60, 'Hicham', 'El Amrani', 'hicham@gmail.com', '0634567890', '0634567890', '2023-12-23', 0),
(61, 'Salma', 'El Moussaoui', 'salma@gmail.com', '0645678901', '0645678901', '2023-12-24', 0),
(62, 'Younes', 'Belkadi', 'younes@gmail.com', '0656789012', '0656789012', '2023-12-25', 0),
(63, 'Laila', 'El Bachiri', 'laila@gmail.com', '0667890123', '0667890123', '2023-12-26', 0),
(64, 'Reda', 'Fassi', 'reda@gmail.com', '0678901234', '0678901234', '2023-12-27', 0),
(65, 'Sara', 'El Alaoui', 'sara@gmail.com', '0689012345', '0689012345', '2023-12-28', 0),
(66, 'Mehdi', 'Taleb', 'mehdi@gmail.com', '0690123456', '0690123456', '2023-12-29', 0),
(67, 'Aicha', 'Moussa', 'aicha@gmail.com', '0601234567', '0601234567', '2023-12-30', 0),
(68, 'Karim', 'Bouchaib', 'karim@gmail.com', '0612345678', '0612345678', '2023-12-31', 0),
(69, 'Samira', 'El Fakir', 'samira@gmail.com', '0623456789', '0623456789', '2024-01-01', 0),
(70, 'Khalid', 'El Kaddouri', 'khalid@gmail.com', '0634567890', '0634567890', '2024-01-02', 0),
(71, 'Fatiha', 'El Khatib', 'fatiha@gmail.com', '0645678901', '0645678901', '2024-01-03', 0),
(72, 'Mounir', 'El Hajji', 'mounir@gmail.com', '0656789012', '0656789012', '2024-01-04', 0),
(73, 'Hajar', 'El Ghazali', 'hajar@gmail.com', '0667890123', '0667890123', '2024-01-05', 0),
(74, 'Hamza', 'El Moufid', 'hamza@gmail.com', '0678901234', '0678901234', '2024-01-06', 0),
(75, 'Rachid', 'El Morabit', 'rachid@gmail.com', '0689012345', '0689012345', '2024-01-07', 0),
(76, 'Nabil', 'El Maslouhi', 'nabil@gmail.com', '0690123456', '0690123456', '2024-01-08', 0),
(77, 'Lina', 'El Alaoui', 'lina@gmail.com', '0601234567', '0601234567', '2024-01-09', 0),
(78, 'Mustapha', 'El Mansouri', 'mustapha@gmail.com', '0612345678', '0612345678', '2024-01-10', 0),
(79, 'Zineb', 'El Fakir', 'zineb@gmail.com', '0623456789', '0623456789', '2024-01-11', 0),
(80, 'Hicham', 'El Alaoui', 'hicham@gmail.com', '0634567890', '0634567890', '2024-01-12', 0),
(81, 'Fatima', 'El Alaoui', 'fatima@gmail.com', '0645678901', '0645678901', '2024-01-13', 0),
(82, 'Khalid', 'El Alaoui', 'khalid@gmail.com', '0656789012', '0656789012', '2024-01-14', 0),
(83, 'Mouna', 'El Alaoui', 'mouna@gmail.com', '0667890123', '0667890123', '2024-01-15', 0),
(84, 'Imane', 'El Alaoui', 'imane@gmail.com', '0678901234', '0678901234', '2024-01-16', 0),
(85, 'Rachid', 'El Alaoui', 'rachid@gmail.com', '0689012345', '0689012345', '2024-01-17', 0),
(86, 'Fatima', 'El Alaoui', 'fatima@gmail.com', '0690123456', '0690123456', '2024-01-18', 0),
(87, 'Omar', 'El Alaoui', 'omar@gmail.com', '0601234567', '0601234567', '2024-01-19', 0),
(88, 'Sara', 'Tazi', 'sara.tazi@gmail.com', '0658123456', '0512345686', '2023-12-15', 0),
(89, 'Rachid', 'El Mansouri', 'rachid.elmansouri@gmail.com', '0659123456', '0512345687', '2023-12-15', 0),
(90, 'Khadija', 'Bakir', 'khadija.bakir@gmail.com', '0660123456', '0512345688', '2023-12-15', 0),
(91, 'Ahmed', 'Bouchta', 'ahmed.bouchta@gmail.com', '0661123456', '0512345689', '2023-12-15', 0),
(92, 'Imane', 'Rahmani', 'imane.rahmani@gmail.com', '0662123456', '0512345690', '2023-12-15', 0),
(93, 'Hassan', 'Moussaoui', 'hassan.moussaoui@gmail.com', '0663123456', '0512345691', '2023-12-15', 0),
(94, 'Naima', 'Lahlou', 'naima.lahlou@gmail.com', '0664123456', '0512345692', '2023-12-15', 0),
(95, 'Abdelali', 'Bekkali', 'abdelali.bekkali@gmail.com', '0665123456', '0512345693', '2023-12-15', 0),
(96, 'Nour', 'Hassani', 'nour.hassani@gmail.com', '0666123456', '0512345694', '2023-12-15', 0),
(97, 'Mounir', 'El Hachimi', 'mounir.elhachimi@gmail.com', '0667123456', '0512345695', '2023-12-15', 0),
(98, 'Salma', 'Fassi', 'salma.fassi@gmail.com', '0668123456', '0512345696', '2023-12-15', 0),
(99, 'Yassin', 'Kadiri', 'yassin.kadiri@gmail.com', '0669123456', '0512345697', '2023-12-15', 0),
(100, 'Rita', 'Benjelloun', 'rita.benjelloun@gmail.com', '0670123456', '0512345698', '2023-12-15', 0),
(101, 'Karim', 'Ouazzani', 'karim.ouazzani@gmail.com', '0671123456', '0512345699', '2023-12-15', 0),
(102, 'Latifa', 'Chakir', 'latifa.chakir@gmail.com', '0672123456', '0512345700', '2023-12-15', 0);

-- --------------------------------------------------------

--
-- Structure de la table `eleve_has_cours`
--

CREATE TABLE `eleve_has_cours` (
  `ideleve` int(8) NOT NULL,
  `idcours` int(8) NOT NULL,
  `nb_achete` int(8) DEFAULT NULL,
  `nb_rest` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `eleve_has_cours`
--

INSERT INTO `eleve_has_cours` (`ideleve`, `idcours`, `nb_achete`, `nb_rest`) VALUES
(43, 10, 8, -51),
(39, 9, 8, 8),
(39, 10, 8, 8),
(39, 11, 8, 8),
(40, 12, 8, 8),
(40, 13, 8, 8),
(40, 14, 8, 8),
(41, 15, 8, 8),
(41, 16, 8, 8),
(41, 17, 8, 8),
(39, 9, 8, 8),
(39, 10, 8, 8),
(39, 11, 8, 8),
(40, 12, 8, 8),
(40, 13, 8, 8),
(40, 14, 8, 8),
(41, 15, 8, 8),
(41, 16, 8, 8),
(41, 17, 8, 8),
(39, 9, 8, 8),
(39, 10, 8, 8),
(39, 11, 8, 8),
(40, 12, 8, 8),
(40, 13, 8, 8),
(40, 14, 8, 8),
(41, 15, 8, 8),
(41, 16, 8, 8),
(41, 17, 8, 8),
(43, 21, 8, 8),
(43, 22, 8, 8),
(43, 23, 8, 8),
(45, 12, 8, 8),
(45, 13, 8, 8),
(45, 14, 8, 8),
(46, 15, 8, 8),
(46, 16, 8, 8),
(46, 17, 8, 8),
(47, 18, 8, 8),
(47, 19, 8, 8),
(47, 20, 8, 8),
(48, 21, 8, 8),
(48, 22, 8, 8),
(48, 23, 8, 8),
(49, 9, 8, 8),
(49, 10, 8, 8),
(49, 11, 8, 8),
(51, 9, 9, 9),
(51, 10, 10, 10),
(51, 11, 11, 11),
(52, 12, 9, 9),
(52, 13, 10, 10),
(52, 14, 11, 11),
(53, 15, 9, 9),
(53, 16, 10, 10),
(53, 17, 11, 11),
(54, 18, 9, 9),
(54, 19, 10, 10),
(54, 20, 11, 11),
(55, 21, 9, 9),
(55, 22, 10, 10),
(55, 23, 11, 11),
(56, 9, 9, 9),
(56, 10, 10, 10),
(56, 11, 11, 11),
(57, 12, 9, 9),
(57, 13, 10, 10),
(57, 14, 11, 11),
(58, 15, 9, 9),
(58, 16, 10, 10),
(58, 17, 11, 11),
(59, 18, 9, 9),
(59, 19, 10, 10),
(59, 20, 11, 11),
(60, 21, 9, 9),
(60, 22, 10, 10),
(60, 23, 11, 11),
(61, 9, 9, 9),
(61, 10, 10, 10),
(61, 11, 11, 11),
(62, 12, 9, 9),
(62, 13, 10, 10),
(62, 14, 11, 11),
(63, 15, 9, 9),
(63, 16, 10, 10),
(63, 17, 11, 11),
(64, 18, 9, 9),
(64, 19, 10, 10),
(64, 20, 11, 11),
(65, 21, 9, 9),
(65, 22, 10, 10),
(65, 23, 11, 11),
(66, 9, 9, 9),
(66, 10, 10, 10),
(66, 11, 11, 11),
(67, 12, 9, 9),
(67, 13, 10, 10),
(67, 14, 11, 11),
(68, 15, 9, 9),
(68, 16, 10, 10),
(68, 17, 11, 11),
(69, 18, 9, 9),
(69, 19, 10, 10),
(69, 20, 11, 11),
(70, 21, 9, 9),
(70, 22, 10, 10),
(70, 23, 11, 11);

-- --------------------------------------------------------

--
-- Structure de la table `eleve_has_groupe`
--

CREATE TABLE `eleve_has_groupe` (
  `ideleve` int(8) NOT NULL,
  `idgroupe` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `eleve_has_groupe`
--

INSERT INTO `eleve_has_groupe` (`ideleve`, `idgroupe`) VALUES
(43, 1),
(59, 1),
(77, 1),
(95, 1),
(40, 2),
(60, 2),
(63, 2),
(78, 2),
(82, 2),
(96, 2),
(41, 3),
(61, 3),
(62, 3),
(79, 3),
(81, 3),
(47, 7),
(64, 7),
(65, 7),
(83, 7),
(101, 7),
(48, 8),
(66, 8),
(80, 8),
(84, 8),
(102, 8),
(49, 9),
(67, 9),
(85, 9),
(50, 10),
(68, 10),
(86, 10),
(39, 11),
(51, 11),
(69, 11),
(87, 11),
(46, 12),
(52, 12),
(70, 12),
(88, 12),
(45, 13),
(53, 13),
(71, 13),
(89, 13),
(54, 14),
(72, 14),
(90, 14),
(55, 15),
(73, 15),
(91, 15),
(100, 15),
(56, 16),
(74, 16),
(92, 16),
(97, 16),
(57, 17),
(75, 17),
(93, 17),
(98, 17),
(58, 18),
(76, 18),
(94, 18),
(99, 18);

-- --------------------------------------------------------

--
-- Structure de la table `eleve_has_seance`
--

CREATE TABLE `eleve_has_seance` (
  `ideleve` int(8) NOT NULL,
  `idseance` int(8) NOT NULL,
  `abscence` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `enseignant`
--

CREATE TABLE `enseignant` (
  `idenseignant` int(11) NOT NULL,
  `nom_enseignant` varchar(45) NOT NULL,
  `prenom_enseignant` varchar(45) NOT NULL,
  `email_enseignant` varchar(45) NOT NULL,
  `numtel_enseignant` varchar(45) NOT NULL,
  `cinenseignant` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `enseignant`
--

INSERT INTO `enseignant` (`idenseignant`, `nom_enseignant`, `prenom_enseignant`, `email_enseignant`, `numtel_enseignant`, `cinenseignant`) VALUES
(1, 'AZOUNA', 'OTAWA', 'AZOUNA@usms.ac.ma', '+65847210144', '5148cc'),
(2, 'HAMIDI', 'MEFTAH', 'meftah@gmail.com', '05667467998', 'UB2341'),
(3, 'SERRAD', 'AMINE', 'serrad@gmail.com', '0654342622', 'UB1445'),
(4, 'RAHIMI', 'JAWAD', 'rahima@gmail.com', '076565656', 'UC3332'),
(5, 'Mounir', 'Benabdellah', 'mounir@gmail.com', '0601122334', 'AB0123456'),
(6, 'Hassan', 'Zerouali', 'hassan@gmail.com', '0601223344', 'BC1234567'),
(7, 'Fatima', 'El Bahri', 'fatima@gmail.com', '0601322355', 'CD2345678'),
(8, 'Youssef', 'El Mansouri', 'youssef@gmail.com', '0601423366', 'DE3456789'),
(9, 'Nadia', 'El Alaoui', 'nadia.elaoui@gmail.com', '0601523377', 'EF4567890'),
(10, 'Omar', 'El Kaddouri', 'omar@gmail.com', '0601623388', 'FG5678901'),
(11, 'Souad', 'El Fassi', 'souad@gmail.com', '0601723399', 'GH6789012'),
(12, 'Ali', 'El Khatib', 'ali.elkhatib@gmail.com', '0601823400', 'HI7890123'),
(13, 'Leila', 'El Fakir', 'leila@gmail.com', '0601923411', 'IJ8901234'),
(14, 'Khalid', 'El Gharbaoui', 'khalid@gmail.com', '0601100244', 'JK9012345'),
(15, 'Yasmine', 'El Goumi', 'yasmine@gmail.com', '0601100255', 'KL0123456'),
(16, 'Ahmed', 'El Haddad', 'ahmed.elhaddad@gmail.com', '0601100266', 'LM1234567'),
(17, 'Sara', 'El Hamidi', 'sara@gmail.com', '0601100277', 'MN2345678'),
(18, 'Rachid', 'El Hamoumi', 'rachid@gmail.com', '0601100288', 'NO3456789'),
(19, 'Salma', 'El Harrak', 'salma.elharrak@gmail.com', '0601100299', 'OP4567890');

-- --------------------------------------------------------

--
-- Structure de la table `enseignant_has_cours`
--

CREATE TABLE `enseignant_has_cours` (
  `idenseignant` int(11) NOT NULL,
  `idcours` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `enseignant_has_cours`
--

INSERT INTO `enseignant_has_cours` (`idenseignant`, `idcours`) VALUES
(1, 9),
(2, 10),
(3, 11),
(4, 13),
(5, 14),
(6, 15),
(7, 16),
(8, 17),
(9, 18),
(10, 19),
(11, 20),
(12, 21),
(13, 22),
(14, 23),
(15, 11),
(16, 12),
(17, 13),
(18, 14),
(19, 15);

-- --------------------------------------------------------

--
-- Structure de la table `facture`
--

CREATE TABLE `facture` (
  `idfacture` int(11) NOT NULL,
  `somme_total` int(11) NOT NULL,
  `date_paiement` datetime NOT NULL,
  `eleve` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `facture`
--

INSERT INTO `facture` (`idfacture`, `somme_total`, `date_paiement`, `eleve`) VALUES
(15, 1200, '2023-12-11 00:00:00', 43),
(17, 1200, '2023-12-11 00:00:00', 45),
(18, 7500, '2023-12-11 00:00:00', 45),
(19, 750, '2023-12-11 00:00:00', 45),
(20, 3000, '2023-12-11 00:00:00', 45),
(29, 1200, '2023-12-11 00:00:00', 46),
(30, 1200, '2023-12-11 00:00:00', 47);

-- --------------------------------------------------------

--
-- Structure de la table `formation`
--

CREATE TABLE `formation` (
  `idformation` int(11) NOT NULL,
  `nom_formation` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `formation`
--

INSERT INTO `formation` (`idformation`, `nom_formation`) VALUES
(2, 'langues'),
(3, 'soft skills'),
(4, 'soutien sco'),
(5, 'softwares');

-- --------------------------------------------------------

--
-- Structure de la table `groupe`
--

CREATE TABLE `groupe` (
  `idgroupe` int(11) NOT NULL,
  `nombre_eleves` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `groupe`
--

INSERT INTO `groupe` (`idgroupe`, `nombre_eleves`) VALUES
(1, 4),
(2, 6),
(3, 6),
(7, 5),
(8, 6),
(9, 8),
(10, 7),
(11, 4),
(12, 8),
(13, 6),
(14, 7),
(15, 6),
(16, 5),
(17, 6),
(18, 6);

-- --------------------------------------------------------

--
-- Structure de la table `séance`
--

CREATE TABLE `séance` (
  `idséance` int(11) NOT NULL,
  `type_séance` varchar(15) NOT NULL COMMENT 'la séance est presentiel ou en ligne\n',
  `enseignant_idenseignant` int(11) NOT NULL,
  `jour` varchar(15) NOT NULL,
  `debut` time NOT NULL,
  `fin` time NOT NULL,
  `idgroupe` int(8) NOT NULL,
  `idcours` int(8) NOT NULL,
  `classe` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `séance`
--

INSERT INTO `séance` (`idséance`, `type_séance`, `enseignant_idenseignant`, `jour`, `debut`, `fin`, `idgroupe`, `idcours`, `classe`) VALUES
(1, 'presentielle', 1, 'Lundi', '08:00:03', '10:00:03', 1, 10, 4),
(17, 'presentiel', 2, 'Mercredi', '14:00:00', '16:00:00', 2, 9, 1),
(18, 'presentiel', 3, 'Jeudi', '16:00:00', '18:00:00', 3, 11, 2),
(19, 'presentiel', 4, 'Vendredi', '09:00:00', '11:00:00', 7, 12, 3),
(20, 'presentiel', 5, 'Samedi', '10:00:00', '12:00:00', 8, 13, 5),
(21, 'presentiel', 6, 'Lundi', '14:00:00', '16:00:00', 9, 14, 6),
(22, 'presentiel', 7, 'Mardi', '16:00:00', '18:00:00', 10, 15, 7),
(23, 'presentiel', 8, 'Mercredi', '09:00:00', '11:00:00', 11, 16, 8),
(24, 'presentiel', 9, 'Jeudi', '10:00:00', '12:00:00', 12, 17, 9),
(25, 'presentiel', 10, 'Vendredi', '14:00:00', '16:00:00', 13, 18, 10),
(26, 'presentiel', 11, 'Samedi', '16:00:00', '18:00:00', 14, 19, 11),
(27, 'presentiel', 12, 'Lundi', '09:00:00', '11:00:00', 15, 20, 12),
(28, 'presentiel', 10, 'Vendredi', '16:00:00', '18:00:00', 16, 21, 13),
(29, 'presentiel', 11, 'Samedi', '08:00:00', '10:00:00', 17, 22, 14),
(30, 'presentiel', 12, 'Lundi', '09:00:00', '11:00:00', 18, 23, 15);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id_admin`);

--
-- Index pour la table `cours`
--
ALTER TABLE `cours`
  ADD PRIMARY KEY (`idcours`),
  ADD KEY `formation_idformation` (`formation_idformation`);

--
-- Index pour la table `eleve`
--
ALTER TABLE `eleve`
  ADD PRIMARY KEY (`id_eleve`);

--
-- Index pour la table `eleve_has_cours`
--
ALTER TABLE `eleve_has_cours`
  ADD KEY `ideleve` (`ideleve`),
  ADD KEY `idcours` (`idcours`);

--
-- Index pour la table `eleve_has_groupe`
--
ALTER TABLE `eleve_has_groupe`
  ADD UNIQUE KEY `ideleve` (`ideleve`),
  ADD KEY `eleve_has_groupe_ibfk_2` (`idgroupe`);

--
-- Index pour la table `eleve_has_seance`
--
ALTER TABLE `eleve_has_seance`
  ADD KEY `ideleve` (`ideleve`),
  ADD KEY `idseance` (`idseance`);

--
-- Index pour la table `enseignant`
--
ALTER TABLE `enseignant`
  ADD PRIMARY KEY (`idenseignant`),
  ADD UNIQUE KEY `cinenseignant` (`cinenseignant`);

--
-- Index pour la table `enseignant_has_cours`
--
ALTER TABLE `enseignant_has_cours`
  ADD KEY `idenseignant` (`idenseignant`),
  ADD KEY `idcours` (`idcours`);

--
-- Index pour la table `facture`
--
ALTER TABLE `facture`
  ADD PRIMARY KEY (`idfacture`),
  ADD KEY `eleve` (`eleve`);

--
-- Index pour la table `formation`
--
ALTER TABLE `formation`
  ADD PRIMARY KEY (`idformation`);

--
-- Index pour la table `groupe`
--
ALTER TABLE `groupe`
  ADD PRIMARY KEY (`idgroupe`);

--
-- Index pour la table `séance`
--
ALTER TABLE `séance`
  ADD PRIMARY KEY (`idséance`),
  ADD KEY `idgroupe` (`idgroupe`),
  ADD KEY `idcours` (`idcours`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `admins`
--
ALTER TABLE `admins`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `cours`
--
ALTER TABLE `cours`
  MODIFY `idcours` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `eleve`
--
ALTER TABLE `eleve`
  MODIFY `id_eleve` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT pour la table `enseignant`
--
ALTER TABLE `enseignant`
  MODIFY `idenseignant` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `facture`
--
ALTER TABLE `facture`
  MODIFY `idfacture` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT pour la table `formation`
--
ALTER TABLE `formation`
  MODIFY `idformation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `groupe`
--
ALTER TABLE `groupe`
  MODIFY `idgroupe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `séance`
--
ALTER TABLE `séance`
  MODIFY `idséance` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `cours`
--
ALTER TABLE `cours`
  ADD CONSTRAINT `cours_ibfk_1` FOREIGN KEY (`formation_idformation`) REFERENCES `formation` (`idformation`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `eleve_has_cours`
--
ALTER TABLE `eleve_has_cours`
  ADD CONSTRAINT `eleve_has_cours_ibfk_1` FOREIGN KEY (`ideleve`) REFERENCES `eleve` (`id_eleve`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `eleve_has_cours_ibfk_2` FOREIGN KEY (`idcours`) REFERENCES `cours` (`idcours`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `eleve_has_groupe`
--
ALTER TABLE `eleve_has_groupe`
  ADD CONSTRAINT `eleve_has_groupe_ibfk_1` FOREIGN KEY (`ideleve`) REFERENCES `eleve` (`id_eleve`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `eleve_has_groupe_ibfk_2` FOREIGN KEY (`idgroupe`) REFERENCES `groupe` (`idgroupe`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `eleve_has_seance`
--
ALTER TABLE `eleve_has_seance`
  ADD CONSTRAINT `eleve_has_seance_ibfk_1` FOREIGN KEY (`idseance`) REFERENCES `séance` (`idséance`) ON UPDATE CASCADE,
  ADD CONSTRAINT `eleve_has_seance_ibfk_2` FOREIGN KEY (`ideleve`) REFERENCES `eleve` (`id_eleve`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `enseignant_has_cours`
--
ALTER TABLE `enseignant_has_cours`
  ADD CONSTRAINT `enseignant_has_cours_ibfk_1` FOREIGN KEY (`idcours`) REFERENCES `cours` (`idcours`) ON UPDATE CASCADE,
  ADD CONSTRAINT `enseignant_has_cours_ibfk_2` FOREIGN KEY (`idenseignant`) REFERENCES `enseignant` (`idenseignant`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `facture`
--
ALTER TABLE `facture`
  ADD CONSTRAINT `facture_ibfk_1` FOREIGN KEY (`eleve`) REFERENCES `eleve` (`id_eleve`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `séance`
--
ALTER TABLE `séance`
  ADD CONSTRAINT `séance_ibfk_1` FOREIGN KEY (`idgroupe`) REFERENCES `groupe` (`idgroupe`) ON UPDATE CASCADE,
  ADD CONSTRAINT `séance_ibfk_2` FOREIGN KEY (`idcours`) REFERENCES `cours` (`idcours`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
