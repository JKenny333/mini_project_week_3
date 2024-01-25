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
#General Life Expectancy Statistics

	#Average life expectancy for entire world per year
		DROP VIEW IF EXISTS avg_world_life_expectancy_per_year;

		CREATE VIEW avg_world_life_expectancy_per_year AS
		SELECT year, ROUND(AVG(life_expectancy),2) AS world_average_life_expectancy
		FROM life_expectancy_record
		GROUP BY year;

		SELECT * FROM avg_world_life_expectancy_per_year;

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
#Health Factors

	#Alcohol consumptions effect on life expectancy
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

		SELECT * FROM alcohol_consumption_life_expectancy;
        
	#Correlation between happiness and life expectancy
		DROP VIEW IF EXISTS happiness_life_expectancy;

		CREATE VIEW happiness_life_expectancy AS
		(SELECT 
			country,
			ROUND(AVG(happiness_score), 2) AS avg_happiness,
			ROUND(AVG(life_expectancy), 2) AS avg_life_expectancy
		FROM
			country
		JOIN
			life_expectancy_record
			USING(country_id)
		JOIN 
			happiness
			USING(country_id)
		GROUP BY country);
		
        #top 10 counties by happiness
			SELECT * FROM happiness_life_expectancy
			ORDER BY avg_happiness DESC
			LIMIT 10;
        
        #bottom 10 counties by happiness
			SELECT * FROM happiness_life_expectancy
			ORDER BY avg_happiness ASC
			LIMIT 10;

-- ================================================================================= --
#Societal Factors

	#GDP#s effect on life expectancy
		DROP VIEW IF EXISTS gdp_life_expectancy;

		CREATE VIEW gdp_life_expectancy AS
		(SELECT 
			le.year, 
			c.country, 
			ROUND(AVG(le.life_expectancy), 2) AS avg_life_expectancy, 
			ROUND(AVG(le.gdp), 2) AS avg_gdp
		FROM 
			life_expectancy_record AS le
		JOIN 
			country c 
			USING(country_id)
		GROUP BY 
			le.year, c.country);

		SELECT * FROM gdp_life_expectancy
		ORDER BY avg_gdp DESC
		LIMIT 5;


	#Compare developed vs developing countries
		DROP VIEW IF EXISTS developed_vs_developing;
		
		CREATE VIEW developed_vs_developing AS
		(SELECT 
            le.development_status,
			ROUND(AVG(le.life_expectancy), 2) AS avg_life_expectancy
		FROM 
			life_expectancy_record AS le
		GROUP BY 
			le.development_status);

		SELECT * FROM developed_vs_developing;
        

