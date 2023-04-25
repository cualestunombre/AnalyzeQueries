WITH 
    TOTAL AS (
        SELECT 
            T.request_at AS Date, 
            COUNT(*) AS CNT 
        FROM 
            Trips AS T 
            INNER JOIN Users AS U ON U.users_id = T.client_id 
            INNER JOIN Users AS V ON T.driver_id = V.users_id 
        WHERE 
            U.banned = 'No' AND V.banned = 'No' AND T.request_at BETWEEN '2013-10-01' AND '2013-10-03'  
        GROUP BY 
            T.request_at
    ),
    CANCELLED_TRIPS AS (
        SELECT 
            T.request_at AS Date, 
            COUNT(*) AS CNT 
        FROM 
            Trips AS T 
            INNER JOIN Users AS U ON U.users_id = T.client_id 
            INNER JOIN Users AS V ON T.driver_id = V.users_id 
        WHERE 
            U.banned = 'No' AND V.banned = 'No' AND T.status != 'completed' AND T.request_at BETWEEN '2013-10-01' AND '2013-10-03' 
        GROUP BY 
            T.request_at
    )
SELECT 
    T.Date AS Day, 
    ROUND(IFNULL(C.CNT, 0) / T.CNT, 2) AS 'Cancellation Rate' 
FROM 
    TOTAL AS T 
    LEFT JOIN CANCELLED_TRIPS AS C ON T.Date = C.Date
