-- Créer la BDD cinema
CREATE DATABASE IF NOT EXISTS cinema;

-- Créer la table film
CREATE TABLE IF NOT EXISTS film(
    id TINYINT PRIMARY KEY AUTO_INCREMENT,
    id_real TINYINT,
    nom CHAR(45) NOT NULL,
    genre CHAR(25) NOT NULL,
    année YEAR NOT NULL
    
)


-- Insérer les données dans la table film (cf tableau de films)
INSERT INTO film(id_real, nom, genre, année)
VALUES
(3, "Pulp Fiction","Policier",1994),
(1, "Inception", "Thriller",2010),
(2, "Les Promesses de I’ombre", "Drame",2007),
(3, "Kill Bill", "Thriller",2003),
(1, "Dunkerque", "Thriller", 2017),
(4, "Big Fish", "Fantastique",2004);



-- Sélectionner dans la table film, les films qui ont le genre Policier et Fantastique

SELECT nom, genre from film
WHERE genre LIKE "Policier" OR genre Like "Fantastique";


-- Supprimer les enregistrements de la table film datant d'avant 1995
DELETE FROM film
WHERE année < 1995

-- Ajouter une colonne nom_original à la table film
ALTER TABLE film
ADD nom_original CHAR(45)

-- Modifier la ligne du film Les promesses de l'ombre afin d'y ajouter son titre original : "Eastern Promises"

UPDATE film
SET nom_original="Eastern Promises"
WHERE nom like "Les Promesses de I’ombre"


-- Afficher le nom de chaque film ainsi que le nom original s'il est renseigné sinon afficher "Pas de titre original"
SELECT nom,
    CASE 
        WHEN nom_original IS NOT NULL nom_original
        ELSE "Pas de titre original"
    END
FROM film


-- Créer la table réalisteur
CREATE TABLE IF NOT EXISTS réalisateur(
    id tinyint primary key auto_increment,
    nom CHAR(30),
    prenom CHAR(30)
    );

-- Insérer les données dans la table réalisateur (cf tableau de réalisateurs)
INSERT INTO réalisateur(nom, prenom)
VALUES
("Nolan","Cristopher"),
("Cronenberg", "David"),
("Tarantino", "Quentin"),
("Burton","Tim")

-- Ajouter une clé étrangère sur la table film pour la colonne id_real
ALTER TABLE film
ADD CONSTRAINT FOREIGN KEY (id_real) REFERENCES réalisateur(id)

-- Afficher chaque nom de film avec leur réalisateur

SELECT film.nom, CONCAT(realisateur.prenom, " ",realisateur.nom) as Director from film
INNER JOIN realisateur
ON film.id_real=realisateur.id
GROUP BY film.nom

 

-- Afficher le nombre de film réalisé par chaque réalisateur
SELECT CONCAT(realisateur.prenom, " ",realisateur.nom) as Director, COUNT(id_real) as "No. of movies" from realisateur
INNER JOIN film
ON realisateur.id = film.id_real
GROUP BY Director



-- Afficher les réalisateurs ayant réalisé au moins 2 films
SELECT CONCAT(realisateur.prenom, " ",realisateur.nom) as Director, COUNT(id_real) as "No. of movies" from realisateur
INNER JOIN film
ON realisateur.id = film.id_real
GROUP BY Director
having COUNT(id_real)>=2

