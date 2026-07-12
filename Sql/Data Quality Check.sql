--DATA QUALITY CHECK

select * from customer;
select * from orders;
select * from payment;
select * from produk;
select * from reviews;
select * from shipping;

select count (*) from customer --Berisi 1000 data
select count(*) from orders --Berisi 10,000 data
select count (*) from payment --Berisi 10,000 data
select count (*) from produk --Berisi 300 data
select count (*) from reviews --Berisi 10,000 data
select count (*) from shipping --Berisi 10,000 data

SELECT 'customer' as nama_tabel, count(*) as total_rows
from customer
UNION ALL
SELECT 'orders', count(*) from orders
UNION ALL
SELECT 'payment', count(*) from payment 
UNION ALL
SELECT 'produk', count(*) from produk 
UNION ALL
SELECT 'reviews', count(*) from reviews
UNION ALL
SELECT 'shipping', count(*) from shipping;
--Semua data berhasil di-import sesuai

--NULL CHECK
select
	sum(Case When Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_null,
	sum(case when Customer_Name IS NULL THEN 1 ELSE 0 END) AS Customer_Name_null,
	sum(Case when Gender IS NULL THEN 1 ELSE 0 END) AS Gender_null,
	sum(Case When Age IS NULL THEN 1 ELSE 0 END) AS Age_null,
	sum(Case When City IS NULL THEN 1 ELSE 0 END) AS City_null,
	sum(Case When Join_Date IS NULL THEN 1 ELSE 0 END) AS Join_Date_null,
	sum(Case When Membership IS NULL THEN 1 ELSE 0 END) AS Membership_nulll
from customer;
SELECT
	sum(Case When Order_ID is null then 1 else 0 end) as Order_ID_Null,
	sum(case when Customer_ID is null then 1 else 0 end) as Customer_ID_null,
	sum(case when Product_ID is null then 1 else 0 end) as Product_ID_null,
	sum(case when Order_Date is null then 1 else 0 end) as Order_Date_null,
	SUM(case when Qty is null then 1 else 0 end) as Qty_null,
	sum(case when Discount is null then 1 else 0 end) as Discount_null,
	sum(case when Channel is null then 1 else 0 end) as Chanel_null,
	sum(case when Campaign is null then 1 else 0 end) as Campaign_null
from orders;
SELECT
	sum(case when Order_ID is null then 1 else 0 end) as Order_ID_null,
	sum(case when Method is null then 1 else 0 end)  as Method_null,
	sum(case when Status is null then 1 else 0 end) as Status_null
from payment;
SELECT
	sum(case when Product_ID is null then 1 else 0 end) as Product_ID_null,
	sum(case when Category is null then 1 else 0 end) as Categeory_null,
	sum(case when Brand is null then 1 else 0 end) as Brand_null,
	sum(case when Price is null then 1 else 0 end) as Price_null,
	sum(case when Cost is null then 1 else 0 end) as Cost_null
from produk;
SELECT
	sum(case when Order_ID is null then 1 else 0 end) as Order_ID_null,
	sum(case when Rating is null then 1 else 0 end) as aRating_null,
	sum(case when Review_Type is null then 1 else 0 end) as Review_null
from reviews;
SELECT
	sum(case when Order_ID is null then 1 else 0 end) as Order_ID_null,
	sum(case when Courier is null then 1 else 0 end) as Courier_null,
	sum(case when Shipping_Days is null then 1 else 0 end) as Shipping_null,
	sum(case when Status is null then 1 else 0 end) as Status_null
from shipping;
--Null Check aman (Tidak ada data Null)

--DUPLICATE CHECK
SELECT
Customer_ID,
COUNT(*) AS total_duplicate
FROM customer
GROUP BY Customer_ID
HAVING COUNT(*) > 1;
SELECT
	Order_ID,
	Count(*) as total_duplicate
	from orders 
	group by Order_ID 
Having COUNT(*) > 1;
SELECT
	Customer_ID,
	Count(*) as total_duplicate
	from orders 
	group by Customer_ID 
Having COUNT(*) > 1;
--Saat duplicate check Customer_ID di table orders muncul banyak data, itu normal ga?
--Jawaban: SANGAT NORMAL.
--Yang perlu dibedakan adalah primary key dan foreign key.
--Itu bukan duplicate yang salah, melainkan one-to-many relationship.

--DOMAIN CHECK
select
	Gender,
	count(*) as total_customer
	from customer
	group by Gender
	order by total_customer desc;
--Terdapat: Male (501) dan Female (499)
SELECT
Membership,
COUNT(*) AS total
FROM customer
GROUP BY Membership;
--Terdapat: Gold(311), Platinum(350), Silver(339)
select
	City,
	count(*) as total_kota
	from customer
	group by City
	order by total_kota desc;
--Medan (222), Semarang (199), Surabaya (198), Bandung (196), Jakarta (185)
SELECT
Status,
COUNT(*)
FROM shipping
GROUP BY Status;
--Terdapat: Cancel(416), Kirim(8.483), Terlambat(795), Returned(306)
SELECT
Status,
COUNT(*)
FROM payment
GROUP BY Status;
--Paid(7.571), Failed(2.429)
SELECT
Review_Type,
COUNT(*)
FROM reviews
GROUP BY Review_Type;
--Negative(3.980), Netral(1.978), Positif(4.042)

--RANGE CHECK
SELECT
    MIN(Age) AS Min_Age,
    MAX(Age) AS Max_Age,
    ROUND(AVG(Age),2) AS Avg_Age
FROM customer;
--Usia customer berada pada rentang 18–60 tahun dengan rata-rata usia sekitar 39 tahun. Tidak ditemukan nilai usia di luar rentang yang wajar.
SELECT 
    MIN(Price) AS Min_Price,
    MAX(Price) AS Max_Price,
    ROUND(AVG(Price),2) AS Avg_Price
FROM produk;
--Harga produk berada dalam rentang yang realistis dan tidak ditemukan nilai negatif atau nol.
SELECT
    MIN(Cost) AS Min_Cost,
    MAX(Cost) AS Max_Cost,
    ROUND(AVG(Cost),2) AS Avg_Cost
FROM produk;
SELECT
    MIN(Qty) AS Min_Qty,
    MAX(Qty) AS Max_Qty,
    ROUND(AVG(Qty),2) AS Avg_Qty
FROM orders;
--Jumlah pembelian per transaksi berkisar antara 1 hingga 5 unit dengan rata-rata sekitar 3 unit, menunjukkan pola pembelian yang masih wajar.
SELECT
    MIN(Discount) AS Min_Discount,
    MAX(Discount) AS Max_Discount,
    ROUND(AVG(Discount),2) AS Avg_Discount
FROM orders;
SELECT
    MIN(Shipping_Days) AS Min_Days,
    MAX(Shipping_Days) AS Max_Days,
    ROUND(AVG(Shipping_Days),2) AS Avg_Days
FROM shipping;
--Lama pengiriman berkisar antara 1 hingga 10 hari. Tidak ditemukan nilai pengiriman negatif atau di luar rentang yang masuk akal.
SELECT
    MIN(Rating) AS Min_Rating,
    MAX(Rating) AS Max_Rating,
    ROUND(AVG(Rating),2) AS Avg_Rating
FROM reviews;

--REFENTIAL INTEGRITY CHECK
SELECT o.Customer_ID
FROM orders o
LEFT JOIN customer c
ON o.Customer_ID = c.Customer_ID
WHERE c.Customer_ID IS NULL;
--semua order memiliki customer yang valid

=================================================================
----------------Data Quality Check------------------------------
1. Isi dalam data table sesuai, berisikan:
	a. customer (1000 data)
	b. orders (10.000 data)
	c. payment (10.000 data)
	d. produk (300 data)
	e. reviews (10.000 data)
	f. shipping (10.000 data)
2. Tidak ada data NULL
3. Tidak ada data duplikat
4. Domain check aman, berisikan:
	a. Gender(Male(501) & Female(499))
	b. Membership (Gold(311), Platinum(350), Silver(339))
	c. kota/customer (Medan(222), Semarang (199), Surabaya (198), Bandung (196), Jakarta (185)
	d. status (Cancel(416), Kirim(8.483), Terlambat(795), Returned(306))
	e. payment (Paid(7.571), Failed(2.429))
	f. reviews (Negative(3.980), Netral(1.978), Positif(4.042))
5. Usia mulai dari 18-60 tahun, rata2 39 tahun
6. Harga mulai dari 118.702 - 14.995.660 rata2 8.232.185
7. Pengeluaran mulai dari 102,661 - 12.575.060 rata2 5.683.651
8. Jumlah pembelian per transaksi berkisar antara 1 hingga 5 unit dengan rata-rata sekitar 3 unit
9. Harga diskon belum tersedia 
10. Lama pengiriman berkisar antara 1 hingga 10 hari
11. Rating mulai dari 1-5 dengan rata2 3
12. semua order memiliki customer yang valid



| Pemeriksaan           | Status | Temuan                                       |
| --------------------- | ------ | -------------------------------------------- |
| Struktur tabel        | ✅      | Semua tabel berhasil di-import               |
| Jumlah baris          | ✅      | Sesuai ekspektasi                            |
| Missing Value         | ✅      | Tidak ditemukan                              |
| Duplicate             | ✅      | Tidak ditemukan                              |
| Domain Value          | ✅      | Nilai kategori konsisten                     |
| Range Value           | ✅      | Semua nilai dalam rentang wajar              |
| Referential Integrity | ✅      | Tidak ditemukan foreign key yang tidak valid |

