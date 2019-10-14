/*The first schema is here to hold information about humans. IE. the employees 
and the clients. They're a similar idea so I grouped them together.

This second schema hold the information pertaining to events. Where they are, 
policies, types, etc and a table to hold all the information needed for a whole event.

This final schema hold the booked information. Services that are booked and events 
that are booked. This information is different than the second schema because these 
are official records rather than options at a buffet to be booked so I grouped them 
seperately.*/


CREATE DATABASE employeesClients;
CREATE DATABASE buildEvents;
CREATE DATABASE booked;

USE employeesClients;

CREATE TABLE employeeRoles (
	roleID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    roleName VARCHAR(15)
);

INSERT INTO employeeRoles (roleName)
VALUES ("Planner"),
		("Chef"),
        ("Cleaner"),
        ("Security"),
        ("DJ");

CREATE TABLE employeeDepartments (
	departmentID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    departmentName VARCHAR(25)
);

INSERT INTO employeeDepartments (departmentName)
VALUES ("Cooking"), 
		("Sales"), 
        ("Planning"), 
        ("Cleaning"), 
        ("Music");

CREATE TABLE employees (
	employeeID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    employeeFirstName VARCHAR(10),
    employeeLastName VARCHAR(20),
    roleID int,
    departmentID int,
    employeeAddress VARCHAR(40),
    employeeCity VARCHAR(20),
    employeePostalCode VARCHAR(7),
    employeePhoneNumber VARCHAR(18),
    FOREIGN KEY employees_department (departmentID) REFERENCES employeeDepartments(departmentID),
    FOREIGN KEY employees_role (roleID) REFERENCES employeeRoles(roleID)
);

INSERT INTO employees (employeeFirstName, employeeLastName, roleID, 
departmentID, employeeAddress, employeeCity, employeePostalCode, employeePhoneNumber) 
VALUES ("Tom", "Clancy", 1, 3, "25 Toronto Street", "Bradford", "L3Z 9Y7", "456 865-1274"), 
("Susan", "Brown", 2, 1, "78 Winston Avenue", "Ottawa", "K8T 7Q7", "(879) 429-7266"),
("Victoria", "Wetherfield", 4, 2, "9254 Park Crescent", "Churchill", "L4C 8W1", "(905) 125-4752"),
("Larry", "Colborne", 3, 3, "147 Cunningham Parkway", "Celadon", "M3C 8F4", "(586) 144-3951"),
("Kayla", "Burns", 5, 5, "34 Newbie Drive", "Barrie", "L9N 5F5", "(905) 778-1369");

CREATE TABLE clients (
	clientID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    clientFirstName VARCHAR(10),
    clientLastName VARCHAR(20),
    clientAddress VARCHAR(40),
    clientCity VARCHAR(20),
    clientPostalCode VARCHAR(7),
    clientPhoneNumber VARCHAR(16)
);

INSERT INTO clients (clientFirstName, clientLastName, clientAddress, clientCity, 
clientPostalCode, clientPhoneNumber)
VALUES("Terry", "Silver", "87 Terrace Drive", "Toronto", "M4L C9F", "(416) 128-1269"),
("Ronald","Clear", "12358 Valhalla Drive", "King", "G6H L7C", "(416) 855-4556"),
("Penelope", "Xing", "125 Happy Avenue", "Barrie", "H6G 0M5", "(785) 698-1238"),
("Hope", "Smith", "854 Barrie Street", "Vaughan", "M5G 0N9", "(554) 524-4458"),
("John",  "Martson", "1 King Way", "South Gwillimbury", "L3M 1F3", "(645) 726-7453");

/*----------------------------------------------------------------------*/
USE buildEvents;

CREATE TABLE eventTypes (
	typeID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    eventType VARCHAR(15),
    eventPrice double,
    typeBookable bit
);

INSERT INTO eventTypes (eventType, eventPrice, typeBookable)
VALUES ("Birthday", 170.99, 0),
		("Reception", 499.99, 0),
        ("Funeral", 0.0, 1),
        ("Anniversary", 189.99, 0),
        ("Y2K Party", 0.0, 1);
        
CREATE TABLE eventLocations (
	locationID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    city VARCHAR(20)
);

INSERT INTO eventLocations (city)
VALUES ("Barrie"),
		("Bradford"),
        ("Toronto"),
        ("Ottawa"),
        ("Halifax");
        
CREATE TABLE venues (
	venueID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    venueName VARCHAR(40),
    venueAddress VARCHAR(40),
    locationID int,
    venuePostalCode VARCHAR(7),
    venuePhoneNumber VARCHAR(18),
    venuePrice double,
    FOREIGN KEY venues_location (locationID) REFERENCES locations(locationID)
);

