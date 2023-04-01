-- 코드를 입력하세요


SELECT d.HISTORY_ID, round((d.daily_fee*diff)*(100-d.discount_rate)*0.01,0) as FEE from 
(SELECT c.DISCOUNT_RATE,a.CAR_TYPE,a.DAILY_FEE,b.HISTORY_ID,
DATEDIFF(END_DATE,START_DATE)+1 as diff ,MAX(REGEXP_REPLACE(c.duration_type, '[^0-9]+', '')) 
as DISCOUNT FROM CAR_RENTAL_COMPANY_CAR as a inner join CAR_RENTAL_COMPANY_RENTAL_HISTORY 
as b on a.CAR_ID=b.CAR_ID inner join CAR_RENTAL_COMPANY_DISCOUNT_PLAN as c 
on a.CAR_TYPE=c.CAR_TYPE where DATEDIFF(END_DATE,START_DATE)+1 >= 
REGEXP_REPLACE(c.duration_type, '[^0-9]+', '') GROUP BY b.HISTORY_ID) as d WHERE d.CAR_TYPE="트럭"
UNION 
SELECT d.HISTORY_ID, d.daily_fee*diff as FEE FROM 
(SELECT a.CAR_TYPE,a.DAILY_FEE,b.HISTORY_ID,DATEDIFF(END_DATE,START_DATE)+1 as diff
 FROM CAR_RENTAL_COMPANY_CAR as a inner join CAR_RENTAL_COMPANY_RENTAL_HISTORY as b on a.CAR_ID=b.CAR_ID 
  where DATEDIFF(END_DATE,START_DATE)+1 < 7)as d WHERE d.CAR_TYPE="트럭" ORDER BY FEE DESC, HISTORY_ID DESC


  /*
  할인 가능 한 것들 중에 group by로 7,30,90일 중 가능한 일수를 묶어 내고, max를 통해 최대 할인율을 적용한 테이블과
  할인 불가능한 것들의 테이블을 union으로 합치는 idea!! 
    출처: https://school.programmers.co.kr/learn/courses/30/lessons/151141

  */