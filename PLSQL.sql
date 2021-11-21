-- 출력 설정
SET SERVEROUTPUT ON;

-- 데이터 출력
BEGIN
  DBMS_OUTPUT.PUT_LINE('HELLO PL/SQL');
END;
/

-- 변수 선언 과 출력
DECLARE
  VEMPNO NUMBER(4);
  VENAME VARCHAR2(10);
BEGIN
  VEMPNO := 7999;
  VENAME := 'STEVE';   
  DBMS_OUTPUT.PUT_LINE('   사원번호  이름'); 
  DBMS_OUTPUT.PUT_LINE('  ---------------');
  DBMS_OUTPUT.PUT_LINE('   ' || VEMPNO || '     ' || VENAME); 
END;
/

-- SELECT 구문 활용
DECLARE
  VEMPNO EMP.EMPNO%TYPE;
  VENAME EMP.ENAME%TYPE;
BEGIN
  SELECT EMPNO, ENAME INTO VEMPNO, VENAME
  FROM EMP
  WHERE ENAME='MILLER';
  DBMS_OUTPUT.PUT_LINE('   사원번호    이름'); 
  DBMS_OUTPUT.PUT_LINE('  ---------------');
  DBMS_OUTPUT.PUT_LINE('   ' || VEMPNO || '   ' || VENAME); 
END;
/

-- SELECT 구문
DECLARE
   VEMPNO 	 EMP.EMPNO%TYPE;
   VENAME 	 EMP.ENAME%TYPE;
   VDEPTNO   EMP.DEPTNO%TYPE;
   VDNAME 	 VARCHAR2(20) := NULL;
BEGIN
   SELECT EMPNO, ENAME, DEPTNO 
   INTO VEMPNO, VENAME, VDEPTNO 
   FROM  EMP
   WHERE EMPNO=7902;
END;
/
  
-- if 출력
DECLARE
   VEMPNO 	 EMP.EMPNO%TYPE;
   VENAME 	 EMP.ENAME%TYPE;
   VDEPTNO   EMP.DEPTNO%TYPE;
   VDNAME 	 VARCHAR2(20) := NULL;
BEGIN
   SELECT EMPNO, ENAME, DEPTNO 
   INTO VEMPNO, VENAME, VDEPTNO 
   FROM  EMP
   WHERE EMPNO=7902;
 IF (VDEPTNO = 10)  THEN
      VDNAME := 'ACCOUNTING';
 END IF;
 IF (VDEPTNO = 20)  THEN
     VDNAME := 'RESEARCH';
 END IF;
 IF (VDEPTNO = 30)  THEN
      VDNAME := 'SALES';
 END IF;
 IF (VDEPTNO = 40) THEN  
      VDNAME := 'OPERATIONS';
 END IF;

 DBMS_OUTPUT.PUT_LINE('   사번     이름      부서명');
 DBMS_OUTPUT.PUT_LINE('  ---------------------------');
 DBMS_OUTPUT.PUT_LINE('   ' || VEMPNO||'    '
                ||VENAME||'    '||VDNAME);
END;
/

-- if - else
DECLARE
  VEMP EMP%ROWTYPE;
  ANNSAL NUMBER(7,2);
BEGIN    
  SELECT * INTO VEMP
  FROM EMP
  WHERE ENAME='SCOTT';
IF (VEMP.COMM IS NULL) THEN 
    ANNSAL:=VEMP.SAL*12;       
ELSE     
    ANNSAL:=VEMP.SAL*12+VEMP.COMM; 
END IF;

DBMS_OUTPUT.PUT_LINE('  사번    이름    연봉'); 
DBMS_OUTPUT.PUT_LINE('--------------------------');
DBMS_OUTPUT.PUT_LINE('  '||VEMP.EMPNO||'   '
         ||VEMP.ENAME||'   '||ANNSAL); 
END;
/  

-- if - else if - else
DECLARE
  VEMP EMP%ROWTYPE;
  VDNAME VARCHAR2(14);
BEGIN  
  SELECT * INTO VEMP
  FROM EMP
  WHERE ENAME='MILLER';
  IF (VEMP.DEPTNO = 10)  THEN
    VDNAME := 'ACCOUNTING';
  ELSIF (VEMP.DEPTNO = 20)  THEN
    VDNAME := 'RESEARCH';
  ELSIF (VEMP.DEPTNO = 30)  THEN
    VDNAME := 'SALES';
  ELSIF (VEMP.DEPTNO = 40) THEN  
    VDNAME := 'OPERATIONS';
  END IF;

  DBMS_OUTPUT.PUT_LINE('  사번    이름     부서명'); 
  DBMS_OUTPUT.PUT_LINE('------------------------------');

  DBMS_OUTPUT.PUT_LINE('  '||VEMP.EMPNO
        ||'    '||VEMP.ENAME||'   '||VDNAME); 
