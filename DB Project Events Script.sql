
CREATE DATABASE buildEvents;

USE buildEvents;

CREATE TABLE eventTypes (
	typeID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    type VARCHAR(15),
    eventPrice int,
    typeBookable bit
);

CREATE TABLE eventLocations (
	locationID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    city VARCHAR(20)
);

CREATE TABLE venues (
	venueID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    venueName VARCHAR(40),
    venueAddress VARCHAR(40),
    venueCity VARCHAR(20),
    venuePostalCode VARCHAR(7),
    venuePhoneNumber VARCHAR(18),
    venuePrice double
);

CREATE TABLE policies (
	policyID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    FOREIGN KEY (locationID) REFERENCES eventLocations(locationID),
    FOREIGN KEY (typeID) REFERENCES eventTypes(typeID),
    policyName VARCHAR(15),
    policyDescription VARCHAR(100)
);

CREATE TABLE eventServices(
	servicesID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
	serviceName VARCHAR(15),
    servicePrice double
);

CREATE TABLE eventData (
	dataID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    beventName VARCHAR(50),
    FOREIGN KEY (clientID) REFERENCES EmployeesClients.clients(clientID),
    FOREIGN KEY (typeID) REFERENCES eventTypes(typeID),
    FOREIGN KEY (locationID) REFERENCES eventLocations(locationID),
    FOREIGN KEY (venueID) REFERENCES venues(venueID),
    FOREIGN KEY (policyID) REFERENCES policies(policyID)
);