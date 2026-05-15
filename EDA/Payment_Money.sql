select Payment_Type as Payment_Type , sum(Trip_Seconds)as Trip_Seconds, sum(Trip_Kilometers)as Trip_Kilometers, COUNT(*)as total_trips, sum(Trip_Total)as Trip_Total,
    round(100*sum(Trip_Total)/sum(sum(Trip_Total)) over() ,2)as pct_total
from sep
group by Payment_Type
order by sum(Trip_Total)desc ,sum(Trip_Seconds) asc

-- Cash	59110683	319236.4500000023	70314	882183.87	38.04
-- Credit Card	25412467	208169.9800000003	29339	628863.84	27.12
-- Prcard	28641498	220330.50000000015	22602	434708.98	18.74
-- Unknown	21114720	124363.37999999976	17188	347609.03	14.99
-- Mobile	890428	7578.66	1259	21651.16	0.93
-- Dispute	108900	350.8299999999999	72	2698.26	0.12
-- No Charge	66780	487.92	102	1395.25	0.06
-- Prepaid	2793	29.98	3	55.25	0.00