END;
/

-- 반복: LOOP
DECLARE
  N  NUMBER := 1;
BEGIN
  LOOP
    DBMS_OUTPUT.PUT_LINE(N);
    N := N + 1;
    IF N > 5 THEN
      EXIT;
    END IF;
  END LOOP;
END;
/

-- FOR
DECLARE
BEGIN
  FOR N IN 1..5 LOOP
    DBMS_OUTPUT.PUT_LINE( N );
  END LOOP;
END;
/

-- tCity 테이블에서 region이 경기인 데이터 출력
BEGIN
    FOR v_cities IN (SELECT * FROM tCity WHERE region='경기')
    LOOP
        DBMS_OUTPUT.PUT_LINE(TRIM(v_cities.name) || ' : ' || v_cities.area || ',' || v_cities.popu);
    END LOOP;
END;
/

-- WHILE
DECLARE
  N NUMBER := 1;
BEGIN
  WHILE N <= 5 LOOP
    DBMS_OUTPUT.PUT_LINE( N );
    N := N + 1;
  END LOOP;
END;
/

-- GOTO를 이용한 1부터 100까지 합계
DECLARE 
    v_num INT := 1;
    v_total INT := 0;
BEGIN
    <<HERE>>    
    v_total := v_total + v_num;
    v_num := v_num + 1;
    IF v_num <= 100 THEN
        GOTO HERE;
    END IF;
   	DBMS_OUTPUT.PUT_LINE('1~100까지의 합산 결과 = ' || v_total);
END;
/

-- switch
DECLARE 
    v_num INT := 2;
    v_numword CHAR(30);
BEGIN
    v_numword := 
    CASE v_num
        WHEN 1 THEN '하나'
        WHEN 2 THEN '둘'
        WHEN 3 THEN '셋'
        WHEN 4 THEN '넷'
        ELSE '그외'
    END;
    DBMS_OUTPUT.PUT_LINE(v_numword);
END;
/

DECLARE 
    v_num INT := 6;
    v_numword CHAR(30);
BEGIN
    v_numword := 
    CASE 
        WHEN v_num < 0 THEN '음수'
        WHEN v_num IN (1, 2, 3) THEN '하나, 둘, 셋'
        WHEN v_num > 4 THEN '넷보다 더 큼'
        ELSE '그외'
    END;
    DBMS_OUTPUT.PUT_LINE(v_numword);
END;
/

DECLARE 
    v_num INT := 2;
    v_popu INT;
BEGIN
    CASE 
        WHEN v_num = 1 THEN SELECT popu INTO v_popu FROM tCity WHERE name = '서울';
        WHEN v_num = 2 THEN DBMS_OUTPUT.PUT_LINE('둘');
        WHEN v_num = 3 THEN COMMIT;
        WHEN v_num > 4 THEN ROLLBACK;
        ELSE DBMS_OUTPUT.PUT_LINE('알 수 없는 명령');
    END CASE;
END;
/

-- 예외 처리
-- tOrder 테이블에 orderID 가 100 번인 데이터의 회원정보를 조회
DECLARE v_member CHAR(20);
BEGIN
    SELECT member INTO v_member FROM tOrder WHERE orderID = 100;
    DBMS_OUTPUT.PUT_LINE(v_member);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('주문 번호가 없습니다.');
END;
/

-- 사용자 정의 예외 던지기
DECLARE 
    v_member CHAR(20);
    v_orderID INT := -1;
BEGIN
    IF (v_orderID < 0) THEN
        RAISE_APPLICATION_ERROR(-20000, '주문 번호가 음수여서는 안됩니다.');
    END IF;
    SELECT member INTO v_member FROM tOrder WHERE orderID = v_orderID;
    DBMS_OUTPUT.PUT_LINE(v_member);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLCODE);
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

-- 프로시저
-- EMP01 테이블의 모든 데이터를 삭제하는 프로시저 생성 및 실행
DROP TABLE EMP01;

CREATE TABLE EMP01
AS
SELECT * FROM EMP;

CREATE OR REPLACE PROCEDURE DEL_ALL
IS
BEGIN
DELETE FROM EMP01;
END;
/ 

BEGIN
  DEL_ALL();
END;     

SELECT *
FROM EMP01;

-- 프로시저 확인
SELECT * 
FROM USER_OBJECTS 
WHERE OBJECT_TYPE = 'PROCEDURE';

