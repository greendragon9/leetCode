/*

CREATE TABLE NEW_PRODUCTS 
(
product_id number(2), 
low_fats varchar2(2) check( low_fats in ('Y','N')), 
recyclable varchar2(2) check( recyclable in ('Y','N'))
);

FIND THE PERCENTAGE OF PRODUCTS THAT ARE LOW_FAT & RECYCLABLE 

*/


SELECT ROUND(AVG(CASE
WHEN low_fats ='Y' and recyclable ='Y' THEN 1
ELSE 0
END),4) *100 AS LF_R,
ROUND(AVG(CASE
WHEN low_fats !='Y' and recyclable !='Y' THEN 1
WHEN low_fats !='Y' and recyclable ='Y' THEN 1
When low_fats ='Y' and recyclable !='Y' THEN 1
ELSE 0
END),4) *100 AS HF_NR
FROM NEW_PRODUCTS