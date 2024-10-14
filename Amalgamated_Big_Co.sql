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