-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3308
-- Généré le : mar. 12 déc. 2023 à 13:27
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
(1, 'math_1bac', 150, 4),
(2, 'physique_1bac', 150, 4),
(3, 'svt_1bac', 150, 4),
(4, 'espangol', 150, 2),
(5, 'Leadership et Gestion d\'équipe', 150, 3),
(6, 'svt_2bac', 150, 4),
(7, 'Python', 150, 5),
(8, 'anglais_2bac', 150, 4),
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
(1, 'Youssef', 'El Alaoui', 'youssef.alaoui@gmail.com', '0612345678', '0987654321', '2023-12-12', 0),
(2, 'Fatima', 'Zahra', 'fatima.zahra@gmail.com', '0712345678', '0987654322', '2023-12-12', 0),
(3, 'Mohamed', 'Amrani', 'mohamed.amrani@gmail.com', '0512345678', '0987654323', '2023-12-12', 0),
(4, 'Houda', 'Benjelloun', 'houda.benjelloun@gmail.com', '0612345679', '0987654324', '2023-12-12', 0),
(5, 'Ahmed', 'Lakhdar', 'ahmed.lakhdar@gmail.com', '0712345679', '0987654325', '2023-12-12', 0),
(6, 'Nadia', 'Cherkaoui', 'nadia.cherkaoui@gmail.com', '0512345679', '0987654326', '2023-12-12', 0),
(7, 'Yassine', 'El Khattabi', 'yassine.khattabi@gmail.com', '0612345680', '0987654327', '2023-12-12', 0),
(8, 'Sara', 'El Moutawakil', 'sara.moutawakil@gmail.com', '0712345680', '0987654328', '2023-12-12', 0),
(9, 'Omar', 'Ait Addi', 'omar.addi@gmail.com', '0512345680', '0987654329', '2023-12-12', 0),
(10, 'Amina', 'El Abbassi', 'amina.abbassi@gmail.com', '0612345681', '0987654330', '2023-12-12', 0),
(11, 'Abdelaziz', 'Hilali', 'abdelaziz.hilali@gmail.com', '0712345681', '0987654331', '2023-12-12', 0),
(12, 'Leila', 'El Fassi', 'leila.fassi@gmail.com', '0512345681', '0987654332', '2023-12-12', 0),
(13, 'Mehdi', 'El Amrani', 'mehdi.amrani@gmail.com', '0612345682', '0987654333', '2023-12-12', 0),
(14, 'Nawal', 'Rachidi', 'nawal.rachidi@gmail.com', '0712345682', '0987654334', '2023-12-12', 0),
(15, 'Hamza', 'El Kadiri', 'hamza.kadiri@gmail.com', '0512345682', '0987654335', '2023-12-12', 0),
(16, 'Loubna', 'El Hamdi', 'loubna.hamdi@gmail.com', '0612345683', '0987654336', '2023-12-12', 0),
(17, 'Yassin', 'Chraibi', 'yassin.chraibi@gmail.com', '0712345683', '0987654337', '2023-12-12', 0),
(18, 'Saida', 'El Boury', 'saida.boury@gmail.com', '0512345683', '0987654338', '2023-12-12', 0),
(19, 'Ali', 'El Guennouni', 'ali.guennouni@gmail.com', '0612345684', '0987654339', '2023-12-12', 0),
(20, 'Nour', 'Laaroussi', 'nour.laaroussi@gmail.com', '0712345684', '0987654340', '2023-12-12', 0),
(21, 'Imane', 'El Farissi', 'imane.farissi@gmail.com', '0512345684', '0987654341', '2023-12-12', 0),
(22, 'Mouad', 'El Kadiri', 'mouad.kadiri@gmail.com', '0612345685', '0987654342', '2023-12-12', 0),
(23, 'Nadia', 'Chami', 'nadia.chami@gmail.com', '0712345685', '0987654343', '2023-12-12', 0),
(24, 'Khalid', 'El Mekkaoui', 'khalid.mekkaoui@gmail.com', '0512345685', '0987654344', '2023-12-12', 0),
(25, 'Hajar', 'El Morabit', 'hajar.morabit@gmail.com', '0612345686', '0987654345', '2023-12-12', 0),
(26, 'Youssef', 'El Yacoubi', 'youssef.yacoubi@gmail.com', '0712345686', '0987654346', '2023-12-12', 0),
(27, 'Sanaa', 'El Akkari', 'sanaa.akkari@gmail.com', '0512345686', '0987654347', '2023-12-12', 0),
(28, 'Abdellah', 'El Amrani', 'abdellah.amrani@gmail.com', '0612345687', '0987654348', '2023-12-12', 0),
(29, 'Nawal', 'El Alaoui', 'nawal.alaoui@gmail.com', '0712345687', '0987654349', '2023-12-12', 0),
(30, 'Brahim', 'El Moussaoui', 'brahim.moussaoui@gmail.com', '0512345687', '0987654350', '2023-12-12', 0),
(31, 'Yasmine', 'El Hassani', 'yasmine.hassani@gmail.com', '0612345688', '0987654351', '2023-12-12', 0),
(32, 'Anas', 'El Mouslim', 'anas.mouslim@gmail.com', '0712345688', '0987654352', '2023-12-12', 0),
(33, 'Rita', 'El Guerrouj', 'rita.guerrouj@gmail.com', '0512345688', '0987654353', '2023-12-12', 0),
(34, 'Karim', 'El Abassi', 'karim.abassi@gmail.com', '0612345689', '0987654354', '2023-12-12', 0),
(35, 'Asmae', 'El Moutaqui', 'asmae.moutaqui@gmail.com', '0712345689', '0987654355', '2023-12-12', 0),
(36, 'Mehdi', 'El Bouchiki', 'mehdi.bouchiki@gmail.com', '0512345689', '0987654356', '2023-12-12', 0),
(37, 'Zineb', 'El Alaoui', 'zineb.alaoui@gmail.com', '0612345690', '0987654357', '2023-12-12', 0),
(38, 'Younes', 'El Fakir', 'younes.fakir@gmail.com', '0712345690', '0987654358', '2023-12-12', 0),
(39, 'Khadija', 'El Haddad', 'khadija.haddad@gmail.com', '0512345690', '0987654359', '2023-12-12', 0),
(40, 'Abdelali', 'El Fatihi', 'abdelali.fatihi@gmail.com', '0612345691', '0987654360', '2023-12-12', 0),
(41, 'Zahra', 'El Mansouri', 'zahra.elmansouri@gmail.com', '0611111111', '0909090909', '2023-12-12', 0),
(42, 'Karim', 'El Bakkali', 'karim.elbakkali@gmail.com', '0622222222', '0808080808', '2023-12-12', 0),
(43, 'Nadia', 'El Abbassi', 'nadia.elabbassi@gmail.com', '0633333333', '0707070707', '2023-12-12', 0),
(44, 'Ahmed', 'El Fassi', 'ahmed.elfassi@gmail.com', '0644444444', '0606060606', '2023-12-12', 0),
(45, 'Houda', 'El Khouja', 'houda.elkhouja@gmail.com', '0655555555', '0505050505', '2023-12-12', 0),
(46, 'Fatima', 'El Hamdi', 'fatima.elhamdi@gmail.com', '0666666666', '0404040404', '2023-12-12', 0),
(47, 'Youssef', 'El Malki', 'youssef.elmalki@gmail.com', '0677777777', '0303030303', '2023-12-12', 0),
(48, 'Sara', 'El Gharbaoui', 'sara.elgharbaoui@gmail.com', '0688888888', '0202020202', '2023-12-12', 0),
(49, 'Omar', 'El Kadiri', 'omar.elkadiri@gmail.com', '0699999999', '0101010101', '2023-12-12', 0),
(50, 'Amina', 'El Mernissi', 'amina.elmernissi@gmail.com', '0612345678', '0123456789', '2023-12-12', 0),
(51, 'Khalid', 'El Harraq', 'khalid.elharraq@gmail.com', '0712345678', '0234567890', '2023-12-12', 0),
(52, 'Nawal', 'El Abbadi', 'nawal.elabbadi@gmail.com', '0812345678', '0345678901', '2023-12-12', 0),
(53, 'Hamza', 'El Moutaouakil', 'hamza.elmoutaouakil@gmail.com', '0912345678', '0456789012', '2023-12-12', 0),
(54, 'Yasmine', 'El Hadad', 'yasmine.elhadad@gmail.com', '0611111111', '0567890123', '2023-12-12', 0),
(55, 'Abdelali', 'El Gharib', 'abdelali.elgharib@gmail.com', '0622222222', '0678901234', '2023-12-12', 0),
(56, 'Nour', 'El Mansouri', 'nour.elmansouri@gmail.com', '0633333333', '0789012345', '2023-12-12', 0),
(57, 'Leila', 'El Mernissi', 'leila.elmernissi@gmail.com', '0644444444', '0890123456', '2023-12-12', 0),
(58, 'Sofia', 'El Abbassi', 'sofia.elabbassi@gmail.com', '0655555555', '0901234567', '2023-12-12', 0),
(59, 'Adil', 'El Fassi', 'adil.elfassi@gmail.com', '0666666666', '0123456789', '2023-12-12', 0),
(60, 'Rim', 'El Khouja', 'rim.elkhouja@gmail.com', '0677777777', '0234567890', '2023-12-12', 0);

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
(1, 'El Haddouchi', 'Hassan', 'hassan.elhaddouchi@gmail.com', '0612345678', 'AB1234567'),
(2, 'El Fassi', 'Fatima', 'fatima.elfassi@gmail.com', '0712345678', 'CD2345678'),
(3, 'El Mansouri', 'Ahmed', 'ahmed.elmansouri@gmail.com', '0512345678', 'EF3456789'),
(4, 'El Kabbaj', 'Houda', 'houda.elkabbaj@gmail.com', '0612345679', 'GH4567890'),
(5, 'El Alaoui', 'Khalid', 'khalid.elaoui@gmail.com', '0712345679', 'IJ5678901'),
(6, 'El Mouti', 'Nadia', 'nadia.elmouti@gmail.com', '0512345679', 'KL6789012'),
(7, 'El Amrani', 'Youssef', 'youssef.elamrani@gmail.com', '0612345680', 'MN7890123'),
(8, 'El Mahjoubi', 'Sara', 'sara.elmahjoubi@gmail.com', '0712345680', 'OP8901234'),
(9, 'El Khattabi', 'Omar', 'omar.elkhattabi@gmail.com', '0512345680', 'QR9012345'),
(10, 'El Mekkaoui', 'Amina', 'amina.elmekkaoui@gmail.com', '0612345681', 'ST0123456'),
(11, 'El Wardi', 'Karim', 'karim.elwardi@gmail.com', '0623456789', 'UV1234567'),
(12, 'El Jazouli', 'Laila', 'laila.eljazouli@gmail.com', '0723456789', 'WX2345678'),
(13, 'El Kandri', 'Mounir', 'mounir.elkandri@gmail.com', '0523456789', 'YZ3456789'),
(14, 'El Mernissi', 'Hiba', 'hiba.elmernissi@gmail.com', '0623456780', 'AB4567890'),
(15, 'El Azzouzi', 'Sofia', 'sofia.elazzouzi@gmail.com', '0723456780', 'CD5678901'),
(16, 'El Bachiri', 'Anas', 'anas.elbachiri@gmail.com', '0523456780', 'EF6789012'),
(17, 'El Abbadi', 'Rim', 'rim.elabbadi@gmail.com', '0623456781', 'GH7890123'),
(18, 'El Harraq', 'Adil', 'adil.elharraq@gmail.com', '0723456781', 'IJ8901234'),
(19, 'El Hadad', 'Sara', 'sara.elhadad@gmail.com', '0523456781', 'KL9012345'),
(20, 'El Moutaouakil', 'Younes', 'younes.elmoutaouakil@gmail.com', '0623456782', 'MN0123456');

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
(2, 0),
(3, 0),
(4, 0),
(5, 0),
(6, 0),
(7, 0),
(8, 0),
(9, 0),
(10, 0),
(11, 0),
(12, 0),
(13, 0),
(14, 0),
(15, 0);

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
(1, 'Présentiel', 1, 'Lundi', '08:00:00', '10:00:00', 1, 1, 1),
(2, 'Présentiel', 2, 'Mardi', '10:00:00', '12:00:00', 2, 2, 2),
(3, 'Présentiel', 3, 'Mercredi', '12:00:00', '14:00:00', 3, 3, 3),
(4, 'Présentiel', 4, 'Jeudi', '14:00:00', '16:00:00', 4, 4, 4),
(5, 'Présentiel', 5, 'Vendredi', '16:00:00', '18:00:00', 5, 5, 5),
(6, 'Présentiel', 6, 'Samedi', '08:00:00', '10:00:00', 6, 6, 6),
(7, 'Présentiel', 7, 'Dimanche', '10:00:00', '12:00:00', 7, 7, 7),
(8, 'Présentiel', 8, 'Lundi', '12:00:00', '14:00:00', 8, 8, 8),
(9, 'Présentiel', 9, 'Mardi', '14:00:00', '16:00:00', 9, 9, 9),
(10, 'Présentiel', 10, 'Mercredi', '16:00:00', '18:00:00', 10, 10, 10),
(11, 'Présentiel', 11, 'Jeudi', '08:00:00', '10:00:00', 11, 11, 11),
(12, 'Présentiel', 12, 'Vendredi', '10:00:00', '12:00:00', 12, 12, 12),
(13, 'Présentiel', 13, 'Samedi', '12:00:00', '14:00:00', 13, 13, 13),
(14, 'Présentiel', 14, 'Dimanche', '14:00:00', '16:00:00', 14, 14, 14),
(15, 'Présentiel', 15, 'Lundi', '16:00:00', '18:00:00', 15, 15, 15);

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
  MODIFY `id_eleve` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT pour la table `enseignant`
--
ALTER TABLE `enseignant`
  MODIFY `idenseignant` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

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
  MODIFY `idgroupe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `séance`
--
ALTER TABLE `séance`
  MODIFY `idséance` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
