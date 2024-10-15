CREATE DATABASE Amalgamated;
GO

USE Amalgamated;
GO

CREATE SCHEMA HR AUTHORIZATION dbo;
GO
CREATE SCHEMA Production AUTHORIZATION dbo;
GO
CREATE SCHEMA Sales AUTHORIZATION dbo;
GO


-- Creating Customer Table
CREATE TABLE Sales.Customer (
    CustomerID INT NOT NULL,
	CustomerName VARCHAR(100),
	CustomerEmail VARCHAR(255) NOT NULL,
    RepeatCustomer BIT,
    CONSTRAINT PK_Customer PRIMARY KEY (CustomerID)
);

-- Creating Customer Details Table
CREATE TABLE Sales.Customer_Details (
	Customer_DetailsID INT NOT NULL,
	CustomerID INT,
	CustomerPhoneNo VARCHAR(10),
	CustomerAddress VARCHAR(255) NOT NULL,
	CustomerCity VARCHAR(50) NOT NULL,
	CustomerCountry VARCHAR(100) NOT NULL,
    CustomerPostalCode VARCHAR(5),
	CONSTRAINT PK_Customer_Details PRIMARY KEY (Customer_DetailsID),
	CONSTRAINT FK_Customer_Details FOREIGN KEY (CustomerID) REFERENCES Sales.Customer(CustomerID),
)

-- Creating Employee Table
CREATE TABLE HR.Employee (
    EmployeeID INT NOT NULL,
	FirstName VARCHAR(10) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
	EmployeeEmail VARCHAR(255) NOT NULL,
	EmployeePhoneNo VARCHAR(10),
	EmployeeAddress VARCHAR(255) NOT NULL,
	EmployeeCity VARCHAR(50) NOT NULL,
	EmployeeCountry VARCHAR(100) NOT NULL,
    EmployeePostalCode VARCHAR(5),
    Title VARCHAR(30),
    HireDate DATE,
    Phone NVARCHAR(24),
    CONSTRAINT PK_Employee PRIMARY KEY (EmployeeID)
);

-- Creating Supplier Table
CREATE TABLE Production.Supplier (
    SupplierID INT NOT NULL,
    CompanyName VARCHAR(100),
    ContactPhone VARCHAR(24),
	CompanyAddress VARCHAR(500),
	CompanyCity VARCHAR(50),
	CompanyCountry VARCHAR(50),
	CompanyPostalCode VARCHAR(50),
    CONSTRAINT PK_Supplier PRIMARY KEY (SupplierID)
);


-- Creating Shipper Table
CREATE TABLE Sales.Shipper (
    ShipperID INT NOT NULL,
    ShipperName VARCHAR(100),
    ShipperPhone VARCHAR(24),
	ShipperAddress VARCHAR(500),
	ShipperCity VARCHAR(50),
	ShipperCountry VARCHAR(50),
	ShipperPostalCode VARCHAR(50),
    CONSTRAINT PK_Shipper PRIMARY KEY (ShipperID)
);


-- Creating Product Categories Table
CREATE TABLE Product_Categories (
    CategoryID INT NOT NULL,
	CategoryName VARCHAR(100) NOT NULL,
    CategoryDescription VARCHAR(255),
    CONSTRAINT PK_Product_Categories PRIMARY KEY (CategoryID),
);

-- Creating Products Table
CREATE TABLE Product (
    ProductID INT,
	ProductName VARCHAR(100) NOT NULL,
	Product_Unit_Price FLOAT NOT NULL,
	Product_Selling_Price FLOAT NOT NULL,
    ProductDescription VARCHAR(255),
    ProductTags VARCHAR(50) DEFAULT 'No Tags',
	discontinued BIT DEFAULT 0 NULL, 
    SupplierID INT,
	CategoryID INT,
    CONSTRAINT PK_Product PRIMARY KEY (ProductID),
    CONSTRAINT FK_Product_Supplier FOREIGN KEY (SupplierID) REFERENCES Production.Supplier(SupplierID),
	CONSTRAINT FK_Product_Category FOREIGN KEY (CategoryID) REFERENCES Product_Categories(CategoryID)
);

