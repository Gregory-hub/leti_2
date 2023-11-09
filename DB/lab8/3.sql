USE AdventureWorks;
GO
CREATE PROCEDURE Sales.GetDiscountsForCategoryAndDate
	@Category nvarchar(50),
	@DateToCheck datetime = NULL
AS
BEGIN
	IF @DateToCheck IS NULL
	BEGIN
		SET @DateToCheck = GETDATE();
	END

	SELECT Description, DiscountPct, Type, Category, StartDate, EndDate, MinQty, MaxQty
	FROM Sales.SpecialOffer
	WHERE Category = @Category AND @DateToCheck BETWEEN StartDate AND EndDate
	ORDER BY StartDate, EndDate;
END
