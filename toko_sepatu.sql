/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 10.4.24-MariaDB : Database - toko_sepatu
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`toko_sepatu` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `toko_sepatu`;

/*Table structure for table `detail_bayar` */

DROP TABLE IF EXISTS `detail_bayar`;

CREATE TABLE `detail_bayar` (
  `id_detail` int(20) NOT NULL AUTO_INCREMENT,
  `id_sepatu` int(20) NOT NULL,
  `jumlah_beli` int(20) NOT NULL,
  PRIMARY KEY (`id_detail`),
  KEY `get_Id_sepatu` (`id_sepatu`),
  CONSTRAINT `get_Id_sepatu` FOREIGN KEY (`id_sepatu`) REFERENCES `sepatu` (`id_sepatu`)
) ENGINE=InnoDB AUTO_INCREMENT=1006 DEFAULT CHARSET=utf8mb4;

/*Data for the table `detail_bayar` */

insert  into `detail_bayar`(`id_detail`,`id_sepatu`,`jumlah_beli`) values 
(201,101,3),
(202,102,6),
(203,103,5),
(204,106,6),
(205,101,10),
(206,105,2);

/*Table structure for table `header_bayar` */

DROP TABLE IF EXISTS `header_bayar`;

CREATE TABLE `header_bayar` (
  `no_nota` varchar(20) NOT NULL,
  `tanggal` date NOT NULL,
  `id_detail` int(20) NOT NULL,
  `total_pembelian` int(20) NOT NULL,
  `bayar` int(20) NOT NULL,
  `sisa_bayar` int(20) NOT NULL,
  PRIMARY KEY (`no_nota`),
  KEY `get_detail` (`id_detail`),
  CONSTRAINT `get_detail` FOREIGN KEY (`id_detail`) REFERENCES `detail_bayar` (`id_detail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `header_bayar` */

insert  into `header_bayar`(`no_nota`,`tanggal`,`id_detail`,`total_pembelian`,`bayar`,`sisa_bayar`) values 
('200523','2023-05-20',205,700000,900000,200000),
('50423','2023-04-05',201,450000,700000,250000),
('70423','2023-04-07',205,700000,1000000,300000);

/*Table structure for table `merk` */

DROP TABLE IF EXISTS `merk`;

CREATE TABLE `merk` (
  `id_merk` int(20) NOT NULL AUTO_INCREMENT,
  `nama_merk` varchar(30) NOT NULL,
  `model_sepatu` varchar(30) NOT NULL,
  PRIMARY KEY (`id_merk`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4;

/*Data for the table `merk` */

insert  into `merk`(`id_merk`,`nama_merk`,`model_sepatu`) values 
(1,'Nike','Sport'),
(2,'New Balance','Casual'),
(3,'Adidas','Sport'),
(4,'Puma','Sport'),
(5,'Patrobas','Casual'),
(6,'Aerostreet','Sneakers'),
(7,'Ventella','Casual'),
(8,'Ortis','Sport'),
(9,'Vantovel','Casual');

/*Table structure for table `sepatu` */

DROP TABLE IF EXISTS `sepatu`;

CREATE TABLE `sepatu` (
  `id_sepatu` int(20) NOT NULL AUTO_INCREMENT,
  `id_merk` int(20) NOT NULL,
  `ukuran` int(20) NOT NULL,
  `warna` varchar(30) NOT NULL,
  `harga` int(20) NOT NULL,
  `stok` int(20) NOT NULL,
  PRIMARY KEY (`id_sepatu`),
  KEY `get_merk` (`id_merk`),
  CONSTRAINT `get_merk` FOREIGN KEY (`id_merk`) REFERENCES `merk` (`id_merk`)
) ENGINE=InnoDB AUTO_INCREMENT=1126 DEFAULT CHARSET=utf8mb4;

/*Data for the table `sepatu` */

insert  into `sepatu`(`id_sepatu`,`id_merk`,`ukuran`,`warna`,`harga`,`stok`) values 
(101,1,41,'Navy',100000,2),
(102,2,39,'Hitam',80000,4),
(103,3,41,'Putih',150000,3),
(104,4,42,'Hitam',100000,1),
(105,5,40,'Merah',250000,12),
(106,6,41,'Hitam',200000,9);

/* Trigger structure for table `detail_bayar` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `EditStok` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `EditStok` AFTER INSERT ON `detail_bayar` FOR EACH ROW BEGIN
	UPDATE sepatu SET stok = stok - NEW.jumlah_beli WHERE id_sepatu = NEW.id_sepatu;
	
    END */$$


DELIMITER ;

/* Trigger structure for table `detail_bayar` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tambahStok` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `tambahStok` AFTER UPDATE ON `detail_bayar` FOR EACH ROW BEGIN
UPDATE sepatu SET stok = stok + (OLD.jumlah_beli - new.jumlah_beli) WHERE id_sepatu = OLD.id_sepatu;
    END */$$


DELIMITER ;

/* Trigger structure for table `detail_bayar` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `ReturnStok` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `ReturnStok` AFTER DELETE ON `detail_bayar` FOR EACH ROW BEGIN
    UPDATE sepatu SET stok = stok + OLD.jumlah_beli WHERE id_sepatu = OLD.id_sepatu;
    END */$$


DELIMITER ;

/* Trigger structure for table `header_bayar` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `Diskon` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `Diskon` BEFORE INSERT ON `header_bayar` FOR EACH ROW BEGIN
    DECLARE total_pembelian DOUBLE;
	DECLARE diskon DOUBLE;
	
	SET total_pembelian = NEW.total_pembelian;
	
	IF total_pembelian > 250000 and total_pembelian < 500000 THEN
		SET diskon = total_pembelian * 0.1;
		SET NEW.total_pembelian = total_pembelian - diskon;
		
	elseIF total_pembelian > 500000 THEN
		SET diskon = total_pembelian * 0.3;
		SET NEW.total_pembelian = total_pembelian - diskon;
		
	END IF;
	
	SET NEW.sisa_bayar = NEW.bayar - NEW.total_pembelian;
    END */$$


DELIMITER ;

/* Trigger structure for table `header_bayar` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `hapus_detail` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `hapus_detail` AFTER DELETE ON `header_bayar` FOR EACH ROW BEGIN
	DELETE FROM detail_bayar WHERE id_detail = old.id_detail;
    END */$$


DELIMITER ;

/* Trigger structure for table `merk` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `hapus_sepatu` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `hapus_sepatu` BEFORE DELETE ON `merk` FOR EACH ROW BEGIN
    DELETE FROM header_bayar WHERE id_detail in (select id_detail from detail_bayar where id_sepatu in (select id_sepatu from sepatu where id_merk = OLD.id_merk));
    delete from detail_bayar where id_sepatu in (select id_sepatu from sepatu where id_merk = OLD.id_merk);
    delete from sepatu where id_merk = OLD.id_merk;
    
    
     
    END */$$


DELIMITER ;

/* Function  structure for function  `buat_noNota` */

/*!50003 DROP FUNCTION IF EXISTS `buat_noNota` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `buat_noNota`(nota char, new_tgl DATE) RETURNS char(10) CHARSET utf8mb4
BEGIN
    DECLARE note INT(11);
    DECLARE tempTahun CHAR(2);
    DECLARE tempBulan CHAR(2);
    DECLARE tempTgl CHAR(2);
    
    set tempTahun= substring(new_tgl, 3, 2);
    SET tempBulan= SUBSTRING(new_tgl, 6, 2);
    SET tempTgl= SUBSTRING(new_tgl, 9, 2);
    return concat(tempTgl, tempBulan, tempTahun);
   
END */$$
DELIMITER ;

/* Function  structure for function  `laporan_pemasukan` */

/*!50003 DROP FUNCTION IF EXISTS `laporan_pemasukan` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `laporan_pemasukan`(tanggal DATE) RETURNS text CHARSET utf8mb4
BEGIN
    DECLARE output TEXT;
    SELECT CONCAT_WS('\n',' Tanggal   No_Nota   Merek  Total', GROUP_CONCAT(CONCAT_WS
    (' ',tanggal,' ', no_nota,'   ', nama_merk,'  ', total_pembelian) SEPARATOR '\n'))
    INTO output
    FROM (
        SELECT tanggal, no_nota, nama_merk, SUM(harga * jumlah_beli) AS total_pembelian
        FROM header_bayar
        INNER JOIN detail_bayar ON header_bayar.id_detail = detail_bayar.id_detail
        INNER JOIN sepatu ON detail_bayar.id_sepatu = sepatu.id_sepatu
        INNER JOIN merk ON sepatu.id_merk = merk.id_merk
        WHERE tanggal = tanggal
        GROUP BY no_nota, nama_merk
    ) AS laporan;
    RETURN output;
END */$$
DELIMITER ;

/* Procedure structure for procedure `delete_detailBayar` */

/*!50003 DROP PROCEDURE IF EXISTS  `delete_detailBayar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_detailBayar`(id_detailBayar int(11))
BEGIN
	delete from detail_bayar where id_detailBayar = id_detail;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `delete_headerBayar` */

/*!50003 DROP PROCEDURE IF EXISTS  `delete_headerBayar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_headerBayar`(id_header int(11))
BEGIN
	delete from header_bayar where id_header = no_nota;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `delete_merk` */

/*!50003 DROP PROCEDURE IF EXISTS  `delete_merk` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_merk`(id_brand int(11))
BEGIN
	delete from merk where id_brand = id_merk;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `delete_sepatu` */

/*!50003 DROP PROCEDURE IF EXISTS  `delete_sepatu` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_sepatu`(id_shoes int(11))
BEGIN
	delete from sepatu where id_shoes = id_sepatu;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `HitungTotalManajemen` */

/*!50003 DROP PROCEDURE IF EXISTS  `HitungTotalManajemen` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `HitungTotalManajemen`()
BEGIN
	START TRANSACTION;
	SELECT SUM(total_pembelian) AS 'Total Pembelian' FROM header_bayar ;
	COMMIT;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `HitungTotalPembelian` */

/*!50003 DROP PROCEDURE IF EXISTS  `HitungTotalPembelian` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `HitungTotalPembelian`()
BEGIN
	select sum(total_pembelian) as 'Total Pembelian' FROM header_bayar ;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `hitung_total_beli` */

/*!50003 DROP PROCEDURE IF EXISTS  `hitung_total_beli` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `hitung_total_beli`()
BEGIN
	select count(no_nota) as 'Total Seluruh Transaksi' from header_bayar; 
	END */$$
DELIMITER ;

/* Procedure structure for procedure `insertHeader` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertHeader` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insertHeader`(no_nota int, tanggal date, id_detail int, bayar int)
BEGIN
	declare total_pembelian int;
	set total_pembelian =(select(s.harga * db.jumlah_beli) from sepatu as s
	inner join detail_bayar as db on db.id_sepatu = s.id_sepatu
	where db.id_detail = id_detail);
	
	insert into header_bayar values (no_nota, tanggal, id_detail, total_pembelian, bayar, (bayar-total_pembelian));
	END */$$
DELIMITER ;

/* Procedure structure for procedure `insert_detailBayar` */

/*!50003 DROP PROCEDURE IF EXISTS  `insert_detailBayar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_detailBayar`(
    id_detail int(11),
    id_sepatu int(11),
    jumlah_beli int(11)
    )
BEGIN
	insert into detail_bayar values (id_detail, id_sepatu, jumlah_beli);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `insert_headerBayar` */

/*!50003 DROP PROCEDURE IF EXISTS  `insert_headerBayar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_headerBayar`(no_nota int(20), tanggal date, id_detail int(20), bayar int(20))
BEGIN
	declare total_pembelian int;
	set total_pembelian =(select(s.harga * db.jumlah_beli) from sepatu as s
	inner join detail_bayar as db on db.id_sepatu = s.id_sepatu
	where db.id_detail = id_detail);
	
	insert into header_bayar values (no_nota, tanggal, id_detail, total_pembelian, bayar, (bayar-total_pembelian));
	END */$$
DELIMITER ;

/* Procedure structure for procedure `insert_merk` */

/*!50003 DROP PROCEDURE IF EXISTS  `insert_merk` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_merk`(
    id_merk int(11), 
    nama_merk varchar(30), 
    model_sepatu varchar(30)
    )
BEGIN
	insert into merk values(id_merk, nama_merk, model_sepatu);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `insert_sepatu` */

/*!50003 DROP PROCEDURE IF EXISTS  `insert_sepatu` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_sepatu`(
    id_sepatu INT(11),
    id_merk INT(11),
    ukuran INT(11),
    warna VARCHAR(30),
    harga INT(11),
    stok INT(11)
    )
BEGIN
	insert into sepatu values (id_sepatu, id_merk, ukuran, warna, harga, stok);
	END */$$
DELIMITER ;

/* Procedure structure for procedure `max_harga` */

/*!50003 DROP PROCEDURE IF EXISTS  `max_harga` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `max_harga`()
BEGIN
	SELECT m.nama_merk, m.model_sepatu, MAX(s.harga) AS harga
	FROM merk m
	JOIN sepatu s ON m.id_merk = s.id_merk
	GROUP BY m.nama_merk
	ORDER BY harga DESC
	LIMIT 1;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `min_harga` */

/*!50003 DROP PROCEDURE IF EXISTS  `min_harga` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `min_harga`()
BEGIN
	SELECT m.nama_merk, m.model_sepatu, MIN(s.harga) AS harga
	FROM merk m
	JOIN sepatu s ON m.id_merk = s.id_merk
	GROUP BY m.nama_merk
	ORDER BY harga
	LIMIT 1;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `most_merk` */

/*!50003 DROP PROCEDURE IF EXISTS  `most_merk` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `most_merk`()
BEGIN
SELECT m.nama_merk, m.model_sepatu, s.harga, max(db.jumlah_beli) AS jumlah_beli
FROM merk m
JOIN sepatu s ON m.id_merk = s.id_merk
JOIN detail_bayar db ON s.id_sepatu = db.id_sepatu
GROUP BY m.nama_merk
ORDER BY jumlah_beli DESC
LIMIT 1;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `updateHeader` */

/*!50003 DROP PROCEDURE IF EXISTS  `updateHeader` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `updateHeader`(up_no_nota VARCHAR(255), new_total_pembelian DOUBLE, 
new_bayar DOUBLE, new_sisa_bayar DOUBLE)
BEGIN
		UPDATE header_bayar
		SET total_pembelian = new_total_pembelian WHERE no_nota = up_no_nota;
		UPDATE header_bayar
		SET bayar = new_bayar WHERE no_nota = up_no_nota;
		UPDATE header_bayar
		SET sisa_bayar = new_sisa_bayar WHERE no_nota = up_no_nota;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `update_detail` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_detail` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `update_detail`(idDetail int,idSepatu int,jumlahBeli int)
BEGIN
	UPDATE detail_bayar SET
	id_detail = idDetail,
	id_sepatu = idSepatu,
	jumlah_beli = jumlahBeli
	WHERE idDetail = id_detail;
END */$$
DELIMITER ;

/* Procedure structure for procedure `update_headerBayar` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_headerBayar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `update_headerBayar`(
    in no_note int(11), in tgl date, in total int(11), in pay int(11)  
    )
BEGIN
	
	update header_bayar set
	tanggal = tgl,
	total_pembelian = total,
	bayar = pay,
	sisa_bayar = (bayar - total_pembelian)
	where no_nota = no_note;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `update_merk` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_merk` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `update_merk`(id_merkBaru int, nama_merkBaru varchar(30), model_sepatuBaru varchar(30))
BEGIN
	update merk set
	id_merk = id_merkBaru,
	nama_merk = nama_merkBaru,
	model_sepatu = model_sepatuBaru where id_merk = id_merkBaru;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `update_sepatu` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_sepatu` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `update_sepatu`(in id_sepatuBaru int(11), 
    in ukuranBaru int(11), in warnaBaru varchar(30), in hargaBaru int(11),
    in stokBaru int(11)
    )
BEGIN
	update sepatu set ukuran = ukuranBaru,
	warna = warnaBaru, harga = hargaBaru, stok = stokBaru
	where id_sepatu = id_sepatuBaru;
	END */$$
DELIMITER ;

/*Table structure for table `daftar_merk` */

DROP TABLE IF EXISTS `daftar_merk`;

/*!50001 DROP VIEW IF EXISTS `daftar_merk` */;
/*!50001 DROP TABLE IF EXISTS `daftar_merk` */;

/*!50001 CREATE TABLE  `daftar_merk`(
 `nama_merk` varchar(30) 
)*/;

/*Table structure for table `pemasukan_harian` */

DROP TABLE IF EXISTS `pemasukan_harian`;

/*!50001 DROP VIEW IF EXISTS `pemasukan_harian` */;
/*!50001 DROP TABLE IF EXISTS `pemasukan_harian` */;

/*!50001 CREATE TABLE  `pemasukan_harian`(
 `No Nota` varchar(20) ,
 `Tanggal` date ,
 `Total Pembelian` decimal(41,0) 
)*/;

/*Table structure for table `sepatu_patroba` */

DROP TABLE IF EXISTS `sepatu_patroba`;

/*!50001 DROP VIEW IF EXISTS `sepatu_patroba` */;
/*!50001 DROP TABLE IF EXISTS `sepatu_patroba` */;

/*!50001 CREATE TABLE  `sepatu_patroba`(
 `Nama` varchar(30) ,
 `Model` varchar(30) 
)*/;

/*Table structure for table `sepatu_puma` */

DROP TABLE IF EXISTS `sepatu_puma`;

/*!50001 DROP VIEW IF EXISTS `sepatu_puma` */;
/*!50001 DROP TABLE IF EXISTS `sepatu_puma` */;

/*!50001 CREATE TABLE  `sepatu_puma`(
 `Nama` varchar(30) ,
 `Model` varchar(30) ,
 `Ukuran` int(20) ,
 `Warna` varchar(30) ,
 `Harga` int(20) 
)*/;

/*Table structure for table `view_db` */

DROP TABLE IF EXISTS `view_db`;

/*!50001 DROP VIEW IF EXISTS `view_db` */;
/*!50001 DROP TABLE IF EXISTS `view_db` */;

/*!50001 CREATE TABLE  `view_db`(
 `id_detail` int(20) ,
 `id_sepatu` int(20) ,
 `jumlah_beli` int(20) 
)*/;

/*Table structure for table `view_hb` */

DROP TABLE IF EXISTS `view_hb`;

/*!50001 DROP VIEW IF EXISTS `view_hb` */;
/*!50001 DROP TABLE IF EXISTS `view_hb` */;

/*!50001 CREATE TABLE  `view_hb`(
 `no_nota` varchar(20) ,
 `tanggal` date ,
 `id_detail` int(20) ,
 `total_pembelian` int(20) ,
 `bayar` int(20) ,
 `sisa_bayar` int(20) 
)*/;

/*Table structure for table `view_merk` */

DROP TABLE IF EXISTS `view_merk`;

/*!50001 DROP VIEW IF EXISTS `view_merk` */;
/*!50001 DROP TABLE IF EXISTS `view_merk` */;

/*!50001 CREATE TABLE  `view_merk`(
 `id_merk` int(20) ,
 `nama_merk` varchar(30) ,
 `model_sepatu` varchar(30) 
)*/;

/*Table structure for table `view_sepatu` */

DROP TABLE IF EXISTS `view_sepatu`;

/*!50001 DROP VIEW IF EXISTS `view_sepatu` */;
/*!50001 DROP TABLE IF EXISTS `view_sepatu` */;

/*!50001 CREATE TABLE  `view_sepatu`(
 `id_sepatu` int(20) ,
 `id_merk` int(20) ,
 `ukuran` int(20) ,
 `warna` varchar(30) ,
 `harga` int(20) ,
 `stok` int(20) 
)*/;

/*View structure for view daftar_merk */

/*!50001 DROP TABLE IF EXISTS `daftar_merk` */;
/*!50001 DROP VIEW IF EXISTS `daftar_merk` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `daftar_merk` AS (select distinct `merk`.`nama_merk` AS `nama_merk` from `merk`) */;

/*View structure for view pemasukan_harian */

/*!50001 DROP TABLE IF EXISTS `pemasukan_harian` */;
/*!50001 DROP VIEW IF EXISTS `pemasukan_harian` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pemasukan_harian` AS (select `header_bayar`.`no_nota` AS `No Nota`,`header_bayar`.`tanggal` AS `Tanggal`,sum(`header_bayar`.`total_pembelian`) AS `Total Pembelian` from `header_bayar` group by `header_bayar`.`tanggal`) */;

/*View structure for view sepatu_patroba */

/*!50001 DROP TABLE IF EXISTS `sepatu_patroba` */;
/*!50001 DROP VIEW IF EXISTS `sepatu_patroba` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sepatu_patroba` AS (select `merk`.`nama_merk` AS `Nama`,`merk`.`model_sepatu` AS `Model` from `merk` where `merk`.`nama_merk` = 'Patrobas') */;

/*View structure for view sepatu_puma */

/*!50001 DROP TABLE IF EXISTS `sepatu_puma` */;
/*!50001 DROP VIEW IF EXISTS `sepatu_puma` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sepatu_puma` AS (select `m`.`nama_merk` AS `Nama`,`m`.`model_sepatu` AS `Model`,`s`.`ukuran` AS `Ukuran`,`s`.`warna` AS `Warna`,`s`.`harga` AS `Harga` from (`merk` `m` join `sepatu` `s` on(`m`.`id_merk` = `s`.`id_merk`)) where `m`.`nama_merk` = 'Puma') */;

/*View structure for view view_db */

/*!50001 DROP TABLE IF EXISTS `view_db` */;
/*!50001 DROP VIEW IF EXISTS `view_db` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_db` AS (select `detail_bayar`.`id_detail` AS `id_detail`,`detail_bayar`.`id_sepatu` AS `id_sepatu`,`detail_bayar`.`jumlah_beli` AS `jumlah_beli` from `detail_bayar`) */;

/*View structure for view view_hb */

/*!50001 DROP TABLE IF EXISTS `view_hb` */;
/*!50001 DROP VIEW IF EXISTS `view_hb` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_hb` AS (select `header_bayar`.`no_nota` AS `no_nota`,`header_bayar`.`tanggal` AS `tanggal`,`header_bayar`.`id_detail` AS `id_detail`,`header_bayar`.`total_pembelian` AS `total_pembelian`,`header_bayar`.`bayar` AS `bayar`,`header_bayar`.`sisa_bayar` AS `sisa_bayar` from `header_bayar`) */;

/*View structure for view view_merk */

/*!50001 DROP TABLE IF EXISTS `view_merk` */;
/*!50001 DROP VIEW IF EXISTS `view_merk` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_merk` AS (select `merk`.`id_merk` AS `id_merk`,`merk`.`nama_merk` AS `nama_merk`,`merk`.`model_sepatu` AS `model_sepatu` from `merk`) */;

/*View structure for view view_sepatu */

/*!50001 DROP TABLE IF EXISTS `view_sepatu` */;
/*!50001 DROP VIEW IF EXISTS `view_sepatu` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_sepatu` AS (select `sepatu`.`id_sepatu` AS `id_sepatu`,`sepatu`.`id_merk` AS `id_merk`,`sepatu`.`ukuran` AS `ukuran`,`sepatu`.`warna` AS `warna`,`sepatu`.`harga` AS `harga`,`sepatu`.`stok` AS `stok` from `sepatu`) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
