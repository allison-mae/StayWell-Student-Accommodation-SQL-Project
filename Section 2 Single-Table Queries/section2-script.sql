# Section 2: Single-Table Queries
# This section focuses on retrieving data from individual tables using a variety of SELECT, FROM, and WHERE clauses.
# It demonstrates core querying skills, including filtering data with different operators, creating computed columns, and using aliases.

# Exercise 1: List the owner number, last name, and first name of every property owner.
# DML - Basic SELECT statement to retrieve specific columns from a table.
SELECT OWNER_NUM, LAST_NAME, FIRST_NAME
  FROM OWNER;

# Exercise 2: List the complete PROPERTY table (all rows and all columns).
# DML - Using the SELECT * wildcard to retrieve all columns from a table.
SELECT *
  FROM PROPERTY;

# Exercise 3: List the last name and first name of every owner who lives in Seattle.
# DML - Using a WHERE clause with a simple condition to filter rows.
SELECT LAST_NAME, FIRST_NAME
  FROM OWNER
    WHERE CITY = 'Seattle';

# Exercise 4: List the last name and first name of every owner who does not live in Seattle.
# DML - Using the NOT EQUAL (<>) comparison operator in a WHERE clause.
SELECT LAST_NAME, FIRST_NAME
  FROM OWNER
    WHERE CITY <> 'Seattle';

# Exercise 5: List the property ID and office number for every property whose square footage is equal to or less than 1,400 square feet.
# DML - Using the less than or equal to (<=) comparison operator on a numeric column.
SELECT PROPERTY_ID, OFFICE_NUM
  FROM PROPERTY
    WHERE SQR_FT <= 1400;

# Exercise 6: List the office number and address for every property with three bedrooms.
# DML - Filtering a table based on a specific numeric value in a WHERE clause.
SELECT OFFICE_NUM, ADDRESS
  FROM PROPERTY
    WHERE BDRMS = 3;

# Exercise 7: List the property ID for every property with two bedrooms that is managed by StayWell-Georgetown.
# DML - Using a compound WHERE clause with the AND operator to combine multiple conditions. Office 2 corresponds to Georgetown.
SELECT PROPERTY_ID
  FROM PROPERTY
    WHERE BDRMS = 2 AND OFFICE_NUM = 2;

# Exercise 8: List the property ID for every property with a monthly rent that is between $1,350 and $1,750.
# DML - Using the BETWEEN operator to filter data within a range of values.
SELECT PROPERTY_ID
  FROM PROPERTY
    WHERE MONTHLY_RENT BETWEEN 1350 AND 1750;

# Exercise 9: List the property ID for every property managed by StayWell-Columbia City whose monthly rent is less than $1,500.
# DML - Using a compound WHERE clause to combine a value condition with a logical condition. Office 1 corresponds to Columbia City.
SELECT PROPERTY_ID
  FROM PROPERTY
    WHERE OFFICE_NUM = 1 AND MONTHLY_RENT < 1500;

# Exercise 10: Labor is billed at the rate of $35 per hour. List the property ID, category number, estimated hours, and estimated labor cost for every service request. To obtain the estimated labor cost, multiply the estimated hours by 35. Use the column name ESTIMATED_COST for the estimated labor cost.
# DML - Creating a computed column with an arithmetic operation (*) and assigning an alias with AS.
SELECT PROPERTY_ID, CATEGORY_NUMBER, EST_HOURS, (EST_HOURS * 35) AS ESTIMATED_COST
  FROM SERVICE_REQUEST;
