SHOW DATABASES;

CREATE DATABASE noodles;

USE noodles;

SHOW TABLES;

DROP TABLE customers;

-- Hapus foreign key terlebih dahulu untuk memutus 'rantai' yang menghubungkan products dengan orders
ALTER TABLE orders
DROP FOREIGN KEY FK_ProductId;

-- Hapus foreign key terlebih dahulu untuk memutus 'rantai' yang menghubungkan customers dengan orders
ALTER TABLE orders
DROP FOREIGN KEY FK_CustomerId;

CREATE TABLE products(
	id INT AUTO_INCREMENT PRIMARY KEY, -- PRIMARY KEY harus adalah sebuah kolom yang nilainya unique, AUTO_INCREMENT agar nilai pada id bertambah secara otomatis
	variant VARCHAR(30), -- Varchar (string) dengan maksimal 30 karakter
    price DECIMAL(3, 2), -- Jumlah digit total yang dimiliki maksimal adalah tiga digit, dengan dua digit di belakang koma
    -- 3.50, 1.00
    -- DECIMAL (5, 2) -- Maksimal terdapat 5 digit, dengan 2 digit di belakang koma
    -- benar : 3.50 , 23.34, 234.99,
    -- salah : 7689.99
    origin VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- 2022-01-18 09:24:00
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- 2022-01-19 19:24:00
);

CREATE TABLE customers(
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    age INT NOT NULL, -- NOT NULL : kolom ini tidak boleh kosong
    gender ENUM('M', 'F'), -- ENUM memungkinkan kita untuk menentukan value apa saja yang dapat disimpan pada suatu kolom
	phone_number VARCHAR(13),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- Mencatat waktu saat data baru ditambahkan
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Mencatat waktu terakhir kali data mengalami perubahan
);

CREATE TABLE orders(
	id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT, -- FOREIGN KEY untuk customers
    product_id INT, -- FOREIGN KEY untuk products
    order_time DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- 2022-01-18 09:24:00
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 2022-01-19 19:24:00
    -- kolom customer_id merupakan foreign key yang akan menyimpan data dari kolom id milik tabel customers
    CONSTRAINT FK_CustomerId FOREIGN KEY (customer_id) REFERENCES customers(id) ON UPDATE CASCADE ON DELETE SET NULL,
    -- kolom product_id merupakan foreign key yang akan menyimpan data dari kolom id milik tabel products
    CONSTRAINT FK_ProductId FOREIGN KEY (product_id) REFERENCES products(id) ON UPDATE CASCADE ON DELETE SET NULL
);

-- DESKRIPSI TABLE / INFORMASI TABLE (jumlah kolum, nama beserta tipe data setiap kolum , dst)
DESC customers;

-- ADD NEW COLUMN (Paling belakang)
ALTER TABLE customers ADD COLUMN address VARCHAR(20);

-- ADD NEW COLUMN (Tentukan Posisi)
ALTER TABLE customers ADD COLUMN age INT AFTER last_name;

-- RENAME COLUMN
ALTER TABLE customers CHANGE address alamat VARCHAR(20);

-- DELETE COLUMN
ALTER TABLE customers DROP COLUMN age;


-- ###########
-- # C R U D #
-- ###########

-- CREATE DATA
-- ###########
SELECT * FROM products;

INSERT INTO products (variant, price, origin) VALUES ('Mi Goreng', 2.50, 'Indonesia');

INSERT INTO products (price, variant, origin) VALUES (3.00, 'Mi Goreng Aceh',  'Aceh');

INSERT INTO products (variant, price, origin)
VALUES	('Soto Banjar', 3.50, 'Banjar'),
		('Soto Banjar Limau Kulit', 3.60, 'Banjar'),
		('Mi Cakalang', 3.50, 'Manado'),
        ('Mi Goreng Cakalang',3.00,'Manado'),
		('Empal Gentong',3.50,'Betawi'),
		('Soto Betawi',3.00,'Betawi'),
		('Mi Kocok Bandung',3.00,'Bandung'),
		('Soto Medan', 2.30,'Medan'),
		('Kari Ayam Medan', 2.50,'Medan'),
		('Bulgogi', 4.20, 'Korea'),
		('Laksa', 4.00, 'Singapore'),
		('Tomyum', 3.80, 'Thailand');


