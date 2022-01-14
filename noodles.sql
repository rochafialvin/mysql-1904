SHOW DATABASES;

CREATE DATABASE noodles;

USE noodles;

SHOW TABLES;

CREATE TABLE products(
	id INT AUTO_INCREMENT PRIMARY KEY, -- PRIMARY KEY harus adalah sebuah kolom yang nilainya unique, AUTO_INCREMENT agar nilai pada id bertambah secara otomatis
	variant VARCHAR(30), -- Varchar (string) dengan maksimal 30 karakter
    price DECIMAL(3, 2), -- Jumlah digit total yang dimiliki maksimal adalah tiga digit, dengan dua digit di belakang koma
    -- 3.50, 1.00
    -- DECIMAL (5, 2) -- Maksimal terdapat 5 digit, dengan 2 digit di belakang koma
    -- benar : 3.50 , 23.34, 234.99,
    -- salah : 7689.99
    origin VARCHAR(20)
);

CREATE TABLE customers(
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    gender ENUM('M', 'F'), -- ENUM memungkinkan kita untuk menentukan value apa saja yang dapat disimpan pada suatu kolom
	phone_number VARCHAR(13)
);


CREATE TABLE orders(
	id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT, -- FOREIGN KEY untuk customers
    product_id INT, -- FOREIGN KEY untuk products
    order_time DATETIME,
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





























