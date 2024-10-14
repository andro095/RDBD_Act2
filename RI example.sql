USE RI
GO

CREATE TABLE [dbo].[tblDepartment](
	[ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[DepartmentName] [varchar](50) NULL);

select * from [dbo].[tblDepartment];

 
CREATE TABLE [dbo].[tblEmployee](
	[EmpID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[FirstName] [nvarchar](255) NULL,
	[LastName] [nvarchar](255) NULL,
	[Education] [nvarchar](255) NULL,
	[YearlyIncome] [float] NULL,
	[Sales] [float] NULL,
	[DeptID] [int] NULL CONSTRAINT [DF_tblEmployee_DeptID] DEFAULT (2),
	CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID] FOREIGN KEY([DeptID])
		REFERENCES [dbo].[tblDepartment] ([ID]));
GO

select * from [dbo].[tblEmployee];

SET IDENTITY_INSERT tblDepartment ON;
INSERT INTO tblDepartment(ID, DepartmentName) VALUES(1, N'Software Developer');
INSERT INTO tblDepartment(ID, DepartmentName) VALUES(2, N'Sr. Software Developer');
INSERT INTO tblDepartment(ID, DepartmentName) VALUES(3, N'Module Lead');
INSERT INTO tblDepartment(ID, DepartmentName) VALUES(4, N'Team Lead');
INSERT INTO tblDepartment(ID, DepartmentName) VALUES(5, N'Project Manager');
INSERT INTO tblDepartment(ID, DepartmentName) VALUES(6, N'Manager');
INSERT INTO tblDepartment(ID, DepartmentName) VALUES(7, N'CEO');
INSERT INTO tblDepartment(ID, DepartmentName) VALUES(8, N'HR');
INSERT INTO tblDepartment(ID, DepartmentName) VALUES(9, NULL);
SET IDENTITY_INSERT tblDepartment OFF;

select * from [dbo].[tblDepartment];


SET IDENTITY_INSERT tblEmployee ON;
INSERT INTO tblEmployee(EmpID, FirstName, LastName, Education, YearlyIncome, Sales, DeptID) VALUES(1, N'John', N'Yang', N'Bachelors', 90000, 3578.27, 1);
INSERT INTO tblEmployee(EmpID, FirstName, LastName, Education, YearlyIncome, Sales, DeptID) VALUES(2, N'Trevor', N'Gate', N'Masters', 80000, 3399.99, 6);
INSERT INTO tblEmployee(EmpID, FirstName, LastName, Education, YearlyIncome, Sales, DeptID) VALUES(3, N'Ruben', N'Tomes', N'Partial College', 50000, 69909.82, 2);
INSERT INTO tblEmployee(EmpID, FirstName, LastName, Education, YearlyIncome, Sales, DeptID) VALUES(4, N'Christy', N'Zhu', N'Bachelors', 80000, 3078.27, 2);
INSERT INTO tblEmployee(EmpID, FirstName, LastName, Education, YearlyIncome, Sales, DeptID) VALUES(5, N'Rob', N'Huang', N'High School', 60000, 2319.99, 8);
INSERT INTO tblEmployee(EmpID, FirstName, LastName, Education, YearlyIncome, Sales, DeptID) VALUES(6, N'John', N'Yang', N'Bachelors', 70000, 539.99, 2);
INSERT INTO tblEmployee(EmpID, FirstName, LastName, Education, YearlyIncome, Sales, DeptID) VALUES(7, N'Sarah', N'Trem', N'Masters', 120000, 2320.49, 7);
INSERT INTO tblEmployee(EmpID, FirstName, LastName, Education, YearlyIncome, Sales, DeptID) VALUES(8, N'Chris', N'Meta', N'Bachelors', 50000, 24.99, 5);
INSERT INTO tblEmployee(EmpID, FirstName, LastName, Education, YearlyIncome, Sales, DeptID) VALUES(9, N'Rob', N'Verhoff', N'Partial High School', 24.99, 3578.27, 6);
INSERT INTO tblEmployee(EmpID, FirstName, LastName, Education, YearlyIncome, Sales, DeptID) VALUES(10, N'Christy', N'Carlson', N'Partial High School', 70000, 2234.99, 3);
INSERT INTO tblEmployee(EmpID, FirstName, LastName, Education, YearlyIncome, Sales, DeptID) VALUES(11, N'Gail', N'Eric', N'Education', 90000, 4319.99, 3);
INSERT INTO tblEmployee(EmpID, FirstName, LastName, Education, YearlyIncome, Sales, DeptID) VALUES(12, N'Barry', N'Johnson', N'Education', 80000, 4968.59, 4);
INSERT INTO tblEmployee(EmpID, FirstName, LastName, Education, YearlyIncome, Sales, DeptID) VALUES(13, N'Peter', N'Krebs', N'Graduate Degree', 50000, 59.53, 1);
INSERT INTO tblEmployee(EmpID, FirstName, LastName, Education, YearlyIncome, Sales, DeptID) VALUES(14, N'Greg', N'Ander', N'Partial High School', 45000, 23.50, NULL);
INSERT INTO tblEmployee(EmpID, FirstName, LastName, Education, YearlyIncome, Sales, DeptID) VALUES(15, N'John', N'Miller', N'Masters', 80000, 2320.49, 8);
SET IDENTITY_INSERT tblEmployee OFF;

select * from [dbo].[tblEmployee];


SELECT 
    C2.TABLE_NAME [PARENT],
	C.TABLE_NAME [CHILD],
	KCU2.COLUMN_NAME [PARENT_FIELD],
	KCU.COLUMN_NAME [CHILD_FIELD],
	C.CONSTRAINT_NAME [constraint_name], 
    RC.DELETE_RULE [DELETE RI], 
   RC.UPDATE_RULE [UPDATE RI]
FROM   INFORMATION_SCHEMA.TABLE_CONSTRAINTS C 
       INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU 
         ON C.CONSTRAINT_SCHEMA = KCU.CONSTRAINT_SCHEMA 
            AND C.CONSTRAINT_NAME = KCU.CONSTRAINT_NAME 
       INNER JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS RC 
         ON C.CONSTRAINT_SCHEMA = RC.CONSTRAINT_SCHEMA 
            AND C.CONSTRAINT_NAME = RC.CONSTRAINT_NAME 
       INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS C2 
         ON RC.UNIQUE_CONSTRAINT_SCHEMA = C2.CONSTRAINT_SCHEMA 
            AND RC.UNIQUE_CONSTRAINT_NAME = C2.CONSTRAINT_NAME 
       INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KCU2 
         ON C2.CONSTRAINT_SCHEMA = KCU2.CONSTRAINT_SCHEMA 
            AND C2.CONSTRAINT_NAME = KCU2.CONSTRAINT_NAME 
            AND KCU.ORDINAL_POSITION = KCU2.ORDINAL_POSITION 
WHERE  C.CONSTRAINT_TYPE = 'FOREIGN KEY'
ORDER BY C2.TABLE_NAME


SELECT	OBJECT_NAME(referenced_object_id) AS [PARENT],
		COUNT (OBJECT_NAME(referenced_object_id)) AS [HOW MANY CHILDREN] 
FROM sys.foreign_key_columns
GROUP BY OBJECT_NAME(referenced_object_id)
ORDER BY COUNT (OBJECT_NAME(referenced_object_id)) DESC








DELETE FROM [tblDepartment] WHERE ID = 1;
UPDATE [tblDepartment] SET ID = 99 WHERE ID = 1;

-- We use the DROP Constraint statement along with the ALTER TABLE Statement to delete the existing Foreign key constraint

ALTER TABLE [dbo].[tblEmployee] DROP CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID];

