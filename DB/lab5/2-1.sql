SELECT DISTINCT m.member_no, m.firstname, m.lastname, l.isbn, l.fine_paid, s.max_fine_paid
FROM member m
INNER JOIN loanhist l ON m.member_no = l.member_no,
(SELECT MAX(l.fine_paid) AS max_fine_paid FROM loanhist l) AS s
WHERE l.fine_paid = s.max_fine_paid;
