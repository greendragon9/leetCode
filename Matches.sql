/*
1841. League Statistics
https://leetcode.com/problems/league-statistics/

CREATE TABLE MATCHES (
home_team_id number(2),
away_team_id number(2),
home_team_goals number(2),
away_team_goals number(2)
)

INSERT INTO MATCHES VALUES (1,4,0,1);
INSERT INTO MATCHES VALUES (1,6,3,3);
INSERT INTO MATCHES VALUES (4,1,5,2);
INSERT INTO MATCHES VALUES (6,1,0,0);



CREATE TABLE TEAMS (
team_id number(2),
team_name varchar2(20)
)

INSERT INTO TEAMs VALUES (1,'Ajax');
INSERT INTO TEAMs VALUES (4,'Dortmund');
INSERT INTO TEAMs VALUES (6,'Arsenal');

SELECT * FROM TEAMS;
SELECT * FROM MATCHES;



INSERT INTO TEAMS VALUES (4,'Juventues');
INSERT INTO TEAMS VALUES (1,'Ajax');
INSERT INTO TEAMS VALUES (8,'BayernMunich');
INSERT INTO TEAMS VALUES (5,'Arsenal');
INSERT INTO TEAMS VALUES (10,'Lyon');


INSERT INTO MATCHES VALUES (1,4,2,3);
INSERT INTO MATCHES VALUES (1,5,2,3);
INSERT INTO MATCHES VALUES (8,4,5,3);
INSERT INTO MATCHES VALUES (8,1,4,1);
INSERT INTO MATCHES VALUES (8,5,3,1);
INSERT INTO MATCHES VALUES (8,10,2,2);
INSERT INTO MATCHES VALUES (5,4,3,0);
INSERT INTO MATCHES VALUES (5,1,5,0);
INSERT INTO MATCHES VALUES (5,8,5,3);
INSERT INTO MATCHES VALUES (10,1,0,2);
INSERT INTO MATCHES VALUES (10,8,1,1);
INSERT INTO MATCHES VALUES (10,5,0,3);


*/

SELECT T.team_name, A.HT_CNT + B.AT_CNT AS MATCHES_PLAYED, C.H_PTS + D.A_PTS AS POINTS,
E.HT_GOALS+F.AT_GOALS AS GOAL_FOR,
E.HT_GOAL_AGAINST + F.AT_GOAL_AGAINST AS GOAL_AGAINST,
E.HT_GOALS+F.AT_GOALS - (E.HT_GOAL_AGAINST + F.AT_GOAL_AGAINST) AS GOAL_DIFF
FROM TEAMS T
LEFT JOIN 
(
SELECT HOME_TEAM_ID, COUNT(*) HT_CNT
FROM MATCHES
GROUP BY HOME_TEAM_ID
)A
ON T.TEAM_ID = A.HOME_TEAM_ID

LEFT JOIN 
(
SELECT away_team_id, COUNT(*) AT_CNT
FROM MATCHES
GROUP BY away_team_id
)B
ON T.team_id = B.away_team_id


LEFT JOIN 
(
SELECT DISTINCT HOME_TEAM_ID, SUM(HOME_PTS) AS H_PTS 
FROM
(
SELECT HOME_TEAM_ID, CASE
WHEN home_team_goals > away_team_goals then 3
WHEN home_team_goals = away_team_goals then 1
ELSE 0 
END AS HOME_PTS
FROM MATCHES
)HT_PTS
GROUP BY HOME_TEAM_ID
)C

ON T.TEAM_ID = C.HOME_TEAM_ID

LEFT JOIN 

(
SELECT DISTINCT AWAY_TEAM_ID, SUM(AWAY_PTS) AS A_PTS 
FROM
(
SELECT AWAY_TEAM_ID, CASE
WHEN home_team_goals < away_team_goals then 3
WHEN home_team_goals = away_team_goals then 1
ELSE 0 
END AS AWAY_PTS
FROM MATCHES
)AT_PTS
GROUP BY AWAY_TEAM_ID
)D

ON T.TEAM_ID = D.AWAY_TEAM_ID


LEFT JOIN
(
SELECT HOME_TEAM_ID, SUM(HOME_TEAM_GOALS) HT_GOALS, SUM(away_team_GOALS) HT_GOAL_AGAINST
FROM MATCHES
GROUP BY HOME_TEAM_ID
)E

ON T.TEAM_ID = E.HOME_TEAM_ID

LEFT JOIN 
(
SELECT away_team_id, SUM(away_team_GOALS) AT_GOALS, SUM(HOME_TEAM_GOALS) AT_GOAL_AGAINST
FROM MATCHES
GROUP BY away_team_id
)F
ON T.TEAM_ID = F.away_team_id

ORDER BY POINTS DESC, goal_diff desc, team_name 
-----------------------------
------------------------------


