-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 27 Sep 2022 pada 08.42
-- Versi server: 10.1.36-MariaDB
-- Versi PHP: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `appstock`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `id_barang` int(11) NOT NULL,
  `kode_barang` varchar(10) DEFAULT NULL,
  `nama_barang` varchar(50) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL,
  `jumlah` int(5) DEFAULT NULL,
  `foto_barang` varchar(100) DEFAULT NULL,
  `id_jenis` int(11) DEFAULT NULL,
  `id_merk` int(11) DEFAULT NULL,
  `kode_supplier` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`id_barang`, `kode_barang`, `nama_barang`, `harga`, `jumlah`, `foto_barang`, `id_jenis`, `id_merk`, `kode_supplier`) VALUES
(2, 'BRG0002', 'Mesin', 3000000, 2, 'barang_1526268105.jpg', 1, 1, 'sp002'),
(3, 'BRG0003', 'Knalpot', 500000, 4, 'barang_1526268446.jpg', 1, 1, 'sp002'),
(4, 'BRG0004', 'Lampu Sen', 20000, 3, 'barang_1526268494.jpg', 1, 1, 'sp002'),
(5, 'BRG0005', 'Oli Mesin', 50000, 20, 'barang_1526268525.png', 1, 1, 'sp001'),
(6, 'BRG0006', 'Xiaomi', 1000, 20, 'barang_1610708734', 4, 1, 'sp001'),
(7, 'BRG0007', 'amri', 10, 20, 'barang_1610712089', 3, 2, 'sp003'),
(8, 'BRG0008', 'suprime', 1000, 5012, 'barang_1644128755', 1, 1, 'sp001'),
(9, 'DCM0009', 'suprime', 1000, 5012, 'barang_1646402085', 2, 1, 'sp001'),
(10, 'DCM0010', 'frrdi', 1000, 5012, 'barang_1646402590', 2, 1, 'sp001');

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_keluar`
--

CREATE TABLE `barang_keluar` (
  `id_barang_keluar` int(11) NOT NULL,
  `kode_barang` varchar(20) DEFAULT NULL,
  `tgl_keluar` date DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `barang_keluar`
--

INSERT INTO `barang_keluar` (`id_barang_keluar`, `kode_barang`, `tgl_keluar`, `jumlah`) VALUES
(1, 'BRG0003', '2018-12-31', 7),
(2, 'BRG0002', '2018-12-31', 5),
(3, 'BRG0005', '2020-12-29', 11),
(4, 'BRG0005', '2021-01-15', 10),
(5, 'BRG0005', '2021-01-15', 20);

--
-- Trigger `barang_keluar`
--
DELIMITER $$
CREATE TRIGGER `KELUAR` BEFORE INSERT ON `barang_keluar` FOR EACH ROW BEGIN
UPDATE barang SET jumlah = jumlah - new.jumlah
WHERE kode_barang = new.kode_barang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_masuk`
--

