USE AdventureWorks
GO
CREATE UNIQUE CLUSTERED	INDEX IX_vEmployeeDetails
ON HumanResources.vEmployeeDetails (EmployeeID);
