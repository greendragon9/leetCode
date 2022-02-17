/** 608. Tree Node **/
/** https://leetcode.com/problems/tree-node/ **/

WITH TEMP AS (
SELECT A.id as A_ID, A.p_id as A_PID, B.id as B_ID, B.p_id as B_PID 
FROM Tree A LEFT JOIN Tree B
ON A.p_id = B.id )

SELECT TEMP.A_ID as id, CASE 
WHEN TEMP.B_PID IS NOT NULL THEN 'Leaf' 
WHEN TEMP.B_PID IS NULL AND TEMP.A_PID IS NOT NULL THEN 'Inner' 
WHEN TEMP.B_PID IS NULL AND TEMP.A_PID IS NULL THEN 'Root'
END AS type 
FROM TEMP
ORDER BY id;