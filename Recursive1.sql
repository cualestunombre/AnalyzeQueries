WITH RECURSIVE cte AS (
    SELECT 0 as n
    UNION ALL
    SELECT n + 1 FROM cte WHERE n < 23
)
SELECT cte.n AS HOUR, COUNT(a.ANIMAL_ID) AS COUNT
FROM cte
LEFT JOIN ANIMAL_OUTS a ON cte.n = HOUR(a.DATETIME)
GROUP BY cte.n
ORDER BY cte.n;
/*
시간을 0,1,2,3....23까지 recursive하게 생성해서 
LEFT inner join하는 것이 포인트!! 
출처 : https://school.programmers.co.kr/learn/courses/30/lessons/59413#qna
*/