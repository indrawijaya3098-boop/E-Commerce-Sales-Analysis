-- =====================================================
-- 1. Total Payment
-- =====================================================

SELECT
COUNT(*) AS Total_Payment
FROM payment;
--Total payment memiliki 10.000

-- =====================================================
-- 2. Payment Method Distribution
-- =====================================================

SELECT 
Methods,
count(*) as Total_Transaction
from payment
GROUP by Methods 
ORDER by Total_Transaction desc;
--COD paling banyak digunakan (2.034)
--Transfer (2.016) kedua
--E-wallet (1.996) ketiga
--Credit Card (1.980) & Qris (1.974) paling rendah

-- =====================================================
-- 3. Payment Status
-- =====================================================

select
Status,
count(*) as Total
from payment
group by Status 
order by Total desc;
--Status Paid (7.571) dan Failed (2.429) Mayoritas transaksi dibayar

-- =====================================================
-- 4. Kontribusi Masing2 Metode pembayaran per-transaksi
-- =====================================================

select
Methods,
count(*) as Total_Pembayaran,
round(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM payment),
        2
    ) AS Contribution_Percent
FROM payment
GROUP BY Methods
ORDER BY Contribution_Percent DESC;
--Metode Pembayaran COD memiliki persentase tertinggi 20.34%
--Metode Pembayaran Qris memiliki persentase terendah 19.74%
--Perbedaan kontribusi antar metode pembayaran relatif kecil, sehingga penggunaan metode pembayaran pada dataset terlihat cukup merata.

-- =====================================================
-- 5. Payment Method Terpopuler
-- =====================================================

select
Methods,
count(*) as Total_Pembayaran
from payment 
group by Methods
order by Total_Pembayaran desc
limit 1;
--Metode pembayaran cod paling banyak di gunakan

-- =====================================================
-- 6. Persentase Payment Status
-- =====================================================

select
Status,
count(*) as Total_Status,
round(
	count(*) *100 /
	(select count(*) from payment),2
	) as Total_Contribution_Percent
from payment
group by Status 
order by Total_Contribution_Percent desc;
--Sebagian besar transaksi memiliki status Paid dengan kontribusi sebesar 74,80%, sedangkan transaksi Failed sebesar 25,20%. Hal ini menunjukkan mayoritas proses pembayaran pada dataset berhasil diselesaikan.
