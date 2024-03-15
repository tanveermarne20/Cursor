SET SERVEROUTPUT ON
DECLARE
CURSOR EMP_TEST
IS
SELECT FIRST_NAME,LAST_NAME,ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12,0) AS EXPER
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50 ;


BEGIN
FOR i in EMP_TEST -- here i become composite datatype ( record )
LOOP
DBMS_OUTPUT.PUT_LINE(i.FIRST_NAME||' '||i.LAST_NAME||' '||i.EXPER);
END LOOP;
END;
-- IN CUSRSOR FOR LOOP we DONT NEED TO OPEN CURSOR, FETCH CURSOR & CLOSE CURSOR

--================================================================================
DECLARE 
i NUMBER := 1;

BEGIN

for i in 1..10
DBMS_OUTPUT.PUT_LINE(i);


EMP_REC EMPLOYEES%ROWTYPE ;    ---employees table ka 11 column 

FOR I IN EMP_TEST


---==================================================================================================
SET SERVEROUTPUT ON
DECLARE
 CURSOR  EMP_TEST 
 IS
  SELECT FIRST_NAME,LAST_NAME,SALARY
  FROM EMPLOYEES
  WHERE DEPARTMENT_ID=&DID;
BEGIN
 FOR I IN EMP_TEST         
 LOOP
   DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME||' '||I.LAST_NAME||' '||I.SALARY);
 END LOOP;
END;
--=================================================================================================
--No declaration
--No condition
--Auto increment
--No need for opening ,fetching and closing the cursor.
--=================================================================================================


SELECT *
FROM EMPLOYEES;







-----------------------------------------------------------
CREATE USER Cursorforloop IDENTIFIED BY root;
GRANT ALL PRIVILEGES TO Cursorforloop;














