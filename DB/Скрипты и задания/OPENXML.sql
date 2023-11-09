USE AdventureWorks
GO

DECLARE @doc xml
SET @doc = '<?xml version="1.0" ?>
			<SalesOrder CustomerID="18759" OrderDate= "2006-01-01T00:00:00" DueDate="2006-02-02T00:00:00" AccountNumber="10-4030-018759" ContactID="4189" BillToAddressID="14024" ShipToAddressID="14024" ShipMethodID="1" SubTotal="174.20" TaxAmt="10"> 
				<Item>
					<ProductID>714</ProductID> 
					<OrderQty>5</OrderQty> 
					<UnitPrice>28.84</UnitPrice> 
				</Item>
				<Item>
					<ProductID>715</ProductID> 
					<OrderQty>1</OrderQty> 
					<UnitPrice>30</UnitPrice> 
				</Item>
			</SalesOrder>'

DECLARE @docHandle int

-- Call stored procedure to create the memory tree

INSERT [Sales].[SalesOrderHeader] 
	([CustomerID], [OrderDate], [DueDate], [AccountNumber], [ContactID], [BillToAddressID],
	 [ShipToAddressID], [ShipMethodID], [SubTotal], [TaxAmt])
SELECT * FROM
-- Add OPENXML function for SalesOrderHeader table INSERT


DECLARE @result int
-- Get the identity of the SalesOrderHeader INSERT for use in the SalesOrderDetail INSERT
SET @result = SCOPE_IDENTITY()

INSERT INTO [Sales].[SalesOrderDetail]
			([SalesOrderID], [OrderQty], [ProductID], [SpecialOfferID], [UnitPrice])
SELECT @result, [OrderQty], [ProductID], 1, [UnitPrice] FROM
-- Add OPENXML function for SalesOrderDetail table INSERT

-- Call stored procedure to clean up memory tree

select * from [Sales].[SalesOrderHeader] where salesorderid = @result
select * from [Sales].[SalesOrderDetail] where salesorderid = @result


GO