-- 프로시저 코드 확인
SELECT * 
FROM USER_SOURCE 
WHERE NAME = 'DEL_ALL';

-- 매개변수가 있는 프로시저
DROP TABLE EMP01;

CREATE TABLE EMP01
AS
SELECT * FROM EMP;

CREATE OR REPLACE PROCEDURE 
DEL_ENAME(VENAME EMP01.ENAME%TYPE)
IS
BEGIN
DELETE FROM EMP01 WHERE ENAME=VENAME;
END;
/

BEGIN
  DEL_ENAME('SMITH');
END; 

SELECT *
FROM EMP01;

-- OUT 매개변수
CREATE OR REPLACE PROCEDURE SEL_EMPNO
( VEMPNO IN 	EMP.EMPNO%TYPE,
  VENAME OUT EMP.ENAME%TYPE,
  VSAL OUT EMP.SAL%TYPE,
  VJOB OUT EMP.JOB%TYPE
)
IS
BEGIN
  SELECT ENAME, SAL, JOB INTO VENAME, VSAL, VJOB
  FROM EMP
  WHERE EMPNO=VEMPNO;
END;
/

VARIABLE VAR_ENAME VARCHAR2(15);
VARIABLE VAR_SAL NUMBER;
VARIABLE VAR_JOB VARCHAR2(9);

BEGIN
  SEL_EMPNO(7902, :VAR_ENAME, :VAR_SAL, :VAR_JOB);
END; 

PRINT VAR_ENAME 
PRINT VAR_SAL  
PRINT VAR_JOB

-- 연습문제
CREATE OR REPLACE PROCEDURE INSERT_EMP_PROC
( VEMPNO IN 	EMP.EMPNO%TYPE,
  VENAME IN EMP.ENAME%TYPE,
  VSAL IN EMP.SAL%TYPE,
  VDEPTNO IN EMP.DEPTNO%TYPE
)
IS
BEGIN
 INSERT INTO EMP(EMPNO, ENAME, SAL, DEPTNO)
 VALUES(VEMPNO, VENAME, VSAL, VDEPTNO);
END;
/

BEGIN
	INSERT_EMP_PROC(9000, 'JOBS', 9000, 10);
END;

SELECT *
FROM EMP;

DELETE FROM EMP 
WHERE EMPNO = 9000;

-- 함수
-- 2개의 정수를 받아서 더한 결과를 리턴하는 함수
CREATE OR REPLACE FUNCTION FN_AddInt(a INT, b INT) 
RETURN INT
AS
BEGIN
	RETURN a + b;
END;
/

-- 함수 실행
SELECT FN_AddInt(2, 3) 
FROM dual;

SELECT * 
FROM tCity 
WHERE popu > FN_AddInt(10, 20);

-- 인수를 받아서 합계를 구해서 리턴하는 함수
CREATE OR REPLACE FUNCTION FN_GetSum(p_upBound INT)
RETURN INT
AS
    v_total INT := 0;
BEGIN
    FOR v_num IN 1 .. p_upBound
    LOOP
        v_total := v_total + v_num;
    END LOOP;
    RETURN v_total;
END;
/

SELECT FN_GetSum(10) 
FROM dual;

-- 테이블 반환 함수
CREATE OR REPLACE TYPE gu_row AS OBJECT
(
    dan INT, 
    num INT, 
    multi INT
);

CREATE OR REPLACE TYPE gu_table AS TABLE OF gu_row;

CREATE OR REPLACE FUNCTION makeDan(p_dan INT)
RETURN gu_table PIPELINED
AS
    v_row gu_row;
BEGIN
    FOR v_num IN 1..9
    LOOP
        v_row := gu_row(p_dan, v_num, p_dan * v_num);
        PIPE ROW(v_row);
    END LOOP;
    RETURN;
END;
/

SELECT * 
FROM TABLE(makeDan(5));

SELECT * 
FROM TABLE(makeDan(7));


-- TCITY 테이블의 모든 도시 조회
DECLARE
    CURSOR v_cursor IS SELECT name FROM tCity;
    v_name CHAR(10);
BEGIN
    OPEN v_cursor;
    LOOP
        FETCH v_cursor INTO v_name;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_name);
    END LOOP;
    CLOSE v_cursor;
END;
/

DECLARE
    CURSOR v_cursor IS SELECT * FROM tCity;
    v_city tCity%ROWTYPE;
BEGIN
    OPEN v_cursor;
    LOOP
        FETCH v_cursor INTO v_city;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_city.region || v_city.name || v_city.area);
    END LOOP;
    CLOSE v_cursor;
END;
/

