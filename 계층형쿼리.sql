-- +-------+-------------+------------------+-----------------+
-- | level | employee_id | emp_name         | path            |
-- +-------+-------------+------------------+-----------------+
-- |     1 |         100 | Steven King      | 100             |
-- |     2 |         101 | a                | 100,101         |
-- |     2 |         102 | b                | 100,102         |
-- |     3 |         200 | Jennifer Whalen  | 100,101,200     |
-- |     3 |         203 | Susan Mavris     | 100,101,203     |
-- |     3 |         103 | Alexander Hunold | 100,102,103     |
-- |     3 |         204 | Hermann Baer     | 100,101,204     |
-- |     3 |         108 | g                | 100,101,108     |
-- |     3 |         205 | i                | 100,101,205     |
-- |     4 |         104 | Bruce Ernst      | 100,102,103,104 |
-- |     4 |         105 | David Austion    | 100,102,103,105 |
-- |     4 |         107 | Diana Lorentz    | 100,102,103,107 |
-- |     4 |         106 | Valli Pataballa  | 100,102,103,106 |
-- |     4 |         113 | c                | 100,101,108,113 |
-- |     4 |         112 | d                | 100,101,108,112 |
-- |     4 |         111 | e                | 100,101,108,111 |
-- |     4 |         110 | f                | 100,101,108,110 |
-- |     4 |         109 | h                | 100,101,108,109 |
-- |     4 |         206 | j                | 100,101,205,206 |
-- +-------+-------------+------------------+-----------------+
-- let's get it MYSQL 402페이지
-- 계층적 정보를 표시하는 쿼리(트리 구조)
 WITH RECURSIVE cte1 AS
 ( SELECT 1 level, employee_id, emp_name, CAST(employee_id AS CHAR(200)) path 
 FROM emp_hierarchy WHERE manager_id IS NULL 
 UNION ALL 
 SELECT level+1, b.employee_id, b.emp_name, CONCAT(a.path,',',b.employee_id) 
 FROM cte1 a INNER JOIN emp_hierarchy b ON a.employee_id = b.manager_id ) 
 select * from cte1;