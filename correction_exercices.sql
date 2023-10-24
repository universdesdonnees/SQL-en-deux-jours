-- Mettez à jour le titre du livre "1984" pour qu'il soit "Nineteen Eighty-Four".
UPDATE Livre
SET titre = 'Nineteen Eighty-Four'
WHERE titre = '1984';

-- Trouvez le livre le plus ancien de la base de données.
SELECT titre, MIN(date_publication) as Date_publication_ancienne
FROM Livre;

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
SELECT date_publication, COUNT(livre_id) as Nombre_de_livres
FROM Livre
GROUP BY date_publication
ORDER BY date_publication;

-- Listez tous les livres écrits par "George Orwell".
SELECT titre
FROM Livre
JOIN Auteur ON Livre.auteur_id = Auteur.auteur_id
WHERE Auteur.nom = 'Orwell' AND Auteur.prenom = 'George';

-- Quels sont les genres les plus populaires (en termes de nombre de livres) ? 
-- Classez-les par ordre décroissant.
SELECT nom_genre, COUNT(livre_id) as Nombre_de_livres
FROM Livre
JOIN Genre ON Livre.genre_id = Genre.genre_id
GROUP BY nom_genre
ORDER BY Nombre_de_livres DESC;

-- Quel est le genre le plus courant parmi les livres écrits par "J.K. Rowling"?
SELECT nom_genre, COUNT(livre_id) as Nombre_de_livres
FROM Livre
JOIN Genre ON Livre.genre_id = Genre.genre_id
JOIN Auteur ON Livre.auteur_id = Auteur.auteur_id
WHERE Auteur.nom = 'Rowling' AND Auteur.prenom = 'J.K.'
GROUP BY nom_genre
ORDER BY Nombre_de_livres DESC
LIMIT 1;


-- Quels auteurs ont écrit plus d'un livre sur la "Fiction"?
SELECT nom, prenom
FROM Auteur
JOIN Livre ON Auteur.auteur_id = Livre.auteur_id
JOIN Genre ON Livre.genre_id = Genre.genre_id
WHERE Genre.nom_genre = 'Fiction'
GROUP BY Livre.auteur_id
HAVING COUNT(livre_id) > 1;

-- Listez les auteurs qui ont écrit à la fois de la "Fiction" et de la "Science-fiction".
SELECT nom, prenom
FROM Auteur
JOIN Livre ON Auteur.auteur_id = Livre.auteur_id
JOIN Genre ON Livre.genre_id = Genre.genre_id
WHERE nom_genre IN ('Fiction', 'Science-fiction')
GROUP BY Livre.auteur_id
HAVING COUNT(DISTINCT nom_genre) = 2;


-- Listez tous les livres qui ont été publiés la même année que "The Great Gatsby".
SELECT titre
FROM Livre
WHERE date_publication = (SELECT date_publication FROM Livre WHERE titre = 'The Great Gatsby');

-- Listez tous les auteurs qui n'ont pas encore écrit de livres (basé sur les données actuelles).
SELECT nom, prenom
FROM Auteur
WHERE auteur_id NOT IN (SELECT DISTINCT auteur_id FROM Livre);

-- Quel est le nombre moyen de livres par auteur ?
SELECT AVG(Nombre_de_livres)
FROM (
    SELECT auteur_id, COUNT(livre_id) as Nombre_de_livres
    FROM Livre
    GROUP BY auteur_id
) AS SousTable;





-- Combien d'auteurs ont leur anniversaire en janvier?
SELECT COUNT(auteur_id)
FROM Auteur
WHERE strftime('%m', date_naissance) = '01';

-- Trouvez tous les livres qui n'ont pas été attribués à un genre.
SELECT titre
FROM Livre
WHERE genre_id IS NULL;

-- Listez tous les auteurs dont les noms commencent par la lettre 'M'.
SELECT nom, prenom
FROM Auteur
WHERE nom LIKE 'M%';

-- Mettez à jour tous les livres du genre "Horreur" pour qu'ils soient du genre "Thriller".
UPDATE Livre
SET genre_id = (SELECT genre_id FROM Genre WHERE nom_genre = 'Thriller')
WHERE genre_id = (SELECT genre_id FROM Genre WHERE nom_genre = 'Horreur');

-- Quels sont les trois genres les moins courants dans la base de données?
SELECT nom_genre, COUNT(livre_id) as Nombre_de_livres
FROM Genre
LEFT JOIN Livre ON Genre.genre_id = Livre.genre_id
GROUP BY nom_genre
ORDER BY Nombre_de_livres
LIMIT 3;

-- Pour chaque auteur, trouvez le genre dans lequel ils ont écrit le plus de livres. Si un auteur a écrit le même nombre de livres dans plusieurs genres, listez tous ces genres.
WITH LivresParAuteurEtGenre AS (
    SELECT Livre.auteur_id, Livre.genre_id, COUNT(Livre.livre_id) as Nombre_de_livres
    FROM Livre
    GROUP BY Livre.auteur_id, Livre.genre_id
),
MaxLivres AS (
    SELECT auteur_id, MAX(Nombre_de_livres) as MaxLivres
    FROM LivresParAuteurEtGenre
    GROUP BY auteur_id
)
SELECT Auteur.nom, Auteur.prenom, Genre.nom_genre
FROM LivresParAuteurEtGenre
JOIN MaxLivres ON LivresParAuteurEtGenre.auteur_id = MaxLivres.auteur_id
JOIN Auteur ON LivresParAuteurEtGenre.auteur_id = Auteur.auteur_id
JOIN Genre ON LivresParAuteurEtGenre.genre_id = Genre.genre_id
WHERE LivresParAuteurEtGenre.Nombre_de_livres = MaxLivres.MaxLivres;

