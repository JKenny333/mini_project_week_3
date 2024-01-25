CREATE DATABASE IF NOT EXISTS life_expectancy;

USE life_expectancy;

DROP TABLE IF EXISTS country;

CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(255)
);

DROP TABLE IF EXISTS happiness;

CREATE TABLE happiness (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    year_id INT,
    happiness_rank INT,
    happiness_score FLOAT
);

DROP TABLE IF EXISTS life_expectancy_record;

CREATE TABLE life_expectancy_record (
    country_id INT,
    year_id INT,
	population FLOAT,
    development_status VARCHAR(100),
    gdp FLOAT,
    schooling FLOAT,
    alcohol FLOAT,
	bmi FLOAT,
    life_expectancy FLOAT,
    adult_mortality FLOAT,
    under_five_deaths INT,
    infant_deaths INT,
    percentage_expenditure FLOAT,
    total_expenditure FLOAT
);




