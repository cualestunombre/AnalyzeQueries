SELECT DISTINCT T.YEAR, T.MONTH, T.GENDER, COUNT(*) 
OVER(PARTITION BY T.YEAR,T.MONTH, T.GENDER) as USERS FROM 
(SELECT DISTINCT U.GENDER,U.USER_ID, YEAR(SALES_DATE) 
 AS YEAR, MONTH(SALES_DATE) AS MONTH FROM ONLINE_SALE as O 
 INNER JOIN USER_INFO AS U ON U.USER_ID = O.USER_ID 
 WHERE U.GENDER IS NOT NULL) AS T 
 ORDER BY YEAR ASC, MONTH ASC, GENDER ASC