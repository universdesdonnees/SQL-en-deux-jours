
-- Création de la table Genre
CREATE TABLE Genre (
    genre_id INT PRIMARY KEY,
    nom_genre VARCHAR(255) NOT NULL
);

-- Création de la table Auteur
CREATE TABLE Auteur (
    auteur_id INT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    date_naissance DATE
);

-- Création de la table Livre
CREATE TABLE Livre (
    livre_id INT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    date_publication DATE,
    genre_id INT,
    auteur_id INT,
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id),
    FOREIGN KEY (auteur_id) REFERENCES Auteur(auteur_id)
);

-- Insertion de données pour la table Genre
INSERT INTO Genre VALUES (1, 'Fiction');
INSERT INTO Genre VALUES (2, 'Science-fiction');
INSERT INTO Genre VALUES (3, 'Romance');
INSERT INTO Genre VALUES (4, 'Histoire');
INSERT INTO Genre VALUES (5, 'Biographie');
INSERT INTO Genre VALUES (6, 'Fantasy');
INSERT INTO Genre VALUES (7, 'Thriller');
INSERT INTO Genre VALUES (8, 'Mystère');
INSERT INTO Genre VALUES (9, 'Horreur');
INSERT INTO Genre VALUES (10, 'Aventure');
INSERT INTO Genre VALUES (11, 'Non-fiction');
INSERT INTO Genre VALUES (12, 'Jeunesse');
INSERT INTO Genre VALUES (13, 'Drame');
INSERT INTO Genre VALUES (14, 'Comédie');
INSERT INTO Genre VALUES (15, 'Poésie');
INSERT INTO Genre VALUES (16, 'Bande dessinée');
INSERT INTO Genre VALUES (17, 'Manga');
INSERT INTO Genre VALUES (18, 'Satire');
INSERT INTO Genre VALUES (19, 'Classique');
INSERT INTO Genre VALUES (20, 'Anthologie');

-- Insertion de données pour la table Auteur
INSERT INTO Auteur VALUES (1, 'Martin', 'George', '1948-09-20');
INSERT INTO Auteur VALUES (2, 'Rowling', 'J.K.', '1965-07-31');
INSERT INTO Auteur VALUES (3, 'Orwell', 'George', '1903-06-25');
INSERT INTO Auteur VALUES (4, 'Shelley', 'Mary', '1797-08-30');
INSERT INTO Auteur VALUES (5, 'Verne', 'Jules', '1828-02-08');
INSERT INTO Auteur VALUES (6, 'Austen', 'Jane', '1775-12-16');
INSERT INTO Auteur VALUES (7, 'Tolkien', 'J.R.R.', '1892-01-03');
INSERT INTO Auteur VALUES (8, 'Hemingway', 'Ernest', '1899-07-21');
INSERT INTO Auteur VALUES (9, 'Fitzgerald', 'F. Scott', '1896-09-24');
INSERT INTO Auteur VALUES (10, 'Dickens', 'Charles', '1812-02-07');
INSERT INTO Auteur VALUES (11, 'Bradbury', 'Ray', '1920-08-22');
INSERT INTO Auteur VALUES (12, 'Lee', 'Harper', '1926-04-28');
INSERT INTO Auteur VALUES (13, 'Salinger', 'J.D.', '1919-01-01');
INSERT INTO Auteur VALUES (14, 'Steinbeck', 'John', '1902-02-27');
INSERT INTO Auteur VALUES (15, 'Woolf', 'Virginia', '1882-01-25');
INSERT INTO Auteur VALUES (16, 'Dostoevsky', 'Fyodor', '1821-11-11');
INSERT INTO Auteur VALUES (17, 'Huxley', 'Aldous', '1894-07-26');
INSERT INTO Auteur VALUES (18, 'Hugo', 'Victor', '1802-02-26');
INSERT INTO Auteur VALUES (19, 'Poe', 'Edgar Allan', '1809-01-19');
INSERT INTO Auteur VALUES (20, 'Marquez', 'Gabriel Garcia', '1927-03-06');

-- Insertion de données pour la table Livre
INSERT INTO Livre VALUES (1, 'Game of Thrones', '1996-08-01', 1, 1);
INSERT INTO Livre VALUES (2, '1984', '1949-06-08', 2, 3);
INSERT INTO Livre VALUES (3, 'Harry Potter and the Philosopher''s Stone', '1997-06-26', 1, 2);
INSERT INTO Livre VALUES (4, 'Frankenstein', '1818-01-01', 1, 4);
INSERT INTO Livre VALUES (5, '20,000 Leagues Under the Sea', '1870-03-20', 2, 5);
INSERT INTO Livre VALUES (6, 'Pride and Prejudice', '1813-01-28', 3, 6);
INSERT INTO Livre VALUES (7, 'The Fellowship of the Ring', '1954-07-29', 6, 7);
INSERT INTO Livre VALUES (8, 'The Old Man and the Sea', '1952-09-01', 4, 8);
INSERT INTO Livre VALUES (9, 'The Great Gatsby', '1925-04-10', 1, 9);
INSERT INTO Livre VALUES (10, 'A Tale of Two Cities', '1859-04-30', 1, 10);
INSERT INTO Livre VALUES (11, 'Sense and Sensibility', '1811-10-30', 3, 6);
INSERT INTO Livre VALUES (12, 'The Two Towers', '1954-11-11', 6, 7);
INSERT INTO Livre VALUES (13, 'A Farewell to Arms', '1929-09-27', 1, 8);
INSERT INTO Livre VALUES (14, 'Brave New World', '1932-09-01', 2, 17);
INSERT INTO Livre VALUES (15, 'Journey to the Center of the Earth', '1864-11-25', 2, 5);
INSERT INTO Livre VALUES (16, 'Emma', '1815-12-25', 3, 6);
INSERT INTO Livre VALUES (17, 'The Return of the King', '1955-10-20', 6, 7);
INSERT INTO Livre VALUES (18, 'For Whom the Bell Tolls', '1940-10-21', 4, 8);
INSERT INTO Livre VALUES (19, 'David Copperfield', '1850-05-01', 1, 10);
INSERT INTO Livre VALUES (20, 'Fahrenheit 451', '1953-10-19', 2, 11);          
INSERT INTO Livre VALUES (21, 'To Kill a Mockingbird', '1960-07-11', 1, 12);    
INSERT INTO Livre VALUES (22, 'The Catcher in the Rye', '1951-07-16', 1, 13);     
INSERT INTO Livre VALUES (23, 'The Grapes of Wrath', '1939-04-14', 1, 14);      
INSERT INTO Livre VALUES (24, 'Mrs Dalloway', '1925-05-14', 1, 15);              
INSERT INTO Livre VALUES (25, 'Crime and Punishment', '1866-01-01', 13, 16);      
INSERT INTO Livre VALUES (26, 'The Doors of Perception', '1954-11-10', 11, 17);   
INSERT INTO Livre VALUES (27, 'Les Misérables', '1862-01-14', 1, 18);             
INSERT INTO Livre VALUES (28, 'The Raven', '1845-01-29', 15, 19);              
INSERT INTO Livre VALUES (29, 'One Hundred Years of Solitude', '1967-06-05', 1, 20); 
