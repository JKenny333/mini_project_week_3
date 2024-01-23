CREATE DATABASE IF NOT EXISTS lab_mysql;

USE lab_mysql;

DROP TABLE IF EXISTS invoice;

CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(255)
);

CREATE TABLE mortality (
    country VARCHAR(255),
    happiness_rank INT,
    happiness_score FLOAT
);

CREATE TABLE health_factors (
    country VARCHAR(255),
    happiness_rank INT,
    happiness_score FLOAT
);

CREATE TABLE societal_factors (
    country VARCHAR(255),
    happiness_rank INT,
    happiness_score FLOAT
);

CREATE TABLE life_expectancy (
    country VARCHAR(255),
    year INT,
    development_status VARCHAR(100),
    life_expectancy FLOAT,
    adult_mortality FLOAT,
    infant_deaths INT,
    alcohol FLOAT,
    percentage_expenditure FLOAT,
    bmi FLOAT,
    under_five_deaths INT,
    total_expenditure FLOAT,
    gdp FLOAT,
    population FLOAT,
    schooling FLOAT
);

CREATE TABLE happiness (
    country VARCHAR(255),
    happiness_rank INT,
    happiness_score FLOAT
);
