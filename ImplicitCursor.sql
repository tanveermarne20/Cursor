--Implicit Cursors:
--1. These cursors are automatically created by the database management system
--to process the result sets of SQL queries.

--When you execute a SELECT statement, an implicit cursor is created by default.
--Implicit cursors are mainly used in simple scenarios where you don't need 
--fine-grained control over the cursor operations.

--------------------------------------------------------------------------
--DELETE
SET SERVEROUTPUT ON
DECLARE
 
 SNO NUMBER:=3;
 ROWS_DELETED VARCHAR2(50);
BEGIN
  DELETE FROM STUDENT
  WHERE SID=SNO;
   ROWS_DELETED:=(SQL%ROWCOUNT ||' row deleted.');
   DBMS_OUTPUT.PUT_LINE(ROWS_DELETED);
END;
----------------------------------------------------------------
--INSERT
SET SERVEROUTPUT ON
DECLARE
ROW_INSERTED VARCHAR2(50);
BEGIN
 INSERT INTO STUDENT VALUES(9,'Bharghavi','Bangalore','F','90');
 ROW_INSERTED:=(SQL%ROWCOUNT||' ROW INSERTED.');
 DBMS_OUTPUT.PUT_LINE(ROW_INSERTED);
END;


---------------------------------------------------------------------------
--UPDATE
SET SERVEROUTPUT ON
DECLARE
  ROW_UPDATED VARCHAR2(50);
BEGIN
  UPDATE STUDENT SET  MARKS=80 WHERE SID=7;
  ROW_UPDATED:=(SQL%ROWCOUNT ||' ROW UPDATED.');
  DBMS_OUTPUT.PUT_LINE(ROW_UPDATED);
END;














