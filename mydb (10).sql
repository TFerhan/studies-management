-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 13 déc. 2023 à 02:02
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
  `password` varchar(30) NOT NULL,
  `CIN` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `admins`
--

INSERT INTO `admins` (`id_admin`, `username`, `password`, `CIN`) VALUES
(1, 'youness', '12345678', 'SD456'),
(2, 'taha', 'mdp', 'BJ4585');

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
(1, 'el mghari', 'ahmed', 'ahmed.elmghari@gmail.com', '', '0654125214', '2023-12-12', 0),
(2, 'omno', 'Aymen', 'aymen.omni@gmail.com', '065414541', '0625521412', '2023-12-12', 0),
(3, 'hayat', 'sara', 'sara.frd@gmail.com', '0654879953', '0654745856', '2023-12-12', 0);

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
(1, 18, 2, 0),
(2, 15, 2, 0),
(1, 19, 2, 0);

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
(1, 10),
(2, 15),
(2, 16),
(2, 27),
(1, 2),
(1, 13);

-- --------------------------------------------------------

--
-- Structure de la table `eleve_has_seance`
--

CREATE TABLE `eleve_has_seance` (
  `ideleve` int(8) NOT NULL,
  `idseance` int(8) NOT NULL,
  `abscence` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `eleve_has_seance`
--

INSERT INTO `eleve_has_seance` (`ideleve`, `idseance`, `abscence`) VALUES
(1, 10, 0),
(2, 15, 0),
(2, 16, 0),
(2, 27, 0),
(1, 2, 0),
(1, 13, 0);

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
(1, 'Chefnaoui', 'Omar', 'omar.chefnaoui@fbm.ma', '0654125221', 'BG748720'),
(2, 'El Amrani', 'Mohamed', 'mohamed.elamrani@fbm.ma', '0612345678', 'AB123456'),
(3, 'Benjelloun', 'Fatima', 'fatima.benjelloun@fbm.ma', '0623456789', 'CD234567'),
(4, 'Kadiri', 'Ahmed', 'ahmed.kadiri@fbm.ma', '0634567890', 'EF345678'),
(5, 'Ouahbi', 'Amina', 'amina.ouahbi@fbm.ma', '0645678901', 'GH456789'),
(6, 'Bouhaddi', 'Hassan', 'hassan.bouhaddi@fbm.ma', '0656789012', 'IJ567890'),
(7, 'Ait Oussa', 'Nadia', 'nadia.aitoussa@fbm.ma', '0667890123', 'KL678901'),
(8, 'El Fassi', 'Youssef', 'youssef.elfassi@fbm.ma', '0678901234', 'MN789012'),
(9, 'Hachimi', 'Karima', 'karima.hachimi@fbm.ma', '0689012345', 'OP890123'),
(10, 'Rami', 'Mounir', 'mounir.rami@fbm.ma', '0690123456', 'QR901234'),
(11, 'El Moussaoui', 'Laila', 'laila.elmoussaoui@fbm.ma', '0611122334', 'ST901234'),
(12, 'Berrada', 'Tarik', 'tarik.berrada@fbm.ma', '0612233445', 'UV901234'),
(13, 'Ait Said', 'Sara', 'sara.aitsaid@fbm.ma', '0613344556', 'WX901234'),
(14, 'Sami', 'Lahlou', 'sami.lahlou@fbm.ma', '0652478747', 'DE471588');

-- --------------------------------------------------------

--
-- Structure de la table `enseignant_has_cours`
--

CREATE TABLE `enseignant_has_cours` (
  `idenseignant` int(11) NOT NULL,
  `idcours` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 300, '2023-12-12 00:00:00', 1),
(2, 300, '2023-12-12 00:00:00', 2),
(3, 300, '2023-12-12 00:00:00', 1),
(4, 300, '2023-12-12 00:00:00', 3),
(5, 3000, '2023-12-12 00:00:00', 3);

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
(1, 0),
(2, 1),
(3, 0),
(4, 0),
(5, 0),
(6, 0),
(7, 0),
(8, 0),
(9, 0),
(10, 1),
(11, 0),
(12, 0),
(13, 1),
(14, 0),
(15, 1),
(16, 1),
(17, 0),
(18, 0),
(19, 0),
(20, 0),
(21, 0),
(22, 0),
(23, 0),
(24, 0),
(25, 0),
(26, 0),
(27, 1),
(28, 0),
(29, 0),
(30, 0),
(31, 0),
(32, 0),
(33, 0),
(34, 0),
(35, 0),
(36, 0),
(37, 0),
(38, 0),
(39, 0),
(40, 0),
(41, 0),
(42, 0),
(43, 0),
(44, 0),
(45, 0),
(46, 0),
(47, 0),
(48, 0),
(49, 0),
(50, 0),
(51, 0),
(52, 0),
(53, 0),
(54, 0),
(55, 0),
(56, 0),
(57, 0),
(58, 0),
(59, 0),
(60, 0),
(61, 0),
(62, 0),
(63, 0),
(64, 0),
(65, 0),
(66, 0),
(67, 0),
(68, 0),
(69, 0),
(70, 0),
(71, 0),
(72, 0),
(73, 0),
(74, 0),
(75, 0),
(76, 0),
(77, 0),
(78, 0),
(79, 0),
(80, 0),
(81, 0),
(82, 0),
(83, 0),
(84, 0),
(85, 0),
(86, 0),
(87, 0),
(88, 0),
(89, 0),
(90, 0),
(91, 0),
(92, 0),
(93, 0),
(94, 0),
(95, 0),
(96, 0);

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
  `classe` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `séance`
--

INSERT INTO `séance` (`idséance`, `type_séance`, `enseignant_idenseignant`, `jour`, `debut`, `fin`, `idgroupe`, `idcours`, `classe`) VALUES
(1, 'presentielle', 1, 'Lundi', '18:00:00', '20:00:00', 1, 19, 'A'),
(2, 'presentielle', 1, 'Lundi', '20:00:00', '22:00:00', 2, 19, 'B'),
(3, 'presentielle', 2, 'Mardi', '18:00:00', '20:00:00', 3, 15, 'C'),
(4, 'presentielle', 2, 'Mardi', '20:00:00', '22:00:00', 4, 15, 'D'),
(5, 'presentielle', 3, 'Mercredi', '18:00:00', '20:00:00', 5, 16, 'A'),
(6, 'presentielle', 3, 'Mercredi', '20:00:00', '22:00:00', 6, 16, 'B'),
(7, 'presentielle', 4, 'Jeudi', '18:00:00', '20:00:00', 7, 17, 'C'),
(8, 'presentielle', 4, 'Jeudi', '20:00:00', '22:00:00', 8, 17, 'D'),
(9, 'presentielle', 5, 'Vendredi', '18:00:00', '20:00:00', 9, 18, 'A'),
(10, 'presentielle', 5, 'Vendredi', '20:00:00', '22:00:00', 10, 18, 'B'),
(11, 'presentielle', 6, 'Samedi', '18:00:00', '20:00:00', 11, 20, 'C'),
(12, 'presentielle', 6, 'Samedi', '20:00:00', '22:00:00', 12, 20, 'D'),
(13, 'presentielle', 7, 'Lundi', '18:00:00', '20:00:00', 13, 19, 'A'),
(14, 'presentielle', 7, 'Lundi', '20:00:00', '22:00:00', 14, 19, 'B'),
(15, 'presentielle', 8, 'Mardi', '18:00:00', '20:00:00', 15, 15, 'C'),
(16, 'presentielle', 8, 'Mardi', '20:00:00', '22:00:00', 16, 15, 'D'),
(17, 'presentielle', 1, 'Mercredi', '18:00:00', '20:00:00', 17, 16, 'A'),
(18, 'presentielle', 1, 'Mercredi', '20:00:00', '22:00:00', 18, 16, 'B'),
(19, 'presentielle', 2, 'Jeudi', '18:00:00', '20:00:00', 19, 17, 'C'),
(20, 'presentielle', 2, 'Jeudi', '20:00:00', '22:00:00', 20, 17, 'D'),
(21, 'presentielle', 3, 'Vendredi', '18:00:00', '20:00:00', 21, 18, 'A'),
(22, 'presentielle', 3, 'Vendredi', '20:00:00', '22:00:00', 22, 18, 'B'),
(23, 'presentielle', 4, 'Samedi', '18:00:00', '20:00:00', 23, 19, 'C'),
(24, 'presentielle', 4, 'Samedi', '20:00:00', '22:00:00', 24, 19, 'D'),
(25, 'presentielle', 5, 'Lundi', '18:00:00', '20:00:00', 25, 20, 'A'),
(26, 'presentielle', 5, 'Lundi', '20:00:00', '22:00:00', 26, 20, 'B'),
(27, 'presentielle', 6, 'Mardi', '18:00:00', '20:00:00', 27, 15, 'C'),
(28, 'presentielle', 6, 'Mardi', '20:00:00', '22:00:00', 28, 15, 'D'),
(29, 'presentielle', 7, 'Mercredi', '18:00:00', '20:00:00', 29, 16, 'A'),
(30, 'presentielle', 7, 'Mercredi', '20:00:00', '22:00:00', 30, 16, 'B');

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
  MODIFY `id_eleve` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `enseignant`
--
ALTER TABLE `enseignant`
  MODIFY `idenseignant` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `facture`
--
ALTER TABLE `facture`
  MODIFY `idfacture` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `formation`
--
ALTER TABLE `formation`
  MODIFY `idformation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `groupe`
--
ALTER TABLE `groupe`
  MODIFY `idgroupe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

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
