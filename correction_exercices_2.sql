-----
----- Schéma HR 
----- Tables : EmployeeDemographics et EmployeeSalary
-----

-- Listez tous les noms d'employés qui ont le poste "Salesman"
-- et qui ont plus de 30 ans.

SELECT employeesalary.jobtitle, employeedemographics.age, employeedemographics.firstname
FROM employeesalary
INNER JOIN employeedemographics
ON employeesalary.employeeid = employeedemographics.employeeid
WHERE employeedemographics.age > 30 and employeesalary.jobtitle = 'Salesman';
	
 -- Identique à la requete précédente, utilisation des alias 'AS'
	
SELECT d.firstname, s.jobtitle, d.age
FROM employeedemographics AS d 
INNER JOIN employeesalary AS s 
ON d.employeeid = s.employeeid
WHERE s.jobtitle = 'Salesman' and d.age > 30;

-- Trouvez les employés ayant un salaire supérieur 
-- à la moyenne, mais qui ont moins de 32 ans.

SELECT d.firstname, d.lastname, d.age
FROM employeedemographics d 
INNER JOIN employeesalary s
ON d.employeeid = s.employeeid
WHERE salary > (
  SELECT avg(salary) as mean_salaire
  FROM employeesalary
) AND d.age < 32;

-- Listez tous les employés qui sont soit "Salesman", soit "Accountant" 
-- mais pas les deux

-- 1
select d.lastname
from employeedemographics d 
left join employeesalary s
on d.employeeid = s.employeeid
Where s.jobtitle IN ('Salesman', 'Accountant')
EXCEPT
select d.lastname
from employeedemographics d 
left join employeesalary s
on d.employeeid = s.employeeid
Where s.jobtitle =  'Salesman' AND s.jobtitle =  'Accountant'

-- 2
SELECT d.lastname
FROM employeedemographics d 
JOIN employeesalary s ON d.employeeid = s.employeeid
WHERE s.jobtitle IN ('Salesman', 'Accountant')
GROUP BY d.lastname
HAVING COUNT(DISTINCT s.jobtitle) = 1;


-- Listez les employés qui n'ont pas le titre "HR" et qui ont moins de 35 ans.

Select d.lastname, s.jobtitle
from employeedemographics as d
INNER join employeesalary as s
on d.employeeid = s.employeeid
WHERE s.jobtitle != 'HR' and d.age < 35;

-- Identifiez les employés qui ont le même salaire que 'Pam Beasley'. 2 requetes possibles 
-- 1 
SELECT d.lastname, d.firstname, s.salary
from employeedemographics as d 
INNER JOIN employeesalary as s
on d.employeeid = s.employeeid
Where s.salary = (
	select salary 
	from employeesalary
	WHERE employeeid  = (
    	select employeeid
    	from employeedemographics
    	where lastname = 'Beasley' AND firstname = 'Pam')) and 
lastname != 'Beasley';
-- 2 
SELECT d.lastname, d.firstname, s.salary
from employeedemographics as d 
INNER JOIN employeesalary as s
on d.employeeid = s.employeeid
Where s.salary = (  
  select se.salary
  from employeesalary as se 
  INNER JOIN employeedemographics as de 
  on se.employeeid = de.employeeid
  WHERE lastname = 'Beasley'
  	) AND 
lastname != 'Beasley';
   
 -- Classifiez les salaires des employés en différentes catégories
 -- en utilisant la clause CASE :'Bas' pour les salaires inférieurs à 40 000,
 -- 'Moyen' pour les salaires entre 40 000 et 55 000 et 
 -- 'Haut' pour les salaires supérieurs à 55 000
 -- Compter le nombre de catégories de salaires
	 
SELECT  
    CASE 
        WHEN salary < 40000 THEN 'bas'
        WHEN salary BETWEEN 40000 AND 55000 THEN 'moyen'
        ELSE 'haut' 
    END AS salary_label, 
    COUNT(*) as salary_count
FROM employeesalary
GROUP BY salary_label

-- Combien d'hommes et de femmes tombent dans chaque 
-- classification de salaire ('Bas', 'Moyen', 'Haut'). 
SELECT d.gender,
 	CASE 
        WHEN salary < 40000 THEN 'bas'
        WHEN salary BETWEEN 40000 AND 55000 THEN 'moyen'
        ELSE 'haut' 
    END AS salary_label, 
    count(*) as salary_count
from employeesalary as s
INNER join employeedemographics as d
on s.employeeid = d.employeeid
GROUP by gender, salary_label;

