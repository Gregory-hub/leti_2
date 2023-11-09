SELECT cp.isbn AS copy_isbn, it.isbn AS item_isbn, 
copy_no, on_loan, title, translation, cover
FROM copy cp
INNER JOIN title tl ON tl.title_no=cp.isbn
INNER JOIN item it ON it.isbn=cp.isbn
WHERE cp.isbn = 1 OR cp.isbn = 500 OR cp.isbn = 1000
ORDER BY cp.isbn ASC;
