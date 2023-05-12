--Soal 3.1
--1.Tampilkan produk yang asset nya diatas 20jt
MariaDB [dbpos]> SELECT * FROM produk WHERE harga_produk > 2000000;
Empty set (0.005 sec)

--2.Tampilkan data produk beserta selisih stok dengan minimal stok
MariaDB [dbpos]> SELECT SUM(stok-min_stok) as selisih from produk;
+---------+
| selisih |
+---------+
|     158 |
+---------+
1 row in set (0.003 sec)

--3.Tampilkan total asset produk secara keseluruhan
MariaDB [dbpos]> SELECT sum(stok) as total_asset from produk;
+-------------+
| total_asset |
+-------------+
|         165 |
+-------------+
1 row in set (0.001 sec)

--4.Tampilkan data pelanggan yang lahirnya antara tahun 1999 sampai 2004
MariaDB [dbpos]> SELECT * FROM pelanggan WHERE YEAR(tgl_lahir) BETWEEN 1999 and 2004;
+----+------+----------------+------+-------------+-----------+------------+---------------------+----------+
| id | kode | nama_pelanggan | jk   | alamat      | tmp_lahir | tgl_lahir  | email               | kartu_id |
+----+------+----------------+------+-------------+-----------+------------+---------------------+----------+
|  1 | 5055 | Rizqy          | L    | Jl.inijalan | Tabanan   | 2000-12-21 | estrizqy@gmail.com  |        1 |
|  2 | 5056 | Sandi          | L    | Jl.inijalan | Tabanan   | 1999-02-08 | iniemail1@gmail.com |        2 |
|  3 | 5057 | Budi           | L    | Jl.inijalan | Malang    | 2003-08-12 | iniemail2@gmail.com |        3 |
+----+------+----------------+------+-------------+-----------+------------+---------------------+----------+
3 rows in set (0.006 sec)

--5.Tampilkan data pelanggan yang lahirnya tahun 1998
MariaDB [dbpos]> SELECT * FROM pelanggan WHERE YEAR(tgl_lahir)=1998;
Empty set (0.001 sec)

--6.Tampilkan data pelanggan yang berulang tahun bulan agustus
MariaDB [dbpos]> SELECT * FROM pelanggan WHERE MONTH(tgl_lahir)=08;
+----+------+----------------+------+-------------+-----------+------------+---------------------+----------+
| id | kode | nama_pelanggan | jk   | alamat      | tmp_lahir | tgl_lahir  | email               | kartu_id |
+----+------+----------------+------+-------------+-----------+------------+---------------------+----------+
|  3 | 5057 | Budi           | L    | Jl.inijalan | Malang    | 2003-08-12 | iniemail2@gmail.com |        3 |
+----+------+----------------+------+-------------+-----------+------------+---------------------+----------+
1 row in set (0.002 sec)

--7.Tampilkan data pelanggan : nama, tmp_lahir, tgl_lahir dan umur (selisih tahun sekarang dikurang tahun kelahiran)
MariaDB [dbpos]> SELECT nama_pelanggan,tmp_lahir,tgl_lahir,(YEAR(NOW())-YEAR(tgl_lahir)) AS umur from pelanggan;
+----------------+-----------+------------+------+
| nama_pelanggan | tmp_lahir | tgl_lahir  | umur |
+----------------+-----------+------------+------+
| Rizqy          | Tabanan   | 2000-12-21 |   23 |
| Sandi          | Tabanan   | 1999-02-08 |   24 |
| Budi           | Malang    | 2003-08-12 |   20 |
+----------------+-----------+------------+------+
3 rows in set (0.002 sec)

--Soal 3.2
--1.	Berapa jumlah pelanggan yang tahun lahirnya 1998
MariaDB [dbpos]> SELECT COUNT(*) AS jumlah FROM pelanggan WHERE YEAR(tgl_lahir)=1998;
+--------+
| jumlah |
+--------+
|      0 |
+--------+
1 row in set (0.001 sec)

--2.    Berapa jumlah pelanggan perempuan yang tempat lahirnya di Jakarta
MariaDB [dbpos]> SELECT COUNT(*) AS jumlah FROM pelanggan WHERE tmp_lahir LIKE '%Jakarta%';
+--------+
| jumlah |
+--------+
|      0 |
+--------+
1 row in set (0.002 sec)