INSERT INTO venues(venueName, venueAddress, venueCity, venuePostalCode, venuePhoneNumber, 
venuePrice)
VALUES("Barrie Legion", "345 Ashton Street", "Barrie", "L2P 0A1", "(905) 845-9835", 150),
		("Eutker Hall","8542 Matilda Drive","Toronto","M4S 0I3","(416) 158-4369", 300),
		("Hilton Hotel","34 Perfect Street", "Ottawa", "4M7 8W1","(588) 924-6462", 80),
		("Lacquered Vineyard","62 Coastal Avenue","Halifax","V2G 9J5","(634) 915-8235", 350),
		("Halifax Town Hall","9 Centre Street"," Halifax","D3B 0H5","(634) 871-3985", 250);

CREATE TABLE policies (
	policyID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    locationID int,
    typeID int,
    policyName VARCHAR(30),
    policyDescription VARCHAR(200),
	FOREIGN KEY policies_locations (locationID) REFERENCES eventLocations(locationID),
    FOREIGN KEY policies_eventTypes (typeID) REFERENCES eventTypes(typeID)
);

INSERT INTO policies (locationID, typeID, policyName, policyDescription)
VALUES (1, 1, "No Drinking", "No drinking on the premises or to be snuck in. If found, perpetrator will be escorted off property"),
		(2, 2, "No Noise Past 2AM", "Due to noise laws in the neighbourhood, no loud parties and music past 2AM. Such parties must end by 1:30."),
		(2, 4, "Included Cleanup", "Cleanup will be performed by Events-R-Us rather than left to the client."),
		(4, 1, "Free Setup and Takedown", "A special bundle package offer for event takedown and cleanup to be completed by Events-R-Us."),
		(5, 1, "No Children", "A childfree party option for those who don't want to care for someone's crying child while their parents dance their cares away.");
        
CREATE TABLE eventServices(
	servicesID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
	serviceName VARCHAR(15),
    servicePrice double,
    employeeID int,
    FOREIGN KEY eventServices_employee (employeeID) REFERENCES employeesclients.employees(employeeID)
);

INSERT INTO eventServices(serviceName, servicePrice, employeeID)
VALUES ("Cleaning", 50.00, 4),
		("Party Planner", 200, 1),
		("Cooking", 50, 2),
		("Music", 100, 5),
		("Security", 200, 3);

CREATE TABLE eventData (
	dataID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    eventName VARCHAR(60),
    clientID int,
    typeID int, 
    locationID int,
    venueID int,
    policyID int,
    FOREIGN KEY eventData_clients(clientID) REFERENCES employeesClients.clients(clientID),
    FOREIGN KEY eventData_eventsTypes(typeID) REFERENCES eventTypes(typeID),
    FOREIGN KEY eventData_locations(locationID) REFERENCES eventLocations(locationID),
    FOREIGN KEY eventData_venues(venueID) REFERENCES venues(venueID),
    FOREIGN KEY eventData_policies(policyID) REFERENCES policies(policyID)
);

INSERT INTO eventData(eventName, clientID, typeID, locationID, venueID, policyID)
VALUES("Steven's Birthday", 2, 1, 3, 2, 5),
		("Grandma's Anniversary", 3, 4, 1, 1, 4),
		("Claire's Birthday", 1, 1, 1, 3, 3),
		("Tom's Welcome Back Reception", 4, 2, 4, 5, 4),
		("Precious Daughter's Wedding Reception", 2, 2, 3, 3, 2);
/*----------------------------------------------------------------------*/

USE booked;

CREATE TABLE eventsBooked(
	eventsBookedID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    dataID int,
    FOREIGN KEY eventsBooked_eventData(dataID) REFERENCES buildEvents.eventData(dataID)
);

INSERT INTO eventsBooked (dataID)
VALUES (1),
		(2),
		(3),
		(4),
		(5);

CREATE TABLE servicesBooked(
	bookedServiceID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    servicesID int,
    eventsBookedID int,
    FOREIGN KEY servicesBooked_services(servicesID) REFERENCES buildEvents.eventServices(servicesID),
    FOREIGN KEY servicesBooked_eventsBooked(eventsBookedID) REFERENCES eventsBooked(eventsBookedID)
);

INSERT INTO servicesBooked(servicesID, eventsBookedID)
VALUES(2, 1), 
		(3, 2), 
		(4, 4), 
		(5, 1), 
		(4, 2);

