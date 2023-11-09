SELECT adult_member_no, COUNT(member_no) AS No_Of_Children
FROM juvenile
GROUP BY adult_member_no
HAVING COUNT(member_no) > 3;