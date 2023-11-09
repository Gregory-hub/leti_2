SELECT ad.member_no, COUNT(CASE jv.adult_member_no WHEN ad.member_no THEN 1 ELSE NULL END) AS numkids 
FROM adult ad, juvenile jv
WHERE state = 'CA'
GROUP BY ad.member_no
HAVING COUNT(CASE jv.adult_member_no WHEN ad.member_no THEN 1 ELSE NULL END) > 3;
