-- trend pickup_community_area by month
select (pickup_community_area)as area , COUNT(*)as total
from sep
group by (pickup_community_area)
order by COUNT(*) desc
-- 8	32478
-- 32	17518
-- 28	14399
-- 76	8016
-- 6	6836

-- trend pickup_community_area by the trend day

select (pickup_community_area)as area , COUNT(*)as total, round((100*COUNT(*)/sum(COUNT(*)) over()) ,2)as pct_total
from sep
where  day(trip_start_timestamp) = 25
group by (pickup_community_area)
order by COUNT(*) desc
-- 8	1381	23
-- 32	726	12
-- 28	605	10
-- 76	330	5
-- 6	284	4

--*------------------------

-- trend dropoff_community_area by month
select (dropoff_community_area)as area , COUNT(*)as total
from sep
group by (dropoff_community_area)
order by COUNT(*) desc
-- 8	30439
-- 32	16294
-- 28	12826
-- 6	7877
-- 7	5505
