---
--- Manipulation de Texte 
---

-- Afficher le nom complet de chaque auteur en combinant leurs prénoms et noms :
SELECT prenom || ' ' || nom AS nom_complet
FROM auteur;

-- Convertir tous les noms de genres dans la table Genre en majuscules :
SELECT UPPER(nom_genre) AS nom_genre_majuscule
FROM genre;

-- Convertir tous les prénoms d'auteurs dans la table Auteur en minuscules :
SELECT LOWER(prenom) AS prenom_minuscule
FROM auteur;

-- S'assurer que chaque mot dans le titre d'un livre commence par une majuscule :
SELECT INITCAP(titre) AS titre_formatte
FROM livre;

-- Trouver la première lettre du prénom de chaque auteur :
SELECT SUBSTRING(prenom FROM 1 FOR 1) AS premiere_lettre_prenom
FROM auteur;

-- Extraire les trois premiers caractères de chaque nom de genre :
SELECT SUBSTRING(nom_genre FROM 1 FOR 3) AS trois_premiers_caracteres
FROM genre;

-- Trouver la position du mot "The" dans tous les titres de livres :
SELECT POSITION('The' IN titre) AS position_the
FROM Livre;

-- Calculer la longueur de chaque titre de livre :
SELECT CHAR_LENGTH(titre) AS longueur_titre
FROM Livre;

---
--- Manipulation de Dates 
---

-- Trouver tous les auteurs qui sont nés après 1900 :
SELECT *
FROM auteur
WHERE date_naissance > '1900-01-01';

-- Calculer l'âge actuel de chaque auteur :
SELECT prenom, nom, AGE(CURRENT_DATE, date_naissance) AS age_actuel
FROM auteur;

-- Extraire le mois de naissance pour chaque auteur :
SELECT prenom, nom, EXTRACT(MONTH FROM date_naissance) AS mois_naissance
FROM auteur;

-- Afficher la date à laquelle chaque livre aura 10 ans :
SELECT titre, date_publication + INTERVAL '10 years' AS date_anniversaire_10_ans
FROM livre;

  
-- Group by la table Livre par mois de
-- publication et comptez le nombre de livres publiés chaque mois  :
SELECT EXTRACT(MONTH FROM date_publication) AS mois_publication, COUNT(*) AS nombre_livres
FROM livre
GROUP BY mois_publication;

-- Afficher l'année de publication pour chaque livre :
SELECT titre, EXTRACT(YEAR FROM date_publication) AS annee_publication
FROM livre;
  
Pour chaque livre, calculez le nombre de jours entre la date de publication du livre et la date de naissance de l'auteur :
SELECT L.titre, A.prenom, A.nom, L.date_publication, A.date_naissance,
       AGE(L.date_publication, A.date_naissance) AS intervalle_temps
FROM livre L
FULL JOIN auteur A USING(auteur_id)
