
SELECT 
  ED.EmployeeID,
  ED.FirstName,
  ED.LastName,
  ES.JobTitle,
  ES.Salary,
  RANK() OVER (ORDER BY ES.Salary DESC) AS SalaryRank
FROM 
  EmployeeDemographics ED
JOIN 
  EmployeeSalary ES ON ED.EmployeeID = ES.EmployeeID;

SELECT 
  EmployeeID,
  JobTitle,
  Salary,
  SUM(Salary) OVER (PARTITION BY JobTitle) AS TotalSalaryByJobTitle
FROM 
  EmployeeSalary;

SELECT 
  EmployeeID,
  JobTitle,
  Salary,
  AVG(Salary) OVER (PARTITION BY JobTitle) AS AverageSalaryByJobTitle
FROM 
  EmployeeSalary;

SELECT 
  ED.EmployeeID,
  ED.FirstName,
  ED.LastName,
  ES.JobTitle,
  ES.Salary,
  LAG(ES.Salary) OVER (ORDER BY ES.Salary DESC) AS PreviousSalary
FROM 
  EmployeeDemographics ED
JOIN 
  EmployeeSalary ES ON ED.EmployeeID = ES.EmployeeID;

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

