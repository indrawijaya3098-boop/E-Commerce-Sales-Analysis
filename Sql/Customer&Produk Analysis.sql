--CUSTOMER ANALYSIS
--Query Ringkasan Customer yang Benar
-- Ringkasan Customer
SELECT
    COUNT(*) AS Total_Customer,
    AVG(Age) AS Rata_Rata_Umur,
    MAX(Age) AS Umur_Tertua,
    MIN(Age) AS Umur_Termuda
FROM customer;
--Total Cust(1.000), Rata2 umur(39), tertua(60), termuda(18)
SELECT
    Gender,
    COUNT(*) AS Total
FROM customer
GROUP BY Gender
ORDER BY Total DESC;
--laki(501), perempuan(499)
SELECT 
count(*) as Total_Membership
from customer;

SELECT
    Membership,
    COUNT(*) AS Total
FROM customer
GROUP BY Membership
ORDER BY Total DESC;
--platinum(350), silver(339), gold(311)
SELECT 
count(*) as Total_Kota
from customer;
SELECT
    City,
    COUNT(*) AS Total_Customer
FROM customer
GROUP BY City
ORDER BY Total_Customer DESC;
--medan(222), semarang(199), sby(198), bandung(196), jkt(185)
-- Top 5 Kota

--PRODUK ANALYSIS
-- Total Produk
SELECT
COUNT(*) AS Total_Product
FROM produk;
--300 produk
SELECT
COUNT(DISTINCT Brand) AS Total_Brand
FROM produk;
--20 Brand
SELECT
COUNT(DISTINCT Category) AS Total_Category
FROM produk;
--5 kategori
SELECT
Category,
COUNT(*) AS Total_Product
FROM produk
GROUP BY Category
ORDER BY Total_Product DESC;
--Printer(71), Monitor(69), Accesory(55), Laptop(54), HP(51)
SELECT
Brand,
COUNT(*) AS Total_Product
FROM produk
GROUP BY Brand
ORDER BY Total_Product DESC;
--brand18(24), brand15(21), brand8(18), brand14(18), brand17(17), brand1(17), brand5(16), brand7(15), brand2(15),
--brand20(14), brand11(14), brand4(13), brand16(13), brand10(13), brand9(12), brand6(11), brand19(11), brand13(11), brand3(9)
SELECT
MIN(Price),
MAX(Price),
ROUND(AVG(Price),2)
FROM produk;
--harga max(14.995.660), min(118.702), avg(8.232.185)
SELECT
MIN(Cost),
MAX(Cost),
ROUND(AVG(Cost),2)
FROM produk;
--cost max(12.575.060), min(102.661), avg(5.683.651)
SELECT
MIN(Price-Cost) AS Min_Margin,
MAX(Price-Cost) AS Max_Margin,
ROUND(AVG(Price-Cost),2) AS Avg_Margin
FROM produk;
--margin max(6.460.930), min(16.041), avg(2.548.534)
SELECT
Product_ID,
Category,
Brand,
Price
FROM produk
ORDER BY Price DESC
LIMIT 10;
--10 produk termahal
SELECT
Product_ID,
Category,
Brand,
Price,
Cost,
(Price-Cost) AS Margin
FROM produk
ORDER BY Margin DESC
LIMIT 10;
--top 10 margin
