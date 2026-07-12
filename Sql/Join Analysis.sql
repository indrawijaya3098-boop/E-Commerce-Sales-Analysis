Berapa total estimasi revenue perusahaan selama periode Januari 2024 – Desember 2025?
SELECT
    ROUND(SUM(p.Price * o.Qty),2) AS Total_Revenue
FROM orders o
INNER JOIN produk p
ON o.Product_ID = p.Product_ID;
--Total Revenue 247.441.764.295 Miliar

Bagaimana tren revenue perusahaan setiap bulan?
SELECT
    strftime('%Y-%m', o.Order_Date) AS Periode,
    ROUND(SUM(p.Price * o.Qty),2) AS Revenue
FROM orders o
INNER JOIN produk p
ON o.Product_ID = p.Product_ID
GROUP BY Periode
ORDER BY Periode;
--Revenue berada di kisaran Rp9,06 miliar – Rp11,12 miliar per bulan.
--Tidak ada bulan yang "meledak" jauh di atas bulan lainnya.
--Tidak ada tren naik terus atau turun terus.
--Revenue naik dan turun secara bergantian.

Business Question
Bagaimana klasifikasi transaksi berdasarkan estimasi revenue?
SELECT
    o.Order_ID,
    c.Customer_Name,
    p.Category,
    o.Qty,
    (p.Price * o.Qty) AS Revenue,
    CASE
        WHEN (p.Price * o.Qty) >= 5000000 THEN 'High Value'
        WHEN (p.Price * o.Qty) >= 2000000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Transaction_Class
FROM orders o
INNER JOIN customer c
ON o.Customer_ID = c.Customer_ID
INNER JOIN produk p
ON o.Product_ID = p.Product_ID
ORDER BY Revenue DESC;
--Sebagian besar transaksi termasuk kategori High Value. (8.788x) dari total (10.000 data)

Business Question
Bagaimana klasifikasi kepuasan pelanggan berdasarkan rating?
SELECT
Review_Type,
CASE
WHEN Rating >=4 THEN 'Satisfied'
WHEN Rating =3 THEN 'Neutral'
ELSE 'Unsatisfied'
END AS Customer_Satisfaction,
COUNT(*) AS Total
FROM reviews
GROUP BY
Review_Type,
Customer_Satisfaction
ORDER BY Total DESC;
--Positive	Satisfied	4042
--Negative	Unsatisfied	3980
--Neutral	Neutral	1978