SELECT TT.TEAM_NAME AS TEAM_NAME, A.HT_CNT + B.AT_CNT AS MATCHES_PLAYED, C.H_PTS + D.A_PTS AS POINTS,
E.HT_GOALS+F.AT_GOALS AS GOAL_FOR,
E.HT_GOAL_AGAINST + F.AT_GOAL_AGAINST AS GOAL_AGAINST,
E.HT_GOALS+F.AT_GOALS - (E.HT_GOAL_AGAINST + F.AT_GOAL_AGAINST) AS GOAL_DIFF
--FROM (SELECT DISTINCT HOME_TEAM_ID FROM MATCHES) T
FROM (SELECT DISTINCT HOME_TEAM_ID FROM MATCHES UNION SELECT DISTINCT AWAY_TEAM_ID FROM MATCHES) T
LEFT JOIN 
(
SELECT HOME_TEAM_ID, COUNT(*) HT_CNT
FROM MATCHES
GROUP BY HOME_TEAM_ID
)A
ON T.HOME_TEAM_ID = A.HOME_TEAM_ID

LEFT JOIN 
(
SELECT away_team_id, COUNT(*) AT_CNT
FROM MATCHES
GROUP BY away_team_id
)B
ON T.HOME_TEAM_ID = B.away_team_id


LEFT JOIN 
(
SELECT DISTINCT HOME_TEAM_ID, SUM(HOME_PTS) AS H_PTS 
FROM
(
SELECT HOME_TEAM_ID, CASE
WHEN home_team_goals > away_team_goals then 3
WHEN home_team_goals = away_team_goals then 1
ELSE 0 
END AS HOME_PTS
FROM MATCHES
)HT_PTS
GROUP BY HOME_TEAM_ID
)C

ON T.HOME_TEAM_ID = C.HOME_TEAM_ID

LEFT JOIN 

(
SELECT DISTINCT AWAY_TEAM_ID, SUM(AWAY_PTS) AS A_PTS 
FROM
(
SELECT AWAY_TEAM_ID, CASE
WHEN home_team_goals < away_team_goals then 3
WHEN home_team_goals = away_team_goals then 1
ELSE 0 
END AS AWAY_PTS
FROM MATCHES
)AT_PTS
GROUP BY AWAY_TEAM_ID
)D

ON T.HOME_TEAM_ID = D.AWAY_TEAM_ID


LEFT JOIN
(
SELECT HOME_TEAM_ID, SUM(HOME_TEAM_GOALS) HT_GOALS, SUM(away_team_GOALS) HT_GOAL_AGAINST
FROM MATCHES
GROUP BY HOME_TEAM_ID
)E

ON T.HOME_TEAM_ID = E.HOME_TEAM_ID

LEFT JOIN 
(
SELECT away_team_id, SUM(away_team_GOALS) AT_GOALS, SUM(HOME_TEAM_GOALS) AT_GOAL_AGAINST
FROM MATCHES
GROUP BY away_team_id
)F
ON T.HOME_TEAM_ID = F.away_team_id

LEFT JOIN TEAMS TT
ON T.HOME_TEAM_ID = TT.TEAM_ID

ORDER BY POINTS DESC, GOAL_DIFF DESC, TT.TEAM_NAME
 
/*

{"headers":{"Teams":["team_id","team_name"],"Matches":["home_team_id","away_team_id","home_team_goals","away_team_goals"]},"rows":{"Teams":[[4,"Juventues"],[1,"Ajax"],[8,"BayernMunich"],[5,"Arsenal"],[10,"Lyon"]],"Matches":[[1,4,2,3],[1,5,2,3],[8,4,5,3],[8,1,4,1],[8,5,3,1],[8,10,2,2],[5,4,3,0],[5,1,5,0],[5,8,5,3],[10,1,0,2],[10,8,1,1],[10,5,0,3]]}}
{"headers": ["TEAM_NAME", "MATCHES_PLAYED", "POINTS", "GOAL_FOR", "GOAL_AGAINST", "GOAL_DIFF"], "values": [["Arsenal", 6, 15, 20, 8, 12], ["BayernMunich", 6, 11, 18, 13, 5], ["Ajax", 5, 3, 7, 15, -8], ["Lyon", 4, 2, 3, 8, -5]]}
{"headers": ["team_name", "matches_played", "points", "goal_for", "goal_against", "goal_diff"], "values": [["Arsenal", 6, 15, 20, 8, 12], ["BayernMunich", 6, 11, 18, 13, 5], ["Juventues", 3, 3, 6, 10, -4], ["Ajax", 5, 3, 7, 15, -8], ["Lyon", 4, 2, 3, 8, -5]]}

*/



