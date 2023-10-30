-- 14. SQL CASE
-- Cette commande ajoute une nouvelle colonne 'Epoque' basée sur la date de publication des livres.
SELECT titre, CASE 
    WHEN date_publication < '2000-01-01' THEN '20ème siècle'
    ELSE '21ème siècle'
END AS Epoque 
FROM livre;

-- 15. SQL UNION
-- Cette commande combine les résultats des titres des livres et des noms des genres en une seule liste.
SELECT titre 
FROM livre
UNION
SELECT nom_genre AS titre 
FROM genre;

-- 16. SQL UNION ALL
-- Semblable à UNION, mais conserve les doublons.
SELECT titre 
FROM livre
UNION ALL
SELECT nom_genre AS titre 
FROM genre;

-- 17. SQL INTERSECT 
-- Cette commande retourne les titres des livres écrits par l'auteur avec l'id 1 qui sont également de genre_id 2.
SELECT titre FROM livre WHERE auteur_id = 1
INTERSECT
SELECT titre FROM livre WHERE genre_id = 2;

-- 18. SQL EXCEPT 
-- Cette commande retourne les titres des livres écrits par l'auteur avec l'id 1 mais qui ne sont pas du genre_id 2.
SELECT titre FROM livre WHERE auteur_id = 1
EXCEPT
SELECT titre FROM livre WHERE genre_id = 2;

-- 19. SQL UPDATE
-- Met à jour le titre du livre "1984" pour qu'il soit "Nineteen Eighty-Four".
UPDATE Livre
SET titre = 'Nineteen Eighty-Four'
WHERE titre = '1984';

-- 20. SQL ON DUPLICATE KEY UPDATE (Note: spécifique à MySQL)
-- Insère un nouveau livre ou met à jour le titre si le 'livre_id' existe déjà.
INSERT INTO livre (livre_id, titre) 
VALUES (1, 'Nouveau Livre')
ON CONFLICT (livre_id)
DO UPDATE SET titre = 'Nouveau Livre';

-- 21. SQL MERGE 
-- Si le 'livre_id' de la source correspond à celui de la cible, 
-- il met à jour le titre, sinon, il insère un nouveau titre.
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


-- 1. Jointure SQL
SELECT * 
FROM livre 
JOIN auteur ON livre.auteur_id = auteur.auteur_id;

-- 2. SQL INNER JOIN
SELECT * 
FROM livre 
INNER JOIN genre ON livre.genre_id = genre.genre_id;

-- 3. SQL CROSS JOIN
SELECT * 
FROM livre 
CROSS JOIN genre;

-- 4. SQL LEFT JOIN
SELECT * 
FROM livre 
LEFT JOIN auteur ON livre.auteur_id = auteur.auteur_id;

-- 5. SQL RIGHT JOIN
SELECT * 
FROM auteur 
RIGHT JOIN livre ON auteur.auteur_id = livre.auteur_id;

-- 6. SQL FULL JOIN 
SELECT * 
FROM livre 
FULL JOIN genre ON livre.genre_id = genre.genre_id;

-- 7. SQL SELF JOIN
SELECT A.titre AS Livre1, B.titre AS Livre2 
FROM livre A, livre B 
WHERE A.auteur_id = B.auteur_id AND A.livre_id <> B.livre_id;

-- 8. SQL Sous-requête
SELECT titre 
FROM livre 
WHERE auteur_id IN (
  SELECT auteur_id 
  FROM auteur 
  WHERE nom = 'Martin');

-- 9. SQL EXISTS
SELECT titre 
FROM livre 
WHERE EXISTS (
  SELECT 1 
  FROM genre 
  WHERE genre.genre_id = livre.genre_id AND nom_genre = 'Fiction');

-- 10. SQL ALL
SELECT titre 
FROM livre 
WHERE date_publication > ALL (
  SELECT date_publication 
  FROM livre 
  WHERE genre_id = 2);

-- 11. SQL ANY / SOME
SELECT titre 
FROM livre 
WHERE genre_id = ANY (
  SELECT genre_id 
  FROM genre 
  WHERE nom_genre LIKE '%Fiction%');

-- 12 SQL VIEW
CREATE VIEW vue_livres_auteurs_genre AS
SELECT 
    l.titre AS Titre_Livre,
    a.nom AS Nom_Auteur,
    a.prenom AS Prenom_Auteur,
    g.nom_genre AS Genre_Livre
FROM 
    Livre l
JOIN 
    Auteur a ON l.auteur_id = a.auteur_id
JOIN 
    Genre g ON l.genre_id = g.genre_id;

