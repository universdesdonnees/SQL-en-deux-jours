-- RANK(): Attribue un rang aux employés basé sur leur salaire dans 
-- un ordre décroissant, où des salaires égaux reçoivent le même rang
-- et les rangs suivants sont ajustés en conséquence (comme 1, 2, 2, 4...).
SELECT ED.EmployeeID, ED.FirstName, ED.LastName, ES.JobTitle, ES.Salary,
  RANK() OVER (ORDER BY ES.Salary DESC) AS SalaryRank
FROM  EmployeeDemographics ED
FULL JOIN  EmployeeSalary ES ON ED.EmployeeID = ES.EmployeeID;

-- SUM(): Calcule la somme totale des salaires pour chaque titre de poste,
-- montrant ainsi la masse salariale allouée à chaque poste.
SELECT jobtitle, TotalSalaryByJobTitle
FROM (SELECT JobTitle,
    SUM(Salary) OVER (PARTITION BY JobTitle) AS TotalSalaryByJobTitle
	  FROM EmployeeSalary)
GROUP BY jobtitle, TotalSalaryByJobTitle

-- AVG(): Détermine la moyenne des salaires par titre de poste, permettant
-- d'évaluer la rémunération moyenne pour chaque catégorie d'emploi.
SELECT  EmployeeID, JobTitle,  Salary,
  AVG(Salary) OVER (PARTITION BY JobTitle) AS AverageSalaryByJobTitle
FROM EmployeeSalary;

-- LAG(): Affiche le salaire précédent par rapport à chaque employé lorsque les
-- salaires sont ordonnés du plus élevé au plus bas, permettant de comparer le 
-- salaire d'un employé avec celui qui le précède immédiatement.
SELECT  ED.EmployeeID, ED.FirstName, ED.LastName, ES.JobTitle, ES.Salary,
  LAG(ES.Salary) OVER (ORDER BY ES.Salary DESC) AS PreviousSalary
FROM 
  EmployeeDemographics ED
JOIN 
  EmployeeSalary ES ON ED.EmployeeID = ES.EmployeeID;

-- LEAD(): Indique le salaire qui suit directement celui 
-- de chaque employé dans la liste ordonnée des salaires décroissants, 
-- utile pour la comparaison entre un employé et celui qui le suit.
SELECT 
  ED.EmployeeID,
  ED.FirstName,
  ED.LastName,
  ES.JobTitle,
  ES.Salary,
  LEAD(ES.Salary) OVER (ORDER BY ES.Salary DESC) AS NextSalary
FROM 
  EmployeeDemographics ED
JOIN 
  EmployeeSalary ES ON ED.EmployeeID = ES.EmployeeID;

-- FIRST_VALUE(): Montre le salaire le plus élevé parmi tous les employés, 
-- en donnant un point de référence pour le salaire maximal dans l'entreprise.
SELECT 
  ED.EmployeeID,
  ED.FirstName,
  ED.LastName,
  ES.Salary,
  FIRST_VALUE(ES.Salary) OVER (ORDER BY ES.Salary DESC) AS HighestSalary
FROM 
  EmployeeDemographics ED
JOIN 
  EmployeeSalary ES ON ED.EmployeeID = ES.EmployeeID;

-- LAST_VALUE(): Donne le salaire le plus bas dans l'ensemble ordonné des salaires,
-- tout en nécessitant une spécification de portée pour fonctionner correctement sur l'ensemble des données.
SELECT 
  ED.EmployeeID,
  ED.FirstName,
  ED.LastName,
  ES.Salary,
  LAST_VALUE(ES.Salary) OVER (
    ORDER BY ES.Salary
    RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
  ) AS LowestSalary
FROM 
  EmployeeDemographics ED
JOIN 
  EmployeeSalary ES ON ED.EmployeeID = ES.EmployeeID;
-- NTILE(): Répartit les employés en quatre groupes de salaires, 
-- offrant une manière de catégoriser les employés en quartiles basés sur leur rémunération.
SELECT 
  ED.EmployeeID,
  ED.FirstName,
  ED.LastName,
  ES.JobTitle,
  ES.Salary,
  NTILE(4) OVER (ORDER BY ES.Salary DESC) AS SalaryQuartile
FROM 
  EmployeeDemographics ED
JOIN 
  EmployeeSalary ES ON ED.EmployeeID = ES.EmployeeID;

