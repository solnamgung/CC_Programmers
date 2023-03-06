
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
	            









