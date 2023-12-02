-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 02 déc. 2023 à 21:51
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

-- --------------------------------------------------------

--
-- Structure de la table `eleve_has_groupe`
--

CREATE TABLE `eleve_has_groupe` (
  `ideleve` int(8) NOT NULL,
  `idgroupe` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 'AZOUNA', 'OTAWA', 'AZOUNA@usms.ac.ma', '+65847210144', '5148cc');

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
  `eleve` int(11) NOT NULL,
  `nbseance` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 0);

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
(1, 'presentielle', 1, 'Lundi', '08:00:03', '10:00:03', 1, 10, 4);

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
-- Index pour la table `eleve_has_groupe`
--
ALTER TABLE `eleve_has_groupe`
  ADD UNIQUE KEY `ideleve` (`ideleve`),
  ADD UNIQUE KEY `idgroupe` (`idgroupe`);

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
  MODIFY `id_eleve` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `enseignant`
--
ALTER TABLE `enseignant`
  MODIFY `idenseignant` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `formation`
--
ALTER TABLE `formation`
  MODIFY `idformation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `groupe`
--
ALTER TABLE `groupe`
  MODIFY `idgroupe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `séance`
--
ALTER TABLE `séance`
  MODIFY `idséance` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `cours`
--
ALTER TABLE `cours`
  ADD CONSTRAINT `cours_ibfk_1` FOREIGN KEY (`formation_idformation`) REFERENCES `formation` (`idformation`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `eleve_has_groupe`
--
ALTER TABLE `eleve_has_groupe`
  ADD CONSTRAINT `eleve_has_groupe_ibfk_1` FOREIGN KEY (`ideleve`) REFERENCES `eleve` (`id_eleve`) ON UPDATE CASCADE,
  ADD CONSTRAINT `eleve_has_groupe_ibfk_2` FOREIGN KEY (`idgroupe`) REFERENCES `groupe` (`idgroupe`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `eleve_has_seance`
--
ALTER TABLE `eleve_has_seance`
  ADD CONSTRAINT `eleve_has_seance_ibfk_1` FOREIGN KEY (`idseance`) REFERENCES `séance` (`idséance`) ON UPDATE CASCADE,
  ADD CONSTRAINT `eleve_has_seance_ibfk_2` FOREIGN KEY (`ideleve`) REFERENCES `eleve` (`id_eleve`) ON UPDATE CASCADE;

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
  ADD CONSTRAINT `facture_ibfk_1` FOREIGN KEY (`eleve`) REFERENCES `eleve` (`id_eleve`) ON UPDATE CASCADE;

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
