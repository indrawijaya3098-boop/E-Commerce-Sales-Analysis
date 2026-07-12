-- =====================================================
-- 1. Total Shipping
-- =====================================================

select
count(*) as Total_Shipping
from shipping;
--Total Shipping memiliki 10.000

-- =====================================================
-- 2. Courier Distribution
-- =====================================================

select
Courier,
count(*) as Total_Distribution
from shipping
group by Courier 
order by Total_Distribution desc;
--JNE merupakan kurir yang paling sering digunakan (2.533x)
--AnterAja merupakan kurir yang paling jarang digunakan (2.470x)
--Belum ada kurir yang sangat mendominasi dengan rentang penggunaan yang tidak terlalu signifikan

-- =====================================================
-- 3. Delivery Status Distribution
-- =====================================================

select
Status,
count(*) as Total_Distribution
from shipping
group by Status
order by Total_Distribution desc;
--Deliverd mendominasi status dengan jumlah (8.483x)
--Status Returned masih tergolong sedikit dengan jumlah (306x)

-- =====================================================
-- 4. Delivery Status Contribution
-- =====================================================

select
Status,
count(*) as Total_Distribution,
ROUND(
	count(*) * 100 / 
	(select COUNT(*) from shipping),2
	) as Contribution
from shipping 
group by Status
order by Contribution desc;
--Status Delivered berkontribusi sebesar 84% dari seluruh pengiriman

-- =====================================================
-- 5. Courier Contribution
-- =====================================================

SELECT 
Courier,
count(*) as Total_Distribution,
ROUND(
	count(*) *100 /
	(select COUNT(*) from shipping),2
) as Contribution
from shipping
group by Courier 
order by Contribution desc;
--Setiap kurir hampir memiliki kontribusi yang sama diantara 24%-25%

-- =====================================================
-- 6. AVG Shipping Days
-- =====================================================

select
ROUND(AVG(Shipping_Days),2) as Rata_Rata_Pengiriman
from shipping;
--Rata2 pengiriman 5 hari

-- =====================================================
-- 7. Pengiriman Tercepat&Terlama
-- =====================================================

select
max(Shipping_Days) as Terlama_Per_Hari,
min(Shipping_Days) as Tercepat_Per_Hari
from shipping;
--Waktu pengiriman terlama 10 Hari dan tercepat 1 Hari

-- =====================================================
-- 8. AVG Shipping days per-Courier
-- =====================================================

select
Courier,
avg(Shipping_Days) as Rata_Rata_Pengiriman
from shipping
group by Courier 
order by Rata_Rata_Pengiriman desc;
--Rata pengiriman per-Courier 5 hari

-- =====================================================
-- 9. Courier Ranking
-- =====================================================

SELECT
Courier,
ROUND(AVG(Shipping_Days),2) AS Avg_Shipping_Days
FROM shipping
GROUP BY Courier
ORDER BY Avg_Shipping_Days ASC;
--SiCepat memiliki rata-rata waktu pengiriman tercepat dari total Courier
--J&T kurir memiliki rata-rata waktu terlama

-- =====================================================
-- 10. Delivery Status per-Courier
-- =====================================================

SELECT
Courier,
Status,
COUNT(*) AS Total_Shipping
FROM shipping
GROUP BY Courier, Status
ORDER BY Courier, Total_Shipping DESC;
--Status Delivered mendominasi pada seluruh kurir.

-- =====================================================
-- 11. AVG Shipping Days per-Status
-- =====================================================

SELECT
Status,
ROUND(AVG(Shipping_Days),2) AS Avg_Shipping_Days
FROM shipping
GROUP BY Status
ORDER BY Avg_Shipping_Days DESC;
--Status Late memiliki rata-rata waktu pengiriman paling lama.


select Shipping_Days from shipping;
	
