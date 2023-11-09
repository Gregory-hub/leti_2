SELECT DISTINCT m.firstname, m.lastname, l.isbn, l.fine_paid
FROM member m
FULL JOIN loanhist l ON m.member_no = l.member_no
WHERE l.fine_paid IN 
(SELECT l.fine_paid
FROM loanhist l,
(SELECT MAX(l.fine_paid) AS max_fine_paid FROM loanhist l) AS s
WHERE l.fine_paid = s.max_fine_paid);
