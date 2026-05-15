select day(trip_start_timestamp)as day , sum(Trip_Seconds)as Trip_Seconds, sum(Trip_Kilometers)as Trip_Kilometers, COUNT(*)as total_trips, sum(Trip_Total)as Trip_Total
from sep
group by day(trip_start_timestamp)
order by sum(Trip_Total)asc ,sum(Trip_Seconds) asc
--!(top)
-- 25	5787116	37299.62999999999	5866	97295.66
-- 4	5589211	34418.649999999994	5635	92017.22
-- 18	5405154	34910.81999999999	5688	91959.53
-- 24	5167004	33826.17	5525	90335.08
-- 11	5166295	33222.37	5366	86454.72

--!(bottom)
-- 6	3161292	21438.360000000004	3170	55784.15
-- 12	3350789	21360.699999999997	3419	56920.46
-- 13	3115238	24716.140000000007	2975	59903.52
-- 5	3939618	23315.370000000017	3989	63626.81
-- 20	3461672	26152.82	3179	64154.29

--*------------------------

with
    cte
    as
    (
        select day(trip_start_timestamp) as day, (pickup_community_area)as area , COUNT(*)as total,
            rank()over(PARTITION BY day(trip_start_timestamp) ORDER BY COUNT(*) desc ) as ranked
        from sep
        group by  day(trip_start_timestamp),(pickup_community_area)
    )
select day, area, total, round((100*total/sum(total) over()),2) as pct_total
from cte
where ranked = 1
order by total desc
-- 18	8	1422	4
-- 4	8	1385	4
-- 25	8	1381	4
-- 24	8	1291	3
-- 11	8	1279	3

--! all month days top1 pickup_area is (8)


--*------------------------


with
    cte
    as
    (
        select day(trip_start_timestamp) as day, (dropoff_community_area)as area , COUNT(*)as total,
            rank()over(PARTITION BY day(trip_start_timestamp) ORDER BY COUNT(*) desc ) as ranked
        from sep
        group by  day(trip_start_timestamp),(dropoff_community_area)
    )
select day, area, total, round((100*total/sum(total) over()),2) as pct_total
from cte
where ranked = 1
order by total desc

-- 18	8	1295	4
-- 4	8	1272	4
-- 25	8	1268	4
-- 10	8	1241	4
-- 24	8	1223	4




select DATEPART(HOUR,Trip_Start_Timestamp)
from sep


select DATEPART(HOUR,Trip_Start_Timestamp) as hour , sum(Trip_Seconds)as Trip_Seconds, sum(Trip_Kilometers)as Trip_Kilometers, COUNT(*)as total_trips, sum(Trip_Total)as Trip_Total,
    round(100*sum(Trip_Total)/sum(sum(Trip_Total)) over() ,2)as pct_total
from sep
group by DATEPART(HOUR,Trip_Start_Timestamp)
order by COUNT(*) desc ,sum(Trip_Total) desc
-- peak hour is 2 PM
-- 14
-- 15
-- 13
-- 17
-- 16

--  low hour 3 AM
-- 1
-- 5
-- 2
-- 4
-- 3


