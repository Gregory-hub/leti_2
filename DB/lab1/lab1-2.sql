SELECT DISTINCT city, state FROM adult;
SELECT DISTINCT title_no, title FROM title ORDER BY title;
--SELECT member_no, isbn, fine_assessed FROM loanhist WHERE fine_assessed IS NOT NULL;
--SELECT member_no, isbn, fine_assessed, fine_assessed * 2 as 'double fine' FROM loanhist WHERE fine_assessed IS NOT NULL;
--SELECT firstname + ' ' + middleinitial + ' ' + lastname as [email_name] FROM member WHERE lastname = 'Anderson';
--SELECT LOWER(firstname + ' ' + middleinitial + ' ' + SUBSTRING(lastname, 1, 2)) as [email_name] FROM member WHERE lastname = 'Anderson';
--SELECT 'The title is ' + title + ', title number ' + CONVERT(varchar, title_no) FROM title;