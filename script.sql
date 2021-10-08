/*Création de la base dominos*/
CREATE DATABASE IF NOT EXISTS dominos;

-- SELECTION DE LA BASE pour que sql sache dans quelle base il doit créer la table
USE dominos;
-- Création de la table pizzas
CREATE TABLE pizzas (
    id TINYINT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(25) NOT NULL,
    taille TINYINT NOT NULL,
    prix DECIMAL(4,2) NOT NULL
);
-- CREATIION  de la table ingredients
CREATE TABLE IF NOT EXISTS ingredients(
    id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(25) NOT NULL

);
--creation  de la table pizzzas_ingredients
--attention de respecter les memes types que la table d'origin lorsque vous mettez en place des clés etrangers
CREATE TABLE IF NOT EXISTS pizzas_ingredients(
    pizza_id TINYINT,
    ingredient_id SMALLINT,
    PRIMARY KEY(pizza_id, ingredient_id)
    FOREIGN KEY (pizza_id) REFERENCES pizzas(id),
    FOREIGN KEY(ingredient_id) REFERENCES ingredients(id)
   
);

INSERT INTO pizzas (nom, taille, prix) 
VALUES
("4 fromages", 2, 8.90),("Margherita",1,4.90), ("Reine", 3,10.90);

-- Insertion des données dans la table ingredients
INSERT INTO ingredients(nom)
VALUES ("mozzarella"), ("tomate"), ("jambon"), ("champignon"), ("gorgonzola");

INSERT INTO pizzas_ingredients(pizza_id, ingredient_id)
VALUES
(1,5),
(1,1),
(2,2),
(2,1),
(3,2),
(3,3),
(3,4);


SELECT nom, prix from pizzas
WHERE taille=2

SELECT nom from pizzas
WHERE prix<10 AND taille>=2

UPDATE pizzas
SET prix=prix*1.1
WHERE taille=2

-- obternir le liste des e=ingredients pour chaque pizza
SELECT pizzas.nom AS pizza, ingredients.nom AS "nom de l'ingredient"
FROM pizzas
INNER JOIN pizzas_ingredients
ON pizzas.id= pizzas_ingredients.pizza_id
INNER JOIN ingredients
ON pizzas_ingredients.ingredient_id=ingredients.id
ORDER BY pizzas.nom;

SELECT nom
    CASE taille
        WHEN 1 THEN "Petite"
        when 2 THEN "Moyene"
        ELSE "Grande"
    END AS "taille de la pizza"

-- AFFICHER LE NOMBRE D4INGREDIENTS UTILIS2 DANS CHAQUE PIZZA

SELECT pizzas.nom, COUNT(pizzas_ingredients.ingredient_id) AS "nombre d'ingredients"
FROM pizzas
LEFT JOIN pizzas_ingredients
ON pizzas.id= pizzas_ingredients.pizza_id
GROUP BY pizzas.nom;

-- afficher pour chaque pizza la liste des ingredients (sans doublon une ligne par pizza)

SELECT pizzas.nom AS pizza, GROUP_CONCAT(ingredients.nom SEPARATOR " - ") AS "Liste des ingredients"
FROM pizzas
INNER JOIN pizzas_ingredients
ON pizzas.id= pizzas_ingredients.pizza_id
INNER JOIN ingredients
ON pizzas_ingredients.ingredient_id=ingredients.id
GROUP  BY pizzas.nom
ORDER BY pizzas.nom;

-- creation d'une view carte_pizzeria
CREATE VIEW carte_pizzeria
AS
SELECT pizzas.nom AS "Nom de la pizza",
    CONCAT(pizzas.prix, "€") AS "prix de la pizza",
    CASE pizzas.taille
        WHEN 1 THEN "Petite"
        when 2 THEN "Moyene"
        ELSE "Grande"
    END AS "taille de la pizza",
GROUP_CONCAT(ingredients.nom SEPARATOR " - ") AS "Liste des ingredients"
FROM pizzas
INNER JOIN pizzas_ingredients
ON pizzas.id= pizzas_ingredients.pizza_id
INNER JOIN ingredients
ON pizzas_ingredients.ingredient_id=ingredients.id
GROUP  BY pizzas.nom
ORDER BY pizzas.nom;

--interogation d'un vue
select * from carte_pizzeria


-- exemple de procedure stockée
DELIMITER $$
CREATE PROCEDURE getPizzaBySize(IN size TINYINT)
BEGIN
    SELECT nom, taille, prix
    FROM pizzas
    WHERE taille=size;
END $$
DELIMITER ;

