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

