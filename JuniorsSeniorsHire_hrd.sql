/*
2004. The Number of Seniors and Juniors to Join the Company

https://leetcode.com/problems/the-number-of-seniors-and-juniors-to-join-the-company/

CREATE TABLE CANDIDATES (
employee_id number(20),
experience varchar(10) check (experience in ('Senior','Junior')),
salary number(6)
);

INSERT INTO CANDIDATES VALUES (1,'Junior', 10000);
INSERT INTO CANDIDATES VALUES (9,'Junior', 10000);
INSERT INTO CANDIDATES VALUES (2,'Senior', 20000);
INSERT INTO CANDIDATES VALUES (11,'Senior', 20000);
INSERT INTO CANDIDATES VALUES (13,'Senior', 50000);
INSERT INTO CANDIDATES VALUES (4,'Junior', 40000);

create table Nadine (
subject varchar2(10),
marks number(7)
);

INSERT INTO NADINE VALUES ('Geography',99);
INSERT INTO NADINE VALUES ('History',70);
INSERT INTO NADINE VALUES ('Maths',89);
INSERT INTO NADINE VALUES ('Biology',98);
INSERT INTO NADINE VALUES ('Physics',80);
INSERT INTO NADINE VALUES ('Chemistry',77);

select N.*, sum(Marks) over (order by marks asc) 
from nadine N


SELECT T.*, SUM(SALARY) OVER (PARTITION BY EXPERIENCE ORDER BY SALARY ) AS SAL 
FROM TALENTPOOL T

UPDATE TALENTPOOL SET SALARY = 10000 WHERE EMPLOYEE_ID = 1;
UPDATE TALENTPOOL SET SALARY = 10000 WHERE EMPLOYEE_ID = 9;
UPDATE TALENTPOOL SET SALARY = 40000 WHERE EMPLOYEE_ID = 4;
UPDATE TALENTPOOL SET SALARY = 20000 WHERE EMPLOYEE_ID = 2;
UPDATE TALENTPOOL SET SALARY = 20000 WHERE EMPLOYEE_ID = 11;
UPDATE TALENTPOOL SET SALARY = 50000 WHERE EMPLOYEE_ID = 13;

*/


WITH SENIOR AS (
SELECT Employee_id, SALARY
FROM (

SELECT T.*, SUM(SALARY) OVER (PARTITION BY EXPERIENCE ORDER BY SALARY ) AS SAL 
FROM CANDIDATES T
WHERE EXPERIENCE = 'Senior'

)A
where A.SAL < 70000
)

SELECT 'Junior' as Experience, COUNT(EMPLOYEE_ID) AS ACCEPTED_CANDIDATES
FROM 
(
SELECT B.*, SUM(SALARY) OVER (PARTITION BY EXPERIENCE ORDER BY SALARY ) AS SAL 
FROM CANDIDATES B
WHERE EXPERIENCE = 'Junior'
)C
WHERE C.SAL<(70000-(select nvl(sum(SALARY),0) FROM SENIOR))

UNION

SELECT 'Senior' as Experience, COUNT(EMPLOYEE_ID) AS ACCEPTED_CANDIDATES FROM SENIOR


/*

{"headers":{"Candidates":["employee_id","experience","salary"]},"rows":{"Candidates":[[16,"Senior",28164],[17,"Senior",36075],[11,"Senior",85086],[7,"Senior",9528],[13,"Junior",5302],[6,"Senior",51224],[1,"Senior",18838],[15,"Junior",8376],[9,"Junior",8530],[3,"Senior",53307],[10,"Senior",13204]]}}

*/