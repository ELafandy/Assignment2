USE CompanyDB;
GO

CREATE SCHEMA M;
GO

CREATE TABLE  M.Department (
    DNum INT PRIMARY KEY,
    DName VARCHAR(50) NOT NULL UNIQUE,
    Location VARCHAR(50) NOT NULL
);

CREATE TABLE M.Employee (
    SSN INT PRIMARY KEY,
    LName TEXT NOT NULL,
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female')) DEFAULT 'MALE',
    BirthDate DATE DEFAULT GETDATE(),
    SuperViserSSN INT NULL,
    EMAIL TEXT ,
    DNum INT,
    FOREIGN KEY (SuperViserSSN) REFERENCES M.Employee(SSN)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
);

CREATE TABLE M.Dependent (
    SSN INT,
    DName VARCHAR(50) UNIQUE,
    Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female')),
    BirthDate DATE DEFAULT GETDATE(),
    PRIMARY KEY (SSN, DName),
    FOREIGN KEY (SSN) REFERENCES M.Employee(SSN)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE M.Project (
    PNum INT PRIMARY KEY,
    PName VARCHAR(50) UNIQUE,
    City VARCHAR(50) NOT NULL,
    DNum INT,
    FOREIGN KEY (DNum) REFERENCES M.Department(DNum)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

CREATE TABLE M.EmployeeProject (
    SSN INT,
    PNum INT,
    WorkHours INT,
    PRIMARY KEY (SSN, PNum),
    FOREIGN KEY (SSN) REFERENCES M.Employee(SSN)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
    FOREIGN KEY (PNum) REFERENCES M.Project(PNum)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);

CREATE TABLE M.DepartmentManager (
    DNum INT,
    SSN INT,
    HiringDate DATE,
    PRIMARY KEY (DNum, SSN),
    FOREIGN KEY (DNum) REFERENCES M.Department(DNum)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    FOREIGN KEY (SSN) REFERENCES M.Employee(SSN)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);

ALTER TABLE M.Employee ADD FName TEXT NOT NULL;

ALTER TABLE M.Employee ALTER COLUMN LName VARCHAR(50);

ALTER TABLE M.Employee DROP COLUMN EMAIL;

ALTER TABLE M.Employee
ADD CONSTRAINT FK_EMPLOYEE_DEPARTMENT
  FOREIGN KEY (DNum) REFERENCES M.Department(DNum)
    ON DELETE SET NULL
    ON UPDATE CASCADE ;

INSERT INTO M.Department (DNum, DName, Location) VALUES
(1, 'IT', 'Cairo'),
(2, 'HR', 'Alex'),
(3, 'Finance', 'Giza');

INSERT INTO M.Employee (SSN, LName, Gender, BirthDate, SuperViserSSN, DNum,FName)
VALUES
(1001, 'Ahmed', 'Male', '2005-01-01', NULL, 1, 'Ali'),
(1003, 'Mona', 'Female', '2005-07-12', 1001, 2, 'Youssef'),
(1004, 'Omar', 'Male', '2005-11-20', 1003, 3, 'Ibrahim'),
(1002, 'Sara', 'Female', '2005-03-05', 1001, 1, 'Hassan');

INSERT INTO M.Project (PNum, PName, City, DNum)
VALUES
(2001, 'Website Dev', 'Cairo', 1),
(2002, 'Recruitment', 'Alex', 2),
(2003, 'Budget Audit', 'Giza', 3);

INSERT INTO M.EmployeeProject (SSN, PNum, WorkHours)
VALUES
(1001, 2001, 40),
(1002, 2001, 30),
(1003, 2002, 35),
(1004, 2003, 20);

INSERT INTO M.Dependent (SSN, DName, Gender, BirthDate)
VALUES
(1001, 'Khaled', 'Male', '2010-05-10'),
(1002, 'Laila', 'Female', '2015-02-14'),
(1003, 'Rami', 'Male', '2012-09-23');

INSERT INTO M.DepartmentManager (DNum, SSN, HiringDate)
VALUES
(1, 1001, '2015-01-01'),
(2, 1003, '2016-06-01'),
(3, 1004, '2019-09-15');



