SELECT DISTINCT t.title_no, t.title, r.isbn, COUNT(r.isbn) AS total_reserved
FROM loan l
INNER JOIN title t ON l.title_no = t.title_no
INNER JOIN reservation r ON r.isbn = l.isbn
WHERE r.isbn IN (SELECT isbn FROM reservation GROUP BY isbn HAVING COUNT(isbn) > 50)
GROUP BY t.title_no, t.title, r.isbn
HAVING COUNT(r.isbn) < 5;