/*----------------------------------------------------*/
/*Queries*/


/*Display event name, location, venue and price for all events booked with Events-R-Us,
sorted by event data ascending*/

USE buildEvents;

SELECT eventName, venueName, venueCity, SUM(Cost) FROM (
	SELECT ed.eventName, v.venueName, v.venueCity, v.venuePrice  AS Cost
	FROM booked.eventsBooked AS eb
	INNER JOIN buildEvents.eventData AS ed
	ON eb.dataID = ed.dataID 
	INNER JOIN buildEvents.venues AS v 
	ON ed.venueID = v.venueID
	UNION ALL
	SELECT ed.eventName, v.venueName, v.venueCity, SUM(es.servicePrice) AS Cost
	FROM booked.eventsBooked  AS eb
	INNER JOIN booked.servicesbooked AS sb
	ON eb.eventsBookedID = sb.eventsBookedID
	INNER JOIN buildEvents.eventServices AS es
	ON sb.servicesID = es.servicesID
	INNER JOIN buildEvents.eventData  AS ed
	ON ed.dataID = eb.dataID
	INNER JOIN buildEvents.venues AS v
	ON ed.venueID = v.venueID
	GROUP BY eventName, venueName, venueCity
    UNION ALL
    SELECT ed.eventName, v.venueName, v.venueCity, SUM(et.eventPrice) AS Cost
    FROM booked.eventsbooked AS eb
    INNER JOIN buildEvents.eventData AS ed
    ON eb.dataID = ed.dataID
    INNER JOIN buildEvents.eventTypes AS et
    ON ed.typeID = et.typeID
    INNER JOIN buildEvents.venues AS v
    ON ed.venueID = v.venueID
    GROUP BY eventName, venueName, venueCity
) AS results
GROUP BY eventName, venueName, venueCity
;


/*Display all staff information (personal data, department info, employee role) that has
been hired as a service add-on for all Event-R-Us events, sorted by last name then first
name*/

USE employeesClients;

SELECT e.employeeFirstName, e.employeeLastName, e.roleID, e.departmentID, e.employeeAddress, e.employeeCity, e.employeePostalCode, e.employeePhoneNumber
FROM employeesclients.employees AS e
INNER JOIN buildEvents.eventServices AS es
ON e.employeeID = es.employeeID
INNER JOIN booked.servicesBooked AS sb
ON es.servicesID = sb.servicesID
INNER JOIN booked.eventsBooked AS eb
ON sb.eventsBookedID = eb.eventsBookedID
ORDER BY e.employeeLastName, e.employeeFirstName;

/*The average price (including add-ons) for all booked events per unique event type
sorted by highest average value*/

USE booked;

SELECT eventType, AVG(Cost) FROM (

	SELECT dataID, eventType, SUM(Cost) AS Cost FROM (
    
		SELECT ed.dataID, et.eventType, v.venuePrice AS Cost
		FROM booked.eventsBooked AS eb
		INNER JOIN buildEvents.eventData AS ed
		ON eb.dataID = ed.dataID 
		INNER JOIN buildEvents.venues AS v 
		ON ed.venueID = v.venueID
		INNER JOIN buildEvents.eventTypes AS et
        ON ed.typeID = et.typeID
        
		UNION ALL
		
		SELECT ed.dataID, et.eventType, SUM(es.servicePrice) AS Cost
		FROM booked.eventsBooked  AS eb
		INNER JOIN booked.servicesbooked AS sb
		ON eb.eventsBookedID = sb.eventsBookedID
		INNER JOIN buildEvents.eventServices AS es
		ON sb.servicesID = es.servicesID
		INNER JOIN buildEvents.eventData  AS ed
		ON ed.dataID = eb.dataID
		INNER JOIN buildEvents.venues AS v
		ON ed.venueID = v.venueID
        INNER JOIN buildEvents.eventTypes AS et
        ON ed.typeID = et.typeID
		GROUP BY dataID, eventType
		
		UNION ALL
		
		SELECT ed.dataID, et.eventType, SUM(et.eventPrice) AS Cost
		FROM booked.eventsbooked AS eb
		INNER JOIN buildEvents.eventData AS ed
		ON eb.dataID = ed.dataID
		INNER JOIN buildEvents.eventTypes AS et
		ON ed.typeID = et.typeID
		INNER JOIN buildEvents.venues AS v
		ON ed.venueID = v.venueID
		GROUP BY dataID, eventType
		) AS results
	GROUP BY dataID, eventType
) AS avgResults
GROUP BY eventType
ORDER BY AVG(Cost) desc;
;

