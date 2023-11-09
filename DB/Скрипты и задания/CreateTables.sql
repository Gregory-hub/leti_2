USE AW_Marketing
GO

-- ������� ������� ���� ��� ��� ����������
IF EXISTS (SELECT * FROM sys.tables t
           JOIN sys.schemas s ON t.schema_id = s.schema_id
           WHERE t.[Name] = 'SpecialOffers'
           AND s.[Name] = 'Promotions')
 DROP TABLE Promotions.SpecialOffers

IF EXISTS (SELECT * FROM sys.tables t
           JOIN sys.schemas s ON t.schema_id = s.schema_id
           WHERE t.[Name] = 'SpecialOffers'
           AND s.[Name] = 'PastPromotions')
 DROP TABLE PastPromotions.SpecialOffers
GO


-- ������� ������� ��� ����������� �����������. �� ������� filegroup
CREATE TABLE Promotions.SpecialOffers
(OfferID int IDENTITY PRIMARY KEY,
 Description nvarchar(200),
 StartDate datetime,
 EndDate datetime, 
 DiscountPercent decimal)

-- ������� ������� ��� �������� ����������� �� ArchivedData filegroup 
CREATE TABLE PastPromotions.SpecialOffers
(OfferID int IDENTITY PRIMARY KEY,
 Description nvarchar(200),
 StartDate datetime,
 EndDate datetime, 
 DiscountPercent decimal)
ON ArchivedData