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
            
	#Countries changes in life expectancy from 2000 to 2015
		DROP VIEW IF EXISTS avg_life_expectancy_per_country_2015;

		CREATE VIEW life_expectancy_changes AS
        SELECT 
			c.country,
			le2000.life_expectancy AS life_expectancy_2000,
			le2015.life_expectancy AS life_expectancy_2015,
			ROUND((le2015.life_expectancy - le2000.life_expectancy), 2) AS change_in_life_expectancy
		FROM 
			(SELECT country_id, life_expectancy 
			 FROM life_expectancy_record 
			 WHERE year = 2000) AS le2000
		JOIN 
			(SELECT country_id, life_expectancy 
			 FROM life_expectancy_record 
			 WHERE year = 2015) AS le2015
		ON 
			le2000.country_id = le2015.country_id
		JOIN 
			country c ON le2000.country_id = c.country_id
		ORDER BY 
			change_in_life_expectancy DESC;

		#top 10 most improved
		SELECT * FROM life_expectancy_changes
			ORDER BY change_in_life_expectancy DESC
			LIMIT 10;
         
         #top 10 biggest drops
		SELECT * FROM life_expectancy_changes
			ORDER BY change_in_life_expectancy ASC
			LIMIT 10;

-- ================================================================================= --
#Health Factors

	#Alcohol and life expectancy
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
        
	##Pearson Correlation coefficient
    SELECT 
    (COUNT(*) * SUM(avg_alcohol_consumption * avg_life_expectancy) - SUM(avg_alcohol_consumption) * SUM(avg_life_expectancy)) / 
    (SQRT((COUNT(*) * SUM(avg_alcohol_consumption * avg_alcohol_consumption) - SUM(avg_alcohol_consumption) * SUM(avg_alcohol_consumption)) *
          (COUNT(*) * SUM(avg_life_expectancy * avg_life_expectancy) - SUM(avg_life_expectancy) * SUM(avg_life_expectancy)))) AS correlation_coefficient
	FROM 
    alcohol_consumption_life_expectancy;

        
	#Happiness and life expectancy
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
            
		#Pearson Correlation coefficient
			SELECT 
			(COUNT(*) * SUM(avg_happiness * avg_life_expectancy) - SUM(avg_happiness) * SUM(avg_life_expectancy)) / 
			(SQRT((COUNT(*) * SUM(avg_happiness * avg_happiness) - SUM(avg_happiness) * SUM(avg_happiness)) *
				  (COUNT(*) * SUM(avg_life_expectancy * avg_life_expectancy) - SUM(avg_life_expectancy) * SUM(avg_life_expectancy)))) AS correlation_coefficient
			FROM 
			happiness_life_expectancy;
        
		#Overall happiness table for export
			DROP VIEW IF EXISTS happiness_full;

			CREATE VIEW happiness_full AS
			SELECT 
				country.country,
				happiness.happiness_score,
				ler.life_expectancy
			FROM
				happiness
			JOIN
				life_expectancy_record AS ler ON happiness.country_id = ler.country_id
			JOIN 
				country ON happiness.country_id = country.country_id
			WHERE ler.year = 2015;

			SELECT * FROM happiness_full;    
-- ================================================================================= --
#Societal Factors

	#GDP and life expectancy
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
        
        #Pearson correlation coefficient
			SELECT 
			(COUNT(*) * SUM(avg_gdp * avg_life_expectancy) - SUM(avg_gdp) * SUM(avg_life_expectancy)) / 
			(SQRT((COUNT(*) * SUM(avg_gdp * avg_gdp) - SUM(avg_gdp) * SUM(avg_gdp)) *
			(COUNT(*) * SUM(avg_life_expectancy * avg_life_expectancy) - SUM(avg_life_expectancy) * SUM(avg_life_expectancy)))) AS correlation_coefficient
			FROM 
			gdp_life_expectancy;


	#Comparing developed vs developing countries
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
        

