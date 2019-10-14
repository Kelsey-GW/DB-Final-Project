
CREATE DATABASE booked;

USE booked;

CREATE TABLE eventsBooked(
	eventsBooked int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    FOREIGN KEY (dataID) REFERENCES buildEvents.eventData(dataID)
);

CREATE TABLE servicesBooked(
	bookedServiceID int PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    FOREIGN KEY (serviceID) REFERENCES buildEvents.eventServices(serviceID),
    FOREIGN KEY (eventsBookedID) REFERENCES eventsBooked(eventsBookedID)
);