--48 company
select DISTINCT Company
from trips

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


--  Types of declines 


select top (1000)
    *
from sep
where Trip_Kilometers = 0
    and Trip_Total = 0
    and Trip_Seconds = 0
--! Totally declined
-- 000

select *
from sep
where Trip_Kilometers = 0
    and Trip_Total != 0
    and Trip_Seconds = 0
--! take money without moving or work
--! 3K record
-- 010

select top (1000)
    *
from sep
where Trip_Kilometers != 0
    and Trip_Total = 0
    and Trip_Seconds != 0
--! work without pay 
--* 99.9% of them cash - one credit card
-- 101

select top (1000)
    *
from sep
where Trip_Kilometers != 0
    and Trip_Total != 0
    and Trip_Seconds = 0
--! Hazard 
-- 110

select top (1000)
    *
from sep
where Trip_Kilometers = 0
    and Trip_Total = 0
    and Trip_Seconds != 0
--! wait without money/talking with cus/negotiate 
-- 001

select *
from sep
where Trip_Kilometers = 0
    and Trip_Total != 0
    and Trip_Seconds != 0
--! wait and take money/talking with cus/negotiate 
--! 17K record
--011


--! there are many question mark on Taxi (Affiliation Services) company?
-- let's talk more about the (take money without moving or work) condition.
--* answer 1: stole money from customer 
--* answer 2: The timer and the Km calculator is broken.
--* answer 3: He asks the customers to stop the trip and take money without the tracker.

select 100*(select count(*)
    from sep
    where Company ='Taxi Affiliation Services' and Trip_Kilometers = 0
        and Trip_Total != 0
        and Trip_Seconds = 0)/count(*)
from sep
where Trip_Kilometers = 0
    and Trip_Total != 0
    and Trip_Seconds = 0

--! Taxi Affiliation Services make this condition 67%.