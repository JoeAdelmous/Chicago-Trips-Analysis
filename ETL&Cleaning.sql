SELECT TOP (1000) *
  FROM [chicago].[dbo].[trips]
  where (Dropoff_Centroid_Latitude is not null 
  and pickup_Centroid_Longitude  is not null )
  and (Dropoff_Centroid_Longitude  is not null 
  and Pickup_Centroid_Latitude  is not null )
  and (Pickup_Community_Area is not null and Dropoff_Community_Area is not null)
  -- 3.4M


  select top (1000) REPLACE(Trip_Seconds, ',','')
  from trips

  update trips
  set Trip_Seconds =  REPLACE(Trip_Seconds, ',','')
  
alter table trips 
alter column Trip_Seconds bigint

alter table trips 
drop column  pickup_census_tract;

alter table trips 
drop column  dropoff_census_tract;

alter table trips 
drop column  dropoff_centroid_location;

alter table trips 
drop column  pickup_centroid_location;


update trips 
set Trip_Miles = round((Trip_Miles*1.60934),3)

alter table trips 
alter column trip_miles trip_km;

EXEC sp_rename 'trips.trip_miles',
               'trip_km',
               'COLUMN';

select count(*)
 FROM [chicago].[dbo].[trips]
  where (Dropoff_Centroid_Latitude is null 
  or pickup_Centroid_Longitude  is null )
  or (Dropoff_Centroid_Longitude  is null 
  or Pickup_Centroid_Latitude  is null )
  or (Pickup_Community_Area is null OR Dropoff_Community_Area is null)
  or Trip_Seconds is null
  -- 3.4M


delete FROM [chicago].[dbo].[trips]
  where (Dropoff_Centroid_Latitude is null 
  or pickup_Centroid_Longitude  is null )
  or (Dropoff_Centroid_Longitude  is null 
  or Pickup_Centroid_Latitude  is null )
  or (Pickup_Community_Area is null OR Dropoff_Community_Area is null)
  or Trip_Seconds is null
  -- 3.4M


delete 
 FROM [chicago].[dbo].[trips]
  where [Fare] is null
      or [Tips] is null 
      or [Tolls] is null
      or [Extras] is null
      or [Trip_Total] is null
  

  select count(*) 
 FROM [chicago].[dbo].[trips]
  where [Trip_Kilometers] is null

   delete 
 FROM [chicago].[dbo].[trips]
  where [Trip_Kilometers] is null


    select COUNT(*)/1E6
 FROM [trips]
  where [Payment_Type] is null
      or [Company] is null

-- ETL AND THE CLEANING Finished!!