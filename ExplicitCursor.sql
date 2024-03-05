--Explicit Cursors:
--These cursors are explicitly 
--created, 
--opened,
--fetched,
--closed by the user
--in their SQL code.
--They allow you to navigate through the result set row by row 
--and perform specific operations on each row. 

--User-Defined: Explicit cursors are explicitly declared, opened, 
--fetched, and closed by the user in their SQL code, 
--providing more control over cursor operations.

--Fine-Grained Control: They allow for greater flexibility in navigating through result sets, performing row-by-row processing and customized operations.
--Multiple Rows: Explicit cursors are suitable for scenarios where the result set may contain multiple rows.
--Dynamic SQL: They can be useful when working with dynamic SQL or when the result set structure is not known at compile time.






--FETCH FIRST_NAME,LAST_NAME,EXPERIENCE
SET SERVEROUTPUT ON
DECLARE
 CURSOR EMP_CUR                     --Step1.Declare the cursor with name
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
   OPEN EMP_CUR;                     --Step2. Open the cursor
     LOOP
          FETCH EMP_CUR INTO FNAME,LNAME,T_EXP;           --step3.Load the current row into variables
          DBMS_OUTPUT.PUT_LINE(FNAME||' '||LNAME||' '||T_EXP);
          EXIT WHEN EMP_CUR%NOTFOUND;
     END LOOP;
   CLOSE EMP_CUR;                           --Close the cursor
END;













