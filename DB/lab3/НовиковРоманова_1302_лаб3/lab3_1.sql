SELECT CONCAT(firstname, ' ', middleinitial, ' ', lastname) as name, street, city, state, zip
FROM member
JOIN adult ON member.member_no=adult.member_no;