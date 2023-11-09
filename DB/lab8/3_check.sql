DECLARE @DateToCheck datetime

--SET @DateToCheck = DATEADD(month, 1, GETDATE()); 
SET @DateToCheck = '2003-06-12 16:30:00';

EXECUTE Sales.GetDiscountsForCategoryAndDate 'Reseller', @DateToCheck;
