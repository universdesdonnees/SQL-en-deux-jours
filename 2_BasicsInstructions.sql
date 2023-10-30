-- 1. SQL SELECT
-- Cette commande permet de récupérer toutes les colonnes et toutes les lignes de la table 'auteur'.
SELECT * 
FROM auteur;

-- 2. SQL DISTINCT
-- Cette commande permet de récupérer des valeurs uniques pour la colonne 'date_naissance' de la table 'auteur'.
SELECT DISTINCT date_naissance
FROM auteur;

-- 3. SQL AS (alias)
-- Cette commande renomme temporairement la colonne 'titre' en 'Titre_du_Livre' pour l'affichage des résultats.
SELECT titre AS Titre_du_Livre
FROM livre;

-- 4. SQL WHERE
-- Cette commande récupère toutes les colonnes du livre ayant pour titre 'Game of Thrones'.
SELECT * 
FROM livre 
WHERE titre = 'Game of Thrones';

-- 5. SQL AND & OR
-- Cette commande récupère les informations de l'auteur dont le prénom est 'George' et le nom est 'Martin'.
SELECT * 
FROM auteur 
WHERE prenom = 'George' AND nom = 'Martin';

-- 6. SQL IN
-- Cette commande récupère les informations des livres ayant pour titre '1984' ou 'Game of Thrones'.
SELECT * 
FROM livre
WHERE titre IN ('1984', 'Game of Thrones');

-- 7. SQL BETWEEN
-- Cette commande récupère les informations des auteurs nés entre le 1er janvier 1900 et le 31 décembre 2000.
SELECT * 
FROM auteur 
WHERE date_naissance BETWEEN '1900-01-01' AND '2000-12-31';

-- 8. SQL LIKE
-- Cette commande récupère les livres dont le titre se termine par 'Game'.
SELECT * 
FROM livre 
WHERE titre LIKE '%Game';

-- 8.1 SQL LIKE
-- Cette commande récupère les livres dont le titre a un caractère avant 'Game' suivi de n'importe quel caractère.
SELECT * 
FROM livre 
WHERE titre LIKE '_Game%';

-- 8.2 SQL LIKE
-- Cette commande récupère les livres dont le titre contient le mot 'Game'.
SELECT * 
FROM livre 
WHERE titre LIKE '%Game%';

-- 9. SQL IS NULL / IS NOT NULL
-- Cette commande récupère les livres qui n'ont pas de date de publication.
SELECT * 
FROM livre 
WHERE date_publication IS NULL;

-- 10. SQL GROUP BY
-- Cette commande compte le nombre de livres par genre et les regroupe par 'genre_id'.
SELECT genre_id, COUNT(*) 
FROM livre 
GROUP BY genre_id;

-- 11. SQL HAVING
-- Après regroupement par 'genre_id', cette commande ne conserve que les genres ayant plus de 5 livres.
SELECT genre_id, COUNT(*)
FROM livre 
GROUP BY genre_id 
HAVING COUNT(*) > 5;

-- 12. SQL ORDER BY
-- Cette commande récupère tous les livres et les trie par titre en ordre croissant.
SELECT * 
FROM livre 
ORDER BY titre ASC;

-- 13. SQL LIMIT
-- Cette commande récupère les informations des 5 premiers livres de la table 'livre'.
SELECT * 
FROM livre
LIMIT 5;

-- 14. SQL UPDATE
-- Met à jour le titre du livre "1984" pour qu'il soit "Nineteen Eighty-Four".
UPDATE Livre
SET titre = 'Nineteen Eighty-Four'
WHERE titre = '1984';


