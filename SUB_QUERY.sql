-- MILLER의 부서명을 알아내기 위한 Sub Query
SELECT DEPTNO
FROM EMP
WHERE ENAME='MILLER';

-- 인구 수가 최대인 도시이름 구하기
-- 에러
SELECT MAX(popu), name 
FROM tCity;   

SELECT name FROM tCity 
WHERE popu = MAX(popu);

-- 에러는 아니지만 2개의 쿼리를 실행해야 함
SELECT MAX(popu) 
FROM tCity;

SELECT name FROM tCity 
WHERE popu = 974;

SELECT name 
FROM tCity 
WHERE popu = (SELECT MAX(popu) FROM tCity);

-- 평균 급여를 구하는 쿼리문을 Sub Query로 사용하여 평균 급여보다 더 많은 급여를 받는 사원을 검색하는 문장
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ( SELECT AVG(SAL)
              FROM EMP); 

-- 연습문제
SELECT ENAME, DEPTNO
FROM EMP
WHERE DEPTNO =  10;   
               
SELECT ENAME, DEPTNO
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE ENAME='MILLER' );
               
SELECT *
FROM EMP
WHERE JOB = (SELECT JOB
                FROM EMP
                WHERE ENAME='MILLER' );
               
SELECT ENAME, SAL
FROM EMP
WHERE SAL >= (SELECT SAL
                FROM EMP
                WHERE ENAME='MILLER' );               
               
SELECT ENAME, DEPTNO
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM DEPT
                WHERE LOC='DALLAS' );
               
SELECT ENAME, SAL
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM DEPT
                WHERE DNAME='SALES' );  
               
                
SELECT ENAME, SAL
FROM EMP
WHERE MGR = (SELECT EMPNO
                FROM EMP
                WHERE ENAME='KING' );  
               
-- 다중 열 서브쿼리
-- tStaff 테이블에서 안중근 과 같은 부서에 근무하고 성별이 같은 직원의 모든 정보를 조회
SELECT * 
FROM tStaff 
WHERE depart = (SELECT depart FROM tStaff WHERE name = '안중근')
       AND gender = (SELECT gender FROM tStaff WHERE name = '안중근');
      
SELECT * 
FROM tStaff 
WHERE (depart, gender) = (SELECT depart, gender FROM tStaff WHERE name = '안중근');
      
             
-- 여러 개의 행이 리턴되는 서브 쿼리에 단일 행 연산자를 사용해서 에러             
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL = (SELECT MAX(SAL)
				FROM EMP
				GROUP BY DEPTNO);

-- IN 적용
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
				FROM EMP
				GROUP BY DEPTNO);  
			
SELECT ENAME, SAL, DEPTNO 
FROM EMP
WHERE DEPTNO IN ( SELECT DISTINCT DEPTNO
			FROM EMP 
			WHERE SAL>=3000);
		
SELECT DEPTNO, DNAME, LOC 
FROM DEPT
WHERE DEPTNO IN ( SELECT DISTINCT DEPTNO
			FROM EMP 
			WHERE JOB = 'MANAGER');
	
-- ALL		
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ALL(SELECT SAL
             FROM EMP
             WHERE DEPTNO =30);
            
SELECT ENAME, SAL
FROM EMP
WHERE SAL > (SELECT MAX(SAL)
             FROM EMP
             WHERE DEPTNO =30);

-- ANY
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ANY ( SELECT SAL 
                  FROM EMP 
                  WHERE DEPTNO = 30 );
                 
SELECT ENAME, SAL
FROM EMP
WHERE SAL >  ( SELECT MIN(SAL) 
                  FROM EMP 
                  WHERE DEPTNO = 30 );
                 
SELECT ENAME, SAL, JOB
FROM EMP
WHERE SAL > ANY ( SELECT SAL 
                  FROM EMP 
                  WHERE JOB='SALESMAN' ) AND JOB != 'SALESMAN';
           
-- EXISTS
SELECT ENAME, SAL
FROM EMP
WHERE EXISTS (SELECT 1 FROM EMP WHERE SAL > 2000);
                 
-- 각 부서별 최고 급여자 목록 조회
SELECT * 
FROM tStaff 
WHERE (depart, salary) IN (SELECT depart, MAX(salary) FROM tStaff GROUP BY depart);

-----------------------------------------------------------------

SELECT ENAME, HIREDATE 
FROM EMP 
WHERE DEPTNO = (SELECT DEPTNO 
				FROM EMP 
				WHERE ENAME='BLAKE');
			
SELECT EMPNO, ENAME 
FROM EMP 
WHERE SAL > (SELECT AVG(SAL) 
			 FROM EMP) 
ORDER BY SAL DESC;

SELECT EMPNO, ENAME, SAL 
FROM EMP 
WHERE ENAME IN (SELECT ENAME 
				FROM EMP 
				WHERE ENAME LIKE '%T%');
			
SELECT ENAME, JOB, SAL
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO 
		   FROM DEPT 
		   WHERE LOC='DALLAS');

SELECT ENAME, SAL 
FROM EMP 
WHERE MGR IN (SELECT EMPNO 
			  FROM EMP 
			  WHERE ENAME='KING');
			 
SELECT * 
FROM EMP 
WHERE SAL> (SELECT MIN(SAL) 
			FROM EMP 
			WHERE DEPTNO =30) AND DEPTNO !=30;