CREATE TABLE `barang_masuk` (
  `id_barang_masuk` int(11) NOT NULL,
  `kode_barang` varchar(10) DEFAULT NULL,
  `kode_supplier` varchar(10) DEFAULT NULL,
  `jumlah` int(3) DEFAULT NULL,
  `harga` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `barang_masuk`
--

INSERT INTO `barang_masuk` (`id_barang_masuk`, `kode_barang`, `kode_supplier`, `jumlah`, `harga`) VALUES
(4, 'BRG0005', 'sp001', 11, 10),
(6, 'BRG0006', 'sp001', 10, 1000),
(7, 'BRG0007', 'sp003', 10, 10);

--
-- Trigger `barang_masuk`
--
DELIMITER $$
CREATE TRIGGER `MASUK` AFTER INSERT ON `barang_masuk` FOR EACH ROW BEGIN
UPDATE barang SET jumlah = jumlah + new.jumlah
WHERE kode_barang = new.kode_barang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_transaksi`
--

CREATE TABLE `detail_transaksi` (
  `kode_transaksi` varchar(10) DEFAULT NULL,
  `kode_barang` varchar(10) DEFAULT NULL,
  `qty` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `detail_transaksi`
--

INSERT INTO `detail_transaksi` (`kode_transaksi`, `kode_barang`, `qty`) VALUES
('TR00001', 'BRG0002', 1),
('TR00001', 'BRG0003', 2),
('TR00002', 'BRG0005', 10),
('TR00003', 'BRG0003', 11),
('TR00004', 'BRG0006', 11),
('TR00005', 'BRG0006', 11),
('TR00007', 'BRG0006', 1),
('TR00007', 'BRG0007', 1),
('TR00007', 'BRG0005', 5),
('TR00008', 'BRG0004', 1000),
('TR00008', 'BRG0002', 1000),
('TR00008', 'BRG0006', 1000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis_barang`
--

CREATE TABLE `jenis_barang` (
  `id_jenis` int(11) NOT NULL,
  `jenis_barang` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `jenis_barang`
--

INSERT INTO `jenis_barang` (`id_jenis`, `jenis_barang`) VALUES
(1, 'Otomotif'),
(2, 'Makanan'),
(3, 'Fashion'),
(4, 'Elektronik'),
(5, 'Handphone & Tablet');

-- --------------------------------------------------------

--
-- Struktur dari tabel `merk_barang`
--

CREATE TABLE `merk_barang` (
  `id_merk` int(11) NOT NULL,
  `merk_barang` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `merk_barang`
--

INSERT INTO `merk_barang` (`id_merk`, `merk_barang`) VALUES
(1, 'Otomotif Supplier'),
(2, 'Elekronik & Tablet'),
(3, 'rolex');

-- --------------------------------------------------------

--
-- Struktur dari tabel `supplier`
--

CREATE TABLE `supplier` (
  `id_supplier` int(11) NOT NULL,
  `kode_supplier` varchar(10) DEFAULT NULL,
  `nama_supplier` varchar(50) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `supplier`
--

INSERT INTO `supplier` (`id_supplier`, `kode_supplier`, `nama_supplier`, `username`, `password`) VALUES
(1, 'sp001', 'Supplier Otomotive', 'suppliera', 'suppliera'),
(2, 'sp002', 'Supplier Electronic', 'supplierb', 'supplierb'),
(3, 'sp003', 'jamal hidayat', 'bahar', '123');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `kode_transaksi` varchar(10) DEFAULT NULL,
  `tgl_transaksi` date DEFAULT NULL,
  `total_harga` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `kode_transaksi`, `tgl_transaksi`, `total_harga`) VALUES
(1, 'TR00001', '2018-05-14', 4000000),
(2, 'TR00002', '2021-01-15', 500000),
(3, 'TR00003', '2021-01-15', 5500000),
(4, 'TR00004', '2021-01-15', 11000),
(5, 'TR00005', '2021-01-15', 11000),
(7, 'TR00007', '2021-11-22', 251010),
(8, 'TR00008', '2021-11-22', 2147483647);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `nama_user` varchar(100) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `level` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id_user`, `nama_user`, `username`, `password`, `level`) VALUES
(1, 'Administrator', 'admin', 'admin', 'admin'),
(2, 'Petugas Gudang', 'gudang', 'gudang', 'petugas gudang'),
(3, 'Officer', 'manajer', 'manajer', 'manajer');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indeks untuk tabel `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD PRIMARY KEY (`id_barang_keluar`);

--
-- Indeks untuk tabel `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD PRIMARY KEY (`id_barang_masuk`);

--
-- Indeks untuk tabel `jenis_barang`
--
ALTER TABLE `jenis_barang`
  ADD PRIMARY KEY (`id_jenis`);

--
-- Indeks untuk tabel `merk_barang`
--
ALTER TABLE `merk_barang`
  ADD PRIMARY KEY (`id_merk`);

--
-- Indeks untuk tabel `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id_supplier`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `barang`
--
ALTER TABLE `barang`
  MODIFY `id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `barang_keluar`
--
ALTER TABLE `barang_keluar`
  MODIFY `id_barang_keluar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `barang_masuk`
--
ALTER TABLE `barang_masuk`
  MODIFY `id_barang_masuk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `jenis_barang`
--
ALTER TABLE `jenis_barang`
  MODIFY `id_jenis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `merk_barang`
--
ALTER TABLE `merk_barang`
  MODIFY `id_merk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id_supplier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
