SELECT S.product_id,S.year as first_year ,S.quantity,S.price FROM SALES AS S 
    WHERE NOT EXISTS 
        (
            SELECT 1 FROM SALES AS S2
                WHERE 
                    S.PRODUCT_ID = S2.PRODUCT_ID
                    AND
                    S.YEAR>S2.YEAR
                    
        )