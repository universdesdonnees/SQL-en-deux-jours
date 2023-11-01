-----
----- Schéma HR 
----- Tables : EmployeeDemographics et EmployeeSalary
-----

--	Listez tous les noms d'employés qui ont le poste "Salesman"
-- et qui ont plus de 30 ans.

SELECT employeesalary.jobtitle, employeedemographics.age, employeedemographics.firstname
FROM employeesalary
INNER JOIN employeedemographics
ON employeesalary.employeeid = employeedemographics.employeeid
WHERE employeedemographics.age > 30 and employeesalary.jobtitle = 'Salesman'

  
SELECT d.firstname, s.jobtitle, d.age
FROM employeedemographics d 
INNER JOIN employeesalary s 
ON d.employeeid = s.employeeid
WHERE s.jobtitle = 'Salesman' and d.age > 30;

-- 	Trouvez les employés ayant un salaire supérieur 
-- à la moyenne, mais qui ont moins de 32 ans.

SELECT d.firstname, d.lastname, d.age
FROM employeedemographics d 
INNER JOIN employeesalary s
ON d.employeeid = s.employeeid
WHERE salary > (
  SELECT avg(salary) as mean_salaire
  FROM employeesalary
) AND d.age < 32;


-----
----- Schéma Bibliothèque :  Table Empl
----- Tables : livre, auteur, genre 
-----

-- Listez tous les livres écrits par "George Orwell".
SELECT auteur.prenom || ' ' || auteur.nom AS auteur_identite, livre.titre
FROM auteur 
JOIN livre ON auteur.auteur_id = livre.auteur_id
WHERE auteur.prenom || ' ' || auteur.nom = 'George Orwell';

-- Quels sont les genres les plus populaires (en termes de nombre de livres) ?  
-- Classez-les par ordre décroissant.
SELECT genre.nom_genre, count(livre.genre_id) nombre_livres
from livre
left JOIN genre on livre.genre_id = genre.genre_id
GROUP by livre.genre_id, genre.genre_id
ORDER BY nombre_livres DESC;

-- Quels auteurs ont écrit au moins deux livres dans le genre Fiction ?
SELECT 
    auteur.prenom || ' ' || auteur.nom AS auteur_identite,
    COUNT(livre.livre_id) 
FROM auteur
JOIN livre ON auteur.auteur_id = livre.auteur_id
JOIN genre ON livre.genre_id = genre.genre_id
WHERE genre.nom_genre = 'Fiction'
GROUP BY auteur.prenom, auteur.nom
HAVING COUNT(livre.livre_id) >= 2;

-- Combien d'auteurs différents ont écrit des livres pour chaque genre ?
SELECT genre.nom_genre, COUNT(DISTINCT livre.auteur_id) AS nombre_auteurs
FROM genre 
JOIN livre ON genre.genre_id = livre.genre_id
GROUP BY genre.nom_genre
ORDER BY nombre_auteurs DESC, genre.nom_genre;

-- Quels auteurs ont écrit des livres dans plus de trois genres différents ?
SELECT auteur.prenom || ' ' || auteur.nom AS auteur_identite, 
		COUNT(DISTINCT livre.genre_id) AS nombre_genres
FROM auteur 
JOIN livre ON auteur.auteur_id = livre.auteur_id
GROUP BY auteur.auteur_id, auteur_identite
HAVING COUNT(DISTINCT livre.genre_id) > 3
ORDER BY nombre_genres DESC, auteur_identite;

-- Quels sont les genres les plus populaires (en termes de nombre de livres) du 19e siècle ?
SELECT genre.nom_genre, COUNT(livre.livre_id) AS nombre_de_livres
FROM livre
JOIN genre ON livre.genre_id = genre.genre_id
WHERE EXTRACT(YEAR FROM livre.date_publication) BETWEEN 1800 AND 1899
GROUP BY genre.nom_genre
ORDER BY nombre_de_livres DESC;

-- Quel est le livre le plus ancien pour chaque genre ?
SELECT genre.nom_genre, livre.titre, livre.date_publication
FROM genre 
JOIN livre ON genre.genre_id = livre.genre_id
WHERE (livre.genre_id, livre.date_publication) IN
    (SELECT genre_id, MIN(date_publication)
     FROM livre
     GROUP BY genre_id)
ORDER BY genre.nom_genre;

-- Quel est le genre le plus courant parmi les livres écrits par "J.K. Rowling"?
SELECT genre.nom_genre, COUNT(livre.livre_id) AS nombre_de_livres
FROM auteur
JOIN livre ON auteur.auteur_id = livre.auteur_id
JOIN genre ON livre.genre_id = genre.genre_id
WHERE auteur.prenom = 'J.K.' AND auteur.nom = 'Rowling'
GROUP BY genre.nom_genre
ORDER BY nombre_de_livres DESC

-- Quels auteurs ont écrit plus d'un livre sur la "Fiction"?
SELECT auteur.nom, genre.nom_genre, 
	COUNT(livre.livre_id) AS nombre_de_livres
FROM auteur
JOIN livre ON auteur.auteur_id = livre.auteur_id
JOIN genre ON livre.genre_id = genre.genre_id
WHERE genre.nom_genre = 'Fiction'
GROUP BY auteur.nom, genre.nom_genre
having COUNT(livre.livre_id) > 1;

-- Listez les auteurs qui ont écrit à la fois de la "Fiction" et de la "Science-fiction".
SELECT auteur.nom, genre.nom_genre 
FROM auteur
JOIN livre ON auteur.auteur_id = livre.auteur_id
JOIN genre ON livre.genre_id = genre.genre_id
WHERE genre.nom_genre = 'Fiction' and genre.nom_genre = 'Science-fiction'
GROUP BY auteur.nom, genre.nom_genre

-- Listez tous les livres qui ont été publiés la même année que "The Great Gatsby".
SELECT titre
FROM Livre
WHERE date_publication IN (
    SELECT date_publication
    FROM Livre
    WHERE titre = 'The Great Gatsby'
);

-- Listez tous les auteurs qui n'ont pas encore écrit de livres (basé sur les données actuelles).
select *
FROM auteur
full JOIN livre on auteur.auteur_id = livre.auteur_id
WHERE auteur.auteur_id ISNULL

-- Quel est le nombre moyen de livres par auteur ?
select AVG(number_book)
FROM (
  SELECT auteur_id, COUNT(*) as number_book
  from livre
  GROUP by auteur_id);

-- Quels sont les trois genres les moins courants dans la base de données?
SELECT genre.nom_genre, COUNT(livre.livre_id) AS nombre_de_livres
FROM Genre genre
LEFT JOIN Livre livre ON genre.genre_id = livre.genre_id
GROUP BY genre.nom_genre
ORDER BY nombre_de_livres ASC
LIMIT 3;
 
 -- Si un auteur a écrit le même nombre de livres dans plusieurs genres, 
 -- listez tous ces genres.


