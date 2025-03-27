-- create database
CREATE DATABASE PetPals;
USE PetPals;

-- create Shelters table
CREATE TABLE IF NOT EXISTS Shelters (
    ShelterID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(255)
);

-- create Pets table
CREATE TABLE IF NOT EXISTS Pets (
    PetID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT CHECK (Age >= 0),  -- Ensures valid age
    Breed VARCHAR(50),
    Type VARCHAR(50),
    AvailableForAdoption BIT DEFAULT 1,  -- Default: available for adoption
    ShelterID INT,
    OwnerID INT DEFAULT NULL,
    FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID),
    FOREIGN KEY (OwnerID) REFERENCES Participants(ParticipantID)
);

-- create Donations table
CREATE TABLE IF NOT EXISTS Donations (
    DonationID INT PRIMARY KEY,
    DonorName VARCHAR(100),
    DonationType VARCHAR(50) CHECK (DonationType IN ('Cash', 'Item')),  -- Ensures valid type
    DonationAmount DECIMAL(10,2) DEFAULT 0,  -- Default value for cash donations
    DonationItem VARCHAR(100) DEFAULT NULL,  -- NULL for cash donations
    DonationDate DATETIME,
    ShelterID INT,
    FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID)
);

-- create AdoptionEvents table
CREATE TABLE IF NOT EXISTS AdoptionEvents (
    EventID INT PRIMARY KEY,
    EventName VARCHAR(100),
    EventDate DATETIME,
    Location VARCHAR(255)
);

-- create Participants table
CREATE TABLE IF NOT EXISTS Participants (
    ParticipantID INT PRIMARY KEY,
    ParticipantName VARCHAR(100),
    ParticipantType VARCHAR(50) CHECK (ParticipantType IN ('Shelter', 'Adopter')),  
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES AdoptionEvents(EventID)
);

-- retrieves a list of available pets
SELECT Name, Age, Breed, Type 
FROM Pets 
WHERE AvailableForAdoption = 1;

-- Retrieve participant names for a specific adoption event
SELECT ParticipantName, ParticipantType 
FROM Participants 
WHERE EventID = ?;

-- updating shelter information
DELIMITER //
CREATE PROCEDURE UpdateShelter(IN shelter_id INT, IN new_name VARCHAR(100), IN new_location VARCHAR(255))
BEGIN
    UPDATE Shelters 
    SET Name = new_name, Location = new_location
    WHERE ShelterID = shelter_id;
END //
DELIMITER ;

-- Retrieve total donation amount per shelter
SELECT s.Name AS ShelterName, 
       COALESCE(SUM(d.DonationAmount), 0) AS TotalDonation
FROM Shelters s
LEFT JOIN Donations d ON s.ShelterID = d.ShelterID
GROUP BY s.Name;

-- Retrieve pets without an owner
SELECT Name, Age, Breed, Type 
FROM Pets 
WHERE OwnerID IS NULL;

-- Retrieve total donation per month-year
SELECT DATE_FORMAT(DonationDate, '%Y-%m') AS MonthYear, 
       COALESCE(SUM(DonationAmount), 0) AS TotalDonation
FROM Donations
GROUP BY MonthYear;

-- Retrieve distinct pet breeds (1-3 years or >5 years)
SELECT DISTINCT Breed 
FROM Pets 
WHERE Age BETWEEN 1 AND 3 OR Age > 5;

-- Retrieve pets and their shelters where pets are available
SELECT p.Name AS PetName, s.Name AS ShelterName 
FROM Pets p
JOIN Shelters s ON p.ShelterID = s.ShelterID
WHERE p.AvailableForAdoption = 1;

-- Count participants in events in a specific city
SELECT a.Location, COUNT(p.ParticipantID) AS TotalParticipants
FROM AdoptionEvents a
JOIN Participants p ON a.EventID = p.EventID
WHERE a.Location = 'Chennai'
GROUP BY a.Location;

-- Retrieve unique breeds of pets aged 1-5 years
SELECT DISTINCT Breed 
FROM Pets 
WHERE Age BETWEEN 1 AND 5;

-- Retrieve pets that have not been adopted
SELECT * FROM Pets 
WHERE AvailableForAdoption = 1;

-- Retrieve names of adopted pets along with adopter names
SELECT p.Name AS PetName, pa.ParticipantName AS AdopterName
FROM Pets p
JOIN Participants pa ON p.OwnerID = pa.ParticipantID
WHERE pa.ParticipantType = 'Adopter';

-- Retrieve shelters with count of available pets
SELECT s.Name AS ShelterName, COUNT(p.PetID) AS AvailablePets
FROM Shelters s
LEFT JOIN Pets p ON s.ShelterID = p.ShelterID AND p.AvailableForAdoption = 1
GROUP BY s.Name;

-- Find pairs of pets from the same shelter with the same breed
SELECT p1.Name AS Pet1, p2.Name AS Pet2, p1.Breed, s.Name AS ShelterName
FROM Pets p1
JOIN Pets p2 ON p1.ShelterID = p2.ShelterID AND p1.Breed = p2.Breed AND p1.PetID < p2.PetID
JOIN Shelters s ON p1.ShelterID = s.ShelterID;

-- List all combinations of shelters and events
SELECT s.Name AS ShelterName, a.EventName 
FROM Shelters s, AdoptionEvents a;

-- Determine the shelter with the highest number of adopted pets
SELECT s.Name AS ShelterName, COUNT(p.PetID) AS AdoptedPets
FROM Shelters s
JOIN Pets p ON s.ShelterID = p.ShelterID
WHERE p.AvailableForAdoption = 0
GROUP BY s.Name
ORDER BY AdoptedPets DESC
LIMIT 1;













