--Explicit Cursors:
--These cursors are explicitly 
--created, 
--opened,
--fetched,
--closed by the user
--in their SQL code.
--They allow you to navigate through the result set row by row 
--and perform specific operations on each row. 

--FETCH FIRST_NAME,LAST_NAME,EXPERIENCE
SET SERVEROUTPUT ON
DECLARE
 CURSOR EMP_CUR 
 IS
  SELECT 
  FIRST_NAME,
  LAST_NAME,
  ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12,2) AS TOTAL_EXP
  FROM EMPLOYEES
  WHERE DEPARTMENT_ID=&DID;
  
  FNAME VARCHAR2(20);
  LNAME VARCHAR2(20);
  T_EXP NUMBER;
  
BEGIN
   OPEN EMP_CUR;
     LOOP
          FETCH EMP_CUR INTO FNAME,LNAME,T_EXP;
          DBMS_OUTPUT.PUT_LINE(FNAME||' '||LNAME||' '||T_EXP);
          EXIT WHEN EMP_CUR%NOTFOUND;
     END LOOP;
   CLOSE EMP_CUR;
END;













