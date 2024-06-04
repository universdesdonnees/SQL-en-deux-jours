-- Mettez à jour tous les livres du genre "Horreur" pour qu'ils soient du genre "Thriller".
-- conseil passer par les numéros de genre_id
UPDATE livre
SET genre_id = 7
WHERE genre_id = 9 

-- Trouvez le livre le plus ancien de la base de données : 2 facons
select titre, date_publication
FROM livre
ORDER by date_publication ASC
LIMIT 1;

select titre, min(date_publication) as oldest_book
FROM livre
GROUP by titre
ORDER by oldest_book ASC
LIMIT 1;

-- Trouvez tous les livres qui contiennent le mot "King" dans le titre.
SELECT titre
FROM livre
WHERE titre LIKE '%King%';

-- Combien de livres ont été publiés après l'an 2000 ?
SELECT titre
FROM livre
WHERE date_publication > '1999-12-31';

-- Nommez tous les auteurs nés avant 1900.
SELECT prenom, nom, date_naissance
FROM auteur
WHERE date_naissance < '1900-01-01'
ORDER BY date_naissance;

-- Quel est le nombre de livres publiés chaque année ? 
-- Classez les résultats par année de publication. 
-- Aide : EXTRACT(YEAR FROM date_publication) AS year
SELECT EXTRACT(YEAR FROM date_publication) AS year, COUNT(*) AS nombre_livre
FROM livre
GROUP by year
ORDER by year ;

-- Combien d'auteurs ont leur anniversaire en janvier?

-- 1
SELECT extract(MONTH from date_naissance) as mois, count(*)
FROM auteur
GROUP BY mois
HAVING extract(month from date_naissance) = 1;

--2
select count(*) as nombre_auteur
from auteur
where EXTRACT(MONTh from date_naissance)  = 1;

-- 3
select EXTRACT(MONTh from date_naissance) as mois,
	count(*) as nombre_auteur
from auteur
group by mois
Having EXTRACT(MONTh from date_naissance) = '01'


-- Listez tous les auteurs dont les noms commencent par la lettre 'M'.
SELECT prenom, nom
FROM auteur
WHERE nom LIKE 'M%';

-- Quelles années ont vu la publication de plus de 2 livres ?
select EXTRACT(YEAR FROM date_publication) AS year, COUNT(*)
FROM livre
GROUP by year
HAVING COUNT(*) > 2
