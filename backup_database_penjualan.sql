/*
SQLyog Community v13.3.1 (64 bit)
MySQL - 10.11.16-MariaDB : Database - penjualan produk(yoseph)
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`penjualan produk(yoseph)` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `penjualan produk(yoseph)`;

/*Table structure for table `photoproduk` */

DROP TABLE IF EXISTS `photoproduk`;

CREATE TABLE `photoproduk` (
  `id_photo` int(11) NOT NULL AUTO_INCREMENT,
  `kodebarang` varchar(10) NOT NULL,
  `nama_file` varchar(150) NOT NULL,
  `is_cover` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id_photo`),
  KEY `kodebarang` (`kodebarang`),
  CONSTRAINT `photoproduk_ibfk_1` FOREIGN KEY (`kodebarang`) REFERENCES `stokbarang` (`kodebarang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `photoproduk` */

insert  into `photoproduk`(`id_photo`,`kodebarang`,`nama_file`,`is_cover`) values 
(1,'BRG01','flanel_depan.jpg',1),
(2,'BRG01','flanel_belakang.jpg',0),
(3,'BRG02','chino_cream.jpg',1),
(4,'BRG03','sneakers_putih.jpg',1),
(5,'BRG04','ransel_hitam.jpg',1),
(6,'BRG05','topi_navy.jpg',1),
(7,'BRG01','flanel_depan.jpg',1),
(8,'BRG01','flanel_belakang.jpg',0),
(9,'BRG02','chino_cream.jpg',1),
(10,'BRG03','sneakers_putih.jpg',1),
(11,'BRG04','ransel_hitam.jpg',1),
(12,'BRG05','topi_navy.jpg',1);

/*Table structure for table `stokbarang` */

DROP TABLE IF EXISTS `stokbarang`;

CREATE TABLE `stokbarang` (
  `kodebarang` varchar(10) NOT NULL,
  `namabarang` varchar(100) NOT NULL,
  `hargabeli` int(11) NOT NULL,
  `hargajual` int(11) NOT NULL,
  `stok` int(11) NOT NULL,
  PRIMARY KEY (`kodebarang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `stokbarang` */

insert  into `stokbarang`(`kodebarang`,`namabarang`,`hargabeli`,`hargajual`,`stok`) values 
('BRG01','Kemeja Flanel Pria',85000,135000,25),
('BRG02','Celana Chino Slimfit',110000,175000,18),
('BRG03','Sepatu Sneakers Kanvas',150000,240000,12),
('BRG04','Tas Ransel Laptop',120000,195000,15),
('BRG05','Topi Baseball Polos',25000,50000,40);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
