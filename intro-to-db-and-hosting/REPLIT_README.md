# TUHSD Hackathon 2023
_Intro to DB REPL.it_


## Terminology

| Term     | Spreadsheet Equivalent |
|----------|------------------------|
| Database | File                   |
| Table    | Sheet / Tab            |
| Schema   | Headers / Format       |
| Entry    | Row                    |


## Basic Queries

__Hello World__

```sql
SELECT "Hello World";
```

__Select everything from a table__

```sql
SELECT * FROM weather;
```

__Some examples of filtering:__

```sql
---
--- Get all weather types that include precipitation
---
SELECT * 
  FROM weather
  WHERE Precipitation = TRUE;

---
--- You can also limit the columns returned
---
SELECT Name, Description
  FROM weather
  WHERE Precipitation = FALSE;

---
--- You can also get more complex with your filtering
--- Maybe you want to filter to only weather where the description mentions clouds
---
SELECT *
  FROM weather
  WHERE
    Description LIKE '%cloud%';

---
--- Well, that's not going to work very well.... 
--- We probably don't want Sunny included
---
SELECT *
  FROM weather
  WHERE
    Id > 1
    AND Description LIKE '%cloud%';
  
---
--- If you want to see how many results you're getting
---
SELECT COUNT(*)
  FROM weather
  WHERE
    Id > 1
    AND Description LIKE '%cloud%';
```

## Creating a Table


__This is how our existing tables were created__

```sql
---
--- Create a table for Cities
---
CREATE TABLE cities(
  Id       INTEGER NOT NULL PRIMARY KEY
 ,Name     VARCHAR(25) NOT NULL
 ,State    VARCHAR(2) NOT NULL
 ,Lat      TEXT NOT NULL
 ,Lon      TEXT NOT NULL
);

---
--- Create a table for weather types
---
CREATE TABLE weather(
  Id                   INTEGER NOT NULL PRIMARY KEY
 ,Name                 VARCHAR(30) NOT NULL
 ,Precipitation        BOOLEAN NOT NULL 
 ,Description           TEXT NOT NULL
);
```

__Let's create a table for weather data__

```sql
---
--- Create a table for date-series weather data
---
CREATE TABLE weather_data(
  Date                     REAL NOT NULL 
  ,City                    INTEGER NOT NULL
  ,Weather                 INTEGER NOT NULL
  ,High                    INTEGER NOT NULL
  ,Low                     INTEGER NOT NULL
  ,FOREIGN KEY(City)       REFERENCES cities(Id)
  ,FOREIGN KEY(Weather)    REFERENCES weather(Id)
);
```

## Creating Rows/Entries in a Table

```sql

---
--- Let's add a day from last summer to each city
---
INSERT INTO weather_data(Date, City, Weather, High, Low)
  VALUES (julianday("2022-07-04"), 1, 5, 106, 84);
INSERT INTO weather_data(Date, City, Weather, High, Low)
  VALUES (julianday("2022-07-04"), 2, 1, 81, 68);
INSERT INTO weather_data(Date, City, Weather, High, Low)
  VALUES (julianday("2022-07-04"), 3, 2, 68, 52);
INSERT INTO weather_data(Date, City, Weather, High, Low)
  VALUES (julianday("2022-07-04"), 4, 2, 75, 66);
INSERT INTO weather_data(Date, City, Weather, High, Low)
  VALUES (julianday("2022-07-04"), 5, 2, 99, 77);

---
--- We can check our work with this query
---
SELECT * FROM weather_data WHERE Date = julianday("2022-07-04");
```

## Updating an Entry/Row

```sql
---
--- It's not obvious, but we made a mistake above.
--- We said it was snowing in Phoenix rather than sunny.
--- We can fix that by updating that data row
---
UPDATE weather_data
  SET Weather = 1
  WHERE City = 1 AND Date = julianday("2022-07-04");
```

## Joining Tables

```sql
---
--- Now this works, but it would be nice to see something more meaningful than the ID# of the city and weather
--- We can do this in a single query, by performing a JOIN.

--- 
--- Let's get all weather data for July 4th of last year
---
SELECT 
  d.Date, 
  c.Name, 
  w.Name,
  d.High,
  d.Low
FROM weather_data as d
  LEFT OUTER JOIN weather as w
    ON d.Weather = w.Id
  LEFT OUTER JOIN cities as c
    ON d.City = c.Id
WHERE d.Date = julianday("2022-07-04");

---
--- You can also alias columns to make the output more legible
---
SELECT 
  d.Date, 
  c.Name as City, 
  w.Name as Weather,
  d.High,
  d.Low
FROM weather_data as d
  LEFT OUTER JOIN weather as w
    ON d.Weather = w.Id
  LEFT OUTER JOIN cities as c
    ON d.City = c.Id
WHERE d.Date = julianday("2022-07-04");
```

__You can also sort the results__

```sql
---
--- Let's say you want to get the results for Phoenix, sorted by date
---
SELECT 
  d.Date, 
  c.Name as City, 
  w.Name as Weather,
  d.High,
  d.Low
FROM weather_data as d
  LEFT OUTER JOIN weather as w
    ON d.Weather = w.Id
  LEFT OUTER JOIN cities as c
    ON d.City = c.Id
WHERE d.City = 1
ORDER by d.Date DESC;

---
--- That's pretty good, but let us make the date more human readable
---
SELECT 
  date(d.Date) as Date, 
  c.Name as City, 
  w.Name as Weather,
  d.High,
  d.Low
FROM weather_data as d
  LEFT OUTER JOIN weather as w
    ON d.Weather = w.Id
  LEFT OUTER JOIN cities as c
    ON d.City = c.Id
WHERE d.City = 1
ORDER by d.Date DESC;
```

__Grouping is an option as well__

```sql
---
--- What if you want to see how many days of each weather type we have for Phoenix?
---
SELECT 
  COUNT(*) as Days, 
  w.Name as Weather
FROM weather_data as d
  LEFT OUTER JOIN weather as w
    ON d.Weather = w.Id
  LEFT OUTER JOIN cities as c
    ON d.City = c.Id
GROUP by d.Weather;

---
--- What if you want to know how Rainy days phoenix had in Feb?
---
SELECT 
  c.Name as City, 
  COUNT(*) as Days, 
  w.Name as Weather
FROM weather_data as d
  LEFT OUTER JOIN weather as w
    ON d.Weather = w.Id
  LEFT OUTER JOIN cities as c
    ON d.City = c.Id
WHERE d.Weather = 4
  AND d.Date >= julianday('2023-02-01')
  AND d.Date <= julianday('2023-02-28')
GROUP by d.Weather;
```


## Challenges

- Update the weather table to include an indication of each weather type is precipitation. Add some new weather types (hail, sleet, fog, etc)
- Try finding more weather data and adding to the database. https://www.weather.gov/wrh/climate?wfo=psr is a good source for weather data.
- Update the weather_data table to include amount of precipitation (usually in inches)
- Write a query that gets the high/low/avg temperature for a month for a city. Maybe it could also get total precipitation amount?

## Additional Topics to Research

There are many many more database topics that we won't have time to cover today. Here are some topics you may want to research:

- Types of Joins
- Migrations
- Seeding
- ACID
- First, Second, and Third normal forms
- Stored Procedures
- Query Optimization
- Indexing
- Object Relational Mapping

