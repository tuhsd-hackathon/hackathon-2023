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
--- Add some cities
---
INSERT INTO cities(Id, Name, State, Lat, Lon)
  VALUES (1, "Phoenix", "AZ", "33.5722", "-112.0901");
INSERT INTO cities(Id, Name, State, Lat, Lon)
  VALUES (2, "New York", "NY", "40.6635", "-73.9387");
INSERT INTO cities(Id, Name, State, Lat, Lon)
  VALUES (3, "Seattle", "WA", "47.6205", "-122.3509");
INSERT INTO cities(Id, Name, State, Lat, Lon)
  VALUES (4, "San Francisco", "CA", "37.7272", "-123.0322");
INSERT INTO cities(Id, Name, State, Lat, Lon)
  VALUES (5, "Austin", "TX", "30.3039", "-97.7544");

---
--- Create a table for weather types
---
CREATE TABLE weather(
  Id                   INTEGER NOT NULL PRIMARY KEY
 ,Name                 VARCHAR(30) NOT NULL
 ,Precipitation        BOOLEAN NOT NULL 
 ,Description           TEXT NOT NULL
);

---
--- Add some types of weather
---
INSERT INTO weather(Id, Name, Precipitation, Description)
  VALUES (1, "Sunny", FALSE, "Not a cloud in the sky.");
INSERT INTO weather(Id, Name, Precipitation, Description)
  VALUES (2, "Partly Cloudy", FALSE, "Some clouds.");
INSERT INTO weather(Id, Name, Precipitation, Description)
  VALUES (3, "Overcast", FALSE, "Total cloud cover.");
INSERT INTO weather(Id, Name, Precipitation, Description)
  VALUES (4, "Rain", TRUE, "Water, from the heavens!");
INSERT INTO weather(Id, Name, Precipitation, Description)
  VALUES (5, "Snow", TRUE, "Rain, but colder.");

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

---
--- Add some starting weather data
---
INSERT INTO weather_data(Date, City, Weather, High, Low)
  VALUES (julianday("2022-07-04"), 1, 1, 106, 84);
INSERT INTO weather_data(Date, City, Weather, High, Low)
  VALUES (julianday("2022-07-04"), 2, 1, 81, 68);
INSERT INTO weather_data(Date, City, Weather, High, Low)
  VALUES (julianday("2022-07-04"), 3, 2, 68, 52);
INSERT INTO weather_data(Date, City, Weather, High, Low)
  VALUES (julianday("2022-07-04"), 4, 2, 75, 66);
INSERT INTO weather_data(Date, City, Weather, High, Low)
  VALUES (julianday("2022-07-04"), 5, 2, 99, 77);


---
--- February 2023 data for Phoenix
---
INSERT INTO weather_data(Date, High, Low, Weather, City)
  VALUES
    (julianday("2023-02-01"), 68, 43, 2, 1),
    (julianday("2023-02-02"), 68, 43, 2, 1),
    (julianday("2023-02-03"), 74, 44, 1, 1),
    (julianday("2023-02-04"), 76, 46, 1, 1),
    (julianday("2023-02-05"), 75, 47, 1, 1),
    (julianday("2023-02-06"), 70, 48, 1, 1),
    (julianday("2023-02-07"), 69, 43, 1, 1),
    (julianday("2023-02-08"), 70, 42, 1, 1),
    (julianday("2023-02-09"), 69, 43, 1, 1),
    (julianday("2023-02-10"), 72, 48, 1, 1),
    (julianday("2023-02-11"), 75, 53, 1, 1),
    (julianday("2023-02-12"), 79, 48, 1, 1),
    (julianday("2023-02-13"), 59, 47, 4, 1),
    (julianday("2023-02-14"), 57, 42, 4, 1),
    (julianday("2023-02-15"), 55, 40, 2, 1),
    (julianday("2023-02-16"), 59, 35, 1, 1),
    (julianday("2023-02-17"), 66, 47, 1, 1),
    (julianday("2023-02-18"), 73, 53, 1, 1),
    (julianday("2023-02-19"), 75, 53, 1, 1),
    (julianday("2023-02-20"), 76, 51, 2, 1),
    (julianday("2023-02-21"), 68, 55, 3, 1),
    (julianday("2023-02-22"), 60, 49, 4, 1),
    (julianday("2023-02-23"), 61, 47, 2, 1),
    (julianday("2023-02-24"), 68, 44, 1, 1),
    (julianday("2023-02-25"), 76, 52, 1, 1),
    (julianday("2023-02-26"), 59, 43, 4, 1),
    (julianday("2023-02-27"), 65, 42, 2, 1),
    (julianday("2023-02-28"), 66, 43, 1, 1);
  
.save starting_data.db
