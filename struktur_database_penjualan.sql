-- 1. Hapus database lama agar tidak bentrok
DROP DATABASE IF EXISTS project_uas_penjualan_produk_yoseph;

-- 2. Nama Database
CREATE DATABASE project_uas_penjualan_produk_yoseph;
USE project_uas_penjualan_produk_yoseph;

-- 3. 
CREATE TABLE stokbarang (
    kodebarang VARCHAR(10) NOT NULL PRIMARY KEY,
    namabarang VARCHAR(100) NOT NULL,
    hargabeli INT NOT NULL,
    hargajual INT NOT NULL,
    stok INT NOT NULL
) ENGINE=INNODB;

CREATE TABLE MEMBER (
    id_member VARCHAR(10) NOT NULL PRIMARY KEY,
    nama_member VARCHAR(100) NOT NULL,
    no_hp VARCHAR(15),
    alamat TEXT,
    tgl_daftar DATE
) ENGINE=INNODB;

CREATE TABLE kasir (
    id_kasir VARCHAR(10) NOT NULL PRIMARY KEY,
    nama_kasir VARCHAR(100) NOT NULL,
    shift VARCHAR(20)
) ENGINE=INNODB;

-- 4. Buat Tabel Anak & Relasi (Foreign Key)
CREATE TABLE photoproduk (
    id_photo INT AUTO_INCREMENT PRIMARY KEY,
    kodebarang VARCHAR(10) NOT NULL,
    nama_file VARCHAR(150) NOT NULL,
    is_cover TINYINT(1) DEFAULT 0,
    CONSTRAINT fk_photo_barang FOREIGN KEY (kodebarang) REFERENCES stokbarang(kodebarang) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE penjualan (
    no_faktur VARCHAR(15) NOT NULL PRIMARY KEY,
    tgl_transaksi DATE NOT NULL,
    id_member VARCHAR(10) NULL,
    id_kasir VARCHAR(10) NOT NULL,
    total_bayar INT DEFAULT 0,
    CONSTRAINT fk_penjualan_member FOREIGN KEY (id_member) REFERENCES MEMBER(id_member) ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_penjualan_kasir FOREIGN KEY (id_kasir) REFERENCES kasir(id_kasir) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=INNODB;

CREATE TABLE detail_penjualan (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    no_faktur VARCHAR(15) NOT NULL,
    kodebarang VARCHAR(10) NOT NULL,
    qty INT NOT NULL,
    subtotal INT NOT NULL,
    CONSTRAINT fk_detail_faktur FOREIGN KEY (no_faktur) REFERENCES penjualan(no_faktur) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_detail_barang FOREIGN KEY (kodebarang) REFERENCES stokbarang(kodebarang) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=INNODB;

CREATE TABLE review_produk (
    id_review INT AUTO_INCREMENT PRIMARY KEY,
    id_member VARCHAR(10) NOT NULL,
    kodebarang VARCHAR(10) NOT NULL,
    rating INT NOT NULL,
    komentar TEXT,
    tgl_review DATE,
    CONSTRAINT fk_review_member FOREIGN KEY (id_member) REFERENCES MEMBER(id_member) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_review_barang FOREIGN KEY (kodebarang) REFERENCES stokbarang(kodebarang) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=INNODB;

-- 5. Isi Data Tabel Induk (Minimal 5 Data per Tabel)
INSERT INTO stokbarang (kodebarang, namabarang, hargabeli, hargajual, stok) VALUES
('BRG01', 'Kemeja Flanel Pria', 85000, 135000, 25),
('BRG02', 'Celana Chino Slimfit', 110000, 175000, 18),
('BRG03', 'Sepatu Sneakers Kanvas', 150000, 240000, 12),
('BRG04', 'Tas Ransel Laptop', 120000, 195000, 15),
('BRG05', 'Topi Baseball Polos', 25000, 50000, 40);

INSERT INTO MEMBER (id_member, nama_member, no_hp, alamat, tgl_daftar) VALUES
('MBR01', 'Andi Pratama', '081234567801', 'Denpasar', '2026-01-10'),
('MBR02', 'Siti Aminah', '081234567802', 'Badung', '2026-02-14'),
('MBR03', 'Budi Santoso', '081234567803', 'Gianyar', '2026-03-05'),
('MBR04', 'Dewi Lestari', '081234567804', 'Tabanan', '2026-04-20'),
('MBR05', 'Rizky Hidayat', '081234567805', 'Denpasar', '2026-05-12');

INSERT INTO kasir (id_kasir, nama_kasir, shift) VALUES
('KSR01', 'Putu Ayu', 'Pagi'),
('KSR02', 'Made Wirawan', 'Siang'),
('KSR03', 'Komang Sari', 'Malam'),
('KSR04', 'Ketut Bagus', 'Pagi'),
('KSR05', 'Ni Luh Gede', 'Siang');

-- 6. Isi Data Tabel Anak (Sesuai Relasi)
INSERT INTO photoproduk (kodebarang, nama_file, is_cover) VALUES
('BRG01', 'flanel_depan.jpg', 1),
('BRG01', 'flanel_belakang.jpg', 0),
('BRG02', 'chino_cream.jpg', 1),
('BRG03', 'sneakers_putih.jpg', 1),
('BRG04', 'ransel_hitam.jpg', 1),
('BRG05', 'topi_navy.jpg', 1);

INSERT INTO penjualan (no_faktur, tgl_transaksi, id_member, id_kasir, total_bayar) VALUES
('INV-001', '2026-11-01', 'MBR01', 'KSR01', 310000),
('INV-002', '2026-11-02', 'MBR02', 'KSR02', 240000),
('INV-003', '2026-11-03', 'MBR03', 'KSR01', 150000),
('INV-004', '2026-11-04', 'MBR04', 'KSR03', 390000),
('INV-005', '2026-11-05', 'MBR05', 'KSR04', 270000);

INSERT INTO detail_penjualan (no_faktur, kodebarang, qty, subtotal) VALUES
('INV-001', 'BRG01', 1, 135000),
('INV-001', 'BRG02', 1, 175000),
('INV-002', 'BRG03', 1, 240000),
('INV-003', 'BRG05', 3, 150000),
('INV-004', 'BRG04', 2, 390000),
('INV-005', 'BRG01', 2, 270000);

INSERT INTO review_produk (id_member, kodebarang, rating, komentar, tgl_review) VALUES
('MBR01', 'BRG01', 5, 'Bahan flanel sangat adem dan jahitan rapi.', '2026-11-02'),
('MBR02', 'BRG03', 4, 'Sepatu nyaman dipakai jalan jauh.', '2026-11-03'),
('MBR03', 'BRG05', 5, 'Topi pas di kepala, warna sesuai gambar.', '2026-11-04'),
('MBR04', 'BRG04', 5, 'Muat laptop 15 inch dengan aman.', '2026-11-05'),
('MBR05', 'BRG01', 4, 'Pengiriman cepat, ukuran pas.', '2026-11-06');
