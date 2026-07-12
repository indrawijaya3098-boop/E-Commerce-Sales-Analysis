-- =====================================================
-- 1. Total Order
-- =====================================================
SELECT
COUNT(*) AS Total_Order
FROM orders;
--Total Order 10.000
-- =====================================================
-- 2. Total Quantity
-- =====================================================
SELECT
SUM(Qty) AS Total_Qty
FROM orders;
--Total QTY terjual 30.250
-- =====================================================
-- 3. Average Quantity
-- =====================================================
SELECT
ROUND(AVG(Qty),2) AS Avg_Qty
FROM orders;
--Rata2 terjual 3
-- =====================================================
-- 4. Average Discount
-- =====================================================
SELECT
ROUND(AVG(Discount)*100,2) AS Avg_Discount_Percent
FROM orders;

-- =====================================================
-- 5. Order per Channel
-- =====================================================
SELECT
Channel,
COUNT(*) AS Total_Order
FROM orders
GROUP BY Channel
ORDER BY Total_Order DESC;
--Website total(2.553), Tokped(2.501), App(2.476), Shopee(2.470)
-- =====================================================
-- 6. Order per Campaign
-- =====================================================
SELECT
Campaign,
COUNT(*) AS Total_Order
FROM orders
GROUP BY Campaign
ORDER BY Total_Order DESC;
--11.11 total(5.511), No Promo(2.503), 12.12(2.497), ramadhan(2.489)
-- =====================================================
-- 7. Discount Statistics
-- =====================================================
SELECT
MIN(Discount)*100 AS Min_Discount,
MAX(Discount)*100 AS Max_Discount,
ROUND(AVG(Discount)*100,2) AS Avg_Discount
FROM orders;

-- =====================================================
-- 8. Monthly Order Trend
-- =====================================================
SELECT
strftime('%Y-%m',Order_Date) AS Month,
COUNT(*) AS Total_Order
FROM orders
GROUP BY Month
ORDER BY Month;
--Cek tren perbulan
-- =====================================================
-- 9. Yearly Order Trend
-- =====================================================
SELECT
strftime('%Y',Order_Date) AS Year,
COUNT(*) AS Total_Order
FROM orders
GROUP BY Year
ORDER BY Year;
--Cek tren pertahun
-- =====================================================
-- 10. Top Channel
-- =====================================================
SELECT
Channel,
COUNT(*) AS Total_Order
FROM orders
GROUP BY Channel
ORDER BY Total_Order DESC
LIMIT 3;
--top 3. Website, Tokped, App
-- =====================================================
-- 11. Top Campaign
-- =====================================================
SELECT
Campaign,
COUNT(*) AS Total_Order
FROM orders
GROUP BY Campaign
ORDER BY Total_Order DESC;
--======================================================
--12. Quantity Distribution
--======================================================
SELECT
Qty,
COUNT(*) AS Total_Order
FROM orders
GROUP BY Qty
ORDER BY Qty;
--Mayoritas transaksi terdiri dari pembelian 1–3 unit, menunjukkan pola pembelian dalam jumlah kecil per transaksi.

--13. Chanel memiliki rata2 jumlah produk(qty) paling tinggi dalam tiap transaksi
SELECT 
Channel,
Round(Avg(Qty),2) as Avg_Qty
from orders
group by Channel
Order By Avg_Qty desc;

--14. Campaign yang menghasilkan total Qty terbanyak
select
Campaign,
Sum(Qty) as Total_Quantity
from orders
group by Campaign 
order by Total_Quantity desc;

--15. Channel Dengan transaksi paling sedikit
select
Channel,
count(*) as Total_Transaksi
from orders
group by Channel
order by Total_Transaksi asc;

--16. Persentase Kontribusi masing2 channel pada total transaksi
SELECT
    Channel,
    COUNT(*) AS Total_Order,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM orders),
        2
    ) AS Contribution_Percent
FROM orders
GROUP BY Channel
ORDER BY Contribution_Percent DESC;

=============================================================================
-------------------Data Finding Orders
=============================================================================
1. Total Order 10.000
2. Total Quantity Terjual 30.250
3. Rata2 terjual 3
4. Rata2 diskon belum tersedia
5. Total Order per-Channel : Website total(2.553), Tokped(2.501), App(2.476), Shopee(2.470)
6. Total Order per-Campaign : 11.11 total(5.511), No Promo(2.503), 12.12(2.497), ramadhan(2.489)
7. Tren Perbulan ....
8. Tren Pertahun memiliki penurunan yang tidak terlalu signifikan
9. Top Chanel adalah Website
10. Top Campaign 11.11
11. Rata2 qty tertinggi dalam Chanel adalah App
12. Campaign yang menghasilkan total qty terbanyak None
13. Persentase kontribusi masing2 chanel 24.76%, 25.01%, 25.53%

--