INSERT INTO customers (first_name, last_name, age, gender, phone_number)
VALUES ('Hinata','Shoyo', 15,'M','01123147789'),
('Elon','Musk', 20,'F','01123439899'),('Mark','Zuckerberg', 28,'M','01174592013'),
('Leonardo','Davinci', 35,'M',NULL),('Sarah','Teressa', 20, 'F','01176348290'),
('Neil','Armstrong', 40,'F','01145787353'),('Michael','Jordan', 55,'M','01980289282'),
('Daily','Nash',35,'F','01176987789'),('Max','Jordan',35,'M','01173456782'),
('Senku',NULL, 19, 'F','01139287883'),('Linda','Jordan', 19,'F','01176923804'),
('Kevin','Hard', 40, 'M',NULL),('John','Smith', 56,'M','01174987221'),
('John','Teressa', 36,'M',NULL),('Elon','Smith', 38, 'F','01176984116'),('Gob','Jordan', 36,'M','01176985498'),
('George','Jordan', 41,'M','01176984303'),('Lucian','Jordan', 28, 'F','01198773214'),
('George','Evans', 33, 'M','01174502933'),('Emily','Sinek',37, 'F','01899284352'),
('Steph','Smith', 53,  'M','01144473330'),('Jennifer',NULL, 20, 'F',NULL),
('Toby','Wan', 34, 'M','01176009822'),('Paul','London', 33,'M','01966947113');


INSERT INTO orders (product_id,customer_id,order_time) VALUES (1,1,'2017-01-01 08-02-11'),(1,2,'2017-01-01 08-05-16'),
(5,12,'2017-01-01 08-44-34'),(3,4,'2017-01-01 09-20-02'),
(1,9,'2017-01-01 11-51-56'),(6,22,'2017-01-01 13-07-10'),
(1,1,'2017-01-02 08-03-41'),(3,10,'2017-01-02 09-15-22'),
(2,2,'2017-01-02 10-10-10'),(3,13,'2017-01-02 12-07-23'),
(1,1,'2017-01-03 08-13-50'),(7,16,'2017-01-03 08-47-09'),
(6,21,'2017-01-03 09-12-11'),(5,22,'2017-01-03 11-05-33'),
(4,3,'2017-01-03 11-08-55'),(3,11,'2017-01-03 12-02-14'),
(2,23,'2017-01-03 13-41-22'),(1,1,'2017-01-04 08-08-56'),
(3,10,'2017-01-04 11-23-43'),(4,12,'2017-01-05 08-30-09'),
(7,1,'2017-01-06 09-02-47'),(3,18,'2017-01-06 13-23-34'),
(2,16,'2017-01-07 09-12-39'),(2,14,'2017-01-07 11-24-15'),
(4,5,'2017-01-08 08-54-11'),(1,1,'2017-01-09 08-03-11'),
(6,20,'2017-01-10 10-34-12'),(3,3,'2017-01-10 11-02-11'),
(4,24,'2017-01-11 08-39-11'),(4,8,'2017-01-12 13-20-13'),
(1,1,'2017-01-14 08-27-10'),(4,15,'2017-01-15 08-30-56'),
(1,7,'2017-01-16 10-02-11'),(2,10,'2017-01-17 09-50-05'),
(1,1,'2017-01-18 08-22-55'),(3,9,'2017-01-19 09-00-19'),
(7,11,'2017-01-19 11-33-00'),(6,12,'2017-01-20 08-02-21'),
(3,14,'2017-01-21 09-45-50'),(5,2,'2017-01-22 10-10-34'),
(6,24,'2017-01-23 08-32-19'),(6,22,'2017-01-23 08-45-12'),
(6,17,'2017-01-23 12-45-30'),(2,11,'2017-01-24 08-01-27'),
(1,1,'2017-01-25 08-05-13'),(6,11,'2017-01-26 10-49-10'),
(7,3,'2017-01-27 09-23-57'),(7,1,'2017-01-27 10-08-16'),
(3,18,'2017-01-27 10-13-09'),(4,19,'2017-01-27 11-02-40'),
(3,10,'2017-01-28 08-03-21'),(1,2,'2017-01-28 08-33-28'),
(1,12,'2017-01-28 11-55-33'),(1,13,'2017-01-29 09-10-17'),
(6,6,'2017-01-30 10-07-13'),(1,1,'2017-02-01 08-10-14'),
(2,14,'2017-02-02 10-02-11'),(7,10,'2017-02-02 09-43-17'),
(7,20,'2017-02-03 08-33-49'),(4,21,'2017-02-04 09-31-01'),
(5,22,'2017-02-05 09-07-10'),(3,23,'2017-02-06 08-15-10'),
(2,24,'2017-02-07 08-27-26'),(1,1,'2017-02-07 08-45-10'),
(6,11,'2017-02-08 10-37-10'),(3,13,'2017-02-09 08-58-18'),
(3,14,'2017-02-10 09-12-40'),(5,4,'2017-02-10 11-05-34'),
(1,2,'2017-02-11 08-00-38'),(3,8,'2017-02-12 08-08-08'),
(7,20,'2017-02-12 09-22-10'),(1,1,'2017-02-13 08-37-45'),
(5,2,'2017-02-13 12-34-56'),(4,3,'2017-02-14 08-22-43'),(5,4,'2017-02-14 09-12-56'),(3,5,'2017-02-15 08-09-10'),(6,7,'2017-02-15 09-05-12'),(1,8,'2017-02-15 09-27-50'),(2,9,'2017-02-16 08-51-12'),(3,10,'2017-02-16 13-07-46'),(4,11,'2017-02-17 08-03-55'),(4,12,'2017-02-17 09-12-11'),(5,10,'2017-02-17 11-41-17'),(6,18,'2017-02-17 13-05-56'),(7,19,'2017-02-18 08-33-27'),(1,17,'2017-02-19 08-12-31'),(1,1,'2017-02-20 09-50-17'),(3,5,'2017-02-20 09-51-29'),(4,6,'2017-02-20 10-43-39'),(3,1,'2017-02-21 08-32-17'),(1,1,'2017-02-21 10-30-11'),(3,2,'2017-02-21 11-08-45'),(4,3,'2017-02-22 11-46-32'),(2,15,'2017-02-22 13-35-16'),(6,13,'2017-02-23 08-34-48'),(4,24,'2017-02-24 08-32-03'),(2,13,'2017-02-25 08-03-12'),(7,17,'2017-02-25 09-34-23'),(7,23,'2017-02-25 11-32-54'),(5,12,'2017-02-26 11-47-34'),
(6,4,'2017-02-27 12-12-34'),(1,1,'2017-02-28 08-59-22');

