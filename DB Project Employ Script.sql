/*The first schema is here to hold information about humans. IE. the employees 
and the clients. They're a similar idea so I grouped them together*/

CREATE DATABASE EmployeesClients;

USE EmployeesClients;

CREATE TABLE employeeRoles (
	roleID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    roleName VARCHAR(15)
);

CREATE TABLE employeeDepartments (
	departmentID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    departmentName VARCHAR(15)
);

CREATE TABLE employees (
	employeeID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    employeeFirstName VARCHAR(10),
    employeeLastName VARCHAR(20),
    employeeRole VARCHAR (20),
    employeeDepartment VARCHAR (15),
    employeeAddress VARCHAR(40),
    employeeCity VARCHAR(20),
    employeePostalCode VARCHAR(7),
    employeePhoneNumber VARCHAR(18)
);

CREATE TABLE clients (
	clientID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    clientFirstName VARCHAR(10),
    clientLastName VARCHAR(20),
    clientAddress VARCHAR(40),
    clientCity VARCHAR(20),
    clientPostalCode VARCHAR(7),
    clientPhoneNumber VARCHAR(16)
);