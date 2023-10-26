-- Mettez à jour tous les livres du genre "Horreur" pour qu'ils soient du genre "Thriller".
UPDATE genre
SET nom_genre = 'Thriller'
WHERE nom_genre = 'Horreur';

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
where titre like '%King%';

-- Nommez tous les auteurs nés avant 1900.
SELECT prenom, nom, date_naissance
from auteur
where date_naissance < '1900-01-01'
order by date_naissance;

-- Quel est le nombre de livres publiés chaque année ? 
-- Classez les résultats par année de publication. 
-- Aide : EXTRACT(YEAR FROM date_publication) AS year
select EXTRACT(YEAR FROM date_publication) AS year, COUNT(*) as nombre_livre
FROM livre
GROUP by year
ORDER by year ;

-- Trouvez tous les livres qui n'ont pas été attribués à un genre.
select * 
from livre
where genre_id is NULL;

-- Combien d'auteurs ont leur anniversaire en janvier?
select extract(MONTH from date_naissance) as MONTH, count(*)
from auteur
GROUP by MONTH
having extract(MONTH from date_naissance) = 1;

-- Listez tous les auteurs dont les noms commencent par la lettre 'M'.
SELECT prenom, nom
from auteur
where nom like 'M%';

-- Quelles années ont vu la publication de plus de 2 livres ?
select EXTRACT(YEAR FROM date_publication) AS year, COUNT(*)
FROM livre
GROUP by year
HAVING COUNT(*) > 2



