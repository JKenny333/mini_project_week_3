CREATE DATABASE IF NOT EXISTS lab_mysql;

USE lab_mysql;

DROP TABLE IF EXISTS invoice;

CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(255)
);

CREATE TABLE year (
	year_id INT AUTO_INCREMENT PRIMARY KEY,
    year INT

CREATE TABLE happiness (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    happiness_rank INT,
    happiness_score FLOAT
);

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




