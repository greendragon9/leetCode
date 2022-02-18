/* Using UNION */
SELECT id, 'Root' as type
FROM TREE 
WHERE p_id is null

Union 

Select id, 'Inner' as type
FROM TREE
WHERE id in (select distinct A.p_id from Tree A)
AND p_id is not null

Union

Select id, 'Leaf' as type
FROM TREE
WHERE id NOT IN  (Select distinct B.p_id from Tree B Where B.p_id is not null)
AND p_id is NOT NULL