SELECT 
    TT.TEAM_NAME AS TEAM_NAME, 
    nvl(A.HT_CNT,0) + nvl(B.AT_CNT,0) AS MATCHES_PLAYED, 
    nvl(C.H_PTS,0) + nvl(D.A_PTS,0) AS POINTS,
    nvl(E.HT_GOALS,0)+nvl(F.AT_GOALS,0) AS GOAL_FOR,
    nvl(E.HT_GOAL_AGAINST,0) + nvl(F.AT_GOAL_AGAINST,0) AS GOAL_AGAINST,
    nvl(E.HT_GOALS,0)+nvl(F.AT_GOALS,0) - (nvl(E.HT_GOAL_AGAINST,0) + nvl(F.AT_GOAL_AGAINST,0)) AS GOAL_DIFF

FROM (
    SELECT DISTINCT HOME_TEAM_ID FROM MATCHES UNION SELECT DISTINCT AWAY_TEAM_ID FROM MATCHES) T
LEFT JOIN 
    (
        SELECT HOME_TEAM_ID, COUNT(*) HT_CNT
        FROM MATCHES
        GROUP BY HOME_TEAM_ID
    )A
ON T.HOME_TEAM_ID = A.HOME_TEAM_ID

LEFT JOIN 
    (
        SELECT away_team_id, COUNT(*) AT_CNT
        FROM MATCHES
        GROUP BY away_team_id
    )B
ON T.HOME_TEAM_ID = B.away_team_id


LEFT JOIN 
    (
        SELECT DISTINCT HOME_TEAM_ID, SUM(HOME_PTS) AS H_PTS 
        FROM
            (
                SELECT HOME_TEAM_ID, 
                CASE
                    WHEN home_team_goals > away_team_goals then 3
                    WHEN home_team_goals = away_team_goals then 1
                    ELSE 0 
                END AS HOME_PTS
                FROM MATCHES
            ) HT_PTS
        GROUP BY HOME_TEAM_ID
    )C

ON T.HOME_TEAM_ID = C.HOME_TEAM_ID

LEFT JOIN 

    (
        SELECT DISTINCT AWAY_TEAM_ID, SUM(AWAY_PTS) AS A_PTS 
        FROM
            (
                SELECT AWAY_TEAM_ID, 
                CASE
                    WHEN home_team_goals < away_team_goals then 3
                    WHEN home_team_goals = away_team_goals then 1
                    ELSE 0 
                END AS AWAY_PTS
                FROM MATCHES
            )AT_PTS
        GROUP BY AWAY_TEAM_ID
    )D

ON T.HOME_TEAM_ID = D.AWAY_TEAM_ID


LEFT JOIN
    (
    SELECT HOME_TEAM_ID, SUM(HOME_TEAM_GOALS) HT_GOALS, SUM(away_team_GOALS) HT_GOAL_AGAINST
    FROM MATCHES
    GROUP BY HOME_TEAM_ID
    )E

ON T.HOME_TEAM_ID = E.HOME_TEAM_ID

LEFT JOIN 
    (
        SELECT away_team_id, SUM(away_team_GOALS) AT_GOALS, SUM(HOME_TEAM_GOALS) AT_GOAL_AGAINST
        FROM MATCHES
        GROUP BY away_team_id
    )F
ON T.HOME_TEAM_ID = F.away_team_id

LEFT JOIN TEAMS TT
ON T.HOME_TEAM_ID = TT.TEAM_ID

ORDER BY POINTS DESC, GOAL_DIFF DESC, TT.TEAM_NAME
 
 ---/* BEST SOLN */---

 WITH CTE AS (
SELECT B.TEAM_NAME, A.GOAL_FOR, A.GOAL_AGAINST, A.POINTS 
FROM (
    SELECT
        home_team_id AS TEAM_ID,
        home_team_goals AS GOAL_FOR,
        away_team_goals AS GOAL_AGAINST,
        CASE WHEN home_team_goals > away_team_goals THEN 3
             WHEN home_team_goals < away_team_goals THEN 0
        ELSE 1 END AS POINTS 
    FROM Matches 
    UNION ALL
    SELECT
        away_team_id AS TEAM_ID,
        away_team_goals AS GOAL_FOR,
        home_team_goals AS GOAL_AGAINST,
        CASE WHEN home_team_goals < away_team_goals THEN 3
             WHEN home_team_goals > away_team_goals THEN 0
        ELSE 1 END AS POINTS 
    FROM Matches) A
LEFT JOIN Teams B
ON A.TEAM_ID=B.TEAM_ID )

SELECT TEAM_NAME, 
    COUNT(*) AS matches_played, 
    SUM(POINTS) AS POINTS,
    SUM(GOAL_FOR) AS GOAL_FOR,
    SUM(GOAL_AGAINST) AS GOAL_AGAINST,
    (SUM(GOAL_FOR)-SUM(GOAL_AGAINST)) AS GOAL_DIFF
FROM CTE 
GROUP BY TEAM_NAME
ORDER BY POINTS DESC, GOAL_DIFF DESC, TEAM_NAME ASC;
