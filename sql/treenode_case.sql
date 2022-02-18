/* Using CASE */

SELECT id, CASE
WHEN id = (select C.id from Tree C where C.p_id is null) THEN 'Root'
WHEN id IN (select B.p_id from Tree B where p_id is not null) THEN 'Inner'
ELSE 'Leaf'
END as type
from tree;