-- Creating Production Order Table
CREATE TABLE Production.[Order] (
    OrderID INT NOT NULL,   
    EmployeeID INT,
    OrderDate DATE,
    SupplierID INT,
    CONSTRAINT PK_Order PRIMARY KEY (OrderID),
    CONSTRAINT FK_Order_Employee FOREIGN KEY (EmployeeID) REFERENCES HR.Employee(EmployeeID),
    CONSTRAINT FK_Order_Shipper FOREIGN KEY (SupplierID) REFERENCES Production.Supplier(SupplierID)
);

-- Creating Production Order Details Table
CREATE TABLE Production.Order_Details (
	Product_Order_DetailsID INT NOT NULL,
	OrderID INT,
	ProductID INT,   
    Unitprice INT NOT NULL,
    Product_Quantity INT NOT NULL,
	discount FLOAT,
	ShippingDate DATE,
	ShippingAddress VARCHAR(500),
	ShippingCity VARCHAR(50),
	ShippingCountry VARCHAR(50),
	ShippingPostalCode VARCHAR(50),
    CONSTRAINT PK_Product_Order_Details PRIMARY KEY (Product_Order_DetailsID),
    CONSTRAINT FK_Order_product FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT FK_Product_Order FOREIGN KEY (OrderID) REFERENCES Production.[Order](OrderID),
);


-- Creating Sales Order Table
CREATE TABLE Sales.[Order] (
    OrderID INT NOT NULL,   
    CustomerID INT,
    OrderDate DATE,
	ShipperID INT,
	ShippingDate DATE,
    CONSTRAINT PK_Order PRIMARY KEY (OrderID),
    CONSTRAINT FK_Order_Customer FOREIGN KEY (CustomerID) REFERENCES Sales.Customer(CustomerID),
    CONSTRAINT FK_Order_Shipper FOREIGN KEY (ShipperID) REFERENCES Sales.Shipper(ShipperID)
);


-- Creating Sales Order Details Table
CREATE TABLE Sales.Order_Details (
	Sales_Order_DetailsID INT NOT NULL,
	OrderID INT,
	ProductID INT,
    Product_Quantity INT NOT NULL,
	discount FLOAT,
    CONSTRAINT PK_Product_Order_Details PRIMARY KEY (Sales_Order_DetailsID),
	CONSTRAINT FK_Sales_Order FOREIGN KEY (OrderID) REFERENCES Sales.[Order](OrderID),
    CONSTRAINT FK_Order_product FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    
);


-- Creating PromoCode for Customer Table
CREATE TABLE PromoCode (
    PromoCodeID INT NOT NULL,
	CustomerID INT,
    CodeDescription VARCHAR(255),
    CONSTRAINT PK_PromoCode PRIMARY KEY (PromoCodeID),
	CONSTRAINT FK_PromoCode_Customer FOREIGN KEY (CustomerID) REFERENCES Sales.Customer(CustomerID)
);


