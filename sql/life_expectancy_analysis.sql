USE life_expectancy;

SHOW TABLES;

SELECT * FROM life_expectancy_record;
SELECT * FROM happiness;
SELECT * FROM country;

# Execute SQL queries for insights using commands (JOIN, GROUP BY, ORDER BY, CASE).

#Average life expectancy for entire work in 2015
DROP VIEW IF EXISTS avg_world_life_expectancy_per_year;

CREATE VIEW avg_world_life_expectancy_per_year AS
SELECT year, ROUND(AVG(life_expectancy),2) AS world_average_life_expectancy
FROM life_expectancy_record
GROUP BY year;

SELECT * FROM avg_world_life_expectancy_per_year;

#Average life expectancy by country in 2015
CREATE VIEW avg_world_life_expectancy_per_country AS
SELECT year, ROUND(AVG(life_expectancy),2)
FROM life_expectancy_record
GROUP BY year;