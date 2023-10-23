-- 1. SQL SELECT
-- Sélectionne tous les attributs de la table Auteur
SELECT * 
FROM auteur;

-- 2. SQL DISTINCT
-- Permet d'obtenir les valeurs uniques des dates de naissance des auteurs
SELECT DISTINCT date_naissance
FROM auteur;

-- 3. SQL AS (alias)
-- Obtenir les titres des livres as le nouvel attribut 'Titre_du_Livre'
SELECT titre AS Titre_du_Livre
FROM livre;

-- 4. SQL WHERE
-- Obtenir les attributs de du livre Game of Thrones
SELECT * 
FROM livre 
WHERE titre = 'Game of Thrones';

-- 5. SQL AND & OR
-- Obtenir les atriibuts pour  prénom George ET le nom Martin dans la table auteur 
SELECT * 
FROM auteur 
WHERE prenom = 'George' AND nom = 'Martin';

-- 6. SQL IN
-- obtenir les attributs des livres 1984 et Game of thrones
SELECT * 
FROM livre
WHERE titre IN ('1984', 'Game of Thrones');

-- 7. SQL BETWEEN
--Affiche les attributs des auteurs nées entre les deux dates
SELECT * 
FROM auteur 
WHERE date_naissance BETWEEN '1900-01-01' AND '2000-12-31';

-- 8. SQL LIKE
SELECT * 
FROM livre 
WHERE titre LIKE '%Game';

-- 8.1 SQL LIKE
SELECT * 
FROM livre 
WHERE titre LIKE '_Game%';

-- 8.2 SQL LIKE
SELECT * 
FROM livre 
WHERE titre LIKE '%Game%';

-- 9. SQL IS NULL / IS NOT NULL
SELECT * 
FROM livre 
WHERE date_publication IS NULL;

-- 10. SQL GROUP BY
SELECT genre_id, COUNT(*) 
FROM livre 
GROUP BY genre_id;

-- 11. SQL HAVING
SELECT genre_id, COUNT(*)
FROM livre 
GROUP BY genre_id 
HAVING COUNT(*) > 5;

-- 12. SQL ORDER BY
--Affiche toutes les informations des livres en rangeant les titres par ordre croissant 
SELECT * 
FROM livre 
ORDER BY titre ASC;

-- 13. SQL LIMIT
-- Sélectionne toutes les informations des 5 premiers livres de la table livre

SELECT * 
FROM livre
LIMIT 5;

-- 14. SQL CASE
-- Creation d'un attribut "Epoque" a partir d'une condtion sur la date de publication
SELECT titre, CASE 
    WHEN date_publication < '2000-01-01' THEN '20ème siècle'
    ELSE '21ème siècle'
END AS Epoque 
FROM livre;

-- 15. SQL UNION
SELECT titre 
FROM livre
UNION
SELECT nom_genre AS titre 
FROM genre;

-- 16. SQL UNION ALL
SELECT titre 
FROM livre
UNION ALL
SELECT nom_genre AS titre 
FROM genre;

-- 17. SQL INTERSECT 
SELECT titre FROM livre WHERE auteur_id = 1
INTERSECT
SELECT titre FROM livre WHERE genre_id = 2;

-- 18. SQL EXCEPT 
SELECT titre FROM livre WHERE auteur_id = 1
EXCEPT
SELECT titre FROM livre WHERE genre_id = 2;

-- 19. SQL ON DUPLICATE KEY UPDATE (Note: spécifique à MySQL)
INSERT INTO livre (livre_id, titre) 
VALUES (1, 'Nouveau Livre')
ON DUPLICATE KEY UPDATE titre = 'Nouveau Livre';

-- 20. SQL MERGE 
MERGE INTO livre AS target
USING (
  SELECT livre_id, titre 
  FROM livre 
  WHERE livre_id = 1) AS source
ON (target.livre_id = source.livre_id)
WHEN MATCHED THEN 
   UPDATE SET titre = source.titre
WHEN NOT MATCHED THEN 
  INSERT (titre) VALUES (source.titre);
