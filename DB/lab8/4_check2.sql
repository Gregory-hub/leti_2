DECLARE @StartDate datetime, @EndDate datetime
SET @StartDate = GetDate()
SET @EndDate = DateAdd(month, 1, @StartDate)
DECLARE @NewId int, @ReturnValue int

EXEC @ReturnValue = Sales.AddDiscount
'Half price off everything',
-0.5, --UNACCEPTABLE VALUE
'Seasonal Discount',
'Customer1',
@StartDate,
@EndDate,
0,
20,
@NewID OUTPUT
IF (@ReturnValue = 0)
SELECT @NewID
ELSE
SELECT TOP 1 * FROM dbo.ErrorLog ORDER BY ErrorTime DESC
