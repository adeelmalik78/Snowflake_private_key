-- liquibase formatted sql

-- Changeset amalik:tag-version01
--tagDatabase: 'release01'

-- Changeset amalik:createTable-MYTABLE5 context:DEV labels:Feature1
CREATE TABLE MYTABLE5 (C1 STRING, C2 STRING);
--rollback DROP TABLE MYTABLE5;

-- Changeset amalik:createTable-MYTABLE6 context:PROD labels:Feature2
CREATE TABLE MYTABLE6 (C1 STRING, C2 STRING);
--rollback DROP TABLE MYTABLE6;

-- Changeset amalik:addColumn-example1 context:DEV labels:Feature3
ALTER TABLE MYTABLE5 ADD address VARCHAR(255);
--rollback ALTER TABLE MYTABLE5 DROP COLUMN address;

-- Changeset amalik:addColumn-example2 context:DEV labels:Feature1
ALTER TABLE MYTABLE5 ADD "name" VARCHAR(50);
--rollback ALTER TABLE MYTABLE5 DROP COLUMN "name";

-- Changeset amalik:addColumn-example3 context:DEV labels:Feature1
ALTER TABLE MYTABLE5 ADD age STRING;
--rollback ALTER TABLE MYTABLE5 DROP COLUMN age;

-- Changeset amalik:insert-example1 context:QA labels:Feature1
INSERT INTO MYTABLE5 (address, C1, C2, age, "name") VALUES ('6080 Tower Bridge Cir.', 'A1', 'A2', 'old', 'Bill');
--rollback DELETE FROM "MYTABLE5" WHERE "C1"='6080 Tower Bridge Cir.';

-- Changeset amalik:createView-example1 context:DEV labels:Feature1
CREATE VIEW MYVIEW_MYTABLE5 AS SELECT * FROM MYTABLE5;
--rollback DROP VIEW MYVIEW_MYTABLE5;

-- Changeset amalik:tag-version02
--tagDatabase: 'release02'

-- Changeset amalik:Alter_view-example context:DEV,PROD labels:Feature1
DROP VIEW MYVIEW_MYTABLE5;
--rollback CREATE VIEW MYVIEW_MYTABLE5 AS SELECT * FROM MYTABLE5;

-- Changeset amalik:renameTable-example context:DEV labels:Feature3
ALTER TABLE IF EXISTS MYTABLE5 RENAME TO CUSTOMER;
--rollback ALTER TABLE IF EXISTS CUSTOMER RENAME TO MYTABLE5;

-- Changeset amalik:4432535-read_result_set context:DEV labels:Feature1 endDelimiter:/ runOneChange:true
create or replace procedure read_result_set()
  returns float not null
  language javascript
  as     
  $$  
    var my_sql_command = "select * from table1";
    var statement1 = snowflake.createStatement( {sqlText: my_sql_command} );
    var result_set1 = statement1.execute();
    // Loop through the results, processing one row at a time... 
    while (result_set1.next())  {
       var column1 = result_set1.getColumnValue(1);
       var column2 = result_set1.getColumnValue(2);
       // Do something with the retrieved values...
       }
  return 0.0; // Replace with something more useful.
  $$
  ;
/
--rollback drop procedure read_result_set();

-- Changeset amalik:createView-example2 context:DEV labels:Feature1
CREATE VIEW MYVIEW_CUSTOMER AS SELECT * FROM CUSTOMER;
--rollback DROP VIEW MYVIEW_CUSTOMER;

-- Changeset amalik:addPrimaryKey-example context:DEV labels:Feature1
ALTER TABLE CUSTOMER ADD CONSTRAINT pk_person PRIMARY KEY (C1, C2);
--rollback ALTER TABLE CUSTOMER DROP PRIMARY KEY;
