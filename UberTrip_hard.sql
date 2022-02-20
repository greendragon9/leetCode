/*
262. Trips and Users
https://leetcode.com/problems/trips-and-users/

CREATE TABLE TRIPS (
id number(4),
client_id number(4),
driver_id number(4),
city_id number(4),
status varchar2(30) check(status in ('completed','cancelled_by_driver','cancelled_by_client')),
request_at date
);

INSERT INTO TRIPS VALUES (1,1,10,1,'completed',date'2013-10-01');
INSERT INTO TRIPS VALUES (2,2,11,1,'cancelled_by_driver',date'2013-10-01');
INSERT INTO TRIPS VALUES (3,3,12,6,'completed',date'2013-10-01');
INSERT INTO TRIPS VALUES (4,4,13,6,'cancelled_by_client',date'2013-10-01');
INSERT INTO TRIPS VALUES (5,1,10,1,'completed',date'2013-10-02');
INSERT INTO TRIPS VALUES (6,2,11,6,'completed',date'2013-10-02');
INSERT INTO TRIPS VALUES (7,3,12,6,'completed',date'2013-10-02');
INSERT INTO TRIPS VALUES (8,2,12,12,'completed',date'2013-10-03');
INSERT INTO TRIPS VALUES (9,3,10,12,'completed',date'2013-10-03');
INSERT INTO TRIPS VALUES (10,4,13,12,'cancelled_by_driver',date'2013-10-03');

CREATE TABLE USERS (
users_id number(4),
banned varchar2(20) check( banned in ('Yes','No')),
role varchar2(20) check(role in ('client','driver','partner'))
);

INSERT INTO USERS VALUES (1,'No','client');
INSERT INTO USERS VALUES (2,'Yes','client');
INSERT INTO USERS VALUES (3,'No','client');
INSERT INTO USERS VALUES (4,'No','client');
INSERT INTO USERS VALUES (10,'No','driver');
INSERT INTO USERS VALUES (11,'No','driver');
INSERT INTO USERS VALUES (12,'No','driver');
INSERT INTO USERS VALUES (13,'No','driver');



*/


with temp as
(select T.*, CASE
WHEN status in ('cancelled_by_client', 'cancelled_by_driver') then 1
else 0 
end as cancelled
from trips T

where client_id NOT IN (SELECT USERS_ID FROM USERS WHERE BANNED='Yes')
and driver_id NOT IN (SELECT USERS_ID FROM USERS WHERE BANNED='Yes')
--and T.request_at between date'2013-10-01' and date'2013-10-03'
--and T.request_at between to_date('2013-10-01','yyyy-mm-dd') and to_date('2013-10-03','yyyy-mm-dd')
and request_at between to_date('2013-10-01','yyyy-mm-dd') and to_date('2013-10-03','yyyy-mm-dd')
)

select request_at AS Day, ROUND((sum(cancelled)/count(*)),2) AS "Cancellation Rate"
from temp 
group by request_at
order by request_at