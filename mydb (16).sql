-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 14 déc. 2023 à 13:55
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
(1, 'youness', '100', 'SD456'),
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
  `numtel_par` varchar(20) DEFAULT NULL COMMENT 'numéro de télephone du parent\r\n',
  `date_inscrit` date NOT NULL,
  `test` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `eleve`
--

INSERT INTO `eleve` (`id_eleve`, `prenom_ev`, `nom_ev`, `email_ev`, `phone_ev`, `numtel_par`, `date_inscrit`, `test`) VALUES
(1, 'Mohamed', 'Benali', 'mohamed.benali@gmail.com', '0650123456', '0678123456', '2023-12-10', 0),
(2, 'Fatima', 'Ait Moussa', 'fatima.aitmoussa@hotmail.com', '0678123456', '0650123456', '2023-12-10', 0),
(3, 'Youssef', 'El Khattabi', 'youssef.elkhattabi@outlook.com', '0666123456', '0665123456', '2023-12-10', 0),
(4, 'Amina', 'Zerouali', 'amina.zerouali@gmail.com', '0677123456', '0666123456', '2023-12-10', 0),
(5, 'Ahmed', 'Bouhaddou', 'ahmed.bouhaddou@hotmail.com', '0651123456', '0679123456', '2023-12-10', 0),
(6, 'Hafsa', 'El Amrani', 'hafsa.elamrani@outlook.com', '0669123456', '0653123456', '2023-12-10', 0),
(7, 'Omar', 'Chakir', 'omar.chakir@gmail.com', '0657123456', '0658123456', '2023-12-10', 0),
(8, 'Nadia', 'El Mansouri', 'nadia.elmansouri@hotmail.com', '0663123456', '0664123456', '2023-12-10', 0),
(9, 'Karim', 'Fassi', 'karim.fassi@outlook.com', '0654123456', '0671123456', '2023-12-10', 0),
(10, 'Salma', 'Gueddari', 'salma.gueddari@gmail.com', '0659123456', '0661123456', '2023-12-10', 0),
(11, 'Rachid', 'Hamidi', 'rachid.hamidi@hotmail.com', '0673123456', '0674123456', '2023-12-10', 0),
(12, 'Loubna', 'Ibrahim', 'loubna.ibrahim@outlook.com', '0655123456', '0656123456', '2023-12-10', 0),
(13, 'Said', 'Joumani', 'said.joumani@gmail.com', '0665123456', '0677123456', '2023-12-10', 0),
(14, 'Nawal', 'Kadiri', 'nawal.kadiri@hotmail.com', '0656123456', '0668123456', '2023-12-10', 0),
(15, 'Imad', 'Lamrani', 'imad.lamrani@outlook.com', '0676123456', '0651123456', '2023-12-10', 0),
(16, 'Houda', 'Moussaoui', 'houda.moussaoui@gmail.com', '0652123456', '0662123456', '2023-12-10', 0),
(17, 'Brahim', 'Najdi', 'brahim.najdi@hotmail.com', '0670123456', '0654123456', '2023-12-10', 0),
(18, 'Samira', 'Ouazzani', 'samira.ouazzani@outlook.com', '0653123456', '0663123456', '2023-12-10', 0),
(19, 'Younes', 'Rahmani', 'younes.rahmani@gmail.com', '0661123456', '0657123456', '2023-12-10', 0),
(20, 'Hajar', 'Saidi', 'hajar.saidi@hotmail.com', '0654123456', '0672123456', '2023-12-10', 0),
(21, 'Abdellah', 'Tazi', 'abdellah.tazi@outlook.com', '0675123456', '0664123456', '2023-12-10', 0),
(22, 'Zineb', 'Zouhir', 'zineb.zouhir@gmail.com', '0655123456', '0676123456', '2023-12-10', 0),
(23, 'Fatiha', 'Amrani', 'fatiha.amrani@gmail.com', '0656123456', '0657123456', '2023-12-10', 0),
(24, 'Mohammed', 'Boukhriss', 'mohammed.boukhriss@hotmail.com', '0660123456', '0671123456', '2023-12-10', 0),
(25, 'Aicha', 'Choukri', 'aicha.choukri@outlook.com', '0672123456', '0653123456', '2023-12-10', 0),
(26, 'Said', 'Dahmane', 'said.dahmane@gmail.com', '0657123456', '0664123456', '2023-12-10', 0),
(27, 'Naima', 'El Fakir', 'naima.elfakir@hotmail.com', '0674123456', '0655123456', '2023-12-10', 0),
(28, 'Abdelkader', 'Ghalia', 'abdelkader.ghalia@outlook.com', '0662123456', '0676123456', '2023-12-10', 0),
(29, 'Sara', 'Hafidi', 'sara.hafidi@gmail.com', '0658123456', '0659123456', '2023-12-10', 0),
(30, 'Hassan', 'Idrissi', 'hassan.idrissi@hotmail.com', '0664123456', '0670123456', '2023-12-10', 0),
(31, 'Najwa', 'Jabrane', 'najwa.jabrane@outlook.com', '0676123456', '0651123456', '2023-12-10', 0),
(32, 'Karima', 'Kandil', 'karima.kandil@gmail.com', '0659123456', '0662123456', '2023-12-10', 0),
(33, 'Mehdi', 'Lazaar', 'mehdi.lazaar@hotmail.com', '0671123456', '0653123456', '2023-12-10', 0),
(34, 'Rita', 'Mazari', 'rita.mazari@outlook.com', '0665123456', '0666123456', '2023-12-10', 0),
(35, 'Abderrahman', 'Ouafi', 'abderrahman.ouafi@gmail.com', '0653123456', '0654123456', '2023-12-10', 0),
(36, 'Fadwa', 'Rami', 'fadwa.rami@hotmail.com', '0666123456', '0667123456', '2023-12-10', 0),
(37, 'Redouane', 'Sefiani', 'redouane.sefiani@outlook.com', '0672123456', '0655123456', '2023-12-10', 0),
(38, 'Nisrine', 'Taleb', 'nisrine.taleb@gmail.com', '0654123456', '0677123456', '2023-12-10', 0),
(39, 'Hamza', 'Zayani', 'hamza.zayani@hotmail.com', '0667123456', '0656123456', '2023-12-10', 0),
(40, 'Zahra', 'Bouazza', 'zahra.bouazza@outlook.com', '0655123456', '0668123456', '2023-12-10', 0),
(41, 'Mounir', 'El Moudir', 'mounir.elmoudir@gmail.com', '0668123456', '0659123456', '2023-12-10', 0),
(42, 'Latifa', 'Hassani', 'latifa.hassani@hotmail.com', '0656123456', '0660123456', '2023-12-10', 0),
(43, 'Sofia', 'Zitouni', 'sofia.zitouni@outlook.com', '0670123456', '0671123456', '2023-12-10', 0),
(44, 'Yassir', 'El Fassi', 'yassir.elfassi@gmail.com', '0657123456', '0658123456', '2023-12-10', 0),
(45, 'Imane', 'Fathi', 'imane.fathi@hotmail.com', '0671123456', '0672123456', '2023-12-10', 0),
(46, 'Tariq', 'Ghazali', 'tariq.ghazali@outlook.com', '0653123456', '0654123456', '2023-12-10', 0),
(47, 'Siham', 'Hammouda', 'siham.hammouda@gmail.com', '0664123456', '0665123456', '2023-12-10', 0),
(48, 'Khalid', 'El Boussiri', 'khalid.elboussiri@hotmail.com', '0655123456', '0656123456', '2023-12-10', 0),
(49, 'Noura', 'El Haddadi', 'noura.elhaddadi@outlook.com', '0672123456', '0667123456', '2023-12-10', 0),
(50, 'Abdelkrim', 'Kasmi', 'abdelkrim.kasmi@gmail.com', '0656123456', '0657123456', '2023-12-10', 0),
(51, 'Naima', 'Lahlou', 'naima.lahlou@hotmail.com', '0660123456', '0671123456', '2023-12-10', 0),
(52, 'Youness', 'Moussaoui', 'youness.moussaoui@outlook.com', '0672123456', '0653123456', '2023-12-10', 0),
(53, 'Houda', 'Najib', 'houda.najib@gmail.com', '0654123456', '0655123456', '2023-12-10', 0),
(54, 'Karim', 'Oubella', 'karim.oubella@hotmail.com', '0665123456', '0676123456', '2023-12-10', 0),
(55, 'Salima', 'Rachidi', 'salima.rachidi@outlook.com', '0656123456', '0657123456', '2023-12-10', 0),
(56, 'Mouna', 'Sabbahi', 'mouna.sabbahi@gmail.com', '0667123456', '0668123456', '2023-12-10', 0),
(57, 'Abderrahmane', 'Tahiri', 'abderrahmane.tahiri@hotmail.com', '0658123456', '0659123456', '2023-12-10', 0),
(58, 'Laila', 'Zerouali', 'laila.zerouali@outlook.com', '0670123456', '0671123456', '2023-12-10', 0),
(59, 'Adnan', 'Berrada', 'adnan.berrada@gmail.com', '0656123456', '0657123456', '2023-12-10', 0),
(60, 'Rabia', 'Chaibi', 'rabia.chaibi@hotmail.com', '0677123456', '0668123456', '2023-12-10', 0),
(61, 'Majid', 'Dhakiri', 'majid.dhakiri@outlook.com', '0659123456', '0650123456', '2023-12-10', 0),
(62, 'Yasmina', 'El Harchi', 'yasmina.elharchi@gmail.com', '0670123456', '0661123456', '2023-12-10', 0),
(63, 'Kamal', 'Fakir', 'kamal.fakir@hotmail.com', '0661123456', '0652123456', '2023-12-10', 0),
(64, 'Ines', 'Ghazi', 'ines.ghazi@outlook.com', '0652123456', '0663123456', '2023-12-10', 0),
(65, 'Nabil', 'Hachimi', 'nabil.hachimi@gmail.com', '0663123456', '0654123456', '2023-12-10', 0),
(66, 'Jihane', 'Idrissi', 'jihane.idrissi@hotmail.com', '0654123456', '0675123456', '2023-12-10', 0),
(67, 'Imran', 'Jawad', 'imran.jawad@outlook.com', '0675123456', '0656123456', '2023-12-10', 0),
(68, 'Kenza', 'Koussa', 'kenza.koussa@gmail.com', '0656123456', '0666123456', '2023-12-10', 0),
(69, 'Wassim', 'Lazaar', 'wassim.lazaar@hotmail.com', '0666123456', '0676123456', '2023-12-10', 0),
(70, 'Hanane', 'Mansouri', 'hanane.mansouri@outlook.com', '0657123456', '0658123456', '2023-12-10', 0),
(71, 'Othman', 'Najib', 'othman.najib@gmail.com', '0668123456', '0659123456', '2023-12-10', 0),
(72, 'Leila', 'Oubella', 'leila.oubella@hotmail.com', '0659123456', '0670123456', '2023-12-10', 0),
(73, 'Yassin', 'Rahmani', 'yassin.rahmani@outlook.com', '0670123456', '0651123456', '2023-12-10', 0),
(74, 'Sanaa', 'Sefiani', 'sanaa.sefiani@gmail.com', '0651123456', '0671123456', '2023-12-10', 0),
(75, 'Ilyas', 'Taleb', 'ilyas.taleb@hotmail.com', '0671123456', '0652123456', '2023-12-10', 0),
(76, 'Zineb', 'Zaitouni', 'zineb.zaitouni@outlook.com', '0652123456', '0662123456', '2023-12-10', 0),
(77, 'Omar', 'Bouazza', 'omar.bouazza@gmail.com', '0662123456', '0672123456', '2023-12-10', 0),
(78, 'Safia', 'Chakir', 'safia.chakir@hotmail.com', '0653123456', '0654123456', '2023-12-10', 0),
(79, 'Imad', 'El Fassi', 'imad.elfassi@outlook.com', '0664123456', '0674123456', '2023-12-10', 0),
(80, 'Hiba', 'El Khattabi', 'hiba.elkhattabi@gmail.com', '0655123456', '0656123456', '2023-12-10', 0),
(81, 'Khalid', 'Gueddari', 'khalid.gueddari@hotmail.com', '0666123456', '0676123456', '2023-12-10', 0),
(82, 'Lina', 'Hammouda', 'lina.hammouda@outlook.com', '0656123456', '0657123456', '2023-12-10', 0),
(83, 'Anas', 'Ibrahim', 'anas.ibrahim@gmail.com', '0677123456', '0667123456', '2023-12-10', 0),
(84, 'Khadija', 'Joumani', 'khadija.joumani@hotmail.com', '0657123456', '0658123456', '2023-12-10', 0),
(85, 'Said', 'Kadiri', 'said.kadiri@outlook.com', '0668123456', '0678123456', '2023-12-10', 0),
(86, 'Nawal', 'Lamrani', 'nawal.lamrani@gmail.com', '0658123456', '0659123456', '2023-12-10', 0),
(87, 'Brahim', 'Moussaoui', 'brahim.moussaoui@hotmail.com', '0669123456', '0679123456', '2023-12-10', 0),
(88, 'Raja', 'Najdi', 'raja.najdi@outlook.com', '0659123456', '0650123456', '2023-12-10', 0),
(89, 'Youssef', 'Ouazzani', 'youssef.ouazzani@gmail.com', '0660123456', '0670123456', '2023-12-10', 0),
(90, 'Hajar', 'Rahmani', 'hajar.rahmani@hotmail.com', '0650123456', '0651123456', '2023-12-10', 0),
(91, 'Fouad', 'Saidi', 'fouad.saidi@outlook.com', '0661123456', '0671123456', '2023-12-10', 0),
(92, 'Samia', 'Tazi', 'samia.tazi@gmail.com', '0651123456', '0652123456', '2023-12-10', 0),
(93, 'Hassan', 'Zouhir', 'hassan.zouhir@hotmail.com', '0662123456', '0672123456', '2023-12-10', 0),
(94, 'Hassan', 'Amrani', 'hassan.amrani@gmail.com', '0656123456', '0657123456', '2023-12-10', 0),
(95, 'Yasmine', 'Benali', 'yasmine.benali@hotmail.com', '0677123456', '0668123456', '2023-12-10', 0),
(96, 'Omar', 'Choukri', 'omar.choukri@outlook.com', '0659123456', '0650123456', '2023-12-10', 0),
(97, 'Lina', 'Dhakiri', 'lina.dhakiri@gmail.com', '0670123456', '0661123456', '2023-12-10', 0),
(98, 'Mohamed', 'El Harchi', 'mohamed.elharchi@hotmail.com', '0661123456', '0652123456', '2023-12-10', 0),
(99, 'Rabab', 'Fakir', 'rabab.fakir@outlook.com', '0652123456', '0663123456', '2023-12-10', 0),
(100, 'Khalid', 'Ghazi', 'khalid.ghazi@gmail.com', '0663123456', '0654123456', '2023-12-10', 0),
(101, 'Lamia', 'Idrissi', 'lamia.idrissi@hotmail.com', '0654123456', '0675123456', '2023-12-10', 0),
(102, 'Amine', 'Jawad', 'amine.jawad@outlook.com', '0675123456', '0656123456', '2023-12-10', 0),
(103, 'Nadia', 'Koussa', 'nadia.koussa@gmail.com', '0656123456', '0666123456', '2023-12-10', 0),
(104, 'Yassin', 'Lazaar', 'yassin.lazaar@hotmail.com', '0666123456', '0676123456', '2023-12-10', 0),
(105, 'Sara', 'Mansouri', 'sara.mansouri@outlook.com', '0657123456', '0658123456', '2023-12-10', 0),
(106, 'Kamal', 'Najib', 'kamal.najib@gmail.com', '0668123456', '0659123456', '2023-12-10', 0),
(107, 'Samira', 'Oubella', 'samira.oubella@hotmail.com', '0659123456', '0670123456', '2023-12-10', 0),
(108, 'Youssef', 'Rahmani', 'youssef.rahmani@outlook.com', '0670123456', '0651123456', '2023-12-10', 0),
(109, 'Sana', 'Sefiani', 'sana.sefiani@gmail.com', '0651123456', '0671123456', '2023-12-10', 0),
(110, 'Ibrahim', 'Taleb', 'ibrahim.taleb@hotmail.com', '0671123456', '0652123456', '2023-12-10', 0),
(111, 'Naima', 'Zaitouni', 'naima.zaitouni@outlook.com', '0652123456', '0662123456', '2023-12-10', 0),
(112, 'Mehdi', 'Bouazza', 'mehdi.bouazza@gmail.com', '0662123456', '0672123456', '2023-12-10', 0),
(113, 'Rania', 'Chakir', 'rania.chakir@hotmail.com', '0653123456', '0654123456', '2023-12-10', 0),
(114, 'Anas', 'El Fassi', 'anas.elfassi@outlook.com', '0664123456', '0674123456', '2023-12-10', 0),
(115, 'Houda', 'El Khattabi', 'houda.elkhattabi@gmail.com', '0655123456', '0656123456', '2023-12-10', 0),
(116, 'Khalid', 'Gueddari', 'khalid.gueddari@hotmail.com', '0666123456', '0676123456', '2023-12-10', 0),
(117, 'Lina', 'Hammouda', 'lina.hammouda@outlook.com', '0656123456', '0657123456', '2023-12-10', 0),
(118, 'Anas', 'Ibrahim', 'anas.ibrahim@gmail.com', '0677123456', '0667123456', '2023-12-10', 0),
(119, 'Khadija', 'Joumani', 'khadija.joumani@hotmail.com', '0657123456', '0658123456', '2023-12-10', 0),
(120, 'Said', 'Kadiri', 'said.kadiri@outlook.com', '0668123456', '0678123456', '2023-12-10', 0),
(121, 'Nawal', 'Lamrani', 'nawal.lamrani@gmail.com', '0658123456', '0659123456', '2023-12-10', 0),
(122, 'Brahim', 'Moussaoui', 'brahim.moussaoui@hotmail.com', '0669123456', '0679123456', '2023-12-10', 0),
(123, 'Raja', 'Najdi', 'raja.najdi@outlook.com', '0659123456', '0650123456', '2023-12-10', 0),
(124, 'Youssef', 'Ouazzani', 'youssef.ouazzani@gmail.com', '0660123456', '0670123456', '2023-12-10', 0),
(125, 'Hajar', 'Rahmani', 'hajar.rahmani@hotmail.com', '0650123456', '0651123456', '2023-12-10', 0),
(126, 'Fouad', 'Saidi', 'fouad.saidi@outlook.com', '0661123456', '0671123456', '2023-12-10', 0),
(127, 'Samia', 'Tazi', 'samia.tazi@gmail.com', '0651123456', '0652123456', '2023-12-10', 0),
(128, 'Hassan', 'Zouhir', 'hassan.zouhir@hotmail.com', '0662123456', '0672123456', '2023-12-10', 0);

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
(2, 9, 8, 8),
(3, 9, 8, 8),
(4, 9, 8, 8),
(5, 9, 20, 20),
(1, 9, 100, 100),
(6, 15, 50, 50),
(7, 15, 9, 9),
(8, 15, 4, 4),
(9, 15, 8, 8),
(10, 15, 9, 9),
(11, 21, 40, 40),
(12, 21, 25, 25),
(13, 21, 4, 4),
(14, 17, 50, 50),
(16, 17, 9, 9),
(16, 17, 8, 8),
(17, 17, 5, 5),
(17, 17, 8, 8),
(15, 18, 40, 40),
(18, 12, 40, 40),
(19, 13, 40, 40),
(20, 13, 8, 8),
(21, 13, 12, 12),
(22, 13, 15, 15),
(23, 13, 15, 15),
(24, 18, 20, 20),
(25, 18, 6, 6),
(27, 18, 15, 15),
(27, 18, 8, 8),
(25, 18, 7, 7),
(26, 18, 4, 4),
(1, 13, 47, 47),
(27, 18, 10, 10),
(28, 23, 45, 45),
(29, 23, 12, 12),
(30, 23, 5, 5),
(31, 23, 22, 22),
(32, 15, 14, 14),
(33, 22, 45, 45),
(34, 10, 50, 50),
(35, 10, 12, 12),
(36, 10, 14, 14),
(37, 21, 4, 4),
(38, 11, 50, 50),
(39, 11, 12, 12),
(40, 11, 12, 12),
(41, 11, 8, 8);

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
(2, 31),
(2, 46),
(2, 37),
(3, 31),
(3, 46),
(3, 37),
(4, 31),
(4, 46),
(4, 37),
(5, 31),
(5, 46),
(5, 37),
(1, 31),
(1, 46),
(1, 37),
(6, 3),
(6, 15),
(6, 28),
(7, 3),
(7, 15),
(7, 28),
(8, 3),
(8, 15),
(8, 28),
(9, 3),
(9, 15),
(9, 28),
(10, 3),
(10, 15),
(10, 28),
(11, 49),
(11, 55),
(11, 61),
(12, 49),
(12, 55),
(12, 61),
(13, 49),
(13, 55),
(13, 61),
(14, 6),
(14, 20),
(14, 77),
(16, 6),
(16, 19),
(16, 20),
(16, 77),
(16, 74),
(17, 6),
(17, 20),
(17, 77),
(17, 7),
(17, 19),
(15, 8),
(15, 21),
(15, 75),
(18, 67),
(18, 71),
(19, 68),
(19, 72),
(20, 68),
(20, 72),
(21, 68),
(21, 72),
(22, 68),
(22, 72),
(23, 68),
(23, 72),
(24, 8),
(24, 75),
(25, 9),
(25, 75),
(27, 8),
(27, 75),
(27, 9),
(25, 8),
(25, 22),
(26, 8),
(26, 21),
(26, 75),
(1, 70),
(1, 14),
(27, 22),
(28, 51),
(28, 57),
(28, 63),
(29, 51),
(29, 60),
(29, 66),
(30, 51),
(30, 57),
(30, 63),
(31, 51),
(31, 57),
(31, 66),
(32, 3),
(32, 16),
(32, 28),
(33, 53),
(33, 56),
(34, 32),
(34, 44),
(34, 35),
(34, 38),
(35, 32),
(35, 44),
(35, 35),
(36, 32),
(36, 47),
(36, 38),
(37, 49),
(37, 55),
(37, 61),
(38, 42),
(38, 48),
(38, 39),
(39, 33),
(39, 45),
(39, 36),
(40, 33),
(40, 48),
(40, 39),
(41, 42),
(41, 48),
(41, 39);

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
(2, 31, 0),
(2, 46, 0),
(2, 40, 0),
(3, 31, 0),
(3, 46, 0),
(3, 40, 0),
(4, 31, 0),
(4, 46, 0),
(4, 40, 0),
(5, 31, 0),
(5, 46, 0),
(5, 40, 0),
(1, 31, 0),
(1, 46, 0),
(1, 40, 0),
(6, 3, 0),
(6, 15, 0),
(6, 28, 0),
(7, 3, 0),
(7, 15, 0),
(7, 28, 0),
(8, 3, 0),
(8, 15, 0),
(8, 28, 0),
(9, 3, 0),
(9, 15, 0),
(9, 28, 0),
(10, 3, 0),
(10, 15, 0),
(10, 28, 0),
(11, 49, 0),
(11, 55, 0),
(11, 61, 0),
(12, 49, 0),
(12, 55, 0),
(12, 61, 0),
(13, 49, 0),
(13, 55, 0),
(13, 61, 0),
(14, 6, 0),
(14, 20, 0),
(14, 78, 0),
(16, 6, 0),
(16, 19, 0),
(16, 20, 0),
(16, 78, 0),
(16, 75, 0),
(17, 6, 0),
(17, 20, 0),
(17, 78, 0),
(17, 7, 0),
(17, 19, 0),
(15, 8, 0),
(15, 21, 0),
(15, 76, 0),
(18, 67, 0),
(18, 71, 0),
(19, 68, 0),
(19, 72, 0),
(20, 68, 0),
(20, 72, 0),
(21, 68, 0),
(21, 72, 0),
(22, 68, 0),
(22, 72, 0),
(23, 68, 0),
(23, 72, 0),
(24, 8, 0),
(24, 76, 0),
(25, 9, 0),
(25, 76, 0),
(27, 8, 0),
(27, 76, 0),
(27, 9, 0),
(25, 8, 0),
(25, 22, 0),
(26, 8, 0),
(26, 21, 0),
(26, 76, 0),
(1, 74, 0),
(1, 70, 0),
(27, 22, 0),
(28, 51, 0),
(28, 57, 0),
(28, 63, 0),
(29, 51, 0),
(29, 60, 0),
(29, 66, 0),
(30, 51, 0),
(30, 57, 0),
(30, 63, 0),
(31, 51, 0),
(31, 57, 0),
(31, 66, 0),
(32, 3, 0),
(32, 16, 0),
(32, 28, 0),
(33, 53, 0),
(33, 56, 0),
(34, 32, 0),
(34, 44, 0),
(34, 47, 0),
(34, 38, 0),
(35, 32, 0),
(35, 44, 0),
(35, 38, 0),
(36, 32, 0),
(36, 47, 0),
(36, 41, 0),
(37, 49, 0),
(37, 55, 0),
(37, 61, 0),
(38, 48, 0),
(38, 36, 0),
(38, 42, 0),
(39, 33, 0),
(39, 45, 0),
(39, 39, 0),
(40, 33, 0),
(40, 48, 0),
(40, 42, 0),
(41, 48, 0),
(41, 36, 0),
(41, 42, 0);

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
(1, 1200, '2023-12-14 00:00:00', 2),
(2, 1200, '2023-12-14 00:00:00', 3),
(3, 1200, '2023-12-14 00:00:00', 4),
(4, 3000, '2023-12-14 00:00:00', 5),
(5, 15000, '2023-12-14 00:00:00', 1),
(6, 7500, '2023-12-14 00:00:00', 6),
(7, 1350, '2023-12-14 00:00:00', 7),
(8, 600, '2023-12-14 00:00:00', 8),
(9, 1200, '2023-12-14 00:00:00', 9),
(10, 1350, '2023-12-14 00:00:00', 10),
(11, 6000, '2023-12-14 00:00:00', 11),
(12, 3750, '2023-12-14 00:00:00', 12),
(13, 600, '2023-12-14 00:00:00', 13),
(14, 7500, '2023-12-14 00:00:00', 14),
(15, 1350, '2023-12-14 00:00:00', 16),
(16, 1200, '2023-12-14 00:00:00', 16),
(17, 750, '2023-12-14 00:00:00', 17),
(18, 1200, '2023-12-14 00:00:00', 17),
(19, 6000, '2023-12-14 00:00:00', 15),
(20, 6000, '2023-12-14 00:00:00', 18),
(21, 6000, '2023-12-14 00:00:00', 19),
(22, 1200, '2023-12-14 00:00:00', 20),
(23, 1800, '2023-12-14 00:00:00', 21),
(24, 2250, '2023-12-14 00:00:00', 22),
(25, 2250, '2023-12-14 00:00:00', 23),
(26, 3000, '2023-12-14 00:00:00', 24),
(27, 900, '2023-12-14 00:00:00', 25),
(28, 2250, '2023-12-14 00:00:00', 27),
(29, 1200, '2023-12-14 00:00:00', 27),
(30, 1050, '2023-12-14 00:00:00', 25),
(31, 600, '2023-12-14 00:00:00', 26),
(32, 7050, '2023-12-14 00:00:00', 1),
(33, 1500, '2023-12-14 00:00:00', 27),
(34, 6750, '2023-12-14 00:00:00', 28),
(35, 1800, '2023-12-14 00:00:00', 29),
(36, 750, '2023-12-14 00:00:00', 30),
(37, 3300, '2023-12-14 00:00:00', 31),
(38, 2100, '2023-12-14 00:00:00', 32),
(39, 6750, '2023-12-14 00:00:00', 33),
(40, 7500, '2023-12-14 00:00:00', 34),
(41, 1800, '2023-12-14 00:00:00', 35),
(42, 2100, '2023-12-14 00:00:00', 36),
(43, 600, '2023-12-14 00:00:00', 37),
(44, 7500, '2023-12-14 00:00:00', 38),
(45, 1800, '2023-12-14 00:00:00', 39),
(46, 1800, '2023-12-14 00:00:00', 40),
(47, 1200, '2023-12-14 00:00:00', 41);

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
(3, 6),
(4, 0),
(5, 0),
(6, 3),
(7, 1),
(8, 5),
(9, 2),
(10, 0),
(11, 0),
(12, 0),
(13, 0),
(14, 1),
(15, 5),
(16, 1),
(17, 0),
(18, 0),
(19, 2),
(20, 3),
(21, 2),
(22, 2),
(23, 0),
(24, 0),
(25, 0),
(26, 0),
(27, 0),
(28, 6),
(29, 0),
(30, 0),
(31, 5),
(32, 3),
(33, 2),
(34, 0),
(35, 2),
(36, 1),
(37, 5),
(38, 2),
(39, 3),
(40, 0),
(41, 0),
(42, 2),
(43, 0),
(44, 2),
(45, 1),
(46, 5),
(47, 1),
(48, 3),
(49, 4),
(50, 0),
(51, 4),
(52, 0),
(53, 1),
(54, 0),
(55, 4),
(56, 1),
(57, 3),
(58, 0),
(59, 0),
(60, 1),
(61, 4),
(62, 0),
(63, 2),
(64, 0),
(65, 0),
(66, 2),
(67, 1),
(68, 5),
(69, 0),
(70, 1),
(71, 1),
(72, 5),
(73, 0),
(74, 1),
(75, 5),
(76, 0),
(77, 3),
(78, 0),
(79, 0),
(80, 0);

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
(0, 'presentielle', 1, 'Lundi', '18:00:00', '20:00:00', 1, 19, 'A'),
(1, 'presentielle', 3, 'Lundi', '20:00:00', '22:00:00', 26, 16, 'C'),
(2, 'presentielle', 1, 'Lundi', '20:00:00', '22:00:00', 2, 19, 'A'),
(3, 'presentielle', 2, 'Lundi', '18:00:00', '20:00:00', 3, 15, 'B'),
(4, 'presentielle', 2, 'Lundi', '20:00:00', '22:00:00', 4, 15, 'B'),
(5, 'presentielle', 3, 'Lundi', '18:00:00', '20:00:00', 5, 16, 'C'),
(6, 'presentielle', 4, 'Mardi', '20:00:00', '22:00:00', 6, 17, 'A'),
(7, 'presentielle', 4, 'Mardi', '18:00:00', '20:00:00', 7, 17, 'A'),
(8, 'presentielle', 5, 'Mardi', '20:00:00', '22:00:00', 8, 18, 'B'),
(9, 'presentielle', 5, 'Mardi', '18:00:00', '20:00:00', 9, 18, 'B'),
(10, 'presentielle', 6, 'Mardi', '20:00:00', '22:00:00', 10, 20, 'C'),
(11, 'presentielle', 6, 'Mardi', '18:00:00', '20:00:00', 11, 20, 'C'),
(12, 'presentielle', 1, 'Mercredi', '20:00:00', '22:00:00', 12, 19, 'A'),
(13, 'presentielle', 1, 'Mercredi', '18:00:00', '20:00:00', 13, 19, 'A'),
(15, 'presentielle', 2, 'Mercredi', '18:00:00', '20:00:00', 15, 15, 'B'),
(16, 'presentielle', 2, 'Mercredi', '20:00:00', '22:00:00', 16, 15, 'B'),
(17, 'presentielle', 3, 'Mercredi', '18:00:00', '20:00:00', 17, 16, 'C'),
(18, 'presentielle', 3, 'Mercredi', '20:00:00', '22:00:00', 18, 16, 'C'),
(19, 'presentielle', 4, 'Jeudi', '18:00:00', '20:00:00', 19, 17, 'A'),
(20, 'presentielle', 4, 'Jeudi', '20:00:00', '22:00:00', 20, 17, 'A'),
(21, 'presentielle', 5, 'Jeudi', '18:00:00', '20:00:00', 21, 18, 'B'),
(22, 'presentielle', 5, 'Jeudi', '20:00:00', '22:00:00', 22, 18, 'B'),
(23, 'presentielle', 6, 'Jeudi', '18:00:00', '20:00:00', 23, 20, 'C'),
(24, 'presentielle', 6, 'Jeudi', '20:00:00', '22:00:00', 24, 20, 'C'),
(25, 'presentielle', 1, 'Vendredi', '18:00:00', '20:00:00', 25, 19, 'A'),
(26, 'presentielle', 1, 'Vendredi', '20:00:00', '22:00:00', 26, 19, 'A'),
(27, 'presentielle', 2, 'Vendredi', '18:00:00', '20:00:00', 27, 15, 'B'),
(28, 'presentielle', 2, 'Vendredi', '20:00:00', '22:00:00', 28, 15, 'B'),
(29, 'presentielle', 3, 'Vendredi', '18:00:00', '20:00:00', 29, 16, 'C'),
(30, 'presentielle', 3, 'Vendredi', '20:00:00', '22:00:00', 30, 16, 'C'),
(31, 'presentielle', 7, 'Lundi', '08:00:00', '10:00:00', 31, 9, 'A'),
(32, 'presentielle', 8, 'Lundi', '08:00:00', '10:00:00', 32, 10, 'B'),
(33, 'presentielle', 9, 'Lundi', '08:00:00', '10:00:00', 33, 11, 'C'),
(34, 'presentielle', 7, 'Lundi', '10:00:00', '12:00:00', 40, 9, 'A'),
(35, 'presentielle', 8, 'Lundi', '10:00:00', '12:00:00', 41, 10, 'B'),
(36, 'presentielle', 9, 'Lundi', '10:00:00', '12:00:00', 42, 11, 'C'),
(37, 'presentielle', 7, 'Mercredi', '08:00:00', '10:00:00', 43, 9, 'A'),
(38, 'presentielle', 8, 'Mercredi', '08:00:00', '10:00:00', 44, 10, 'B'),
(39, 'presentielle', 9, 'Mercredi', '08:00:00', '10:00:00', 45, 11, 'C'),
(40, 'presentielle', 7, 'Mercredi', '10:00:00', '12:00:00', 46, 9, 'A'),
(41, 'presentielle', 8, 'Mercredi', '10:00:00', '12:00:00', 47, 10, 'B'),
(42, 'presentielle', 9, 'Mercredi', '10:00:00', '12:00:00', 48, 11, 'C'),
(43, 'presentielle', 7, 'Vendredi', '08:00:00', '10:00:00', 34, 9, 'A'),
(44, 'presentielle', 8, 'Vendredi', '08:00:00', '10:00:00', 35, 10, 'B'),
(45, 'presentielle', 9, 'Vendredi', '08:00:00', '10:00:00', 36, 11, 'C'),
(46, 'presentielle', 7, 'Vendredi', '10:00:00', '12:00:00', 37, 9, 'A'),
(47, 'presentielle', 8, 'Vendredi', '10:00:00', '12:00:00', 38, 10, 'B'),
(48, 'presentielle', 9, 'Vendredi', '10:00:00', '12:00:00', 39, 11, 'C'),
(49, 'presentielle', 10, 'Lundi', '14:00:00', '16:00:00', 49, 21, 'A'),
(50, 'presentielle', 11, 'Lundi', '14:00:00', '16:00:00', 50, 22, 'B'),
(51, 'presentielle', 12, 'Lundi', '14:00:00', '16:00:00', 51, 23, 'C'),
(52, 'presentielle', 10, 'Lundi', '16:00:00', '18:00:00', 52, 21, 'A'),
(53, 'presentielle', 11, 'Lundi', '16:00:00', '18:00:00', 53, 22, 'B'),
(54, 'presentielle', 12, 'Lundi', '16:00:00', '18:00:00', 54, 23, 'C'),
(55, 'presentielle', 10, 'Mercredi', '14:00:00', '16:00:00', 55, 21, 'A'),
(56, 'presentielle', 11, 'Mercredi', '14:00:00', '16:00:00', 56, 22, 'B'),
(57, 'presentielle', 12, 'Mercredi', '14:00:00', '16:00:00', 57, 23, 'C'),
(58, 'presentielle', 10, 'Mercredi', '16:00:00', '18:00:00', 58, 21, 'A'),
(59, 'presentielle', 11, 'Mercredi', '16:00:00', '18:00:00', 59, 22, 'B'),
(60, 'presentielle', 12, 'Mercredi', '16:00:00', '18:00:00', 60, 23, 'C'),
(61, 'presentielle', 10, 'Vendredi', '14:00:00', '16:00:00', 61, 21, 'A'),
(62, 'presentielle', 11, 'Vendredi', '14:00:00', '16:00:00', 62, 22, 'B'),
(63, 'presentielle', 12, 'Vendredi', '14:00:00', '16:00:00', 63, 23, 'C'),
(64, 'presentielle', 10, 'Vendredi', '16:00:00', '18:00:00', 64, 21, 'A'),
(65, 'presentielle', 11, 'Vendredi', '16:00:00', '18:00:00', 65, 22, 'B'),
(66, 'presentielle', 12, 'Vendredi', '16:00:00', '18:00:00', 66, 23, 'C'),
(67, 'presentielle', 13, 'Mardi', '14:00:00', '16:00:00', 67, 12, 'A'),
(68, 'presentielle', 14, 'Mardi', '14:00:00', '16:00:00', 68, 13, 'B'),
(69, 'presentielle', 13, 'Mardi', '16:00:00', '18:00:00', 69, 12, 'A'),
(70, 'presentielle', 14, 'Mardi', '16:00:00', '18:00:00', 70, 13, 'B'),
(71, 'presentielle', 13, 'Jeudi', '14:00:00', '16:00:00', 71, 12, 'A'),
(72, 'presentielle', 14, 'Jeudi', '14:00:00', '16:00:00', 72, 13, 'B'),
(73, 'presentielle', 13, 'Jeudi', '16:00:00', '18:00:00', 73, 12, 'A'),
(74, 'presentielle', 14, 'Jeudi', '16:00:00', '18:00:00', 14, 13, 'B'),
(75, 'presentielle', 4, 'Samedi', '08:00:00', '10:00:00', 74, 17, 'A'),
(76, 'presentielle', 5, 'Samedi', '10:00:00', '12:00:00', 75, 18, 'B'),
(77, 'presentielle', 6, 'Samedi', '08:00:00', '10:00:00', 76, 20, 'C'),
(78, 'presentielle', 4, 'Samedi', '10:00:00', '12:00:00', 77, 17, 'A'),
(79, 'presentielle', 5, 'Samedi', '08:00:00', '10:00:00', 78, 18, 'B'),
(80, 'presentielle', 6, 'Samedi', '10:00:00', '12:00:00', 79, 20, 'C');

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
  ADD KEY `ideleve` (`ideleve`),
  ADD KEY `idcours` (`idgroupe`);

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
  MODIFY `id_eleve` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT pour la table `enseignant`
--
ALTER TABLE `enseignant`
  MODIFY `idenseignant` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `facture`
--
ALTER TABLE `facture`
  MODIFY `idfacture` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

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
  MODIFY `idséance` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

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
  ADD CONSTRAINT `séance_ibfk_2` FOREIGN KEY (`idcours`) REFERENCES `cours` (`idcours`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
