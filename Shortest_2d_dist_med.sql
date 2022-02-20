/*
612. Shortest Distance in a Plane
https://leetcode.com/problems/shortest-distance-in-a-plane/

CREATE TABLE point_2d (
x number(4),
y number(4)
)

INSERT INTO point_2d values (-1,-1);
INSERT INTO point_2d values (0,0);
INSERT INTO point_2d values (-2,-2);


*/

select  round(sqrt(MIN((p1.x-p2.x)*(p1.x-p2.x) + (p1.y-p2.y)*(p1.y-p2.y))),2) as shortest
FROM point_2d p1, point_2d p2
where p1.x <> p2.x or p1.y <> p2.y