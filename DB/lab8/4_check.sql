DECLARE @StartDate datetime, @EndDate datetime
SET @StartDate = GetDate()
SET @EndDate = DateAdd(month, 1, @StartDate)
DECLARE @NewId int

EXEC Sales.AddDiscount
'Half price off everything',
0.5,
'Seasonal Discount',
'Customer',
@StartDate,
@EndDate,
0,
20,
@NewID OUTPUT
SELECT @NewID

SELECT * FROM Sales.SpecialOffer
