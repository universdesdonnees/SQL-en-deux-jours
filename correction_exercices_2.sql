--	Listez tous les noms d'employés qui ont le poste "Salesman"
-- et qui ont plus de 30 ans.

SELECT d.firstname, s.jobtitle, d.age
from employeedemographics d 
INNER JOIN employeesalary s 
on d.employeeid = s.employeeid
WHERE s.jobtitle = 'Salesman' and d.age > 30;

-- 	Trouvez les employés ayant un salaire supérieur 
-- à la moyenne, mais qui ont moins de 32 ans.

-- salaire, age 
select d.firstname, d.lastname, d.age
FROM employeedemographics d 
INNER JOIN employeesalary s
ON d.employeeid = s.employeeid
Where salary > (
  select avg(salary) as mean_salaire
  from employeesalary
) and d.age < 32;

