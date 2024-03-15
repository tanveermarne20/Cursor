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



--========================6th march===============================================
SET SERVEROUTPUT ON
DECLARE
 CURSOR EMP_CUR
 IS
 SELECT 
 E.FIRST_NAME,
 E.LAST_NAME,
 D.DEPARTMENT_NAME,
 ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12,0) AS TOTAL_EXPER
 FROM EMPLOYEES E JOIN DEPARTMENTS D
 ON(E.DEPARTMENT_ID=D.DEPARTMENT_ID);
 
 FNAME VARCHAR2(20);
 LNAME VARCHAR2(20);
 DNAME VARCHAR2(20);
 T_EXP NUMBER;
 
BEGIN
 OPEN EMP_CUR;
    LOOP
       FETCH EMP_CUR INTO FNAME,LNAME,DNAME,T_EXP;
       DBMS_OUTPUT.PUT_LINE(FNAME||' '||LNAME||' '||DNAME||' '||T_EXP);
       EXIT WHEN EMP_CUR%NOTFOUND; 
    END LOOP;
 CLOSE EMP_CUR;
END;



--=============================================================================
--FIRST_NAME,LAST_NAME,SALARY,DEPARTMENT_NAME,EXPER
SET SERVEROUTPUT ON
DECLARE
 CURSOR EMP_TEST 
 IS
 SELECT 
 E.FIRST_NAME,
 E.LAST_NAME,
 E.SALARY,
 D.DEPARTMENT_NAME
 FROM EMPLOYEES E JOIN DEPARTMENTS D
 ON(E.DEPARTMENT_ID=D.DEPARTMENT_ID);
 
BEGIN
 FOR I IN EMP_TEST
 LOOP
 DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME||' '||I.LAST_NAME||' '||I.SALARY||' '||I.DEPARTMENT_NAME);
 END LOOP;
END;




----=================================================================================================
SET SERVEROUTPUT ON
DECLARE
 CURSOR EMP_CONTEXT
 IS
 SELECT 
 E.FIRST_NAME,
 COUNT(*) AS CNT
 FROM EMPLOYEES E JOIN EMPLOYEES M
 ON(E.EMPLOYEE_ID=M.MANAGER_ID)
 GROUP BY E.FIRST_NAME;
 
BEGIN
 FOR I IN EMP_CONTEXT 
 LOOP
   DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME||' '||I.CNT);
 END LOOP;
END;
--=================================================================================
SET SERVEROUTPUT ON
DECLARE
 CURSOR EMP_TEST 
 IS
 SELECT 
 E.FIRST_NAME AS MNG_NAME,
 E.LAST_NAME,
 COUNT(*) AS CNT
 FROM EMPLOYEES E JOIN EMPLOYEES M
 ON(E.EMPLOYEE_ID=M.MANAGER_ID)
 GROUP BY E.FIRST_NAME,E.LAST_NAME;
BEGIN
  FOR I IN EMP_TEST 
  LOOP
   DBMS_OUTPUT.PUT_LINE(I.MNG_NAME||' '||I.CNT);
  END LOOP;
END;
--========================================================================================
--FETCH MANAGER_NAME AND COUNT OF EMPLOYEES WORKING UNDER THAT MANAGER.


SET SERVEROUTPUT ON
DECLARE
 CURSOR EMP_CONTEXT 
 IS
 
 SELECT 
 E.FIRST_NAME AS MNG_NAME,
 COUNT(*) AS CNT
 FROM EMPLOYEES E JOIN EMPLOYEES M
 ON(E.EMPLOYEE_ID=M.MANAGER_ID)
 GROUP BY E.FIRST_NAME;
 
BEGIN
   FOR I IN EMP_CONTEXT 
   LOOP
    DBMS_OUTPUT.PUT_LINE(I.MNG_NAME||' '||I.CNT);
   END LOOP;
END;
--====================================================================
SET SERVEROUTPUT ON
DECLARE
 CURSOR EMP_CUR
 IS
 SELECT 
 FIRST_NAME,
 LAST_NAME,
 SALARY,
 ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12,2) AS TOTAL_EXPER
 FROM EMPLOYEES;
 
 FNAME VARCHAR2(20);
 LNAME VARCHAR2(20);
 SAL NUMBER;
 TOTAL_EXPER NUMBER;
 
BEGIN
   OPEN EMP_CUR;
      LOOP 
        FETCH EMP_CUR INTO FNAME,LNAME,SAL,TOTAL_EXPER;
        EXIT WHEN EMP_CUR%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(FNAME||' '||LNAME||' '||SAL||' '||TOTAL_EXPER);
      END LOOP;
   CLOSE EMP_CUR;
END;

--=============================================================================

SET SERVEROUTPUT ON
DECLARE
 CURSOR EMP_CUR
 IS
 SELECT *FROM(
 SELECT 
 FIRST_NAME,
 LAST_NAME,
 SALARY,
 DENSE_RANK() OVER(ORDER BY SALARY DESC) AS DEN
 FROM EMPLOYEES
 )WHERE DEN<4;
BEGIN
 FOR I IN EMP_CUR
 LOOP
 DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME||' '||I.LAST_NAME||' '||I.SALARY||' '||I.DEN);
 END LOOP;
END;

--============================15MARCH=====================
SET SERVEROUTPUT ON
DECLARE
 CURSOR EMP_CURSOR 
 IS
 SELECT FIRST_NAME,LAST_NAME,SALARY
 FROM EMPLOYEES
 WHERE DEPARTMENT_ID=&DID;
 
 FNAME VARCHAR2(20);
 LNAME VARCHAR2(20);
 SAL VARCHAR2(20);
BEGIN
 OPEN EMP_CURSOR;
 LOOP
     FETCH EMP_CURSOR INTO FNAME,LNAME,SAL;
     EXIT WHEN EMP_CURSOR%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(FNAME||' '||LNAME||' '||SAL);  
 END LOOP;
 CLOSE EMP_CURSOR;
END;
--==========================================================================
--FIND EXPERIENCE
SET SERVEROUTPUT ON
DECLARE
 CURSOR EMP_CURSOR 
 IS
 SELECT 
 FIRST_NAME,
 LAST_NAME,
 SALARY,
 ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12,0) AS TOTAL_EXPERIENCE
 FROM EMPLOYEES
 WHERE EMPLOYEE_ID=&EID;
 
 FNAME VARCHAR2(20);
 LNAME VARCHAR2(20);
 SAL VARCHAR2(20);
 TOTAL_EXPERIENCE VARCHAR2(20);
BEGIN
 OPEN EMP_CURSOR;
  LOOP
   FETCH EMP_CURSOR INTO FNAME,LNAME,SAL ,TOTAL_EXPERIENCE;
 EXIT WHEN EMP_CURSOR%NOTFOUND;
  DBMS_OUTPUT.PUT_LINE(FNAME||' '||LNAME||' '||SAL||' '||TOTAL_EXPERIENCE);
  END LOOP;
 CLOSE EMP_CURSOR;
END;
--============================================================================
--FIND EXPERIENCE USING FOR LOOP
SET SERVEROUTPUT ON
DECLARE
 CURSOR EMP_CURSOR 
 IS
 SELECT 
 FIRST_NAME,
 LAST_NAME,
 SALARY,
 ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12,0) AS TOTAL_EXP
 FROM EMPLOYEES
 WHERE EMPLOYEE_ID=&EID;
BEGIN
 FOR I IN EMP_CURSOR
 LOOP
  DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME||' '||I.LAST_NAME||' '||I.TOTAL_EXP);
 END LOOP;
END;

