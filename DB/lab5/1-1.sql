SELECT j.adult_member_no, j.No_Of_Children, a.expr_date
FROM adult a,
(SELECT adult_member_no, COUNT(member_no) AS No_Of_Children
FROM juvenile
GROUP BY adult_member_no
HAVING COUNT(member_no) > 3) as j
WHERE a.member_no = j.adult_member_no;
