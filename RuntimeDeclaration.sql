--DECLARE VARIABLE AT RUNTIME
SET SERVEROUTPUT ON
DECLARE
DEP_DETAILS DEPARTMENTS%ROWTYPE;
CURSOR DEP_TEST
IS
SELECT *
FROM DEPARTMENTS;

BEGIN
OPEN DEP_TEST;
LOOP
FETCH DEP_TEST INTO DEP_DETAILS;
DBMS_OUTPUT.PUT_LINE(DEP_DETAILS.DEPARTMENT_ID||' '||DEP_DETAILS.DEPARTMENT_NAME);
EXIT WHEN DEP_TEST%NOTFOUND;
END LOOP;
CLOSE DEP_TEST;
END;

-------------------------------
SET SERVEROUTPUT ON
DECLARE
DEP_DETAILS DEPARTMENTS%ROWTYPE;
CURSOR DEP_TEST
IS
SELECT *
FROM DEPARTMENTS;

BEGIN

OPEN DEP_TEST;
  FETCH DEP_TEST INTO DEP_DETAILS;
  WHILE DEP_TEST%FOUND LOOP
  FETCH DEP_TEST INTO DEP_DETAILS;
  DBMS_OUTPUT.PUT_LINE(DEP_DETAILS.DEPARTMENT_ID||' '||DEP_DETAILS.DEPARTMENT_NAME);
END LOOP;
CLOSE DEP_TEST;

END;

-------------------------------------
SET SERVEROUTPUT ON
DECLARE
DEP_DETAILS DEPARTMENTS%ROWTYPE;

CURSOR DEP_TEST
IS
SELECT *
FROM DEPARTMENTS;

I EMPLOYEES.SALARY%TYPE := 1;
BEGIN
OPEN DEP_TEST;
FETCH DEP_TEST INTO DEP_DETAILS;
WHILE I <= DEP_TEST%ROWCOUNT LOOP
FETCH DEP_TEST INTO DEP_DETAILS;
DBMS_OUTPUT.PUT_LINE(DEP_DETAILS.DEPARTMENT_ID||' '||DEP_DETAILS.DEPARTMENT_NAME);
I := I + 1;
END LOOP;
CLOSE DEP_TEST;
END;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
SET SERVEROUTPUT ON
DECLARE
  DEP_DETAILS DEPARTMENTS%ROWTYPE;   ----  VARIABLE TABLE%ROWTYE  ----> ALL COLUMNS /DATATYPE 
  
  CURSOR DEPT_TEST 
  IS
  SELECT *FROM DEPARTMENTS;
BEGIN
  OPEN DEPT_TEST; 
     LOOP
           FETCH DEPT_TEST INTO DEP_DETAILS;
           DBMS_OUTPUT.PUT_LINE(DEP_DETAILS.DEPARTMENT_ID||' '||DEP_DETAILS.DEPARTMENT_NAME);
           EXIT WHEN DEPT_TEST%NOTFOUND;
     END LOOP;
  
  CLOSE DEPT_TEST;
END;
---==============================================================
--VIEW QUESTION
---=================================================

SET SERVEROUTPUT ON
DECLARE
CURSOR EMP_TEST
IS 
SELECT FIRST_NAME,LAST_NAME,SALARY
FROM EMPLOYEES;

BEGIN

FOR I IN EMP_TEST LOOP
DBMS_OUTPUT.PUT_LINE(I.FIRST_NAME||' '||I.LAST_NAME||' '||I.SALARY);
END LOOP;

END;

---------------------
SET SERVEROUTPUT ON
DECLARE
NUM1 NUMBER := &N1;

BEGIN
FOR I IN 1..NUM1 LOOP
DBMS_OUTPUT.PUT_LINE(I);
END LOOP;
END;

----------------------------------
SET SERVEROUTPUT ON
DECLARE
NUM1 NUMBER := &N1;

BEGIN
FOR I IN 1..NUM1 LOOP
DBMS_OUTPUT.PUT_LINE(I);
END LOOP;
END;

-----------------------------------------------
--HERE VIEW IS CREATED IN OUTER SIDE 
--AND WE ARE ACCESSING THAT VIEW IN BOTTOM.
CREATE OR REPLACE VIEW EMP_VIEW_2
AS
SELECT 
E.FIRST_NAME,
E.LAST_NAME,
D.DEPARTMENT_NAME,
E.SALARY
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON(E.DEPARTMENT_ID=D.DEPARTMENT_ID);

SET SERVEROUTPUT ON
DECLARE
      CURSOR EMP_CUR IS SELECT *FROM EMP_VIEW_2;
      
      EMP_DETAILS EMP_CUR%ROWTYPE;
BEGIN
   OPEN EMP_CUR;
       LOOP
            FETCH EMP_CUR INTO EMP_DETAILS;
            DBMS_OUTPUT.PUT_LINE(EMP_DETAILS.FIRST_NAME||' '||EMP_DETAILS.LAST_NAME||' '||EMP_DETAILS.DEPARTMENT_NAME||' '||EMP_DETAILS.SALARY);
       EXIT WHEN EMP_CUR%NOTFOUND;
       END LOOP;
   CLOSE EMP_CUR;
END;

--============================================================================
SET SERVEROUTPUT ON

BEGIN
    -- This block creates the view using dynamic SQL
    EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW view_employee_details AS
                       SELECT e.employee_id, e.first_name, e.last_name, e.salary, d.department_id, d.department_name
                       FROM employees e
                       JOIN department d ON e.department_id = d.department_id';

    -- Here's how you would declare and use a cursor to select from that view
    -- Note that you can only use the cursor after the view has been created
    DECLARE
        CURSOR emp_cursor IS SELECT * FROM vview_employee_details;
        emp_record emp_cursor%ROWTYPE;
    BEGIN
        OPEN emp_cursor;
        LOOP
            FETCH emp_cursor INTO emp_record;
            EXIT WHEN emp_cursor%NOTFOUND;

            -- Do something with emp_record
            -- For example, outputting the fetched employee details
            DBMS_OUTPUT.PUT_LINE(emp_record.employee_id || ', ' ||
                                 emp_record.first_name || ', ' ||
                                 emp_record.last_name || ', ' ||
                                 emp_record.salary || ', ' ||
                                 emp_record.department_name);
        END LOOP;
        CLOSE emp_cursor;
   END;
END;
--============================================================================
SET SERVEROUTPUT ON
DECLARE
 DEPT_DETAILS DEPARTMENTS%ROWTYPE;

 CURSOR DEPT_DET
 IS
 SELECT *FROM DEPARTMENTS;

BEGIN
 OPEN DEPT_DET;
  LOOP
   FETCH DEPT_DET INTO DEPT_DETAILS;
   EXIT WHEN DEPT_DET%NOTFOUND;
   DBMS_OUTPUT.PUT_LINE(DEPT_DETAILS.DEPARTMENT_ID||' '||DEPT_DETAILS.DEPARTMENT_NAME);
  END LOOP;
 CLOSE DEPT_DET;
END;  