-- UPDATE DATA
-- ###########
SELECT * FROM products;

-- UPDATE table_name
-- SET column_name = new_value
-- WHERE conditions;

-- Ubah nilai origin menjadi Jakarta untuk produk yang memiliki id = 7
UPDATE products 
SET origin = 'Jakarta'
WHERE id = 7;

-- Ubah nilai harga dan origin untuk semua produk bernama Mi Goreng
UPDATE products
SET price = 3.25, origin = 'Jakarta'
WHERE variant = 'Mi Goreng';

-- Ubah nilai origin menjadi DKI untuk semua data yang origin nya adalah Jakarta
UPDATE products
SET origin = 'DKI'
WHERE origin = 'Jakarta';

-- Ubah nilai origin menjadi NULL untuk semua produk yang variant nya adalah Tomyum
UPDATE products
SET origin = NULL
WHERE variant = 'Tomyum';

-- DELETE DATA
-- ###########

-- Hapus semua data dari products yang memiliki origin Aceh
DELETE FROM products
WHERE origin = 'Aceh';

-- READ DATA
-- ###########

-- Tampilkan semua kolom dari tabel products;
SELECT * FROM products;

-- Tampilkan kolom variant dan origin dari tabel products;
SELECT variant, origin FROM products;

-- Tampilkan semua kolom yang memiliki harga 3.50 dan juga berasal dari Banjar
SELECT * FROM products
WHERE price = 3.50 AND origin = 'Banjar';

-- Tampilkan semua kolom yang memiliki harga 3.00 atau berasal dari Manado
SELECT * FROM products
WHERE price = 3.00 OR origin = 'Manado';


-- INEQUALITY (>, <, >=, <=, !=)

-- Tampilkan products yang harganya bukan 3.50
SELECT * FROM products
WHERE price != 3.50;

-- Tampilkan products yang origin nya NULL. Khusus untuk NULL tidak menggunakan sama dengan melainkan keyword IS
SELECT * FROM products
WHERE origin IS NULL;

-- Tampilkan products yang origin nya tidak NULL dan juga harga nya bukan 3.00
SELECT * FROM products
WHERE origin IS NOT NULL AND price = 3.00;

-- EXERCISE
-- ########

-- Tampilkan nama depan dan nomor handphone untuk perempuan yang memiliki nama belakang = Jordan
SELECT first_name, phone_number FROM customers
WHERE gender = 'F' AND last_name = 'Jordan';

