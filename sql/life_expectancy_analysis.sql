USE life_expectancy;

SHOW TABLES;

SELECT * FROM life_expectancy_record;
SELECT * FROM happiness;
SELECT * FROM country;

#Overall view table

DROP VIEW IF EXISTS full_table;

CREATE VIEW full_table AS
SELECT country,
		year,
        population,
        development_status,
        gdp,
        schooling,
        alcohol,
        bmi,
        life_expectancy,
        adult_mortality,
        under_five_deaths,
        infant_deaths,
        percentage_expenditure,
        total_expenditure
FROM life_expectancy_record
JOIN country
USING(country_id);

SELECT * FROM full_table;

-- ================================================================================= --
#Average life expectancy for entire world per year

DROP VIEW IF EXISTS avg_world_life_expectancy_per_year;

CREATE VIEW avg_world_life_expectancy_per_year AS
SELECT year, ROUND(AVG(life_expectancy),2) AS world_average_life_expectancy
FROM life_expectancy_record
GROUP BY year;

SELECT * FROM avg_world_life_expectancy_per_year;

-- ================================================================================= --
#Average life expectancy by country in 2015

DROP VIEW IF EXISTS avg_life_expectancy_per_country_2015;

CREATE VIEW avg_life_expectancy_per_country_2015 AS
SELECT c.country, ROUND(AVG(life_expectancy), 2) AS average_life_expectancy_2015
FROM life_expectancy_record AS ler
JOIN country AS c ON ler.country_id = c.country_id
WHERE ler.year = 2015
GROUP BY c.country;

	#top 10 counties for life expectancy
	SELECT * FROM avg_life_expectancy_per_country_2015
	ORDER BY average_life_expectancy_2015 DESC
	Limit 10;

	#bottom 10 countries for life expectancy
	SELECT * FROM avg_life_expectancy_per_country_2015
	ORDER BY average_life_expectancy_2015 ASC
	Limit 10;

	#Find your country's life expectancy
	SELECT * FROM avg_life_expectancy_per_country_2015
	WHERE country = "Ireland";

-- ================================================================================= --
#HEALTH FACTORS

#alcohol consumption compared to life expectancy
DROP VIEW IF EXISTS alcohol_consumption_life_expectancy;

CREATE VIEW alcohol_consumption_life_expectancy AS
(SELECT 
    le.year, 
    c.country, 
    ROUND(AVG(le.life_expectancy), 2) AS avg_life_expectancy, 
    ROUND(AVG(le.alcohol), 2) AS avg_alcohol_consumption
FROM 
    life_expectancy_record le
JOIN 
    country c ON le.country_id = c.country_id
GROUP BY 
    le.year, c.country);

SELECT * FROM alcohol_consumption_life_expectancy


#GDP compared to life expectancy
DROP VIEW IF EXISTS gdp_life_expectancy;

CREATE VIEW gdp_life_expectancy AS
(SELECT 
    le.year, 
    c.country, 
    ROUND(AVG(le.life_expectancy), 2) AS avg_life_expectancy, 
    ROUND(AVG(le.alcohol), 2) AS avg_alcohol_consumption
FROM 
    life_expectancy_record le
JOIN 
    country c ON le.country_id = c.country_id
GROUP BY 
    le.year, c.country);

SELECT * FROM alcohol_consumption_life_expectancy

#compare developed vs developing
DROP VIEW IF EXISTS avg_world_life_expectancy_per_year_developed_vs_developiong;

CREATE VIEW avg_world_life_expectancy_per_year_developed_vs_developiong AS
SELECT year, ROUND(AVG(life_expectancy),2) AS world_average_life_expectancy
FROM life_expectancy_record
GROUP BY year;

SELECT * FROM avg_world_life_expectancy_per_year;


CREATE VIEW alcohol_consumption_life_expectancy AS
(SELECT 
    le.year, 
    c.country, 
    le.developed
    ROUND(AVG(le.life_expectancy), 2) AS avg_life_expectancy, 
FROM 
    life_expectancy_record le
JOIN 
    country c ON le.country_id = c.country_id
GROUP BY 
    le.year, c.country);


#GDP effect on life expectancy

S
