/*

1454. Active Users
https://leetcode.com/problems/active-users/

CREATE TABLE ACCOUNTS (
id number(4),
name varchar2(30)
);

CREATE TABLE LOGINS (
id number(4),
login_date date
);

insert into accounts values (1,'Winston');
insert into accounts values (7,'Jonathan');

insert into logins values (7,date'2020-05-30');
insert into logins values (1,date'2020-05-30');
insert into logins values (7,date'2020-05-31');
insert into logins values (7,date'2020-06-01');
insert into logins values (7,date'2020-06-02');
insert into logins values (7,date'2020-06-02');
insert into logins values (7,date'2020-06-03');
insert into logins values (1,date'2020-06-07');
insert into logins values (7,date'2020-06-10');

select * from accounts;
select * from logins;

*/

select id, login_date, dense_rank() over (partition by id order by login_date asc)
from logins