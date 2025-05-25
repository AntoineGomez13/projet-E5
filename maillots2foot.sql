-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 07 mai 2025 à 09:47
-- Version du serveur : 8.3.0
-- Version de PHP : 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `maillots2foot`
--

-- --------------------------------------------------------

--
-- Structure de la table `championnats`
--

DROP TABLE IF EXISTS `championnats`;
CREATE TABLE IF NOT EXISTS `championnats` (
  `id_championnat` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  PRIMARY KEY (`id_championnat`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `championnats`
--

INSERT INTO `championnats` (`id_championnat`, `nom`) VALUES
(1, 'Ligue 1'),
(2, 'La Liga'),
(3, 'Premier League'),
(4, 'Bundesliga'),
(5, 'Serie A');

-- --------------------------------------------------------

--
-- Structure de la table `log_maillots`
--

DROP TABLE IF EXISTS `log_maillots`;
CREATE TABLE IF NOT EXISTS `log_maillots` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_maillot` int DEFAULT NULL,
  `action_type` varchar(10) DEFAULT NULL,
  `date_action` datetime DEFAULT CURRENT_TIMESTAMP,
  `ancien_contenu` text,
  `nouveau_contenu` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `log_maillots`
--

INSERT INTO `log_maillots` (`id`, `id_maillot`, `action_type`, `date_action`, `ancien_contenu`, `nouveau_contenu`) VALUES
(5, 1, 'UPDATE', '2025-05-07 08:42:44', 'Stock: 42, Prix: 86.99', 'Stock: 43, Prix: 86.99'),
(6, 1, 'UPDATE', '2025-05-07 08:49:27', 'Stock: 43, Prix: 86.99', 'Stock: 44, Prix: 86.99'),
(7, 1, 'UPDATE', '2025-05-07 09:12:02', 'Stock: 44, Prix: 86.99', 'Stock: 45, Prix: 86.99'),
(8, 1, 'UPDATE', '2025-05-07 09:41:37', 'Stock: 45, Prix: 86.99', 'Stock: 46, Prix: 86.99');

-- --------------------------------------------------------

--
-- Structure de la table `maillots`
--

DROP TABLE IF EXISTS `maillots`;
CREATE TABLE IF NOT EXISTS `maillots` (
  `id_maillot` int NOT NULL AUTO_INCREMENT,
  `nom_equipe` varchar(100) NOT NULL,
  `id_championnat` int DEFAULT NULL,
  `id_pays` int DEFAULT NULL,
  `prix` decimal(10,2) NOT NULL,
  `taille_disponible` varchar(50) NOT NULL,
  `lien_image` text NOT NULL,
  `stock` int NOT NULL,
  PRIMARY KEY (`id_maillot`),
  KEY `id_championnat` (`id_championnat`),
  KEY `id_pays` (`id_pays`)
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `maillots`
--

INSERT INTO `maillots` (`id_maillot`, `nom_equipe`, `id_championnat`, `id_pays`, `prix`, `taille_disponible`, `lien_image`, `stock`) VALUES
(1, 'Monaco', 1, 6, 86.99, 'S,M,L,XL', 'https://shop.asmonaco.com/cdn/shop/files/351N3VW_A13_1_900x.jpg?v=1720075645', 46),
(2, 'Paris Saint-Germain', 1, 6, 99.99, 'S,M,L,XL', 'https://media.handball-store.fr/catalog/product/cache/image/1800x/9df78eab33525d08d6e5fb8d27136e95/n/i/nike_21848753.jpg', 50),
(3, 'Lille', 1, 6, 79.99, 'S,M,L,XL', 'https://www.foot.fr/131305-large_default/maillot-losc-domicile-2024-25.jpg', 25),
(4, 'Lyon', 1, 6, 84.99, 'S,M,L,XL', 'https://thumblr.uniid.it/product/359315/f8f81c1b8f62.jpg?width=3840&format=webp&q=75', 40),
(5, 'Lens', 1, 6, 74.99, 'S,M,L,XL', 'https://thumblr.uniid.it/product/356826/b32030e52764.jpg?width=3840&format=webp&q=75', 25),
(6, 'Marseille', 1, 6, 89.99, 'S,M,L,XL', 'https://www.foot.fr/133162-pdt_1500/maillot-om-domicile-authentique-2024-25.jpg', 50),
(7, 'Rennes', 1, 6, 69.99, 'S,M,L,XL', 'https://boutique.staderennais.com/3241-large_default/maillot-domicile-adulte-24-25.jpg', 15),
(8, 'Nice', 1, 6, 74.99, 'S,M,L,XL', 'https://boutique.ogcnice.com/media/catalog/product/cache/fb71270bb5973ecf596c8bfc818ac4da/m/a/maillot-ogc-nice-home-2024-2025-le-coq-sportif-1_18.jpg', 10),
(9, 'Athletic Bilbao', 2, 5, 74.99, 'S,M,L,XL', 'https://images.footballfanatics.com/athletic-club-bilbao/athletic-bilbao-castore-home-shirt-2024-25_ss5_p-200827566+pv-2+u-ilspzyudhxfjvrfsfg5a+v-acaczxsw0dphrvnzzhoc.jpg?_hv=2&w=900', 15),
(10, 'Atlético Madrid', 2, 5, 89.99, 'S,M,L,XL', 'https://www.foot.fr/135157-large_default/maillot-atletico-madrid-domicile-2024-25.jpg', 25),
(11, 'Barcelone', 2, 5, 99.99, 'S,M,L,XL', 'https://media.intersport.fr/is/image/intersportfr/FN8797_LJI_Q1?$produit_l$', 50),
(12, 'Real Madrid', 2, 5, 99.99, 'S,M,L,XL', 'https://media.foot-store.fr/catalog/product/cache/image/1800x/9df78eab33525d08d6e5fb8d27136e95/a/d/adidas_jx2136_1-nw121124.jpg', 40),
(13, 'Séville', 2, 5, 79.99, 'S,M,L,XL', 'https://www.foot-sport.com/cdn/shop/files/Maillot-FC-Seville-Domicile-2024-2025.jpg?v=1721390616', 20),
(14, 'Betis Séville', 2, 5, 74.99, 'S,M,L,XL', 'https://thumblr.uniid.it/product/330338/17fdd7d4c4ef.jpg?width=3840&format=webp&q=75', 10),
(15, 'Arsenal', 3, 2, 99.99, 'S,M,L,XL', 'https://www.foot.fr/130945-large_default/maillot-arsenal-domicile-2024-25.jpg', 50),
(16, 'Chelsea', 3, 2, 99.99, 'S,M,L,XL', 'https://images.footballfanatics.com/chelsea/chelsea-cup-nike-home-stadium-shirt-2024-25-with-njackson-15-printing_ss5_p-201964884+pv-2+u-ups0fai69uadmy4eefy2+v-gm2odr8j2ghmimvkkctz.jpg?_hv=2&w=900', 40),
(17, 'Manchester United', 3, 2, 99.99, 'S,M,L,XL', 'https://images.footballfanatics.com/manchester-united/manchester-united-cup-adidas-home-shirt-2024-25-with-parris-22-printing_ss5_p-201714268+pv-2+u-hp0kbhgjnouj6pd8dvhh+v-rbtw428cyyjo3tgv9dc3.jpg?_hv=2&w=900', 50),
(18, 'Manchester City', 3, 2, 99.99, 'S,M,L,XL', 'https://shop.mancity.com/dw/image/v2/BDWJ_PRD/on/demandware.static/-/Sites-master-catalog-MAN/default/dw887b23ea/images/large/701230876001_pp_01_mcfc.png?sw=1600&sh=1600&sm=fit', 60),
(19, 'Newcastle', 3, 2, 84.99, 'S,M,L,XL', 'https://static1.cdn-subsidesports.com/2/media/catalog/product/cache/38d4094f49a5c2931b615f53f1250097/a/5/a5ff0f6b8a8652d06188a2e48a0ae5fddc3e0df052720b4c5bbcff588c1dbfda.jpeg', 30),
(20, 'Tottenham', 3, 2, 89.99, 'S,M,L,XL', 'https://cdn.media.amplience.net/i/frasersdev/37868401_o?fmt=auto&upscale=false&w=767&h=767&sm=scaleFit&$h-ttl$', 35),
(21, 'Bayern Munich', 4, 1, 99.99, 'S,M,L,XL', 'https://cdn.media.amplience.net/i/frasersdev/36822708_o?fmt=auto&upscale=false&w=767&h=767&sm=scaleFit&$h-ttl$', 50),
(22, 'Bayer Leverkusen', 4, 1, 79.99, 'S,M,L,XL', 'https://www.foot-sport.com/cdn/shop/files/Maillot-Leverkusen-Domicile-2024-2025-1_992x.jpg?v=1718442911', 30),
(23, 'Dortmund', 4, 1, 89.99, 'S,M,L,XL', 'https://www.foot.fr/130902-pdt_1500/maillot-dortmund-domicile-2024-25.jpg', 40),
(24, 'Francfort', 4, 1, 74.99, 'S,M,L,XL', 'https://foot-star.com/wp-content/uploads/2024/10/Maillot-Frankfurt-Domicile-2024-2025.jpg', 20),
(25, 'RB Leipzig', 4, 1, 89.99, 'S,M,L,XL', 'https://www.foot-sport.com/cdn/shop/files/Maillot-Red-Bull-Leipzig-Domicile-2024-2025-Femme.jpg?v=1720610076', 35),
(26, 'AS Roma', 5, 4, 89.99, 'S,M,L,XL', 'https://foot-star.com/wp-content/uploads/2024/07/Maillot-AS-Roma-Domicile-2024-2025.jpg', 30),
(27, 'Atalanta', 5, 4, 79.99, 'S,M,L,XL', 'https://www.foot-sport.com/cdn/shop/files/Maillot-Atalanta-Domicile-2024-2025-1.jpg?v=1723352643', 25),
(28, 'Inter Milan', 5, 4, 99.99, 'S,M,L,XL', 'https://store.inter.it/dw/image/v2/BJBQ_PRD/on/demandware.static/-/Sites-inter-master-catalog/default/dw4de19501/images/large/24N001M0103_01.jpg?sw=1400&q=80', 50),
(29, 'Juventus', 5, 4, 99.99, 'S,M,L,XL', 'https://www.foot.fr/134872-large_default/maillot-juventus-domicile-2024-25.jpg', 40),
(30, 'Lazio Rome', 5, 4, 84.99, 'S,M,L,XL', 'https://media.foot-store.fr/catalog/product/cache/image/1800x/9df78eab33525d08d6e5fb8d27136e95/m/i/mizuno_p2gabx0704_airy-blue_1.jpg', 20),
(31, 'Milan AC', 5, 4, 99.99, 'S,M,L,XL', 'https://media.foot-store.fr/catalog/product/cache/image/1800x/9df78eab33525d08d6e5fb8d27136e95/p/u/puma_774979-01_1-nw051824.jpg', 40),
(32, 'Naples', 5, 4, 99.99, 'S,M,L,XL', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRYvI0Dryv27-4W7QaE4k2-i1e3SkVyG0jAQ&s', 35),
(33, 'Allemagne', NULL, 1, 99.99, 'S,M,L,XL', 'https://www.footcenter.fr/media/catalog/product/cache/82d5e29288185f6fc64d760e116074a6/m/a/maillot-allemagne-domicile-2024-2025202411261720316745f54f72b9b.jpg', 50),
(34, 'Angleterre', NULL, 2, 99.99, 'S,M,L,XL', 'https://thumblr.uniid.it/product/353016/f9e0a4de5f67.jpg?width=3840&format=webp&q=75', 40),
(35, 'Belgique', NULL, 3, 99.99, 'S,M,L,XL', 'https://www.footcenter.fr/media/catalog/product/cache/82d5e29288185f6fc64d760e116074a6/m/a/maillot-belgique-domicile-2024-2025-0.jpg', 30),
(36, 'Croatie', NULL, 4, 99.99, 'S,M,L,XL', 'https://xclusivejerseys.com/cdn/shop/files/Untitled_design_9_c951e2bc-d0f3-4dd1-a659-f6b92aa3ba9c.png?v=1720790529&width=416', 25),
(37, 'Espagne', NULL, 5, 99.99, 'S,M,L,XL', 'https://www.footcenter.fr/media/catalog/product/cache/82d5e29288185f6fc64d760e116074a6/m/a/maillot-espagne-domicile-2024-2025-junior202411130942566734669053673.jpg', 35),
(38, 'France', NULL, 6, 99.99, 'S,M,L,XL', 'https://www.footcenter.fr/media/catalog/product/cache/82d5e29288185f6fc64d760e116074a6/m/a/maillot-france-domicile-2024-2025-0.jpg', 50),
(39, 'Italie', NULL, 7, 99.99, 'S,M,L,XL', 'https://thumblr.uniid.it/product/332352/395608f4ea7c.jpg?width=3840&format=webp&q=75', 40),
(40, 'Pays-Bas', NULL, 8, 99.99, 'S,M,L,XL', 'https://www.footcenter.fr/media/catalog/product/cache/82d5e29288185f6fc64d760e116074a6/m/a/maillot-pays-bas-domicile-2024-2025202501021731596776bf7fa6b89.jpg', 30),
(41, 'Portugal', NULL, 9, 99.99, 'S,M,L,XL', 'https://media.foot-store.fr/catalog/product/cache/image/1800x/9df78eab33525d08d6e5fb8d27136e95/n/i/nike_fj4325-657-phsfh001.jpg', 35),
(42, 'Algérie', NULL, 10, 79.99, 'S,M,L,XL', 'https://www.foot.fr/137068-large_default/maillot-algerie-domicile-2024-25.jpg', 40),
(43, 'Maroc', NULL, 11, 79.99, 'S,M,L,XL', 'https://www.foot-sport.com/cdn/shop/files/Maillot-Maroc-Domicile-2024-2025.jpg?v=1731770124', 35),
(44, 'Côte d\'Ivoire', NULL, 12, 79.99, 'S,M,L,XL', 'https://www.foot-sport.com/cdn/shop/files/Maillot-Cote-dIvoire-Domicile-2024-2025.jpg?v=1731767573', 30),
(45, 'Argentine', NULL, 13, 99.99, 'S,M,L,XL', 'https://thumblr.uniid.it/product/332456/54af6b0dbb7f.jpg?width=3840&format=webp&q=75', 50),
(46, 'Brésil', NULL, 14, 99.99, 'S,M,L,XL', 'https://thumblr.uniid.it/product/352832/71a059d454af.jpg?width=3840&format=webp&q=75', 40),
(47, 'Uruguay', NULL, 15, 99.99, 'S,M,L,XL', 'https://www.foot-sport.com/cdn/shop/files/MAILLOT-DOMICILE-URUGUAY-BLEU-2023-2024.jpg?v=1723947951', 30);

--
-- Déclencheurs `maillots`
--
DROP TRIGGER IF EXISTS `after_update_maillots`;
DELIMITER $$
CREATE TRIGGER `after_update_maillots` AFTER UPDATE ON `maillots` FOR EACH ROW INSERT INTO log_maillots (id_maillot, action_type, ancien_contenu, nouveau_contenu) 
VALUES (OLD.id_maillot, 'UPDATE',
    CONCAT('Stock: ', OLD.stock, ', Prix: ', OLD.prix),
    CONCAT('Stock: ', NEW.stock, ', Prix: ', NEW.prix)
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `pays`
--

DROP TABLE IF EXISTS `pays`;
CREATE TABLE IF NOT EXISTS `pays` (
  `id_pays` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `continent` varchar(50) NOT NULL,
  PRIMARY KEY (`id_pays`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `pays`
--

INSERT INTO `pays` (`id_pays`, `nom`, `continent`) VALUES
(1, 'Allemagne', 'Europe'),
(2, 'Angleterre', 'Europe'),
(3, 'Belgique', 'Europe'),
(4, 'Croatie', 'Europe'),
(5, 'Espagne', 'Europe'),
(6, 'France', 'Europe'),
(7, 'Italie', 'Europe'),
(8, 'Pays-Bas', 'Europe'),
(9, 'Portugal', 'Europe'),
(10, 'Algérie', 'Afrique'),
(11, 'Maroc', 'Afrique'),
(12, 'Côte d\'Ivoire', 'Afrique'),
(13, 'Argentine', 'Amérique'),
(14, 'Brésil', 'Amérique'),
(15, 'Uruguay', 'Amérique');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `password`) VALUES
(6, 'antoine@antoine.com', '$2b$10$w1aUGdNanPTDcmZHg/cHdeSHipcyeIP7Ad/9FKkPQNed87JeVKPGe'),
(5, 'maxime@maxime.com', '$2b$10$FiFMki2QcQEtJylZor.mpuf7gy3SI.EmFnmB7aabS93.KnNi7banW'),
(7, 'sousou@sousou.com', '$2b$10$FPm2rhT6mJOdIPLCPEu2KeWnoIN.DjIwikwNDNF.6D/HlBsBBvjHu');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
