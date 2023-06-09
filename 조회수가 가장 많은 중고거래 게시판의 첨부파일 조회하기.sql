SELECT CONCAT('/home/grep/src/',BOARD.BOARD_ID,'/',FILE.FILE_ID,FILE.FILE_NAME,FILE.FILE_EXT) as FILE_PATH
FROM USED_GOODS_FILE as FILE INNER JOIN 
USED_GOODS_BOARD as BOARD on FILE.BOARD_ID=BOARD.BOARD_ID
WHERE BOARD.VIEWS = (select MAX(VIEWS) as MAXVAL from USED_GOODS_BOARD)
ORDER BY FILE_PATH DESC