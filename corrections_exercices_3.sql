-- CTE -- 
-- À l'aide d'une CTE, comptez le nombre de livres publiés chaque décennies. 
-- Ensuite, dans la requête principale, sélectionnez seulement les décennies 
-- où plus de 5  livres ont été publiés.
-- Aide : (annee / 10) * 10 AS decennie

WITH nb_livre_decennie AS (
Select round((EXTRACT(Year from date_publication) / 10) ,0) * 10  as decennie, 
	count(*) as nb_livre
FROM livre 
GROUP by decennie 
having count(*) > 5
ORDER BY decennie
)
SELECT *
From nb_livre_decennie

-- Créez une CTE qui compte le nombre de livres écrits par chaque auteur. 
-- Dans votre requête principale, sélectionnez les auteurs qui ont écrit plus de 2 livres.

With livre_par_auteur AS (
  SELECT auteur_id, COUNT(*) as nombre_de_livre
  from livre 
  GROUP by auteur_id
)
select a.nom as nom_auteur, A.prenom as prenom_auteur
from auteur a 
left join livre_par_auteur 
on a.auteur_id = livre_par_auteur.auteur_id 
where livre_par_auteur.nombre_de_livre > 2

-- Créez une CTE qui calcule la moyenne du nombre de livres écrits par auteur. 
-- Dans la requête principale, listez tous les auteurs qui ont écrit plus que cette moyenne.

with moyenne_livre_par_auteur AS (
	select AVG(nombre_de_livre) as moyenne_livre 
	from (
      select auteur_id, 
      count(*) as nombre_de_livre 
      from livre 
      GROUP by auteur_id)
),
livre_par_auteur as (
 	select l.auteur_id, au.prenom, au.nom, count(*) as nb_livre
  	from livre as l 
  	INNER join auteur as au 
  	on l.auteur_id = au.auteur_id
  	group by l.auteur_id,  au.prenom, au.nom
)
select la.*
from livre_par_auteur la 
CROSS JOIN moyenne_livre_par_auteur as mla
where la.nb_livre < mla.moyenne_livre

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
