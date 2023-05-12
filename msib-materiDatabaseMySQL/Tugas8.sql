CREATE TRIGGER set_status_pembayaran BEFORE INSERT ON pembayaran
    -> FOR EACH ROW
    -> BEGIN
    ->     DECLARE total DOUBLE;
    ->     SELECT SUM(qty * harga) INTO total FROM pesanan_items WHERE pesanan_id = NEW.pesanan_id;
    ->     IF NEW.jumlah >= total THEN
    ->         SET NEW.status_pembayaran = 'lunas';
    ->     END IF;
    -> END$$
Query OK, 0 rows affected (0.005 sec)

-- Jika jumlah kurang dari total harga
INSERT INTO pembayaran(nokuitansi,tanggal,jumlah,ke,pesanan_id,status_pembayaran) VALUES
    -> ('KI002','2023-09-12',4000,2,12,'belum lunas');
Query OK, 1 row affected (0.006 sec)

MariaDB [dbpos]> select * from pembayaran;
+----+------------+------------+--------+------+------------+-------------------+
| id | nokuitansi | tanggal    | jumlah | ke   | pesanan_id | status_pembayaran |
+----+------------+------------+--------+------+------------+-------------------+
|  1 | KI001      | 2023-03-10 |  11000 |    1 |         11 | lunas             |
|  2 | KI002      | 2023-09-12 |   4000 |    2 |         12 | belum lunas       |
+----+------------+------------+--------+------+------------+-------------------+


-- Jika jumlah >= dari total harga
INSERT INTO pembayaran(nokuitansi,tanggal,jumlah,ke,pesanan_id,status_pembayaran) VALUES
    -> ('KI003','2023-09-12',5000,2,12,'belum lunas');
Query OK, 1 row affected (0.003 sec)

MariaDB [dbpos]> select * from pembayaran;
+----+------------+------------+--------+------+------------+-------------------+
| id | nokuitansi | tanggal    | jumlah | ke   | pesanan_id | status_pembayaran |
+----+------------+------------+--------+------+------------+-------------------+
|  1 | KI001      | 2023-03-10 |  11000 |    1 |         11 | lunas             |
|  2 | KI002      | 2023-09-12 |   4000 |    2 |         12 | belum lunas       |
|  5 | KI003      | 2023-09-12 |   5000 |    2 |         12 | lunas             |
+----+------------+------------+--------+------+------------+-------------------+
3 rows in set (0.000 sec)