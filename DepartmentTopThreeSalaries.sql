SELECT 
Department, Employee, Salary FROM
(SELECT d.name AS Department,
       e.name AS Employee,
       e.salary AS Salary,
    DENSE_RANK() OVER (PARTITION BY d.id ORDER BY e.salary DESC ) AS ran
FROM Employee AS e
INNER JOIN Department AS d ON e.departmentId = d.id
) AS T WHERE ran<=3 