-- Trouvez le salaire moyen des hommes et des femmes.
--salaire, genre 

SELECT d.gender, ROUND(avg(salary), 2) as avg_salary
from employeedemographics d 
INNER join employeesalary s 
on d.employeeid = s.employeeid
GROUP by d.gender

-----
----- Schéma Bibliothèque 
----- Tables : livre, auteur, genre 
-----

-- Listez tous les livres écrits par "George Orwell".
SELECT livre.titre
FROM livre
FULL JOIN auteur
USING (auteur_id)
WHERE prenom ||' '|| nom = 'George Orwell';

-- Quels sont les genres les plus populaires (en termes de nombre de livres) ?  
-- Classez-les par ordre décroissant.
SELECT ge.nom_genre, COUNT(*) as nb_livre
FROM genre ge
FULL JOIN livre USING(genre_id)
GROUP by ge.nom_genre
ORDER by nb_livre desc
	
-- Quel est le genre le plus courant parmi les livres écrits par "J.K. Rowling"?
SELECT ge.nom_genre, COUNT(*) as nb_livre
FROM genre ge
FULL join livre USING(genre_id)
FULL JOIN auteur USING(auteur_id)
WHERE prenom ||' '|| nom = 'J.K. Rowling'
GROUP BY ge.nom_genre
ORDER BY nb_livre desc

-- Quels auteurs ont écrit plus d'un livre sur la "Fiction"? : 2 requetes possibles
--1
SELECT au.prenom ||' '|| au.nom AS auteur_identite, COUNT(*) 
FROM (
	SELECT ge.nom_genre, l.titre, l.auteur_id
	FROM genre ge 
	FULL JOIN livre l USING(genre_id)	
  	WHERE ge.nom_genre ='Fiction'
	) as livre_fiction
FULL JOIN auteur au
ON livre_fiction.auteur_id = au.auteur_id
GROUP BY auteur_identite
HAVING count(*)  > 1

--2
SELECT 
    auteur.prenom || ' ' || auteur.nom AS auteur_identite,
    COUNT(livre.livre_id) 
FROM auteur
JOIN livre ON auteur.auteur_id = livre.auteur_id
JOIN genre ON livre.genre_id = genre.genre_id
WHERE genre.nom_genre = 'Fiction'
GROUP BY auteur.prenom, auteur.nom
HAVING COUNT(livre.livre_id) > 1;

-- Combien d'auteurs différents ont écrit des livres pour chaque genre ?
SELECT genre.nom_genre, COUNT(DISTINCT livre.auteur_id) AS nombre_auteurs
FROM genre 
JOIN livre ON genre.genre_id = livre.genre_id
GROUP BY genre.nom_genre
ORDER BY nombre_auteurs DESC, genre.nom_genre;

-- Quels auteurs ont écrit des livres dans au moins 2 genres différents ?
SELECT auteur.prenom || ' ' || auteur.nom AS auteur_identite, 
		COUNT(DISTINCT livre.genre_id) AS nombre_genres
FROM auteur 
JOIN livre ON auteur.auteur_id = livre.auteur_id
GROUP BY auteur.auteur_id, auteur_identite
HAVING COUNT(DISTINCT livre.genre_id) > 1
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

-- Listez les auteurs qui ont écrit à la fois de la "Fiction" et de la "Science-fiction".

select auteur.prenom || ' ' || auteur.nom AS auteur_identite
FROM auteur
where auteur.auteur_id = (
	select  l.auteur_id
	from genre ge 
	FULL join livre l using(genre_id)	
	WHERE ge.nom_genre = 'Fiction'
	INTERSECT
	select  l.auteur_id
	from genre ge 
	FULL join livre l using(genre_id)	
	WHERE ge.nom_genre = 'Science-fiction'
)

--	Listez tous les livres qui ont été publiés après "The Great Gatsby".
select titre
from livre
where date_publication > (
	select date_publication
	from livre
	WHERE titre = 'The Great Gatsby'
)
 
-- Quel est le nombre moyen de livres par auteur ?
select ROUND(AVg(nombre_livre), 2) as nombre_moyen_livre
from (
  select auteur_id, COUNT(*) nombre_livre	
  from auteur
  full JOIN livre USING(auteur_id)
  GROUP by auteur_id) 

-- Quels sont les trois genres les moins courants dans la base de données ?

SELECT nom_genre, COUNT(*) nombre_livre
from genre
FULL join livre using(genre_id)
GROUP by nom_genre
ORDER by nombre_livre 
LIMIT 3
 

