# Section 6: Functions, Procedures, and Triggers
# This final section showcases advanced SQL and procedural programming skills. It demonstrates the use of built-in functions for data formatting and calculations, as well as the creation of stored procedures to embed DML commands and handle multi-row data processing with cursors.

# Exercise 1: List the owner number, first name, and last name for all owners. The first name should appear in uppercase letters and the last name should appear in lowercase letters.
# Using the UPPER() and LOWER() functions to change the case of character data for display.
SELECT OWNER_NUM, UPPER(FIRST_NAME) AS UPPER_FIRST_NAME, LOWER(LAST_NAME) AS LOWER_LAST_NAME
  FROM OWNER;

# Exercise 2: List the owner number and last name for all owners located in the city of Seattle. This query should ignore case.
# Using the UPPER() function in a WHERE clause to perform a case-insensitive search.
SELECT OWNER_NUM, LAST_NAME
  FROM OWNER
    WHERE UPPER(CITY) = 'SEATTLE';

# Exercise 3: StayWell is offering a monthly discount for residents who pay their rent on a quarterly basis. The discount is 1.75 percent of the monthly fee. For each property, list the office number, address, owner number, owner’s last name, monthly rent, and discount. The discount should be rounded to the nearest dollar.
# Using the ROUND() function on a computed column and joining two tables (PROPERTY and OWNER) to display combined data.
SELECT
  P.OFFICE_NUM,
  P.ADDRESS,
  O.LAST_NAME,
  P.MONTHLY_RENT,
  ROUND(P.MONTHLY_RENT * 0.0175, 0) AS MONTHLY_DISCOUNT
    FROM PROPERTY P
      JOIN OWNER O ON P.OWNER_NUM = O.OWNER_NUM;

# Exercise 4a: Write a procedure to obtain the first and last name of an owner.
# Creating a stored procedure with an input parameter and using SELECT...INTO to retrieve a single row of data into variables.
DELIMITER //
CREATE PROCEDURE GET_OWNER_NAME (IN I_OWNER_NUM CHAR(5))
BEGIN
    DECLARE V_FIRST_NAME VARCHAR(50);
    DECLARE V_LAST_NAME VARCHAR(50);

    SELECT FIRST_NAME, LAST_NAME
    INTO V_FIRST_NAME, V_LAST_NAME
    FROM OWNER
    WHERE OWNER_NUM = I_OWNER_NUM;

    SELECT I_OWNER_NUM, V_FIRST_NAME, V_LAST_NAME;
END //
DELIMITER ;

# Exercise 4b: Write a procedure to obtain property and owner details for a specific property.
# Creating a stored procedure that uses a multi-table join to retrieve and output data.
DELIMITER //
CREATE PROCEDURE GET_PROPERTY_AND_OWNER_DETAILS (IN I_PROPERTY_ID INT)
BEGIN
    DECLARE V_OFFICE_NUM INT;
    DECLARE V_OFFICE_ADDRESS VARCHAR(100);
    DECLARE V_PROPERTY_ADDRESS VARCHAR(100);
    DECLARE V_OWNER_NUM CHAR(5);
    DECLARE V_FIRST_NAME VARCHAR(50);
    DECLARE V_LAST_NAME VARCHAR(50);

    SELECT
        P.OFFICE_NUM,
        OFC.ADDRESS,
        P.ADDRESS,
        P.OWNER_NUM,
        OW.FIRST_NAME,
        OW.LAST_NAME
    INTO
        V_OFFICE_NUM,
        V_OFFICE_ADDRESS,
        V_PROPERTY_ADDRESS,
        V_OWNER_NUM,
        V_FIRST_NAME,
        V_LAST_NAME
    FROM
        PROPERTY P
    JOIN
        OFFICE OFC ON P.OFFICE_NUM = OFC.OFFICE_NUM
    JOIN
        OWNER OW ON P.OWNER_NUM = OW.OWNER_NUM
    WHERE
        P.PROPERTY_ID = I_PROPERTY_ID;

    SELECT I_PROPERTY_ID, V_OFFICE_NUM, V_OFFICE_ADDRESS, V_PROPERTY_ADDRESS, V_OWNER_NUM, V_FIRST_NAME, V_LAST_NAME;
END //
DELIMITER ;

# Exercise 4c: Write a procedure to add a row to the OWNER table.
# Embedding an INSERT command within a stored procedure.
DELIMITER //
CREATE PROCEDURE ADD_OWNER_ROW ()
BEGIN
    INSERT INTO OWNER (OWNER_NUM, LAST_NAME, FIRST_NAME, ADDRESS, CITY, STATE, ZIP_CODE)
    VALUES ('AD123', 'Dempsey', 'Allison', '123 Address Dr', 'St Petersburg', 'FL', '33710');
END //
DELIMITER ;

# Exercise 4d: Write a procedure to change the last name of an owner.
# Embedding an UPDATE command with parameters within a stored procedure.
DELIMITER //
CREATE PROCEDURE CHG_OWNER_LAST_NAME (
    IN I_OWNER_NUM CHAR(5),
    IN I_LAST_NAME VARCHAR(50)
)
BEGIN
    UPDATE OWNER
    SET LAST_NAME = I_LAST_NAME
    WHERE OWNER_NUM = I_OWNER_NUM;
END //
DELIMITER ;

# Exercise 4e: Write a procedure to delete an owner.
# Embedding a DELETE command with a parameter within a stored procedure.
DELIMITER //
CREATE PROCEDURE DEL_OWNER (IN I_OWNER_NUM CHAR(5))
BEGIN
    DELETE FROM OWNER
    WHERE OWNER_NUM = I_OWNER_NUM;
END //
DELIMITER ;

# Exercise 5: Write a procedure to retrieve multiple properties whose square footage is equal to the square footage stored in I_SQR_FT.
# Using a cursor (DECLARE CURSOR, OPEN, FETCH, CLOSE) and a loop to retrieve and process multiple rows of data from a query result set.
DELIMITER //
CREATE PROCEDURE GET_PROPERTIES_BY_SQR_FT (IN I_SQR_FT INT)
BEGIN
    DECLARE DONE INT DEFAULT FALSE;
    DECLARE V_OFFICE_NUM INT;
    DECLARE V_OFFICE_ADDRESS VARCHAR(100);
    DECLARE V_PROPERTY_ADDRESS VARCHAR(100);
    DECLARE V_MONTHLY_RENT DECIMAL(10, 2);
    DECLARE V_OWNER_NUM CHAR(5);
    DECLARE PROPGROUP CURSOR FOR
        SELECT
            P.OFFICE_NUM,
            OFC.ADDRESS,
            P.ADDRESS,
            P.MONTHLY_RENT,
            P.OWNER_NUM
        FROM
            PROPERTY P
        JOIN
            OFFICE OFC ON P.OFFICE_NUM = OFC.OFFICE_NUM
        WHERE
            P.SQR_FT = I_SQR_FT;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET DONE = TRUE;

    OPEN PROPGROUP;

    read_loop: LOOP
        FETCH PROPGROUP INTO V_OFFICE_NUM, V_OFFICE_ADDRESS, V_PROPERTY_ADDRESS, V_MONTHLY_RENT, V_OWNER_NUM;
        IF DONE THEN
            LEAVE read_loop;
        END IF;
        SELECT V_OFFICE_NUM, V_OFFICE_ADDRESS, V_PROPERTY_ADDRESS, V_MONTHLY_RENT, V_OWNER_NUM;
    END LOOP;

    CLOSE PROPGROUP;
END //
DELIMITER ;
