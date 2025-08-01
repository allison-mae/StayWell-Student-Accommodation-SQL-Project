# Section 1: Database Creation & Foundational SQL
# These exercises showcase foundational DDL and DML skills, including table creation, data typing, data insertion,
# and viewing data. It demonstrates how to set up a database and manage its basic structure and content.

# Exercise 1: Create a table named SUMMER_SCHOOL_RENTALS
# DDL - CREATE TABLE command, defining columns and data types (NUMERIC, DECIMAL, CHAR), and specifying a primary key.
CREATE TABLE SUMMER_SCHOOL_RENTALS (
    PROPERTY_ID NUMERIC(2, 0) PRIMARY KEY,
    OFFICE_NUM NUMERIC(2, 0),
    ADDRESS CHAR(25),
    SQR_FT DECIMAL(5,0),
    BDRMS DECIMAL(2,0),
    FLOORS DECIMAL(2,0),
    WEEKLY_RENT DECIMAL(6, 2),
    OWNER_NUM CHAR(5)
);

# Exercise 2: Add a row to the SUMMER_SCHOOL_RENTALS table
# DML - INSERT command for adding a single row with specific values.
INSERT INTO SUMMER_SCHOOL_RENTALS
    VALUES (13, 1, '5867 Goodwin Ave', 1650, 2, 1, 400.00, 'CO103');

# Exercise 3: Delete the SUMMER_SCHOOL_RENTALS table
# DDL - DROP TABLE command to permanently remove a table.
DROP TABLE SUMMER_SCHOOL_RENTALS;

# Exercise 4: Run the script to create the StayWell database tables by executing a database creation script, which demonstrates setting up a complete database from a file.
# Note: This is an example of what would go in your script.
# SOURCE MySQL_StayWell.sql;

# Exercise 5: Confirm that the tables were created correctly using DESCRIBE to view the structure, data types, and constraints of tables.
DESCRIBE OFFICE;
DESCRIBE OWNER;
DESCRIBE PROPERTY;
DESCRIBE SERVICE_CATEGORY;
DESCRIBE SERVICE_REQUEST;
DESCRIBE RESIDENTS;

# Exercise 6: Confirm that data was added correctly by viewing the tables
# DML - SELECT command with the wildcard (*) to view all rows and columns in a table.
SELECT * FROM OFFICE;
SELECT * FROM OWNER;
SELECT * FROM PROPERTY;
SELECT * FROM SERVICE_CATEGORY;
SELECT * FROM SERVICE_REQUEST;
SELECT * FROM RESIDENTS;