DECLARE 
BEGIN
	FOR v_cursor IN (SELECT name FROM tCity) 
	LOOP
		DBMS_OUTPUT.PUT_LINE(v_cursor.name); 
	END LOOP;
END;
/

-- SYS_REFCURSOR
DECLARE
    v_cursor SYS_REFCURSOR;
    v_name CHAR(10);
BEGIN
    OPEN v_cursor FOR SELECT name FROM tCity;
    LOOP
        FETCH v_cursor INTO v_name;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_name);
    END LOOP;
    CLOSE v_cursor;
END;
/

-- 전라도의 도시이름 조회
CREATE OR REPLACE PROCEDURE SP_OutCityName(p_region IN CHAR, o_cursor OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN o_cursor FOR SELECT name FROM tCity WHERE region = p_region;
END;
/

DECLARE
    v_cursor SYS_REFCURSOR;
    v_name CHAR(10);
BEGIN
    SP_OutCityName('전라', v_cursor);
    LOOP
        FETCH v_cursor INTO v_name;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_name);
    END LOOP;
END;
/

-- 커서를 이용한 업데이트
DECLARE
    CURSOR v_cursor IS SELECT * FROM tCity FOR UPDATE;
    v_city tCity%ROWTYPE;
BEGIN
    OPEN v_cursor;
    LOOP
        FETCH v_cursor INTO v_city;
        EXIT WHEN v_cursor%NOTFOUND;
        IF v_city.metro = 'y' THEN
            UPDATE tCity SET area = area + 10 WHERE CURRENT OF v_cursor;
        END IF;
    END LOOP;
    CLOSE v_cursor;
END;
/


-- 사원 테이블에 새로운 데이터가 들어오면(즉, 신입 사원이 들어오면) 
-- 급여 테이블에 새로운 데이터(즉 신입 사원의 급여 정보)를 자동으로 생성하도록 하기 위해서 
-- 사원 테이블에 TRIGGER를 작성(신입사원의 급여는 일괄적으로 100) 

DROP TABLE EMP01;

CREATE TABLE EMP01(
	EMPNO NUMBER(4) PRIMARY KEY,	
	ENAME VARCHAR2(10) NOT NULL,
	JOB VARCHAR2(20)
);

CREATE TABLE SAL01(
	SALNO NUMBER(4) PRIMARY KEY,
	SAL NUMBER(7,2),
	EMPNO NUMBER(4) REFERENCES EMP01(EMPNO)
);

CREATE SEQUENCE SAL01_SALNO_SEQ; 

CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT 
ON EMP01
FOR EACH ROW
BEGIN 
INSERT INTO SAL01 VALUES(
SAL01_SALNO_SEQ.NEXTVAL, 100, :NEW.EMPNO); 
END;
/

INSERT INTO EMP01 VALUES(1, '박문석', '프로그래머');

SELECT * FROM EMP01;

SELECT * FROM SAL01;

-- 사원이 삭제되면 그 사원의 급여 정보도 자동 삭제되는 TRIGGER를 작성
CREATE OR REPLACE TRIGGER TRG_02
AFTER DELETE ON EMP01
FOR EACH ROW
BEGIN
DELETE FROM SAL01 WHERE EMPNO=:OLD.EMPNO;
END;
/

DELETE FROM EMP01 WHERE EMPNO=1;

SELECT * FROM EMP01;

SELECT * FROM SAL01;

-- TRIGGER 삭제
DROP TRIGGER TRG_01;

DROP TRIGGER TRG_02;

-- EMP 테이블에서 급여를 수정 시 현재의 값보다 적게 수정할 수 없으며 
-- 현재의 값보다 10% 이상 높게 수정할 수 없도록 하는 TRIGGER를 작성
CREATE OR REPLACE TRIGGER EMP_SAL_CHK
BEFORE UPDATE OF SAL ON EMP
FOR EACH ROW WHEN (NEW.SAL < OLD.SAL 
		OR NEW.SAL > OLD.SAL * 1.1)
BEGIN
	RAISE_APPLICATION_ERROR(-20502,
	   'MAY NOT DECREASE SALARY. INCREASE MUST BE < 10%');
END;
/

-- EMP 테이블을 사용할 수 있는 시간은 
-- 월요일부터 금요일까지 09시부터 18시까지만 사용할 수 있도록 하는 TRIGGER를 작성
CREATE OR REPLACE TRIGGER EMP_RESOURCE
	BEFORE INSERT OR UPDATE OR DELETE ON EMP
BEGIN
	IF TO_CHAR(SYSDATE,'DY') IN ('SAT','SUN')
		OR TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))
			NOT BETWEEN 9 AND 18 THEN
		RAISE_APPLICATION_ERROR(-20502,
		   '작업할 수 없는 시간 입니다.');
	END IF;