--3.	Berapa jumlah total stok semua produk yang harga jualnya dibawah 10rb
MariaDB [dbpos]> SELECT COUNT(stok) AS jumlah FROM produk where harga_produk < 10000;
+--------+
| jumlah |
+--------+
|      2 |
+--------+
1 row in set (0.001 sec)

--4.	Ada berapa produk yang mempunyai kode awal K
MariaDB [dbpos]> SELECT COUNT(*) as jumlah_kode_K FROM produk WHERE kode_produk LIKE '%K%';
+---------------+
| jumlah_kode_K |
+---------------+
|             0 |
+---------------+
1 row in set (0.001 sec)

--5.	Berapa harga jual rata-rata produk yang diatas 1jt
MariaDB [dbpos]> SELECT AVG(harga_produk) as harga_rata_diatas_1jt FROM produk WHERE harga_produk < 1000000;
+-----------------------+
| harga_rata_diatas_1jt |
+-----------------------+
|     70333.33333333333 |
+-----------------------+
1 row in set (0.004 sec)

--6.	Tampilkan jumlah stok yang paling besar
MariaDB [dbpos]> SELECT MAX(stok) as stok_paling_banyak FROM produk;
+--------------------+
| stok_paling_banyak |
+--------------------+
|                 50 |
+--------------------+
1 row in set (0.001 sec)

--7.	Ada berapa produk yang stoknya kurang dari minimal stok
MariaDB [dbpos]> SELECT COUNT(*) as jumlah_stok_kurang_dari_minstok FROM produk WHERE stok < min_stok;
+---------------------------------+
| jumlah_stok_kurang_dari_minstok |
+---------------------------------+
|                               0 |
+---------------------------------+
1 row in set (0.001 sec)

--8.	Berapa total asset dari keseluruhan produk
MariaDB [dbpos]> SELECT SUM(harga_produk * stok) AS total_assets FROM produk;
+--------------+
| total_assets |
+--------------+
|     79550000 |
+--------------+
1 row in set (0.004 sec)

--Soal 3.3
--1.	Tampilkan data produk : id, nama, stok dan informasi jika stok telah sampai batas minimal atau kurang dari minimum stok dengan informasi ‘segera belanja’ jika tidak ‘stok aman’.
MariaDB [dbpos]> SELECT id, nama_produk AS nama, stok,
    -> IF(stok <= min_stok, 'segera belanja','stok aman') AS status_stok
    -> FROM produk;
+----+---------------+------+-------------+
| id | nama          | stok | status_stok |
+----+---------------+------+-------------+
|  1 | TV            |   20 | stok aman   |
|  7 | TV LG 32inch  |   15 | stok aman   |
|  8 | Fried Chicken |   50 | stok aman   |
|  9 | Lemari        |   30 | stok aman   |
| 10 | Es Teh        |   50 | stok aman   |
+----+---------------+------+-------------+
5 rows in set (0.003 sec)

--2.	Tampilkan data pelanggan: id, nama, umur dan kategori umur : jika umur < 17 → ‘muda’ , 17-55 → ‘Dewasa’, selainnya ‘Tua’
SELECT id, nama_pelanggan AS nama,
    -> TIMESTAMPDIFF(YEAR, tgl_lahir, CURDATE()) AS umur,
    -> CASE
    -> WHEN TIMESTAMPDIFF(YEAR, tgl_lahir, CURDATE()) < 17 THEN 'muda'
    -> WHEN TIMESTAMPDIFF(YEAR, tgl_lahir, CURDATE()) BETWEEN 17 AND 55 THEN 'Dewasa'
    -> ELSE 'Tua'
    -> END AS kategori_umur
    -> FROM pelanggan;
+----+-------+------+---------------+
| id | nama  | umur | kategori_umur |
+----+-------+------+---------------+
|  1 | Rizqy |   22 | Dewasa        |
|  2 | Sandi |   24 | Dewasa        |
|  3 | Budi  |   19 | Dewasa        |
+----+-------+------+---------------+
3 rows in set (0.000 sec)

--3.	Tampilkan data produk: id, kode, nama, dan bonus untuk kode ‘TV01’ →’DVD Player’ , ‘K001’ → ‘Rice Cooker’ selain dari diatas ‘Tidak Ada’
SELECT id, kode_produk AS kode, nama_produk AS nama,
    -> CASE
    -> WHEN kode_produk = 'TV01' THEN 'DVD Player'
    -> WHEN kode_produk = 'K001' THEN 'Rice Cooker'
    -> ELSE 'Tidak Ada'
    -> END AS bonus
    -> FROM produk;
