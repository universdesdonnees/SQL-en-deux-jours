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

-- 8. SQL NATURAL JOIN 
SELECT * 
FROM livre 
NATURAL JOIN auteur;

-- 9. SQL Sous-requête
SELECT titre 
FROM livre 
WHERE auteur_id IN (SELECT auteur_id FROM auteur WHERE nom = 'Martin');

-- 10. SQL EXISTS
SELECT titre 
FROM livre 
WHERE EXISTS (
  SELECT 1 
  FROM genre 
  WHERE genre.genre_id = livre.genre_id AND nom_genre = 'Fiction');

-- 11. SQL ALL
SELECT titre 
FROM livre 
WHERE date_publication > ALL (
  SELECT date_publication 
  FROM livre 
  WHERE genre_id = 2);

-- 12. SQL ANY / SOME
SELECT titre 
FROM livre 
WHERE genre_id = ANY (
  SELECT genre_id 
  FROM genre 
  WHERE nom_genre LIKE '%Fiction%');