-- Creating Discount on Products Table
CREATE TABLE DiscountApplied (
    DiscountID INT NOT NULL,
	ProductID INT,
    Discount_Amount DECIMAL(10, 2),
    CONSTRAINT PK_DiscountApplied PRIMARY KEY (DiscountID),
    CONSTRAINT FK_Product_Discount FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

INSERT HR.Employee (EmployeeID, lastname, firstname, title, hiredate, EmployeeAddress, EmployeeCity, EmployeePostalCode, EmployeeCountry, phone, EmployeeEmail, EmployeePhoneNo)VALUES
(1, N'Davis', N'sara', N'CEO', CAST(N'2018-09-21 00:00:00.000' AS DateTime), N'212 - 29th ave', N'seatle', N'231', N'USA', N'(122) 212 2121', 'example@gmail.com', '1234567890'),

(2, N'John', N'deo', N'manger', CAST(N'2018-09-21 00:00:00.000' AS DateTime), N'506 - 206 lester', N'waterloo', N'231', N'USA', N'(226) 565 8295', 'example@gmail.com', '1234567890'),

(3, N'Wyatt', N'Abreu', N'Certified financial planner', N'2018-06-02 00:00:00', N'788-65 Westmount', N'WA', N'N2l', N'CA', N'(226) 784 9865', 'example@gmail.com', '1234567890'),

(4, N'Steve', N'Arai', N'Chartered wealth manager', N'2017-07-05 00:00:00', N'23847 36A Ave Langley BC', N'WA', N'V2Z', N'CA', N'(604) 533-2340', 'example@gmail.com', '1234567890'),

(5, N'Elenora', N'Smiley', N'Service desk analyst.', N'2015-06-05 00:00:00', N'43 Connor Lane Guelph ON', N'WA', N'N1E', N'CA', N'(519) 824-2661', 'example@gmail.com', '1234567890'),

(6, N'Kenisha', N'Yeung', N'Chartered wealth manager', N'2012-11-25 00:00:00', N'32-441 Weber', N'WA', N'N6g', N'CA', N'(226) 484 6532', 'example@gmail.com', '1234567890'),
(7, N'Nikia', N'Curtin', N'Network administrator', N'2010-06-09 00:00:00', N'39 Dobbin Lane Kanata ON', N'WA', N'K2M', N'CA', N'(613) 591-0347', 'example@gmail.com', '1234567890'),
(8, N'Shaunte', N'Romaine', N'Network engineer', N'2013-07-08 00:00:00', N'733 Skene Rd Gilmour ON', N'WA', N'K0L', N'CA', N'(613) 474-1027', 'example@gmail.com', '1234567890'),
(9, N'Quinn', N'Moorehead', N'Network architect', N'2014-08-05 00:00:00', N'1470 Pennyfarthing Dr 203 Vancouver BC', N'WA', N'V6J', N'CA', N'(604) 736-2823', 'example@gmail.com', '1234567890'),
(10, N'Idell', N'Muck', N'Network manager', N'2014-09-09 00:00:00', N'452-2750 Fairlane St , Abbotsford, BC', N'WA', N'V2S', N'CA', N'604-870-9982', 'example@gmail.com', '1234567890');

INSERT INTO Sales.Customer(CustomerID, CustomerName, CustomerEmail, RepeatCustomer)
VALUES
(1, N'360Networks Inc.', 'example@gmail.com', 1),
(2, N'3DLabs Inc. Ltd.', 'example@gmail.com', 1),
(3, N'724 Solutions Inc.', 'example@gmail.com', 1),
(4, N'Acme Corporation', 'example@gmail.com', 1),
(5, N'Globex Corporation', 'example@gmail.com', 1),
(6, N'Soylent Corp', 'example@gmail.com', 1),
(7, N'Initech', 'example@gmail.com', 1),
(8, N'Umbrella Corporation', 'example@gmail.com', 1),
(9, N'Hooli', 'example@gmail.com', 1),
(10, N'Massive Dynamic', 'example@gmail.com', 1);

insert into Sales.Customer_Details(customerid, customeraddress, customercity, customerpostalcode, customercountry, customerphoneno, Customer_DetailsID)
values
(1, N'506-201 lester', N'WA', N'N2l', N'CA', N'(226) 565', 1),
(2, N'456-84 King St', N'WA', N'N2l',N'CA', N'(226) 784', 2),
(3, N'52-489 Albert St', N'WA', N'N6g',N'CA', N'(226) 852', 3),
(4, N'7307 Prasmount Pl', N'BC', N'V0M',N'CA', N'604-796', 4),
(5, N'1145 Dakota St 209', N'MB', N'N6g',N'CA', N'(204) 949', 5),
(6, N'68 Baycrest Pl SW 5', N'AB', N'T2V',N'CA', N'(403) 244', 6),
(7, N'PO Box 206', N'AB ', N'T0C',N'CA', N'780-696', 7),
(8, N'513A Deer St', N'AB', N'T1L',N'CA', N'403-762', 8),
(9, N'2-119 4 Ave W', N'AB', N'T0K',N'CA', N'403-545', 9),
(10, N'42 Rue Bourbonnais', N'QC', N'J0P',N'CA', N'450-308', 10);