=====================================================
PART A
CUSTOMER + ORDERS
=====================================================
1. Membership mana yang menghasilkan transaksi terbanyak?
select
c.Membership,
count(*) as Total_Transaksi
from customer c
inner join orders o
on c.Customer_ID = o.Customer_ID
group by c.Membership
order by Total_Transaksi desc;
--Platinum memiliki transaksi terbanyak dengan total (3.478)
--Tetapi Silver juga hampir sama banyak dengan total (3.473)
--Gold memiliki transaksi terbawah dengan total (3.049)
2. Membership mana yang membeli quantity paling banyak?
select
c.Membership,
Round(Sum(o.Qty),2) as Total_Quantity
from customer c
inner join orders o
on c.Customer_ID = o.Customer_ID
group by c.Membership
order by Total_Quantity desc;
--Platinum memiliki pembelian qty terbanyak dengan total (10.618)
--Silver juga memiliki pembelian yang tidak jauh sama banyaknya dengan total (10.511)
--Gold memiliki pembelian qty terbawah dengan total (9.121)
3. Kota mana yang memiliki transaksi terbanyak?
select
c.City,
count(*) as Total_Transaksi
from customer c
inner join orders o
on c.Customer_ID = o.Customer_ID
group by c.City
order by Total_Transaksi desc;
--Medan mendominasi untuk transaksi terbanyak dengan total (2.293)
--Surabaya dan bandung cenderung memiliki transaksi yang mirip dengan total (1.994) & (1.953)
--Semarang (1.910) & Jakarta (1.850)
4. Kota mana yang membeli quantity paling banyak?
select
c.City,
round(sum(o.Qty),2) as Total_Quantity
from customer c
inner join orders o
on c.Customer_ID = o.Customer_ID
group by c.City
order by Total_Quantity desc;
--Medan memiliki pembelian dengan quantity terbanyak (6.925)
--Surabaya (6.048) & Bandung (5.892)
--Semarang (5.745) & Jakarta (5.640)
5. Rata-rata quantity berdasarkan membership.
select
c.Membership,
round(avg(o.Qty),2) as Rata_Rata_Qty
from customer c
inner join orders o
on c.Customer_ID = o.Customer_id
group by c.Membership
order by Rata_Rata_Qty desc;
--Rata2 Qty tiap membership relatif sama yaitu (3,05), (3,03) & (2.99)
6. Rata-rata umur customer berdasarkan membership.
select
Membership,
Round(avg(Age),2) as Rata_Rata_Umur
from customer
group by Membership
order by Rata_Rata_Umur desc;
--Rata2 umur di tiap membership diantara 39-40 tahun
=====================================================
PART B
ORDERS + PRODUCT
=====================================================
7. Kategori produk paling sering dibeli.
select
p.Category,
count(*) as Terbanyak_Dibeli
from produk p
inner join orders o
on p.Product_ID = o.Product_ID
group by p.Category
order by Terbanyak_Dibeli desc;
--Printer adalah kategori paling sering dibeli (2.321), begitu juga Monitor yang hampir sama banyaknya (2.265)
--Accessory terbanyak dibeli (1.900) di ikuti dengan Laptop (1.797) dan Phone (1.717)
8. Brand yang paling sering dibeli.
select
p.Brand,
count(*) as Terbanyak_Dibeli
from produk p
inner join orders o
on p.Product_ID = o.Product_ID
group by p.Brand
order by Terbanyak_Dibeli desc;
--Brand 18 paling banyak dibeli dengan total (821) di ikuti dengan Brand15 (682) dan Brand8 (608)
9. Total quantity per kategori.
select
p.Category,
round(sum(o.Qty),2) Total_Qty
from produk p
inner join orders o
on p.Product_ID = o.Product_ID
group by p.Category
order by Total_Qty desc;
--Printer memiliki total qty tertinggi (6.944) dan Monitor memiliki total qty yang tidak jauh sama tingginya (6.833)
--Accessory, Laptop, dan Phone relatif sama di total (5.736), (5.464), dan (5.273)
10. Total quantity per brand.
SELECT 
p.Brand,
round(sum(o.Qty),2) as Total_Qty
from produk p
inner join orders o
on p.Product_ID = o.Product_ID
group by p.Brand
order by Total_Qty desc;
--Brand 18 memiliki total qty tertinggi (2.526) di ikuti dengan Brand15 (2.068)
11. Average quantity setiap kategori.
select
p.Category,
round(avg(o.Qty),2) as Rata_rata_Qty
from produk p
inner join orders o
on p.Product_ID = o.Product_ID
group by p.Category
order by Rata_rata_Qty desc;
--rata2 qty per-produk relatif sama dengan range antara 2.99%-3.07%
12. Revenue potensial setiap kategori
SELECT
    p.Category,
    ROUND(SUM(p.Price * o.Qty),2) AS Revenue
FROM produk p
INNER JOIN orders o
ON p.Product_ID = o.Product_ID
GROUP BY p.Category
ORDER BY Revenue DESC;
--Printer	57873780733
--Monitor	57017940863
--Accessory	46783339942
--Phone	43544757448
--Laptop	42221945309
=====================================================
PART C
ORDERS + PAYMENT
=====================================================
13. Payment Method paling banyak digunakan pada setiap Channel.
WITH Payment_Rank AS (
SELECT
    o.Channel,
    p.Methods,
    COUNT(*) AS Total_Payment,
    ROW_NUMBER() OVER(
        PARTITION BY o.Channel
        ORDER BY COUNT(*) DESC
    ) AS Ranking
FROM payment p
INNER JOIN orders o
ON p.Order_ID = o.Order_ID
GROUP BY
o.Channel,
p.Methods )
SELECT * FROM Payment_Rank
WHERE Ranking = 1;
--App	Transfer	522	1
--Shopee	Credit Card	516	1
--Tokopedia	COD	512	1
--Website	COD	544	1
14. Status pembayaran berdasarkan Channel.
select
p.Status,
o.Channel,
count(o.Channel) as Total_Status
from payment p
inner join orders o
on p.Order_ID = o.Order_ID
group by p.Status, o.Channel
order by Total_Status desc;
--Paid	Website	1932
--Paid	Tokopedia	1885
--Paid	App	1882
--Paid	Shopee	1872
--Failed	Website	621
--Failed	Tokopedia	616
--Failed	Shopee	598
--Failed	App	594