-- Tampilkan nama product yang memiliki harga lebih besar dari 3.50 atau berasal dari Medan
SELECT variant FROM products
WHERE price > 3.50 OR origin = 'Medan';

-- Tampilkan semua kolom untuk laki - laki yang tidak memiliki nomor handphone
SELECT * FROM customers
WHERE gender = 'M' AND phone_number IS NULL;

-- Tampilkan semua kolom untuk customer yang memiliki nama belakang antara 'Smith', 'Jordan', 'Armstrong';
SELECT * FROM customers
WHERE last_name = 'Smith' OR last_name = 'Jordan' OR last_name = 'Armstrong';

USE noodles;

-- IN
-- Tampilkan semua kolom untuk customer yang memiliki nama belakang antara 'Smith', 'Jordan', 'Armstrong';
SELECT * FROM customers
WHERE last_name IN('Smith', 'Jordan', 'Armstrong');

-- NOT IN
-- Tampilkan semua kolom untuk customer yang memiliki nama belakang selain 'Smith', 'Jordan', 'Armstrong';
SELECT * FROM customers
WHERE last_name NOT IN('Smith', 'Jordan', 'Armstrong');

-- Tampilkan informasi pesanan sejak tanggal 5 pukul 00:00 hingga 19 pukul 10:00:00 januari 2017;
-- Tampilkan informasi pesanan sejak tanggal 5 hingga tanggal 19 terakhir jam 10 pagi, lewat satu detik tidak akan muncul;
SELECT * FROM orders
WHERE order_time >= '2017-01-05 00:00:00' AND order_time <= '2017-01-19 10:00:00';

-- Tampilkan informasi pesanan sejak tanggal 5 hingga 20 januari 2017;
SELECT * FROM orders
WHERE order_time >= '2017-01-05 00:00:00' AND order_time <= '2017-01-20 23:59:59';

-- BETWEEN
-- Tampilkan pesanan yang terjadi pada tanggal 5 hingga 20 januari 2017;
SELECT * FROM orders
WHERE order_time BETWEEN '2017-01-05 00:00:00' AND '2017-01-20 23:59:59';

-- Tampilkan pesanan yang dilakukan oleh user dengan id 5 hingga 11;
SELECT * FROM orders
WHERE customer_id BETWEEN 5 AND 11;

-- LIKE (case in-sensitive : tidak membedakan huruf kapital dan huruf kecil)
-- % , karakter apapun , dengan jumlah berapapun
-- _ , krakter apapun, satu karakter

-- Customer yang memiliki huruf o, sebelum dan sesudah huruf o boleh ada karakter apapun dan berapapun
-- Elon, Leonardo, John, Gob, George, Toby
SELECT first_name FROM customers
WHERE first_name LIKE '%o%';

-- Customer yang memiliki akhiran l , tidak boleh ada karakter setelah huruf l, tapi boleh ada karakter sebelum l
-- Neil, Michael, Paul
SELECT first_name FROM customers
WHERE first_name LIKE '%l';

-- Customer yang memiliki awalan l
-- Leonardo, Linda, Lucian
SELECT first_name FROM customers
WHERE first_name LIKE 'l%';

-- Customer yang memiliki huruf o, hanya boleh ada satu karakter pada awal dan akhir nama.
-- Gob
SELECT first_name FROM customers
WHERE first_name LIKE '_o_';
-- Customer yang memiliki huruf o
-- sebelum huruf o boleh memiliki karakter berapapun, setelah huruf o hanya boleh ada satu karakter.
SELECT first_name FROM customers
WHERE first_name LIKE '%o_';

SELECT first_name FROM customers
WHERE first_name LIKE '_o%';

-- Products yang mengandung kata soto
SELECT * FROM products
WHERE variant LIKE '%soto%';

-- ORDER BY
-- Mengurutkan data berdasarkan kolom tertentu.
-- ASC / ASCENDING  : kecil --> besar (default)
-- DESC / DESCENDING : besar --> kecil

-- Mengurutkan produk berdasarkan harga (dari yang termurah).
SELECT * FROM products
ORDER BY price;

-- Mengurutkan produk berdasarkan harga (dari yang termahal).
SELECT * FROM products
ORDER BY price DESC ;

-- Pesanan yang dilakukan oleh user dengan id 4 dan diurutkan berdasarkan tanggal (dari yang terbaru)
SELECT * FROM orders
WHERE customer_id = 4
ORDER BY order_time DESC;

