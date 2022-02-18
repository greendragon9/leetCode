/* Using IF 
Not Working */

SELECT T.id, NVL2(T.p_id,'Root',IF(T.id in (select distinct A.p_id from tree A WHERE A.p_id IS NOT NULL), 'Inner','Leaf')) Type
FROM Tree T
Order by T.id