+----+------+---------------+-----------+
| id | kode | nama          | bonus     |
+----+------+---------------+-----------+
|  1 | 2011 | TV            | Tidak Ada |
|  7 | 2012 | TV LG 32inch  | Tidak Ada |
|  8 | 2013 | Fried Chicken | Tidak Ada |
|  9 | 2014 | Lemari        | Tidak Ada |
| 10 | 2015 | Es Teh        | Tidak Ada |
+----+------+---------------+-----------+
5 rows in set (0.000 sec)

--Soal 3.4
--1.	Tampilkan data statistik jumlah tempat lahir pelanggan
SELECT tmp_lahir, COUNT(*) AS jumlah_pelanggan
    -> FROM pelanggan
    -> GROUP BY tmp_lahir;
+-----------+------------------+
| tmp_lahir | jumlah_pelanggan |
+-----------+------------------+
| Malang    |                1 |
| Tabanan   |                2 |
+-----------+------------------+
2 rows in set (0.002 sec)

--2.	Tampilkan jumlah statistik produk berdasarkan jenis produk
SELECT jenis_produk.nama AS jenis_produk, COUNT(*) AS jumlah_produk
    -> FROM produk
    -> INNER JOIN jenis_produk ON produk.jenis_produk_id = jenis_produk.id
    -> GROUP BY jenis_produk.nama;
+--------------+---------------+
| jenis_produk | jumlah_produk |
+--------------+---------------+
| Elektronik   |             2 |
| Furniture    |             1 |
| Makanan      |             1 |
| Minuman      |             1 |
+--------------+---------------+
4 rows in set (0.017 sec)

-- 3.	Tampilkan data pelanggan yang usianya dibawah rata usia pelanggan
SELECT id, nama_pelanggan, YEAR(CURDATE()) - YEAR(tgl_lahir) AS usia
    -> FROM pelanggan
    -> WHERE YEAR(CURDATE()) - YEAR(tgl_lahir) <
    -> (SELECT AVG(YEAR(CURDATE()) - YEAR(tgl_lahir)) FROM pelanggan);
+----+----------------+------+
| id | nama_pelanggan | usia |
+----+----------------+------+
|  3 | Budi           |   20 |
+----+----------------+------+
1 row in set (0.002 sec)

-- 4.	Tampilkan data produk yang harganya diatas rata-rata harga produk
SELECT id, kode_produk, nama_produk, harga_produk
    -> FROM produk
    -> WHERE harga_produk >
    -> (SELECT AVG(harga_produk) FROM produk);
+----+-------------+-------------+--------------+
| id | kode_produk | nama_produk | harga_produk |
+----+-------------+-------------+--------------+
|  1 | 2011        | TV          |      2000000 |
|  9 | 2014        | Lemari      |      1200000 |
+----+-------------+-------------+--------------+
2 rows in set (0.001 sec)

-- 5.	Tampilkan data pelanggan yang memiliki kartu dimana iuran tahunan kartu diatas 90rb
SELECT pelanggan.id, pelanggan.nama_pelanggan, pelanggan.kartu_id, kartu.iuran_tahunan
    -> FROM pelanggan
    -> INNER JOIN kartu ON pelanggan.kartu_id = kartu.id
    -> WHERE kartu.iuran_tahunan > 90000;

-- 6.	Tampilkan statistik data produk dimana harga produknya dibawah rata-rata harga produk secara keseluruhan
SELECT COUNT(*) as jumlah_produk, AVG(harga_produk) as rata_harga_produk
    -> FROM produk
    -> WHERE harga_produk <
    -> (SELECT AVG(harga_produk) FROM produk);
+---------------+-------------------+
| jumlah_produk | rata_harga_produk |
+---------------+-------------------+
|             3 | 70333.33333333333 |
+---------------+-------------------+
1 row in set (0.001 sec)

-- 7.	Tampilkan data pelanggan yang memiliki kartu dimana diskon kartu yang diberikan diatas 3%
SELECT pelanggan.id, pelanggan.nama_pelanggan, kartu.diskon
    -> FROM pelanggan
    -> INNER JOIN kartu ON pelanggan.kartu_id = kartu.id
    -> WHERE kartu.diskon > 0.03;
Empty set (0.002 sec)