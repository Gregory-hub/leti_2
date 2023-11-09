SELECT j.adult_member_no, COUNT(j.adult_member_no) AS No_Of_Children, a.expr_date
FROM juvenile j
INNER JOIN adult a ON j.adult_member_no = a.member_no
GROUP BY j.adult_member_no, a.expr_date
HAVING COUNT(j.adult_member_no) > 3;
