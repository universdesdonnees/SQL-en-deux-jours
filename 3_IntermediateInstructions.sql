-- 1. SQL UNION
-- Cette commande combine les résultats des titres des livres et des noms des genres en une seule liste.
SELECT titre 
FROM livre
UNION
SELECT nom_genre AS titre 
FROM genre;

-- 2. SQL UNION ALL
-- Semblable à UNION, mais conserve les doublons.
SELECT titre 
FROM livre
UNION ALL
SELECT nom_genre AS titre 
FROM genre;

-- 3. SQL INTERSECT 
-- Cette commande retourne les titres des livres écrits par l'auteur avec l'id 1 qui sont également de genre_id 2.
SELECT titre FROM livre WHERE auteur_id = 1
INTERSECT
SELECT titre FROM livre WHERE genre_id = 1;

-- 4. SQL EXCEPT 
-- Cette commande retourne les titres des livres avec le genre_id = 1 mais non écrits par l'auteur avec l'id 1 
SELECT titre FROM livre WHERE genre_id = 1
EXCEPT
SELECT titre FROM livre WHERE auteur_id = 1 ;


-- 5. SQL CASE
-- Cette commande ajoute une nouvelle colonne 'Epoque' basée sur la date de publication des livres.
SELECT titre, CASE 
    WHEN date_publication < '2000-01-01' THEN '20ème siècle'
    ELSE '21ème siècle'
END AS Epoque 
FROM livre;

-- 
-- Les jointures 
-- 

-- 1. Jointure SQL
SELECT * 
FROM livre 
full JOIN auteur ON livre.auteur_id = auteur.auteur_id;

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

-- 7. SQL Sous-requête
SELECT titre 
FROM livre 
WHERE auteur_id IN (
  SELECT auteur_id 
  FROM auteur 
  WHERE nom = 'Martin');

-- 8. SQL EXISTS
SELECT titre 
FROM livre 
WHERE EXISTS (
  SELECT 1 
  FROM genre 
  WHERE genre.genre_id = livre.genre_id AND nom_genre = 'Fiction');

-- 9. SQL ALL
SELECT titre 
FROM livre 
WHERE date_publication > ALL (
  SELECT date_publication 
  FROM livre 
  WHERE genre_id = 2);

-- 10. SQL ANY / SOME
SELECT titre 
FROM livre 
WHERE genre_id = ANY (
  SELECT genre_id 
  FROM genre 
  WHERE nom_genre LIKE '%Fiction%');

-- 11 SQL VIEW
CREATE VIEW vue_livres_auteurs_genre AS
SELECT 
    l.titre AS Titre_Livre,
    a.nom AS Nom_Auteur,
    a.prenom AS Prenom_Auteur,
    g.nom_genre AS Genre_Livre
FROM 
    Livre l
FULL JOIN 
    Auteur a ON l.auteur_id = a.auteur_id
FULL JOIN 
    Genre g ON l.genre_id = g.genre_id;
