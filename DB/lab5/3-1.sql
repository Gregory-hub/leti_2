SELECT member.member_no, member.lastname
FROM member
JOIN
(SELECT loanhist.member_no, SUM(loanhist.fine_assessed) AS fine_sum
FROM loanhist
GROUP BY loanhist.member_no) l 
ON l.member_no = member.member_no
WHERE l.fine_sum > 5;