select * from [dbo].[tblDepartment];
select * from [dbo].[tblEmployee];


-- NO ACTION RI Rule (EXPLICIT)

ALTER TABLE [dbo].[tblEmployee]  
ADD CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID] FOREIGN KEY([DeptID])
        REFERENCES [dbo].[tblDepartment] ([ID])
        ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Lets attempt deleting a raw from the Parent Table.

DELETE FROM [tblDepartment] WHERE ID = 1;

ALTER TABLE [dbo].[tblEmployee] DROP CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID];

select * from [dbo].[tblDepartment];
select * from [dbo].[tblEmployee];

--SET DEFAULT RI Rule

-- We will add back the Foreign key constraint with SET DEFAULT referential Integrity.
-- It means, whenever we perform DELETE, or UPDATE on the Parent table,
-- then the default value will be loaded in the Dept Id column (tblEmployee).


ALTER TABLE [dbo].[tblEmployee]  
ADD CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID] FOREIGN KEY([DeptID])
        REFERENCES [dbo].[tblDepartment] ([ID])
        ON UPDATE SET DEFAULT ON DELETE SET DEFAULT;

DELETE FROM [tblDepartment] WHERE ID = 6;

select * from [dbo].[tblDepartment];
select * from [dbo].[tblEmployee];

--SET NULL RI Rule

ALTER TABLE [dbo].[tblEmployee] DROP CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID];

select * from [dbo].[tblDepartment];
select * from [dbo].[tblEmployee];

ALTER TABLE [dbo].[tblEmployee]  
ADD CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID] FOREIGN KEY([DeptID])
        REFERENCES [dbo].[tblDepartment] ([ID])
        ON UPDATE SET NULL ON DELETE SET NULL;

select * from [dbo].[tblDepartment];
select * from [dbo].[tblEmployee];

DELETE FROM [tblDepartment] WHERE ID = 2;

select * from [dbo].[tblDepartment];
select * from [dbo].[tblEmployee];

-- CASCADING RI Rules

ALTER TABLE [dbo].[tblEmployee] DROP CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID];

ALTER TABLE [dbo].[tblEmployee]  
ADD CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID] FOREIGN KEY([DeptID])
        REFERENCES [dbo].[tblDepartment] ([ID])
        ON UPDATE CASCADE ON DELETE CASCADE;

select * from [dbo].[tblDepartment];
select * from [dbo].[tblEmployee];

DELETE FROM [tblDepartment] WHERE ID = 5;

--DROP TABLE with regard to RI Rules

DROP TABLE [tblEmployee];

select * from [dbo].[tblDepartment];
select * from [dbo].[tblEmployee];


