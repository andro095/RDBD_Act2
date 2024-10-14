-- DROP SCHEMA dbo;

CREATE SCHEMA dbo;
-- NF.dbo.Customer definition

-- Drop table

-- DROP TABLE NF.dbo.Customer;

CREATE TABLE NF.dbo.Customer (
	CustomerID int NOT NULL,
	CustomerPhoneNo varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CountryCode varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CustomerEmail varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	RepeatCustomer bit NULL,
	CustomerName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Customer__A4AE64B8EB1C3691 PRIMARY KEY (CustomerID)
);

-- NF.dbo.Product definition

-- Drop table

-- DROP TABLE NF.dbo.Product;

CREATE TABLE NF.dbo.Product (
	ProductID int NOT NULL,
	ProductDescription varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ProductTags varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT 'No Tags' NULL,
	CONSTRAINT PK__Products__B40CC6EDDF139695 PRIMARY KEY (ProductID)
);


-- NF.dbo.PromoCode definition

-- Drop table

-- DROP TABLE NF.dbo.PromoCode;

CREATE TABLE NF.dbo.PromoCode (
	PromoCode int IDENTITY(1,1) NOT NULL,
	DiscountAppliedPC int NULL,
	CONSTRAINT PromoCode_PK PRIMARY KEY (PromoCode)
);


-- NF.dbo.Sale definition

-- Drop table

-- DROP TABLE NF.dbo.Sale;

CREATE TABLE NF.dbo.Sale (
	SaleID int NOT NULL,
	SaleDate datetime NOT NULL,
	TotalSalePrice decimal(18,0) NULL,
	CONSTRAINT PK__Sales__1EE3C41F157FC471 PRIMARY KEY (SaleID)
);


-- NF.dbo.CustomerAddress definition

-- Drop table

-- DROP TABLE NF.dbo.CustomerAddress;

CREATE TABLE NF.dbo.CustomerAddress (
	CustomerID int NULL,
	CustomerAddress varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT FK_CustomerAddressID FOREIGN KEY (CustomerID) REFERENCES NF.dbo.Customer(CustomerID)
);


-- NF.dbo.DiscountApplied definition

-- Drop table

-- DROP TABLE NF.dbo.DiscountApplied;

CREATE TABLE NF.dbo.DiscountApplied (
	PromoCode int NULL,
	DiscountApplied int NULL,
	CONSTRAINT FK_PromoCode FOREIGN KEY (PromoCode) REFERENCES NF.dbo.PromoCode(PromoCode)
);


-- NF.dbo.[Order] definition

-- Drop table

-- DROP TABLE NF.dbo.[Order];

CREATE TABLE NF.dbo.[Order] (
	OrderID int NOT NULL,
	OrderDate int NULL,
	CustomerId int NULL,
	CompanyName varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK__Orders__C3905BAF1E4BF0C1 PRIMARY KEY (OrderID),
	CONSTRAINT FK_CustomerID FOREIGN KEY (CustomerId) REFERENCES NF.dbo.Customer(CustomerID)
);


-- NF.dbo.OrderDetails definition

-- Drop table

-- DROP TABLE NF.dbo.OrderDetails;

CREATE TABLE NF.dbo.OrderDetails (
	OrderDetailID int IDENTITY(1,1) NOT NULL,
	ParentOrderNo varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ProductID int NULL,
	ProductQuantity int NULL,
	ProductPrice decimal(18,0) NULL,
	OrderId int NULL,
	CONSTRAINT PK__OrderDet__D3B9D30CD62AA225 PRIMARY KEY (OrderDetailID),
	CONSTRAINT FK_OrderID FOREIGN KEY (OrderId) REFERENCES NF.dbo.[Order](OrderID),
	CONSTRAINT FK_ProductID FOREIGN KEY (ProductID) REFERENCES NF.dbo.Product(ProductID)
);