-- display the entire data
select * from indian_weather_repository

-- display all column names
show columns from indian_weather_repository

-- delete column named last_updated
alter table indian_weather_repository
drop column last_updated;

-- find the location with highest wind speed
SELECT location_name, region, wind_kph
FROM indian_weather_repository
WHERE wind_kph = (SELECT MAX(wind_kph) FROM indian_weather_repository)

-- find locations with specific conditions (e.g., 'Clear')
SELECT location_name,region, condition_text, temperature_celsius
FROM indian_weather_repository
WHERE condition_text = 'Clear'
order by temperature_celsius desc

-- average humidity and pressure of each location
SELECT location_name, AVG(humidity) AS avg_humidity, AVG(pressure_mb) AS avg_pressure
FROM indian_weather_repository
GROUP BY location_name;

-- Query to identify locations experiencing sunrise and sunset within a specific time range
SELECT location_name,region, sunrise, sunset
FROM indian_weather_repository
WHERE sunrise BETWEEN '06:00 AM' AND '07:00 AM' AND sunset BETWEEN '06:00 PM' AND '07:00 PM'
ORDER BY sunrise,sunset;

-- maxium 15 temperatures by region
select * from indian_weather_repository
where(temperature_celsius,region) in (select max(temperature_celsius) as Maximum_Temperature, region from indian_weather_repository group by region)
limit 10

-- create a separate table for data where region is Kerala and display the 100 locations in kerala with maxium temperature
create table Kerala_Weather_Report as select * from indian_weather_repository
where region='Kerala'
--
select * from Kerala_Weather_Report
order by temperature_celsius desc 
limit 100

-- Find Locations with UV Index Above Threshold and Humidity above 50
SELECT location_name, uv_index, humidity, region
FROM indian_weather_repository
WHERE uv_index > 7 and humidity > 50;

-- Total Visibility for Each Region
SELECT region, SUM(visibility_km) AS total_visibility
FROM indian_weather_repository
GROUP BY region;

-- Longest daylight duration
SELECT location_name, (sunset - sunrise) AS daylight_duration,temperature_celsius,region
FROM indian_weather_repository
ORDER BY daylight_duration DESC
LIMIT 1;