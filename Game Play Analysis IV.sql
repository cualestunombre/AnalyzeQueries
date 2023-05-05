WITH TARGET1 AS (
    SELECT player_id, MIN(event_date) as MIN_DATE FROM Activity as A1
    GROUP BY player_id
),
TARGET2 AS (
    SELECT  COUNT(DISTINCT A1.player_id) as CNT FROM Activity as A1
    WHERE EXISTS (
            SELECT 1 FROM TARGET1 as A2
                WHERE 
                    A1.player_id = A2.player_id
                    AND
                    ABS(DATEDIFF(A1.event_date, A2.MIN_DATE))=1
    )
)
SELECT ROUND(TARGET2.CNT/COUNT(DISTINCT player_id), 2) as fraction FROM activity , TARGET2; 