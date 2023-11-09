USE AdventureWorks
GO
CREATE PROC Sales.AddDiscount
	@Description nvarchar(255),
	@DiscountPct smallmoney,
	@Type nvarchar(50),
	@Category nvarchar(50),
	@StartDate Datetime,
	@EndDate Datetime,
	@MinQty int,
	@MaxQty int,
	@NewProductID int OUTPUT
AS
BEGIN TRY
	BEGIN
		INSERT INTO Sales.SpecialOffer 
		(Description, DiscountPct, Type, Category, StartDate, EndDate, MinQty, MaxQty, ModifiedDate)
		VALUES
		(@Description, @DiscountPct, @Type, @Category, @StartDate, @EndDate, @MinQty, @MaxQty, GETDATE());

		SET @NewProductID = SCOPE_IDENTITY();
	END
END TRY
BEGIN CATCH
	SET @NewProductID = -1;
	INSERT INTO dbo.ErrorLog 
	(ErrorTime, UserName, ErrorNumber, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorMessage)
	VALUES
	(GETDATE(), USER_NAME(), ERROR_NUMBER(), ERROR_SEVERITY(), ERROR_STATE(), ERROR_PROCEDURE(), ERROR_LINE(), ERROR_MESSAGE());
END CATCH
