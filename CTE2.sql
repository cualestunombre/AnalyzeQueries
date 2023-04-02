WITH available_cars AS (
  SELECT *
  FROM CAR_RENTAL_COMPANY_CAR
  WHERE CAR_ID NOT IN (
    SELECT CAR_ID
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY h
    WHERE h.START_DATE <= '2022-11-30'
      AND h.END_DATE >= '2022-11-01'
  )
), discounted_cars AS (
  SELECT
    ac.CAR_ID,
    ac.CAR_TYPE,
    ROUND((ac.daily_fee * 30) * (1 - dp.discount_rate * 0.01), 0) AS fee
  FROM available_cars ac
  INNER JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN dp
    ON ac.CAR_TYPE = dp.CAR_TYPE
  WHERE
    SUBSTRING(dp.DURATION_TYPE, 1, 1) = '3'
    AND ac.CAR_TYPE IN ('세단', 'SUV')
    AND ROUND((ac.daily_fee * 30) * (1 - dp.discount_rate * 0.01), 0) BETWEEN 500000 AND 2000000
)
SELECT *
FROM discounted_cars
ORDER BY fee DESC, CAR_TYPE ASC, CAR_ID DESC;

/*
출처 https://school.programmers.co.kr/questions/46722

*/