END;
/

-- INSTEAD OF 트리거
CREATE OR REPLACE TRIGGER TR_AddNewCar
INSTEAD OF INSERT ON vCarMaker
FOR EACH ROW
BEGIN
	INSERT INTO tCar(car, capacity, price, maker) VALUES 
        (:NEW.car, :NEW.capacity, :NEW.price, :NEW.maker);
	INSERT INTO tMaker(maker, factory, domestic) VALUES 
        (:NEW.maker, :NEW.factory, :NEW.domestic);
END;
/

-- DDL 트리거
CREATE OR REPLACE TRIGGER TR_Change AFTER DDL ON DATABASE
BEGIN
DBMS_OUTPUT.PUT_LINE('명령 : ' || ora_sysevent); 
DBMS_OUTPUT.PUT_LINE('타입 : ' || ora_dict_obj_type); 
DBMS_OUTPUT.PUT_LINE('이름 : ' ]| ora_dict_obj_name);
END;
/

CREATE TABLE tTemp(id INT); 

DROP TABLE tTemp;

-- 로그 트리거
CREATE TABLE tCityHistory
(
    dt DATE,
    suser VARCHAR(20),
    ip VARCHAR(20),
    action VARCHAR(10),
    name CHAR(10),
    area VARCHAR(30) NULL,
    popu VARCHAR(30) NULL
);

CREATE OR REPLACE TRIGGER TR_History
AFTER INSERT OR UPDATE OR DELETE ON tCity
FOR EACH ROW
DECLARE
    areaChange VARCHAR(30);
    popuChange VARCHAR(30);
    suser VARCHAR(20);
    ip VARCHAR(20);
BEGIN
    SELECT SYS_CONTEXT('USERENV', 'SESSION_USER') INTO suser FROM DUAL;
    SELECT SYS_CONTEXT('USERENV', 'IP_ADDRESS') INTO ip FROM DUAL;
    
    IF INSERTING THEN
        INSERT INTO tCityHistory VALUES 
            (SYSDATE, suser, ip, 'INSERT', :NEW.name, :NEW.area, :NEW.popu);
    END IF;
    IF UPDATING THEN
        IF :OLD.area = :NEW.area THEN
            areaChange := :OLD.area;
        ELSE
            areaChange := :OLD.area || '->' || :NEW.area;
        END IF;
        IF :OLD.popu = :NEW.popu THEN
            popuChange := :OLD.popu;
        ELSE
            popuChange := :OLD.popu || '->' || :NEW.popu;
        END IF;
        INSERT INTO tCityHistory VALUES 
            (SYSDATE, suser, ip, 'UPDATE', :NEW.name, areaChange, popuChange);
    END IF;
    IF DELETING THEN
        INSERT INTO tCityHistory VALUES 
            (SYSDATE, suser, ip, 'DELETE', :OLD.name, :OLD.area, :OLD.popu);
    END IF;
END;
/

-- 연습문제
DROP TABLE EMP_SAL_TOT;

CREATE TABLE EMP_SAL_TOT AS
  SELECT DEPTNO, SUM(SAL) SAL_TOT
  FROM EMP
  GROUP BY DEPTNO;
 
 
CREATE OR REPLACE TRIGGER EMP_TOT
	AFTER INSERT OR UPDATE OR DELETE ON EMP
	FOR EACH ROW
BEGIN
		IF INSERTING THEN
			UPDATE EMP_SAL_TOT 
			SET SAL_TOT = SAL_TOT + :NEW.SAL
			WHERE DEPTNO = :NEW.DEPTNO;
		END IF;
		IF UPDATING THEN 
			UPDATE EMP_SAL_TOT 
			SET SAL_TOT = SAL_TOT + :NEW.SAL - :OLD.SAL
			WHERE DEPTNO = :NEW.DEPTNO;
		END IF;
		IF DELETING THEN 
			UPDATE EMP_SAL_TOT 
			SET SAL_TOT = SAL_TOT - :OLD.SAL
			WHERE DEPTNO = :OLD.DEPTNO;
		END IF;
END;
/ 

SELECT *
FROM EMP_SAL_TOT;

INSERT INTO EMP(EMPNO, ENAME, SAL, DEPTNO)
VALUES(8000, 'TAMES', 2000, 10);

SELECT *
FROM EMP_SAL_TOT;

UPDATE EMP
SET SAL = 4000
WHERE EMPNO = 8000;

SELECT *
FROM EMP_SAL_TOT;

DELETE FROM EMP
WHERE EMPNO = 8000;

SELECT *
FROM EMP_SAL_TOT;













