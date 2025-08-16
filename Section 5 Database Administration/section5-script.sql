# Section 5: Database Administration
# This section demonstrates core database administration tasks, including the creation and management of views and indexes,
# configuring user security with privileges, and enforcing data integrity rules.

# Exercise 1: Create a view named SMALL_PROPERTY. It consists of the property ID, office number, bedrooms, floor, monthly rent, and owner number for every property whose square footage is less than 1,250 square feet.
# CREATE VIEW command with a SELECT query to create a view that filters a base table.

# a. Write and execute the CREATE VIEW command.
CREATE VIEW SMALL_PROPERTY AS
  (SELECT PROPERTY_ID, OFFICE_NUM, BDRMS, FLOORS, MONTHLY_RENT, OWNER_NUM
    FROM PROPERTY
      WHERE (SQR_FT < 1250)
  );

# b. Write and execute the command to retrieve the office number, property ID, and monthly rent for every property in the SMALL_PROPERTY view with a monthly rent of $1150 or more.
# Querying a view as if it were a regular table.
SELECT OFFICE_NUM, PROPERTY_ID, MONTHLY_RENT
  FROM SMALL_PROPERTY
    WHERE MONTHLY_RENT >= 1150;

# Exercise 2: Create a view named PROPERTY_OWNERS. It consists of the property ID, office number, square footage, bedrooms, floors, monthly rent, and owner’s last name for every property in which the number of bedrooms is three.

# a. Write and execute the CREATE VIEW command.
CREATE VIEW PROPERTY_OWNERS AS
  (SELECT P.PROPERTY_ID, P.OFFICE_NUM, P.SQR_FT, P.BDRMS, P.FLOORS, P.MONTHLY_RENT, O.LAST_NAME
    FROM PROPERTY P, OWNER O
      WHERE P.OWNER_NUM = O.OWNER_NUM AND P.BDRMS = 3
  );

# b. Write and execute the command to retrieve the property ID, office number, monthly rent, square footage, and owner’s last name for every property in the PROPERTY_OWNERS view with a monthly rent of less than $1675.
# Querying a view derived from a join.
SELECT PROPERTY_ID, OFFICE_NUM, MONTHLY_RENT, SQR_FT, LAST_NAME
  FROM PROPERTY_OWNERS
    WHERE MONTHLY_RENT < 1675;

# Exercise 3: Create a view named MONTHLY_RENTS. It consists of two columns: The first is the number of bedrooms, and the second is the average monthly rent for all properties in the PROPERTY table that have that number of bedrooms. Use AVERAGE_RENT as the column name for the average monthly rent. Group and order the rows by number of bedrooms.
# Creating a view that involves a GROUP BY clause and an aggregate function.

# a. Write and execute the CREATE VIEW command.
CREATE VIEW MONTHLY_RENTS AS
  (SELECT BDRMS, AVG(MONTHLY_RENT) AS AVERAGE_RENT
    FROM PROPERTY
      GROUP BY BDRMS
      ORDER BY BDRMS
  );

# Exercise 4: Write commands to grant the following privileges.
# Using the GRANT command to assign specific privileges to users.

# a. User Oliver must be able to retrieve data from the PROPERTY table.
GRANT SELECT ON PROPERTY TO Oliver;

# b. Users Crandall and Perez must be able to add new owners and properties to the database.
GRANT INSERT ON OWNER TO Crandall, Perez;
GRANT INSERT ON PROPERTY TO Crandall, Perez;

# c. Users Johnson and Klein must be able to change the monthly rent of any unit.
GRANT UPDATE (MONTHLY_RENT) ON PROPERTY TO Johnson, Klein;

# d. All users must be able to retrieve the office number, monthly rent, and owner number for every property.
GRANT SELECT (OFFICE_NUM, MONTHLY_RENT, OWNER_NUM) ON PROPERTY TO PUBLIC;

# e. User Klein must be able to add and delete service categories.
GRANT INSERT, DELETE ON SERVICE_CATEGORY TO Klein;

# f. User Adams must be able to create an index on the SERVICE_REQUEST table.
GRANT INDEX ON SERVICE_REQUEST TO Adams;

# g. Users Adams and Klein must be able to change the structure of the PROPERTY table.
GRANT ALTER ON PROPERTY TO Adams, Klein;

# h. User Klein must have all privileges on the OFFICE, OWNER, and PROPERTY tables.
GRANT ALL PRIVILEGES ON OFFICE, OWNER, PROPERTY TO Klein;

# Exercise 5: Write the command to revoke all privileges from user Adams.
# Using the REVOKE command to remove previously granted privileges.
REVOKE ALL PRIVILEGES ON PROPERTY FROM Adams;
REVOKE INDEX ON SERVICE_REQUEST FROM Adams;

# Exercise 6: Create the following indexes.

# a. Create an index named OWNER_INDEX1 on the STATE column in the OWNER table.
CREATE INDEX OWNER_INDEX1 ON OWNER (STATE);

# b. Create an index named OWNER_INDEX2 on the LAST_NAME column in the OWNER table.
CREATE INDEX OWNER_INDEX2 ON OWNER (LAST_NAME);

# c. Create an index named OWNER_INDEX3 on the STATE and CITY columns in the OWNER table. List the states in descending order.
CREATE INDEX OWNER_INDEX3 ON OWNER (STATE DESC, CITY);

# Exercise 7: Delete the OWNER_INDEX3 index from the OWNER table.
DROP INDEX OWNER_INDEX3 ON OWNER;

# Exercise 8: Write the commands to obtain the following information from the system catalog.
# Database Administration - Querying the system catalog (INFORMATION_SCHEMA) to inspect database metadata.

# a. List every column in the PROPERTY table and its associated data type.
SELECT COLUMN_NAME, DATA_TYPE
  FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = 'StayWell' AND TABLE_NAME = 'PROPERTY';

# b. List every table that contains a column named OWNER_NUM.
SELECT TABLE_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
    WHERE COLUMN_NAME = 'OWNER_NUM' AND TABLE_SCHEMA = 'StayWell';

# Exercise 9: Add the OWNER_NUM column as a foreign key in the PROPERTY table.
# Using ALTER TABLE to add a FOREIGN KEY constraint to a table.
ALTER TABLE PROPERTY
  ADD FOREIGN KEY (OWNER_NUM) REFERENCES OWNER (OWNER_NUM);

# Exercise 10: Ensure that the only legal values for the BDRMS column in the PROPERTY table are 1, 2, or 3.
# Using ALTER TABLE to add a CHECK constraint to enforce data integrity.
ALTER TABLE PROPERTY
  ADD CHECK (BDRMS IN (1, 2, 3));

