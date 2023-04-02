WITH b AS
(SELECT MAX(VIEWS) as MAX FROM USED_GOODS_BOARD),
c AS(SELECT BOARD_ID FROM USED_GOODS_BOARD u, b where b.MAX=u.VIEWS)


SELECT CONCAT('/home/grep/src/',a.BOARD_ID,'/', a.FILE_ID , a.FILE_NAME,a.FILE_EXT) 
as FILE_PATH from USED_GOODS_FILE as a ,c WHERE a.BOARD_ID=c.BOARD_ID ORDER BY a.FILE_ID DESC
/*
서브 쿼리에서 서브쿼리를 사용해서 최대값을 가진 BOARD_ID를 구해 냄
이 방법이 아니라면, 서브쿼리를 inner join해야 함


*/


