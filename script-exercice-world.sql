-- Afficher toutes les villes française

/* SELECT city.Name FROM city
INNER JOIN country
ON city.CountryCode= country.code
WHERE country.Name="France" */

-- ou

SELECT city.Name FROM city
WHERE city.CountryCode ="FRA"
order by Name

--Afficher les villes ayant plus de 500000 habitants

select city.name, city.population from city
where population>500000
order by population desc

--Afficher les villes ayant plus de 500000 habitants en europe

select city.name, city.population from city
INNER JOIN  country
ON city.CountryCode= country.code
where country.Continent Like "Europe" and city.population>500000
order by city.population desc

-- Afficher le nom de tous les pays parlant officiellement français

select country.Name, country.continent, country.population from country
INNER JOIN countrylanguage
ON country.Code=countrylanguage.CountryCode
where countrylanguage.Language Like "French" and countrylanguage.isOfficial Like "T"
order by country.Continent

-- afficher les capitales de tous les pays
select city.Name, country.Name  from city
INNER JOIN country
ON city.CountryCode= country.code
WHERE country.Capital= city.id

-- Afficher le pays avec le plus d'habitants

    SELECT country.Name, country.Population from country
    ORDER BY country.Population Desc
    LIMIT 0, 1; 

-- Afficher le nombre de pays pour chaque continent

SELECT Continent, count(Name) as "Nombre de pays" from country
GROUP BY Continent

-- Afficher des pays ou la langue anglaise est parlée à au moins 50%

SELECT country.name, countrylanguage.Percentage from country
INNER JOIN countrylanguage
ON country.Code= countrylanguage.CountryCode
WHERE countrylanguage.Language Like "English" and countrylanguage.Percentage >=50
ORDER BY countrylanguage.Percentage Desc

-- Afficher les continent et trier par la grandeur du continent

SELECT Continent, SUM(SurfaceArea) as "Total surface" from country
GROUP BY Continent
ORDER BY SUM(SurfaceArea) DESC

-- Créer une vue pour afficher les 10 villes avec le plus d'habitants dans le monde
CREATE VIEW top10_cities
AS
SELECT Name, Population FROM city
ORDER BY Population DESC
LIMIT 0, 10;

-- Créer une procédure stockée permettant d'afficher le détail d'une ville spécifiée au moment de l'appel à la procédure stockée
DELIMITER $$
CREATE PROCEDURE city_info (IN cityName CHAR(35))
    BEGIN
    SELECT * from city;
    WHERE Name Like cityName
END $$
DELIMITER ;




