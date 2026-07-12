-- =====================================================
-- 1. Total Reviews
-- =====================================================

select
count(*) as Total_Reviews
from reviews;
--Total reviews 10.000

-- =====================================================
-- 2. Rating Distribution
-- =====================================================

select
Rating,
count(*) as Total_Distribution
from reviews
group by Rating 
order by Total_Distribution desc;
--Rating 4 memiliki kontribusi terbanyak yaitu (2.070)

-- =====================================================
-- 3. Reviews Sentiment Distribution
-- =====================================================

select
Review_Type,
count(*) as Reviews_Total,
ROUND(
	count(*) *100 /
	(select COUNT(*) from reviews),2
) as Contribution
from reviews
group by Review_Type 
order by Reviews_Total desc;
--Reviews positif mendapatkan posisi tertinggi dengan total(4.042) tetapi reviews negatif hampir mendekati dengan total (3.980)
--Reviews netral berada di angka(1.978)

-- =====================================================
-- 4. Rating Contribution
-- =====================================================

Select
Rating,
count(*) as Total_Distribution,
ROUND(
	count(*) *100 /
	(select COUNT(*) from reviews),2
) as Contribution
from reviews
group by Rating 
order by Contribution desc;
--Rating 4 & 1 berkontribusi 20% dibanding dengan lainnya yang mendapatkan masing2 19%

-- =====================================================
-- 5. Statistik
-- =====================================================

select
Max(Rating) as Rating_Tertinggi,
Min(Rating) as Rating_Terendah,
Round(Avg(Rating),2) as Rata_Rata_Rating
from reviews;
--Rating tertinggi adalah 5
--Rating terendah adalah 1
--Rata-rata rating 3