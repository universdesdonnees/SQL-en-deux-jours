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

-- 3
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

	
with moyenne_livre_par_auteur AS (
	select AVG(nombre_de_livre) as moyenne_livre 
	from (
      select auteur_id, 
      count(*) as nombre_de_livre 
      from livre 
      GROUP by auteur_id)
) 
SELECT auteur.nom 
from (
      select auteur_id, 
      count(*) as nombre_de_livre 
      from livre 
      GROUP by auteur_id
	) as livre_par_auteur 
inner join auteur 
on auteur.auteur_id = livre_par_auteur.auteur_id
where nombre_de_livre > (
  select moyenne_livre
  from moyenne_livre_par_auteur
)



-- 
-- OVER()
-- 