15. Payment Method Contribution.
select
Methods,
Round(count(*) *100 /
	(select count(*) from payment),2
) as Contribution
from payment 
group by Methods
order by Contribution desc;
--Transfer	20.0
--COD	20.0
--QRIS	19.0
--E-Wallet	19.0
--Credit Card	19.0
=====================================================
PART D
ORDERS + SHIPPING
=====================================================
16. Channel mana yang memiliki rata-rata pengiriman paling lama?
select
o.Channel,
Round(avg(s.Shipping_Days),2) as Rata_Rata_Pengiriman
from orders o
inner join shipping s 
on o.Order_ID = s.Order_ID
group by o.Channel
order by Rata_Rata_Pengiriman asc;
--App	5.45
--Shopee	5.47
--Tokopedia	5.53
--Website	5.62

17. Courier yang paling sering digunakan pada setiap Channel.
WITH Payment_Rank AS (
SELECT
    o.Channel,
    s.Courier,
    COUNT(*) AS Total_Digunakan,
    ROW_NUMBER() OVER(
        PARTITION BY o.Channel
        ORDER BY COUNT(*) DESC
    ) AS Ranking
FROM shipping s
INNER JOIN orders o
ON s.Order_ID = o.Order_ID
GROUP BY
s.Courier,
o.Channel
ORDER BY Total_Digunakan DESC)
SELECT * FROM Payment_Rank
WHERE Ranking = 1;
--Website	J&T	664	1
--App	AnterAja	651	1
--Shopee	JNE	642	1
--Tokopedia	JNE	633	1
18. Status pengiriman berdasarkan Channel.
select
s.Status,
o.Channel,
count(o.Channel) as Total_Status
from shipping s
inner join orders o
on s.Order_ID = o.Order_ID
group by s.Status, o.Channel
order by Total_Status desc;
---Delivered	Website	2171
--Delivered	Shopee	2116
--Delivered	Tokopedia	2115
--Delivered	App	2081
--Late	App	214
--Late	Tokopedia	207
--Late	Website	194
--Late	Shopee	180
--Cancelled	Shopee	107
--Cancelled	App	106
--Cancelled	Tokopedia	104
--Cancelled	Website	99
--Returned	Website	89
--Returned	App	75
--Returned	Tokopedia	75
--Returned	Shopee	67
19. Average Shipping Days per Channel.
select
o.Channel,
Round(avg(s.Shipping_Days),2) as Rata2_Pengiriman
from orders o
inner join shipping s 
on o.Order_ID = s.Order_ID
group by o.Channel
order by Rata2_Pengiriman desc;
--Rata2 Pengiriman relatif sama tiap channel yaitu 5 hari

=====================================================
PART E
ORDERS + REVIEW
=====================================================
20. Rating rata-rata berdasarkan Channel.
select
o.Channel,
Round(avg(r.Rating),2) as Rata2_Rating
from orders o
inner join reviews r
on o.Order_ID = r.Order_ID
group by o.Channel
order by Rata2_Rating desc;
--Rating disetiap Channel relatif sama di skala 2.9-3.04
21. Distribusi Review Type pada setiap Channel.
SELECT
    o.Channel,
    r.Review_Type,
    COUNT(*) AS Total_Review
FROM orders o
INNER JOIN reviews r
ON o.Order_ID = r.Order_ID
GROUP BY
    o.Channel,
    r.Review_Type
ORDER BY
    o.Channel,
    Total_Review DESC;
--App	Positive	1014
--App	Negative	977
--App	Neutral	485
--Shopee	Negative	1018
--Shopee	Positive	968
--Shopee	Neutral	484
--Tokopedia	Positive	1040
--Tokopedia	Negative	959
--Tokopedia	Neutral	502
--Website	Negative	1026
--Website	Positive	1020
--Website	Neutral	507

22. Average Rating berdasarkan Campaign.
select
o.Campaign,
Round(avg(r.Rating),2) as Rata2_Rating
from orders o
inner join reviews r
on o.Order_ID = r.Order_ID
group by o.Campaign
order by Rata2_Rating desc;
--Rating pada setiap Campaign hampir memiliki rata2 rating yang relatif sama di skala 2,94-3,02

