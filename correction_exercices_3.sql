-- 
-- CTE 
-- 

-- 1
WITH nb_livre_decennie AS (
SELECT round((EXTRACT(YEAR from date_publication) / 10) ,0) * 10  as decennie, 
	count(*) AS nb_livre
FROM livre 
GROUP by decennie 
HAVING COUNT(*) > 5
ORDER BY decennie
)
SELECT *
FROM nb_livre_decennie

-- 2
WITH livre_par_auteur AS (
  SELECT auteur_id, COUNT(*) AS nombre_de_livre
  FROM livre 
  GROUP by auteur_id
)
SELECT a.nom as nom_auteur, A.prenom as prenom_auteur
FROM auteur a 
LEFT JOIN livre_par_auteur 
ON  a.auteur_id = livre_par_auteur.auteur_id 
WHERE livre_par_auteur.nombre_de_livre > 2

-- 3.1
WITH moyenne_livre_par_auteur AS (
	SELECT AVG(nombre_de_livre) AS moyenne_livre 
	FROM (	SELECT auteur_id,
	      	COUNT(*) AS nombre_de_livre 
      		FROM livre 
      		GROUP BY auteur_id)
),
livre_par_auteur as (
 	SELECT l.auteur_id, au.prenom, au.nom, COUNT(*) AS nb_livre
  	FROM livre AS l 
  	INNER join auteur AS au 
  	ON l.auteur_id = au.auteur_id
  	GROUP BY l.auteur_id,  au.prenom, au.nom
)
SELECT  prenom, nom
FROM livre_par_auteur la 
CROSS JOIN moyenne_livre_par_auteur AS mla
WHERE la.nb_livre > mla.moyenne_livre

-- 3.2	
WITH livre_par_auteur as (
	SELECT l.auteur_id, au.prenom, au.nom, COUNT(*) AS nb_livre
  	FROM livre AS l 
  	INNER join auteur AS au 
  	ON l.auteur_id = au.auteur_id
  	GROUP BY l.auteur_id,  au.prenom, au.nom
)
SELECT nom, prenom
FROM livre_par_auteur 
WHERE nb_livre > (
  SELECT AVG(nb_livre) 
  FROM livre_par_auteur) 

-- 4
WITH SalaireMoyenParPoste AS (
  SELECT JobTitle, AVG(Salary) AS MoyenneSalaire
  FROM EmployeeSalary
  GROUP BY JobTitle
)
SELECT JobTitle, MoyenneSalaire
FROM SalaireMoyenParPoste
WHERE MoyenneSalaire > 50000;

-- 5 
WITH AuteursApres2000 AS (
  SELECT DISTINCT auteur_id
  FROM Livre
  WHERE date_publication > '2000-01-01'
)
SELECT a.nom, a.prenom
FROM Auteur AS a
LEFT JOIN AuteursApres2000 AS ap2000 ON a.auteur_id = ap2000.auteur_id
WHERE ap2000.auteur_id IS NULL;


-- 
-- OVER()
-- 

SELECT livre_id, titre, date_publication,
  ROW_NUMBER() OVER (ORDER BY date_publication) AS rang_publication
FROM Livre;

SELECT livre_id, titre, genre_id, date_publication,
  RANK() OVER (PARTITION BY genre_id ORDER BY date_publication) AS rang_genre
FROM Livre;

SELECT EmployeeID, Salary,
  SUM(Salary) OVER (ORDER BY EmployeeID) AS salaire_cumule
FROM EmployeeSalary;

SELECT EmployeeID, Salary,
  AVG(Salary) OVER (ORDER BY EmployeeID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moyenne_glissante
FROM EmployeeSalary;

SELECT livre_id, titre, genre_id, date_publication,
  FIRST_VALUE(titre) OVER (PARTITION BY genre_id ORDER BY date_publication ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS premier_livre,
  LAST_VALUE(titre) OVER (PARTITION BY genre_id ORDER BY date_publication ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dernier_livre
FROM Livre;

SELECT EmployeeID, Salary,
  Salary - LAG(Salary) OVER (ORDER BY EmployeeID) AS difference_avec_precedent,
  LEAD(Salary) OVER (ORDER BY EmployeeID) - Salary AS difference_avec_suivant
FROM EmployeeSalary;

SELECT EmployeeID, Salary,
  (Salary / SUM(Salary) OVER ()) * 100 AS pourcentage_du_total
FROM EmployeeSalary;

SELECT a.nom, a.prenom, a.date_naissance, l.titre, l.date_publication,
  COUNT(*) OVER (PARTITION BY l.auteur_id ORDER BY l.date_publication ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS nbr_livres_avant
FROM Livre l
JOIN Auteur a ON l.auteur_id = a.auteur_id
ORDER BY l.date_publication;

WITH NombreLivresParAn AS (
  SELECT EXTRACT(YEAR FROM date_publication) AS annee, COUNT(*) AS nombre_livres
  FROM Livre
  GROUP BY annee
)
SELECT annee, nombre_livres,
  (nombre_livres - LAG(nombre_livres) OVER (ORDER BY annee)) / LAG(nombre_livres) OVER (ORDER BY annee) * 100 AS pourcentage_croissance
FROM NombreLivresParAn;







