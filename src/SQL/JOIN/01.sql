
-- 1. Print a list of books and authors by ascending order
	
	SELECT
	        b.BOOK_ID, 
	        a.AUTHOR_NAME,   
	        DATE_FORMAT(b.PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE
	  FROM
	        BOOK b
	 JOIN
	        AUTHOR a
	   ON 
	        a.AUTHOR_ID = b.AUTHOR_ID
	WHERE 
	        b.CATEGORY = '경제'
	ORDER BY 
	        PUBLISHED_DATE ASC ;

-- 2.  extract the data from the animal_outs that doesn't contain id in the animal ins        
	SELECT
           a.ANIMAL_ID, a.NAME
      FROM
           ANIMAL_OUTS a
  LEFT JOIN
            ANIMAL_INS b
         ON
            b.ANIMAL_ID = a.ANIMAL_ID
      WHERE
            b.ANIMAL_ID IS NULL
   ORDER BY
            a.ANIMAL_ID ASC ;


-- 3. extract the data from ANIMAL_INS whose the DATETIME's data valuess are the bigger than animal_outs.
	SELECT 
	            a.ANIMAL_ID, a.NAME
	      FROM
	            ANIMAL_INS a
	      JOIN
	            ANIMAL_OUTS b
	        ON
	            b.ANIMAL_ID = a.ANIMAL_ID
	     WHERE
	            a.DATETIME > b.DATETIME 
	  ORDER BY
	            a.DATETIME ASC;
	            

-- 4.
  SELECT  
               NAME, DATETIME
          FROM
                ANIMAL_INS 
         WHERE
                ANIMAL_ID NOT IN (
                                    SELECT 
                                            ANIMAL_ID
                                      FROM 
                                            ANIMAL_OUTS )
      ORDER BY
               DATETIME ASC 
         LIMIT
                3;
                
       SELECT
                ins.NAME, ins.DATETIME
          FROM
                ANIMAL_INS ins
     LEFT JOIN
                ANIMAL_OUTS outs
             ON
                ins.ANIMAL_ID = outs.ANIMAL_ID
          WHERE
                outs.ANIMAL_ID IS NULL
       ORDER BY
                DATETIME ASC
          LIMIT
                3;             
                
  -- 5. First, extract the intact Male and female from ANIMAL_INS. 
  -- Then check whether the ANIMAL_ID's involved in ANIMAL_OUTS with the same conditions in 'SEX_UPON_INTAKE'
  
       
	     SELECT
	            outs.ANIMAL_ID, outs.ANIMAL_TYPE, outs.NAME
	       FROM
	            ANIMAL_OUTS outs
	  INNER JOIN
	            (
	            SELECT
	                    ANIMAL_ID, SEX_UPON_INTAKE
	              FROM
	                    ANIMAL_INS
	             WHERE
	                    SEX_UPON_INTAKE LIKE 'Intact%'
	            ) T
	         ON
	            outs.ANIMAL_ID = T.ANIMAL_ID
	      WHERE
	            T.SEX_UPON_INTAKE  <> outs.SEX_UPON_OUTCOME ;
            
                
            SELECT
		            outs.ANIMAL_ID, outs.ANIMAL_TYPE, outs.NAME
		      FROM
		            ANIMAL_OUTS outs
		 LEFT JOIN
		            ANIMAL_INS ins
		        ON
		            outs.ANIMAL_ID = ins.ANIMAL_ID
		     WHERE
		            outs.SEX_UPON_OUTCOME <> ins.SEX_UPON_INTAKE;         
	                
            
   -- 6. calculate the sum of the total sales by each product.
   --  Join the tables each other, then extract the price * sales_amount by descending order  of total sales and product code.
      
                 SELECT
	                    p.PRODUCT_CODE, 
	                    SUM(p.PRICE * s.SALES_AMOUNT)  AS TOTAL_PRICE
	              FROM
	                    PRODUCT p
	        INNER JOIN
	                    OFFLINE_SALE s
	                ON
	                    p.PRODUCT_ID = s.PRODUCT_ID
	         GROUP BY
	                  P.PRODUCT_CODE 
	         ORDER BY
	                  TOTAL_PRICE DESC, 
	                  p.PRODUCT_CODE ;
                          
                
  -- 7.calculate the ratio(round from two decimal places) of the number of members who bought products in 2021 
  --   and sorts by ascending order of the date acoording to the year and date.
		 		 
		SELECT * FROM ONLINE_SALE;


        SELECT 
              YEAR(s.SALES_DATE)         AS YEARS,
              MONTH(s.SALES_DATE)        AS MONTHS,
              COUNT(DISTINCT s.USER_ID)  AS PUCHASED_USERS,
              ROUND(COUNT(DISTINCT s.USER_ID) / (select count(*) from user_info where YEAR(joined) = '2021'), 1) 
                                                                                                        PURCHASED_RATIO
         FROM
                ONLINE_SALE s
      INNER JOIN
                USER_INFO o
           ON
                o.USER_ID = s.USER_ID
        WHERE
                YEAR(o.JOINED) = '2021'
     GROUP BY
                YEARS, MONTHS
     ORDER BY
                YEARS, MONTHS;
                
                
                
 --8. Calculate the Fees ((Price * the rate of dis) * period), History_ID Extract car_type first,
 -- calculate the period between START_DATE and END_DATE, check if DURATION_TYPE and * discount_rate
 -- the rate 5,8,15 by truck
 
           
            SELECT
                HISTORY_ID,
                FEES
         FROM
                CAR_RENTAL_COMPANY_CAR c
         JOIN
                CAR_RENTAL_COMPANY_RENTAL_HISTORY h
           ON   
                h.CAR_ID = c.CAR_ID
         JOIN
                CAR_RENTAL_COMPANY_DISCOUNT_PLAN p
           ON
                c.CAR_TYPE = p.CAR_TYPE
       
                
-- 8. Calculate the Fees ((Price * the rate of dis) * period), History_ID Extract car_type first,
-- calculate the period between START_DATE and END_DATE, check if DURATION_TYPE and * discount_rate
 

		SELECT             
               h.HISTORY_ID,
               ROUND (
                       c.DAILY_FEE * ( 
                               CASE 
                                    WHEN DATEDIFF(h.END_DATE, h.START_DATE) + 1 < 7  THEN 1
                                    WHEN DATEDIFF(h.END_DATE, h.START_DATE) + 1 < 30 THEN 0.95
                                    WHEN DATEDIFF(h.END_DATE, h.START_DATE) + 1 < 90 THEN 0.92
                               ELSE 0.85
                               END ) * (DATEDIFF(h.END_DATE, h.START_DATE) + 1))   AS FEE
          FROM
               CAR_RENTAL_COMPANY_CAR c
          JOIN
               CAR_RENTAL_COMPANY_RENTAL_HISTORY h
            ON
               h.CAR_ID = c.CAR_ID
          JOIN          
               CAR_RENTAL_COMPANY_DISCOUNT_PLAN p
            ON
               p.CAR_TYPE = c.CAR_TYPE
          WHERE
                c.CAR_TYPE = '트럭'
       GROUP BY
                HISTORY_ID
       ORDER BY
                FEE DESC , HISTORY_ID DESC ;
               
                            
 -- 9. extract the data where the name in 'Lucy', 'Ella', 'Pickle', 'Rogan','Sabrina' ,'Mitty'
 
        SELECT ANIMAL_ID,
               NAME,
               SEX_UPON_INTAKE
          FROM
                ANIMAL_INS
         WHERE
                NAME IN ('Lucy', 'Ella', 'Pickle', 'Rogan','Sabrina' ,'Mitty') ;
 
 -- 10. extract the data where the name contains "el". then select colums of animal_id and  name in Dog,
 -- but it's doesn't matter if the word is capital letter of small letter.
 
 	    SELECT
               ANIMAL_ID,
               NAME
          FROM
                ANIMAL_INS
         WHERE
                ANIMAL_TYPE = 'Dog'
           AND  UPPER(NAME) LIKE  UPPER('%el%')
      ORDER BY
                NAME ASC;
 
 
 -- the other way
 		SELECT
               ANIMAL_ID,
               NAME
          FROM
                ANIMAL_INS
         WHERE
                ANIMAL_TYPE = 'Dog'
           AND  (NAME LIKE '%el%' or NAME LIKE '%El%' or  NAME LIKE '%eL%' or NAME LIKE '%EL%')
      ORDER BY
                NAME ASC;
                
                
                
 -- 11. Extract ANIMAL_ID, NAME, something whether animals are sprayed or Neutered with O, if not then check X.
     	
        SELECT ANIMAL_ID,
               NAME,
               CASE
                    WHEN SEX_UPON_INTAKE = 'Neutered Male' THEN 'O' 
                    WHEN SEX_UPON_INTAKE = 'Spayed Female' THEN 'O' 
                    WHEN SEX_UPON_INTAKE = 'Intact Male'   THEN 'X' 
                    WHEN SEX_UPON_INTAKE = 'Intact Female' THEN 'X' 
                END AS NUETERING
          FROM
               ANIMAL_INS

 -- the other way
 
         SELECT ANIMAL_ID,
                NAME,
                CASE
                    WHEN SEX_UPON_INTAKE LIKE 'Intact%' THEN 'X' ELSE 'O' 
                END AS NUETERING
           FROM
                ANIMAL_INS ;
 
 
 -- 12. Extract the two of the NAME, ID who are adapted the most in a long period.
 
   WITH T AS  ( 
        SELECT 
               ins.ANIMAL_ID,
               ins.NAME,
     DATEDIFF(DATE_FORMAT(outs.DATETIME, '%Y-%m-%d'), DATE_FORMAT(ins.DATETIME, '%Y-%m-%d')) PERIOD
          FROM 
               ANIMAL_INS ins
          JOIN 
               ANIMAL_OUTS outs 
            ON 
               outs.ANIMAL_ID = ins.ANIMAL_ID 
      ORDER BY
               PERIOD DESC
            )
  
      SELECT
            T.ANIMAL_ID,
            T.NAME
        FROM
            T
       LIMIT 2;
 
 
 -- 13. 
	SELECT m.member_name, r.review_text, DATE_FORMAT(r.review_date, '%Y-%m-%d') review_date
	FROM REST_REVIEW r LEFT JOIN MEMBER_PROFILE m ON r.member_id = m.member_id,
	    (
	    SELECT member_id
	    FROM REST_REVIEW r 
	    GROUP BY member_id
	    HAVING COUNT(review_id) = 
	        (SELECT MAX(cnt) 
	         FROM (SELECT COUNT(*) cnt FROM REST_REVIEW GROUP BY member_id) tb1)
	    ) tb2
	WHERE tb2.member_id = m.member_id
	ORDER BY 3 ASC, 2 AS ;
	
	
 -- 14. extract the three flavour by descending order total_order
	   select
                T.flavor       AS FLAVOR
           from
                (select
                      f.flavor           as flavor,
                      sum(f.total_order) as total_ord1,
                      sum(j.total_order) as total_ord2
                  from
                       first_half f
                  join
                       july j
                    on 
                       j.flavor = f.flavor
                  group by
                        f.flavor
                 ) T
        order by
                 T.total_ord1 + T.total_ord2 desc
           limit 3;
           
 -- 15. 
	
	
	
	
	 

 
 