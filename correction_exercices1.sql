--------------------------------------------------------
----------- Requetes simples
--------------------------------------------------------

-- Mettez à jour tous les livres du genre "Horreur" pour qu'ils soient du genre "Thriller".
UPDATE Livre
SET genre_id = (SELECT genre_id FROM Genre WHERE nom_genre = 'Thriller')
WHERE genre_id = (SELECT genre_id FROM Genre WHERE nom_genre = 'Horreur');

-- Trouvez le livre le plus ancien de la base de données.
SELECT titre, MIN(date_publication) as Date_publication_ancienne
FROM Livre
GROUP by titre
ORDER BY Date_publication_ancienne
LIMIT 1;

-- Trouvez tous les livres qui contiennent le mot "King" dans le titre.
SELECT titre
FROM Livre
WHERE titre LIKE '%King%';

-- Combien de livres ont été publiés après l'an 2000 ?
SELECT COUNT(*)
FROM Livre
WHERE date_publication > '2000-01-01';

-- Nommez tous les auteurs nés avant 1900.
SELECT nom, prenom
FROM Auteur
WHERE date_naissance < '1900-01-01';

-- Quel est le nombre de livres publiés chaque année ? 
-- Classez les résultats par année de publication.
SELECT EXTRACT(YEAR FROM date_publication) AS year, COUNT(livre_id) as Nombre_de_livres
FROM Livre
GROUP BY year
ORDER BY year;

-- Trouvez tous les livres qui n'ont pas été attribués à un genre.
SELECT titre
FROM Livre
WHERE genre_id IS NULL;

-- Combien d'auteurs ont leur anniversaire en janvier?
SELECT COUNT(auteur_id)
FROM Auteur
WHERE  EXTRACT(MONTH FROM date_naissance) = '01';

-- Listez tous les auteurs dont les noms commencent par la lettre 'M'.
SELECT nom, prenom
FROM Auteur
WHERE nom LIKE 'M%';

-- Quelles années ont vu la publication de plus de 2 livres ?
SELECT EXTRACT(YEAR FROM date_publication AS Annee_Publication
FROM Livre
GROUP BY Annee_Publication
HAVING COUNT(livre_id) > 2;
