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