=====================================================
PART F
MULTI JOIN
=====================================================
23.Kategori TERATAS tiap Membership?
WITH Category_Rank AS (
SELECT
    c.Membership,
    p.Category,
    COUNT(*) AS Total_Order,
    ROW_NUMBER() OVER(
        PARTITION BY c.Membership
        ORDER BY COUNT(*) DESC
    ) AS Ranking
FROM customer c
INNER JOIN orders o
ON c.Customer_ID=o.Customer_ID
INNER JOIN produk p
ON o.Product_ID=p.Product_ID
GROUP BY
c.Membership,
p.Category )
SELECT *
FROM Category_Rank
WHERE Ranking=1;
--Gold paling sering membeli kategori monitor 698
--Platinum paling sering membeli printer 796
--Silver paling sering membeli printer 831
24.Kota mana yang menghasilkan revenue terbesar pada setiap kategori?
SELECT
    c.City,
    p.Category,
    ROUND(SUM(p.Price * o.Qty),2) AS Revenue
FROM customer c
INNER JOIN orders o
ON c.Customer_ID=o.Customer_ID
INNER JOIN produk p
ON o.Product_ID=p.Product_ID
GROUP BY
c.City,
p.Category
ORDER BY Revenue DESC;
--Kota Medan menghasilkan revenue terbesar dalam kategori printer (13,2M) Accessory (10,9M) Laptop (10.3M) dan Phone (9,7M)
--Kota Surabaya menghasilkan revenue terbesar dalam kategori monitor (12.2M)
25.Metode pembayaran apa yang paling sering digunakan pada setiap status pengiriman?
SELECT
    s.Status,
    p.Methods,
    COUNT(*) AS Total_Transaction
FROM orders o
INNER JOIN payment p
ON o.Order_ID=p.Order_ID
INNER JOIN shipping s
ON o.Order_ID=s.Order_ID
GROUP BY
s.Status,
p.Methods
ORDER BY
s.Status,
Total_Transaction DESC;
--Metode pembayaran transfer paling sering digunakan dalam status cancelled
--Metode pembayaran cod paling sering digunakan dalam status delivered
--Metode pembayaran e-wallet paling sering digunakan dalam status late
--Metode pembayaran cod paling sering digunakan dalam status returned
26.Apakah rata-rata rating dipengaruhi oleh lama pengiriman?
SELECT
    s.Shipping_Days,
    ROUND(AVG(r.Rating),2) AS Avg_Rating
FROM shipping s
INNER JOIN reviews r
ON s.Order_ID=r.Order_ID
GROUP BY
s.Shipping_Days
ORDER BY
s.Shipping_Days;
--Berdasarkan dataset, lama pengiriman belum menunjukkan hubungan yang konsisten terhadap rata-rata rating pelanggan. 
--Kemungkinan terdapat faktor lain yang lebih memengaruhi kepuasan pelanggan selain durasi pengiriman.

27.Membership mana yang menghasilkan estimasi revenue terbesar berdasarkan metode pembayaran?
SELECT
    c.Membership,
    p.Methods,
    ROUND(SUM(pr.Price * o.Qty),2) AS Revenue
FROM customer c
INNER JOIN orders o
ON c.Customer_ID=o.Customer_ID
INNER JOIN produk pr
ON o.Product_ID=pr.Product_ID
INNER JOIN payment p
ON o.Order_ID=p.Order_ID
GROUP BY
c.Membership,
p.Methods
ORDER BY Revenue DESC;
--Membership Platinum dengan metode pembayaran COD menghasilkan estimasi revenue tertinggi sebesar Rp17,91 miliar.
--Membership Platinum memberikan kontribusi revenue tertinggi pada metode pembayaran COD, namun perbedaan revenue antar membership dan metode pembayaran relatif kecil sehingga belum menunjukkan dominasi yang signifikan.
--Platinum	COD	17910730988
--Platinum	E-Wallet	17878876355
--Silver	Transfer	17741791188
--Silver	Credit Card	17148727902
--Silver	COD	17037823568
--Platinum	Credit Card	17025850017
--Platinum	Transfer	17020458131
--Platinum	QRIS	16872164435
--Silver	E-Wallet	16750721585
--Silver	QRIS	16465508764
--Gold	COD	15878699843
--Gold	QRIS	15195874851
--Gold	Transfer	15170226997
--Gold	E-Wallet	15111631166
--Gold	Credit Card	14232678505