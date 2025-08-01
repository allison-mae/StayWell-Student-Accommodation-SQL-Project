# Section 3: Multiple-Table Queries
# This section demonstrates advanced data retrieval skills by combining data from multiple tables.
# It showcases the use of various join techniques, subqueries, and advanced operators to answer complex business questions.

# Exercise 1: For every property, list the management office number, address, monthly rent, owner number, owner's first name, and owner's last name.
# DML - Joining two tables (PROPERTY and OWNER) on a common column (OWNER_NUM).
# Note: Aliases (P for PROPERTY, O for OWNER) are used to simplify the query and qualify column names.
SELECT P.OFFICE_NUM, P.ADDRESS, P.MONTHLY_RENT, P.OWNER_NUM, O.FIRST_NAME, O.LAST_NAME
  FROM PROPERTY P, OWNER O
    WHERE P.OWNER_NUM = O.OWNER_NUM;

# Exercise 2: For every completed or open service request, list the property ID, description, and status.
# DML - A basic query on a single table (SERVICE_REQUEST) to retrieve specific columns.
SELECT PROPERTY_ID, DESCRIPTION, STATUS
  FROM SERVICE_REQUEST;

# Exercise 3: For every service request for furniture replacement, list the property ID, management office number, address, estimated hours, spent hours, owner number, and owner last name.
# DML - Joining three tables (SERVICE_REQUEST, PROPERTY, and OWNER) and filtering on a specific category number (6 for furniture replacement).
SELECT SR.PROPERTY_ID, SR.OFFICE_NUM, P.ADDRESS, SR.EST_HOURS, SR.SPENT_HOURS, P.OWNER_NUM, O.LAST_NAME
  FROM SERVICE_REQUEST SR, PROPERTY P, OWNER O
    WHERE SR.CATEGORY_NUMBER = 6
    AND SR.PROPERTY_ID = P.PROPERTY_ID
    AND P.OWNER_NUM = O.OWNER_NUM;

# Exercise 4: List the first and last names of all owners who own a two-bedroom property. Use the IN operator in your query.
# DML - Using a subquery with the IN operator to retrieve data based on a list of values generated from another query.
SELECT O.FIRST_NAME, O.LAST_NAME
  FROM OWNER O
    WHERE O.OWNER_NUM IN (
      SELECT OWNER_NUM
      FROM PROPERTY
      WHERE BDRMS = 2
    );

# Exercise 5: List the property IDs of any pair of properties that have the same number of bedrooms.
# DML - Performing a self-join by joining a table to itself using aliases (F and S) and a non-equijoin condition to avoid redundant pairs.
SELECT F.PROPERTY_ID AS Property1_ID, S.PROPERTY_ID AS Property2_ID
  FROM PROPERTY F, PROPERTY S
    WHERE F.BDRMS = S.BDRMS
    AND F.PROPERTY_ID < S.PROPERTY_ID
    ORDER BY Property1_ID, Property2_ID;

# Exercise 6: List the square footage, owner number, owner last name, and owner first name for each property managed by the Columbia City office.
# DML - Joining two tables (PROPERTY and OWNER) and filtering on a specific office number (1 for Columbia City).
SELECT P.SQR_FT, P.OWNER_NUM, O.LAST_NAME, O.FIRST_NAME
  FROM PROPERTY P, OWNER O
    WHERE P.OWNER_NUM = O.OWNER_NUM
    AND P.OFFICE_NUM = 1;

# Exercise 7: List the office number, address, and monthly rent for properties whose owners live in Washington state or own two-bedroom properties.
# DML - Using a subquery combined with the OR operator to list properties based on two different conditions.
SELECT OFFICE_NUM, ADDRESS, MONTHLY_RENT
  FROM PROPERTY
    WHERE BDRMS = 2
    OR OWNER_NUM IN (SELECT OWNER_NUM FROM OWNER WHERE STATE = 'WA');

# Exercise 8: List the office number, address, and monthly rent for properties whose owners live in Washington state AND own a two-bedroom property.
# DML - Using a subquery combined with the AND operator to find properties that meet two specific conditions simultaneously.
SELECT OFFICE_NUM, ADDRESS, MONTHLY_RENT
  FROM PROPERTY
    WHERE BDRMS = 2
    AND OWNER_NUM IN (SELECT OWNER_NUM FROM OWNER WHERE STATE = 'WA');

# Exercise 9: Find the service ID and property ID for each service request whose estimated hours are greater than the number of estimated hours of AT LEAST ONE service request on which the category number is 5.
# DML - Using a subquery with the ANY operator to compare a value against a list of values from another query.
SELECT SERVICE_ID, PROPERTY_ID
  FROM SERVICE_REQUEST
    WHERE EST_HOURS > ANY (
      SELECT EST_HOURS FROM SERVICE_REQUEST
      WHERE CATEGORY_NUMBER = 5
    );

# Exercise 10: List the address, square footage, owner number, service ID, number of estimated hours, and number of spent hours for each service request on which the category number is 4.
# DML - Joining two tables (PROPERTY and SERVICE_REQUEST) and filtering the results based on a specific service category.
SELECT P.ADDRESS, P.SQR_FT, P.OWNER_NUM, SR.SERVICE_ID, SR.EST_HOURS, SR.SPENT_HOURS
  FROM PROPERTY P, SERVICE_REQUEST SR
    WHERE P.PROPERTY_ID = SR.PROPERTY_ID
    AND SR.CATEGORY_NUMBER = 4;
