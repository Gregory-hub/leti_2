SELECT DISTINCT t.title_no, t.title, r.isbn, r.total_reserved AS "Total Reserved"
FROM loan l
INNER JOIN title t ON l.title_no = t.title_no
INNER JOIN
(SELECT isbn, COUNT(isbn) AS total_reserved
FROM reservation
GROUP BY isbn
HAVING COUNT(isbn) < 5 OR COUNT(isbn) > 50) r ON l.isbn = r.isbn;
