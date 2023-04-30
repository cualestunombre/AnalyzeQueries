WITH tb as (SELECT DISTINCT BOOK.BOOK_ID, BOOK.AUTHOR_ID, BOOK.CATEGORY,
SUM(BOOK_SALES.SALES * BOOK.PRICE) OVER(partition by BOOK.BOOK_ID) as SALES 
FROM BOOK_SALES INNER JOIN BOOK ON BOOK.BOOK_ID = BOOK_SALES.BOOK_ID 
WHERE BOOK_SALES.SALES_DATE between '2022-01-01' and '2022-01-31') 

select DISTINCT  tb.AUTHOR_ID, AUTHOR.AUTHOR_NAME, tb.CATEGORY, SUM(tb.SALES) 
OVER(partition by tb.AUTHOR_ID , tb.category) as TOTAL_SALES 
from tb inner join AUTHOR on tb.AUTHOR_ID = AUTHOR.AUTHOR_ID 
ORDER BY AUTHOR_ID ASC, CATEGORY DESC ;

/*
위 쿼리는 윈도우 함수 사용
밑의 쿼리는 단순 group by 사용
*/

SELECT b.author_id, a.author_name, b.category, SUM(bs.sales * b.price) AS total_sales
FROM book b, author a, book_sales bs
WHERE b.author_id = a.author_id AND b.book_id = bs.book_id
AND bs.sales_date BETWEEN '2022-01-01' AND '2022-01-31'
GROUP BY b.author_id, b.category, a.author_name
ORDER BY b.author_id ASC, b.category DESC