-- DISTINCT
-- ########
-- Menampilkan data secara unique

-- Menampilkan daftar origin products
SELECT DISTINCT origin FROM products;

-- Products apa saja yang pernah dipesan
SELECT DISTINCT product_id FROM orders;

-- LIMIT & OFFSET
-- ##############
-- LIMIT  : Membatasi jumlah data
-- OFFSET : Skip data

SELECT * FROM products LIMIT 5;
SELECT * FROM customers LIMIT 3 OFFSET 10;


-- ALIAS
-- #####
-- Mengubah nama kolom saat ditampilkan

SELECT 
	first_name AS 'Nama depan',
	last_name AS 'Nama belakang',
	phone_number AS 'Nomor Telpon'
FROM customers;

-- Menambahkan kolom baru untuk ditampilkan dan menggunakan alias untuk memberi nama kolom tersebut
SELECT 
	variant AS Variant,
	price AS 'Price 2021',
	ROUND(price + (price * 0.1), 2) AS 'Price 2022',
	origin AS Origin
FROM products;

-- EXERCISE

-- Tampilkan nama produk dan harga untuk semua product yang berasal dari DKI atau Manado
SELECT variant, price FROM products WHERE origin = 'DKI' OR origin = 'Manado';
SELECT variant, price FROM products WHERE origin IN('DKI', 'Manado');

-- Tampilkan semua kolom untuk order yang terjadi pada bulan februari untuk costumer dengan id 2 , 4, 6, 8
SELECT * FROM orders WHERE order_time LIKE '%-02-%' AND customer_id IN(2, 4, 6, 8) ;

-- Tampilkan nama depan, nama belakang, nomor tlp untuk customer yang nama belakang mengandung huruf 'ar'
SELECT first_name, last_name, phone_number FROM customers WHERE last_name LIKE '%ar%';

-- Tampilkan semua kolom untuk 3 order pertama yang dilakukan oleh customer dengan id 4
SELECT * FROM orders WHERE customer_id = 4 LIMIT 3;

-- Tampilkan product id berapa saja yang berhasil terjual pada bulan februari
SELECT DISTINCT product_id FROM orders WHERE MONTH(order_time) = 2;

-- Tampilkan semua kolom untuk orderan terakhir yang dilakukan oleh customer dengan id 4
SELECT * FROM orders WHERE customer_id = 4 ORDER BY order_time DESC LIMIT 1 ;

-- MONTH(), YEAR(), DATE()
SELECT 
	YEAR('2017-01-20 23:59:59') AS Tahun,
	MONTH('2017-01-20 23:59:59') AS Bulan,
	DAY('2017-01-20 23:59:59') AS Tanggal,
	TIME('2017-01-20 23:59:59') AS Waktu,
	HOUR('2017-01-20 23:59:59') AS Jam,
	MINUTE('2017-01-20 23:59:59') AS Menit,
	SECOND('2017-01-20 23:59:59') AS Detik;


-- JOIN : INNER JOIN | LEFT OUTER JOIN | RIGHT OUTER JOIN
-- #######################################################

-- Menampilkan variant produk (products) dan waktu order (orders) 
SELECT variant, ORDER_TIME 
FROM products JOIN orders  ON orders.product_id = products.id ORDER BY products.id;

-- tampilkan semua products, orders mengikuti
SELECT variant, ORDER_TIME 
FROM products LEFT JOIN orders ON orders.product_id = products.id ORDER BY products.id;

-- tampilkan semua products, orders mengikuti
SELECT variant, ORDER_TIME
FROM orders RIGHT JOIN products ON orders.product_id = products.id ORDER BY products.id;

-- Empat pesanan terakhir untuk variant Mi Cakalang;
SELECT variant, price, order_time
FROM products 
JOIN orders ON products.id = orders.product_id
WHERE variant = 'Mi Cakalang' ORDER BY order_time DESC LIMIT 4 ;

-- alias column
SELECT variant AS 'Rasa', price AS Harga, order_time AS 'Waktu Pesanan'
FROM products 
JOIN orders ON products.id = orders.product_id
WHERE variant = 'Mi Cakalang' ORDER BY order_time DESC LIMIT 4 ;

-- alias table
SELECT variant AS 'Rasa', price AS Harga, order_time AS 'Waktu Pesanan'
FROM products p 
JOIN orders o ON p.id = o.product_id
WHERE variant = 'Mi Cakalang' ORDER BY order_time DESC LIMIT 4 ;

