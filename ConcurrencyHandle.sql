START TRANSACTION;

SELECT stock FROM products WHERE product_id = [상품 ID] FOR UPDATE;

UPDATE products SET stock = stock - [주문량] WHERE product_id = [상품 ID];

IF (SELECT stock FROM products WHERE product_id = [상품 ID]) < 0 THEN
    ROLLBACK;
ELSE
    COMMIT;
END IF;

/*
위 방법을 쓰면 재고량이 한정 된 상태에서 동시성을 제어할 수 있음
첫째 줄에서 select for update문으로 쓰기락을 가져옴 <-- 대기해서
그후 커밋될 때까지 쓰기락을 가지므로, 동시성을 제어할 수가 있음
*/