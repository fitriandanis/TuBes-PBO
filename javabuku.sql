-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 17, 2019 at 05:36 AM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `javabuku`
--

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `kd_buku` varchar(10) NOT NULL,
  `judul` varchar(50) NOT NULL,
  `jenis` varchar(10) NOT NULL,
  `penulis` varchar(50) NOT NULL,
  `penerbit` varchar(50) NOT NULL,
  `tahun` varchar(4) NOT NULL,
  `stok` int(3) NOT NULL,
  `harga_pokok` int(5) NOT NULL,
  `harga_jual` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`kd_buku`, `judul`, `jenis`, `penulis`, `penerbit`, `tahun`, `stok`, `harga_pokok`, `harga_jual`) VALUES
('K0001', 'Berjuta Rasanya', 'Novel', 'Tere Liye', 'Tere Liye', '2014', 10, 80000, 90000),
('K0002', 'Buku Sakti Pemrograman Web Seri PHP', 'Tutorial', 'Mundzir Mf', 'Start Up', '2018', 16, 45000, 50000),
('K0003', 'MCI', 'Novel', 'Asma Nadia', 'Asma Nadia', '2010', 20, 100000, 150000),
('K0004', 'The Power Of Water', 'Edukasi', 'Masaru Emoto', 'Fiky Barokah', '2006', 50, 50000, 60000),
('K0005', 'Kamus Bahasa Inggris Indonesia', 'Edukasi', 'John M Echols & Hassan Shadily', 'PT. Gramedia Pustaka Utama', '2005', 50, 50000, 60000);

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `nama` varchar(20) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`nama`, `username`, `password`) VALUES
('Zhafari Irsyad', 'admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `kd_pelanggan` varchar(10) NOT NULL,
  `nama_pelanggan` varchar(50) NOT NULL,
  `jenis_kelamin` varchar(1) NOT NULL,
  `alamat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`kd_pelanggan`, `nama_pelanggan`, `jenis_kelamin`, `alamat`) VALUES
('PL0001', 'Erza Okta', 'L', 'Serang'),
('PL0002', 'Ananda Desfithania Sari', 'P', 'Serang'),
('PL0003', 'Bayu Aji Herlambang', 'L', 'Serang'),
('PL0004', 'Eko Teguh', 'L', 'Cilegon');

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE `penjualan` (
  `kd_pretransaksi` varchar(10) NOT NULL,
  `kd_transaksi` varchar(10) NOT NULL,
  `kd_pelanggan` varchar(10) NOT NULL,
  `kd_buku` varchar(10) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `sub_total` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `penjualan`
--

INSERT INTO `penjualan` (`kd_pretransaksi`, `kd_transaksi`, `kd_pelanggan`, `kd_buku`, `jumlah`, `sub_total`) VALUES
('PS0001', 'TR0001', 'PL0003', 'K0002', 4, 200000);

--
-- Triggers `penjualan`
--
DELIMITER $$
CREATE TRIGGER `BELI` AFTER INSERT ON `penjualan` FOR EACH ROW UPDATE buku SET
buku.stok = buku.stok - NEW.jumlah WHERE buku.kd_buku = NEW.kd_buku
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Batal` AFTER DELETE ON `penjualan` FOR EACH ROW UPDATE buku
SET stok = stok + OLD.jumlah
WHERE
kd_buku = OLD.kd_buku
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `penjualan2`
--

CREATE TABLE `penjualan2` (
  `kd_transaksi` varchar(10) NOT NULL,
  `nama_pelanggan` varchar(50) NOT NULL,
  `total` int(50) NOT NULL,
  `tanggal_beli` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `penjualan2`
--

INSERT INTO `penjualan2` (`kd_transaksi`, `nama_pelanggan`, `total`, `tanggal_beli`) VALUES
('TR0001', 'Bayu Aji Herlambang', 200000, '2019-12-17 04:32:07');

-- --------------------------------------------------------

--
-- Stand-in structure for view `perbulan`
-- (See below for the actual view)
--
CREATE TABLE `perbulan` (
`kd_buku` varchar(10)
,`judul` varchar(50)
,`jenis` varchar(10)
,`jumlah` int(11)
,`tanggal_beli` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `struk`
-- (See below for the actual view)
--
CREATE TABLE `struk` (
`nama_pelanggan` varchar(50)
,`total` int(50)
,`tanggal_beli` timestamp
,`kd_transaksi` varchar(10)
,`jumlah` int(11)
,`sub_total` int(20)
,`judul` varchar(50)
);

-- --------------------------------------------------------

--
-- Structure for view `perbulan`
--
DROP TABLE IF EXISTS `perbulan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `perbulan`  AS  select `buku`.`kd_buku` AS `kd_buku`,`buku`.`judul` AS `judul`,`buku`.`jenis` AS `jenis`,`penjualan`.`jumlah` AS `jumlah`,`penjualan2`.`tanggal_beli` AS `tanggal_beli` from ((`buku` join `penjualan` on(`buku`.`kd_buku` = `penjualan`.`kd_buku`)) join `penjualan2` on(`buku`.`kd_buku` = `penjualan`.`kd_buku`)) ;

-- --------------------------------------------------------

--
-- Structure for view `struk`
--
DROP TABLE IF EXISTS `struk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `struk`  AS  select `penjualan2`.`nama_pelanggan` AS `nama_pelanggan`,`penjualan2`.`total` AS `total`,`penjualan2`.`tanggal_beli` AS `tanggal_beli`,`penjualan`.`kd_transaksi` AS `kd_transaksi`,`penjualan`.`jumlah` AS `jumlah`,`penjualan`.`sub_total` AS `sub_total`,`buku`.`judul` AS `judul` from ((`penjualan2` join `penjualan` on(`penjualan2`.`kd_transaksi` = `penjualan`.`kd_transaksi`)) join `buku` on(`penjualan`.`kd_buku` = `buku`.`kd_buku`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`kd_buku`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`kd_pelanggan`);

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`kd_pretransaksi`);

--
-- Indexes for table `penjualan2`
--
ALTER TABLE `penjualan2`
  ADD PRIMARY KEY (`kd_transaksi`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
