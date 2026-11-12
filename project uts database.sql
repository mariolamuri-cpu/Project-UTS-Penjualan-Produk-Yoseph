-- Aktifkan database project
USE project_uas_penjualan_produk_yoseph;

-- ====================================================================
-- DATA QUERY LANGUAGE (DQL) - SOAL 1 SAMPAI 8
-- ====================================================================

-- 1. Tampilkan seluruh data dari tabel stokbarang
SELECT * FROM stokbarang;

-- 2. Tampilkan seluruh data dari tabel photoproduk
SELECT * FROM photoproduk;

-- 3. Tampilkan data dari kodebarang, namabarang, harga beli dan stok
SELECT kodebarang, namabarang, hargabeli, stok FROM stokbarang;

-- 4. Tampilkan data prediksi keuntungan tiap stokbarang yang dimiliki
SELECT 
    kodebarang, 
    namabarang, 
    hargabeli, 
    hargajual, 
    stok,
    (hargajual - hargabeli) AS untung_per_unit,
    ((hargajual - hargabeli) * stok) AS total_prediksi_keuntungan
FROM stokbarang;

-- 5. Tampilkan data photo dari tiap stokbarang
SELECT 
    s.kodebarang, 
    s.namabarang, 
    p.nama_file, 
    IF(p.is_cover = 1, 'Cover Utama', 'Foto Tambahan') AS keterangan_foto
FROM stokbarang s
JOIN photoproduk p ON s.kodebarang = p.kodebarang;

-- 6. Tampilkan data cover photo dari tiap stokbarang
SELECT 
    s.kodebarang, 
    s.namabarang, 
    p.nama_file AS cover_photo
FROM stokbarang s
JOIN photoproduk p ON s.kodebarang = p.kodebarang
WHERE p.is_cover = 1;

-- 7. Cek seluruh isi tabel dari DML poin 1 (memastikan minimal 5 data terisi)
SELECT * FROM MEMBER;
SELECT * FROM kasir;
SELECT * FROM penjualan;
SELECT * FROM detail_penjualan;
SELECT * FROM review_produk;

-- 8A. Tampilkan produk yang paling laris
SELECT s.kodebarang, s.namabarang, COALESCE(SUM(d.qty), 0) AS total_terjual
FROM stokbarang s
LEFT JOIN detail_penjualan d ON s.kodebarang = d.kodebarang
GROUP BY s.kodebarang, s.namabarang
ORDER BY total_terjual DESC
LIMIT 1;

-- 8B. Tampilkan produk yang paling jarang dibeli
SELECT s.kodebarang, s.namabarang, COALESCE(SUM(d.qty), 0) AS total_terjual
FROM stokbarang s
LEFT JOIN detail_penjualan d ON s.kodebarang = d.kodebarang
GROUP BY s.kodebarang, s.namabarang
ORDER BY total_terjual ASC
LIMIT 1;

-- 8C. Tampilkan rata-rata penjualan tiap produk
SELECT 
    s.kodebarang, 
    s.namabarang, 
    COALESCE(ROUND(AVG(d.qty), 2), 0) AS rata_rata_qty_terjual,
    COALESCE(ROUND(AVG(d.subtotal), 0), 0) AS rata_rata_omzet_per_transaksi
FROM stokbarang s
LEFT JOIN detail_penjualan d ON s.kodebarang = d.kodebarang
GROUP BY s.kodebarang, s.namabarang;


-- ====================================================================
-- SOAL 9: 5 STUDI KASUS TAMBAHAN
-- ====================================================================

-- Studi Kasus 1: Evaluasi kepuasan pelanggan (rata-rata rating per produk)
SELECT 
    s.kodebarang, 
    s.namabarang, 
    COUNT(r.id_review) AS jumlah_ulasan,
    COALESCE(ROUND(AVG(r.rating), 1), 0) AS rata_rata_rating
FROM stokbarang s
LEFT JOIN review_produk r ON s.kodebarang = r.kodebarang
GROUP BY s.kodebarang, s.namabarang
ORDER BY rata_rata_rating DESC;

-- Studi Kasus 2: Laporan kinerja penjualan & total setoran per kasir
SELECT 
    k.id_kasir, 
    k.nama_kasir, 
    k.shift, 
    COUNT(p.no_faktur) AS jumlah_transaksi,
    COALESCE(SUM(p.total_bayar), 0) AS total_pendapatan
FROM kasir k
LEFT JOIN penjualan p ON k.id_kasir = p.id_kasir
GROUP BY k.id_kasir, k.nama_kasir, k.shift
ORDER BY total_pendapatan DESC;

-- Studi Kasus 3: Identifikasi member paling loyal (belanja > Rp 250.000)
SELECT 
    m.id_member, 
    m.nama_member, 
    m.no_hp,
    COUNT(p.no_faktur) AS frekuensi_belanja,
    SUM(p.total_bayar) AS total_belanja
FROM MEMBER m
JOIN penjualan p ON m.id_member = p.id_member
GROUP BY m.id_member, m.nama_member, m.no_hp
HAVING total_belanja > 250000
ORDER BY total_belanja DESC;

-- Studi Kasus 4: Peringatan dini stok menipis (stok kurang dari 20 unit)
SELECT 
    kodebarang, 
    namabarang, 
    stok AS sisa_stok,
    (hargajual - hargabeli) AS margin_keuntungan
FROM stokbarang
WHERE stok < 20
ORDER BY sisa_stok ASC;

-- Studi Kasus 5: Rekapitulasi struk belanja lengkap (menggabungkan 5 tabel)
SELECT 
    p.no_faktur, 
    p.tgl_transaksi, 
    m.nama_member, 
    k.nama_kasir, 
    s.namabarang, 
    d.qty, 
    d.subtotal
FROM penjualan p
JOIN MEMBER m ON p.id_member = m.id_member
JOIN kasir k ON p.id_kasir = k.id_kasir
JOIN detail_penjualan d ON p.no_faktur = d.no_faktur
JOIN stokbarang s ON d.kodebarang = s.kodebarang
ORDER BY p.no_faktur ASC;
