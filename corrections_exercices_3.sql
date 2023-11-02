
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
