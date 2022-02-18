/*
SELECT * FROM TEAMS;
SELECT * FROM MATCHES;

*/
SELECT T.team_id, T.team_name, A.HT_CNT + B.AT_CNT AS MATCHES_PLAYED, C.HT_GOALS, D.AT_GOALS 
FROM Teams T

LEFT JOIN (
SELECT HOME_TEAM_ID, COUNT(*) HT_CNT
FROM MATCHES
GROUP BY HOME_TEAM_ID
ORDER BY HOME_TEAM_ID
)A
ON T.team_id = A.HOME_TEAM_ID

LEFT JOIN (
SELECT away_team_id, COUNT(*) AT_CNT
FROM MATCHES
GROUP BY away_team_id
ORDER BY away_team_id
)B
ON T.team_id = B.away_team_id

LEFT JOIN (
SELECT HOME_TEAM_ID, SUM(home_team_goals) HT_GOALS
FROM MATCHES
GROUP BY HOME_TEAM_ID
ORDER BY HOME_TEAM_ID
)C
ON T.team_id = C.HOME_TEAM_ID

LEFT JOIN (
SELECT away_team_id, SUM(away_team_goals) AT_GOALS
FROM MATCHES
GROUP BY away_team_id
ORDER BY away_team_id
)D
ON T.team_id = D.away_team_id

ORDER BY MATCHES_PLAYED 

/*
(
SELECT home_team_id, away_team_id, CASE
WHEN home_team_goals >away_team_goals THEN 3
WHEN home_team_goals < away_team_goals THEN 0
WHEN home_team_goals = away_team_goals THEN 1
END AS HT_PTS,

CASE
WHEN home_team_goals >away_team_goals THEN 0
WHEN home_team_goals < away_team_goals THEN 3
WHEN home_team_goals = away_team_goals THEN 1
END AS AT_PTS

FROM MATCHES)E

*/
