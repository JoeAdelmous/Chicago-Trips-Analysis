--! EDA:

select top (1000)
    *
from trips


    select 'Trip_Seconds' as name , (max(Trip_Seconds) /60) as max , (AVG(Trip_Seconds)/60) as avg
    from trips
UNION ALL
    select 'fare' as name , (max(fare) ) as max , (AVG(fare)) as avg
    from trips
UNION ALL
    select 'tips' as name , (max(tips) ) as max , (AVG(tips)) as avg
    from trips
UNION ALL
    select 'extras' as name , (max(extras) ) as max , (AVG(extras)) as avg
    from trips
UNION ALL
    select 'trip_total' as name , (max(trip_total) ) as max , (AVG(trip_total)) as avg
    from trips
UNION ALL
    select 'trip_kilometers' as name , (max(trip_kilometers) ) as max , (AVG(trip_kilometers)) as avg
    from trips


select DISTINCT Dropoff_Community_Area
from trips
-- 77 area 


select top (1000)
    *
from trips


--48 company
select DISTINCT Company
from trips

select count(*)/1e3
from trips
where Payment_Type = 'Unknown'
-- 163K record

select top (1000)
    *
from trips


--* before any thing u must make integration!

create view sep
as
    (
    select *
    from trips
    where month(Trip_Start_Timestamp) = 9
)



select *
from sep



    select 'Trip_Seconds' as name , (max(Trip_Seconds) /60) as max , (AVG(Trip_Seconds)/60) as avg
    from sep
UNION ALL
    select 'fare' as name , (max(fare) ) as max , (AVG(fare)) as avg
    from sep
UNION ALL
    select 'tips' as name , (max(tips) ) as max , (AVG(tips)) as avg
    from sep
UNION ALL
    select 'extras' as name , (max(extras) ) as max , (AVG(extras)) as avg
    from sep
UNION ALL
    select 'trip_total' as name , (max(trip_total) ) as max , (AVG(trip_total)) as avg
    from sep
UNION ALL
    select 'trip_kilometers' as name , (max(trip_kilometers) ) as max , (AVG(trip_kilometers)) as avg
    from sep

-- Trip_Seconds	1439	16
-- fare	828.38	15.0595
-- tips	100	0.8061
-- extras	555.55	0.5365
-- trip_total	828.38	16.4621
-- trip_kilometers	342.15	6.250382952746725

select *
from sep


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





select *
from sep

select company as company , sum(Trip_Seconds)as Trip_Seconds, sum(Trip_Kilometers)as Trip_Kilometers, COUNT(*)as total_trips, sum(Trip_Total)as Trip_Total,
    round(100*sum(Trip_Total)/sum(sum(Trip_Total)) over() ,2)as pct_total
from sep
group by company
order by sum(Trip_Total)desc ,sum(Trip_Seconds) asc
-- Flash Cab	55696983	392527.85999999964	52541	832578.22	35.90
-- Taxi Affiliation Services	39426600	206796.21999999907	44987	732679.72	31.59
-- Medallion Leasin	8562466	60502.93999999999	9180	158982.95	6.86
-- Taxicab Insurance Agency, LLC	3727200	30871.69	5056	86414.92	3.73
-- Sun Taxi	7548368	33678.76	5055	83204.63	3.59


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

select *
from sep


with cte
as
(
select day(trip_start_timestamp) as day, (dropoff_community_area)as area , COUNT(*)as total,
    rank()over(PARTITION BY day(trip_start_timestamp) ORDER BY COUNT(*) desc ) as ranked
from sep
group by  day(trip_start_timestamp),(dropoff_community_area))
select day, area, total, round((100*total/sum(total) over()),2) as pct_total
from cte
where ranked = 1
order by total desc

-- 18	8	1295	4
-- 4	8	1272	4
-- 25	8	1268	4
-- 10	8	1241	4
-- 24	8	1223	4

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

select *
from sep


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

select *
from sep


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

--! We've extracted nice insights for work 📈




-- Deep dive
--! with python wit an i coming!!