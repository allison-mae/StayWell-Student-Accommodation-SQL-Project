# Section 4: Data Manipulation and Structure
# This section focuses on modifying and managing data and table structures using advanced DML and DDL commands.
# It demonstrates the ability to create tables from existing data, perform bulk and conditional updates, and alter table schemas.

# Exercise 1: Create a LARGE_PROPERTY table.
# CREATE TABLE command to define a new table with specific columns, data types (DECIMAL, CHAR), and a primary key. 
CREATE TABLE LARGE_PROPERTY
(
    OFFICE_NUM DECIMAL(2, 0),
    ADDRESS CHAR(25) PRIMARY KEY,
    BDRMS DECIMAL(2, 0),
    FLOORS DECIMAL(2, 0),
    MONTHLY_RENT DECIMAL(6, 2),
    OWNER_NUM CHAR(5)
);

# Exercise 2: Insert into the LARGE_PROPERTY table the office number, address, bedrooms, baths, monthly rent, and owner number for those properties whose square footage is greater than 1,500 square feet.
# INSERT command combined with a SELECT subquery to populate a new table based on a condition from an existing table. 
INSERT INTO LARGE_PROPERTY
  (SELECT OFFICE_NUM, ADDRESS, BDRMS, FLOORS, MONTHLY_RENT, OWNER_NUM
    FROM PROPERTY
      WHERE (SQR_FT > 1500));

# Exercise 3: StayWell has increased the monthly rent of each large property by $150. Update the monthly rents in the LARGE_PROPERTY table accordingly.
# UPDATE command without a WHERE clause to perform a bulk update on all rows in a table. 
UPDATE LARGE_PROPERTY
  SET MONTHLY_RENT = MONTHLY_RENT + 150;

# Exercise 4: After increasing the monthly rent of each large property by $150 (Exercise 3), StayWell decides to decrease the monthly rent of any property whose monthly fee is more than $1750 by 1 percent. Update the monthly rents in the LARGE_PROPERTY table accordingly.
# UPDATE command with a WHERE clause to perform a conditional update on specific rows. 
UPDATE LARGE_PROPERTY
  SET MONTHLY_RENT = MONTHLY_RENT * 0.99
    WHERE MONTHLY_RENT > 1750;

# Exercise 5: Insert a row into the LARGE_PROPERTY table for a new property.
# INSERT command with a VALUES clause to add a single new row to a table. 
INSERT INTO LARGE_PROPERTY
  VALUES (1, '2643 Lugsi Dr', 3, 2, 775, 'MA111');

# Exercise 6: Delete all properties in the LARGE_PROPERTY table for which the owner number is BU106.
# DELETE command with a WHERE clause to remove specific rows from a table.
DELETE FROM LARGE_PROPERTY
  WHERE OWNER_NUM = 'BU106';

# Exercise 7: Change the bedrooms value in the LARGE_PROPERTY table to null for the property managed by Columbia City with the address 105 North Illinois Rd.
# UPDATE command to set a column value to NULL for a specific row, demonstrating handling of unknown or unavailable data. 
UPDATE LARGE_PROPERTY
  SET BDRMS = NULL
    WHERE ADDRESS = '105 North Illinois Rd.';

# Exercise 8: Add to the LARGE_PROPERTY table a new character column named OCCUPIED that is one character in length. Set the value for the OCCUPIED column on all rows to Y.
# Using ALTER TABLE with the ADD clause to change a tables structure, followed by an UPDATE to set the new column values. 
ALTER TABLE LARGE_PROPERTY
  ADD OCCUPIED CHAR(1);

UPDATE LARGE_PROPERTY
  SET OCCUPIED = 'Y';

# Exercise 9: Change the OCCUPIED column in the LARGE_PROPERTY table to N for office 9.
# UPDATE command with a WHERE clause to conditionally change values in a newly added column. Note: Based on the provided data, office 2 is 'StayWell-Georgetown' which is what was likely intended instead of 'office 9'.
UPDATE LARGE_PROPERTY
  SET OCCUPIED = 'N'
    WHERE OFFICE_NUM = 2;

# Exercise 10: Change the MONTHLY_RENT column in the LARGE_PROPERTY table to reject nulls.
# ALTER TABLE with the MODIFY clause to change the characteristics of an existing column, adding the NOT NULL constraint. 
ALTER TABLE LARGE_PROPERTY
  MODIFY MONTHLY_RENT DECIMAL(6, 2) NOT NULL;

# Exercise 11: Delete the LARGE_PROPERTY table from the database.
# DROP TABLE command to permanently remove a table and all its contents. 
DROP TABLE LARGE_PROPERTY;
