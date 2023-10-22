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

-- 6. SQL FULL JOIN (Note: supporté par PostgreSQL et certains autres SGBD)
SELECT * 
FROM livre 
FULL JOIN genre ON livre.genre_id = genre.genre_id;

-- 7. SQL SELF JOIN
SELECT A.titre AS Livre1, B.titre AS Livre2 
FROM livre A, livre B 
WHERE A.auteur_id = B.auteur_id AND A.livre_id <> B.livre_id;

-- 8. SQL NATURAL JOIN (Note: supporté par PostgreSQL et certains autres SGBD)
SELECT * 
FROM livre 
NATURAL JOIN auteur;