-- definisikan nama tabel saat hendak manampilkan suatu kolom yang sama
SELECT 
	p.id AS 'Product Id',
	variant AS 'Rasa', price AS Harga,
	o.id AS 'Order Id', order_time AS 'Waktu Pesanan' 
FROM products p 
JOIN orders o ON p.id = o.product_id;

-- Daftar pesanan berikut dengan nama pelanggan;
SELECT
	first_name 'Nama depan', last_name 'Nama belakang', phone_number 'Nomor telpon',
	order_time 'Waktu pemesanan'
FROM customers c
JOIN orders o ON c.id = o.customer_id;

-- Tampilkan daftar pesanan berikut dengan nama pelanggan dan juga variant yang dipesan.
-- first_name, last_name (customers)
-- order_time (orders)
-- variant (products)

SELECT
	first_name, last_name,
	variant,
	order_time
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN products p ON p.id = o.product_id;

SELECT
	first_name, last_name,
	variant,
	order_time
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN products p ON p.id = o.product_id
WHERE first_name = 'Elon';

SELECT
	first_name, last_name,
	variant,
	order_time
FROM customers 
JOIN orders ON customers.id = orders.customer_id
JOIN products ON products.id = orders.product_id
WHERE variant = 'Soto Banjar';

-- CASCADE  : Mengikut
-- SET NULL : Akan diganti jadi null
-- RESTRICT : Akan menggagalkan operasi

-- ON UPDATE CASCADE : Jika primary key berubah, maka foreign key akan ikut berubah
-- ON DELETE SET NULL : Jika primary key dihapus, maka foreign key akan di set menjadi null.

-- product_id : ON UPDATE CASCADE ON DELETE SET NULL (before)
-- product_id : ON UPDATE CASCADE ON DELETE RESTRICT (after)

-- Drop Foreign Key
ALTER TABLE orders
DROP FOREIGN KEY FK_ProductId;

-- (Re) Create Foreign Key
ALTER TABLE orders
ADD CONSTRAINT FK_ProductId
FOREIGN KEY (product_id) REFERENCES products(id) ON UPDATE CASCADE ON DELETE RESTRICT;

-- Add Column age, created_at, updated_at
-- created_at : kolom yang akan mencatat waktu saat data baru diinput
-- updated_at : kolom yang akan mencatat waktu terakhir kali data diupdate

-- data yang dikirim : first_name, last_name, age, phone_number
-- data yang terisi oleh mysql : id, created_at, updated_at
ALTER TABLE customers
ADD age INT AFTER last_name,
ADD created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- current_timestamp : waktu saat ini (saat data masuk)
ADD updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;


-- Sub Query

-- List produk yang pernah dipesan
SELECT DISTINCT product_id FROM orders;

-- List produk yang belum pernah dipesan / tidak ada di tabel orders
SELECT * FROM products
WHERE id NOT IN(SELECT DISTINCT product_id FROM orders);

-- AGGREGATE FUNCTION 💘 GROUP BY

-- AVG
-- Rata - rata harga mi
SELECT AVG(price) FROM products;
SELECT ROUND( AVG(price) , 2 ) AS average_price FROM products;
-- Rata - rata harga mi setiap daerah (origin)
-- kita lakukan group by pada kolom yang datanya duplicate
SELECT origin, AVG(price) FROM products GROUP BY origin;

-- COUNT
-- Jumlah data origin
SELECT COUNT(DISTINCT origin) FROM products;
-- Jumlah data yang kita miliki
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM discounts;
SELECT COUNT(*) FROM students;
-- Jumlah customer yang memiliki nama belakang
SELECT COUNT(last_name) FROM customers;
-- Jumlah variant tiap daerah (origin)
SELECT origin, COUNT(variant) AS total_variant FROM products GROUP BY origin;

-- SUM
-- total pendapatan seluruhnya
SELECT SUM(price) AS total_profit
FROM orders o
JOIN products p ON p.id = o.product_id;
-- total pendapatan untuk masing - masing variant
SELECT variant, SUM(price) AS total_profit
FROM orders o
JOIN products p ON p.id = o.product_id
GROUP BY variant ORDER BY total_profit;

-- MIN & MAX

-- Harga mi termahal
SELECT MAX(price) FROM products;

-- Umur paling tua
SELECT MAX(age) FROM customers;

-- Harga mi termurah
SELECT MIN(price) FROM products;

-- Umur paling muda
SELECT MIN(age) FROM customers;

