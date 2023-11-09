SELECT mb.member_no, CONCAT(mb.lastname, ' ', mb.firstname, ' ', mb.middleinitial) as name, 
rs.isbn, CONVERT(char(8), rs.log_date, 1) as date
FROM reservation rs
FULL OUTER JOIN member mb ON mb.member_no=rs.member_no
WHERE mb.member_no = 250 OR mb.member_no = 341 OR mb.member_no = 1675
ORDER BY mb.member_no ASC;
