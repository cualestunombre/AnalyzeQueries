SELECT ROUND (SUM(TB.tiv_2016),2) as tiv_2016 FROM 
    (SELECT DISTINCT I1.*
    FROM Insurance as I1, Insurance as I2
    WHERE
        I1.pid != I2.pid AND
        I1.tiv_2015 = I2.tiv_2015  
        AND NOT EXISTS
            (
                SELECT 1 FROM Insurance as I3
                WHERE I1.pid != I3.pid 
                    AND
                    I1.lon=I3.lon 
                    AND 
                    I1.lat=I3.lat
            )
    ) AS TB