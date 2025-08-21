-- 1.Database Creation
CREATE DATABASE EventsManagement;

-- use database
USE EventsManagement;

-- table Creation
-- create events table
CREATE TABLE Events (
    Event_Id INT PRIMARY KEY,
    Event_Name VARCHAR(50) NOT NULL,
    Event_Date DATETIME NOT NULL,
    Event_Location VARCHAR(150),
    Event_Description VARCHAR(1000)
);
-- create attendees table
CREATE TABLE Attendees (
    Attendee_Id INT PRIMARY KEY,
    Attendee_Name VARCHAR(100) NOT NULL,
    Attendee_Phone VARCHAR(15) NOT NULL,
    Attendee_Email VARCHAR(100) NOT NULL,
    Attendee_City VARCHAR(30) NOT NULL
);
-- create registrations table
CREATE TABLE Registrations (
    Registration_Id INT PRIMARY KEY,
    Event_Id INT NOT NULL,
    Attendee_Id INT NOT NULL,
    Registration_Date DATETIME ,
    Registration_Amount DECIMAL(10,2),
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
);

-- 2)B Insert Values


-- Insert sample Events
INSERT INTO Events (Event_Id, Event_Name, Event_Date, Event_Location, Event_Description) VALUES
(1001, 'Ananda Bajar Expo', '2025-09-28 21:00:00', 'Science City, Kolkata', 'Legacy of Ananda Bajar Patrika & impact'),
(1002, 'TCS Labour Relations WKshop', '2025-08-26 08:00:00', 'TCS Gitobitan, Pune', 'Workshop on labour market of india'),
(1003, 'IBM data analytics Workshop', '2025-12-17 17:00:00', 'Leela Palace, Delhi', 'Leveraging AI for Data Analytics'),
(1004, 'History of Bengali Bands', '2025-11-15 14:00:00', 'Biswa Bangla CV Centre', 'A journey through time with Sidhu'),
(1005, 'BMW Car Expo 2025', '2025-08-02 19:00:00', 'Mahalakshmi Race Course, Mumbai', 'Car Show for BMW upcoming models');

-- Insert sample Attendees
INSERT INTO Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City) VALUES
(1, 'Sramana Sarkar', '869756432', 'sarkar.sramana@email.com', 'Kolkata'),
(2, 'Debayan Bagchi', '900745678', 'bagchi.debayan@gmail.com', 'Pune'),
(3, 'Chandrabali Bishnu', '9830340929', 'bischan@gmail.com', 'Delhi'),
(4, 'Siddharta Chatterjeee', '8697412969', 'chatusidhu@gmail.com', 'Kolkata'),
(5, 'Subham Sadhukhan', '9131661929', 'sadhushub@gmail.com', 'Mumbai');

-- Insert sample Registrations
INSERT INTO Registrations (Registration_Id, Event_Id, Attendee_Id, Registration_Date, Registration_Amount) VALUES
(5001, 1001, 1, '2025-07-01 06:15:00', 25000.00),
(5002, 1001, 2, '2025-08-10 20:40:00', 10000.00),
(5003, 1002, 2, '2025-10-13 09:25:00', 15000.00),
(5004, 1003, 3, '2025-06-03 12:00:00', 8000.00),
(5005, 1005, 4, '2025-05-01 16:02:00', 15000.00);




-- 3a) Inserting a new event
INSERT INTO Events (Event_Id, Event_Name, Event_Date, Event_Location, Event_Description) VALUES
(1006, 'AWS Annual Indian Summit', '2025-12-15 14:00:00', 'World Trade centre, Bangalore', 'Impact and Outlook of AWS in the age of AI');

--- to view results
select * from Events ;


-- 3b)Updating an event's information(using the newly created event for example)
UPDATE Events
set Event_Date = '2025-12-14 09:00:00', Event_Location = 'Global Tech Park, Bengalore'
WHERE Event_Id = 1006;

--- to view results
select * from Events ;

-- 3c)Deleting an event (Deleting the newly created event)

DELETE FROM Events WHERE Event_Id = 1006;

--- to view results
select * from Events; 

-- 4a)Inserting a new attendee
INSERT INTO Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City) VALUES
(6, 'Souvik Chatterjee', '9830456789', 'pjchats@email.com', 'Delhi');

--- to view results
select * from Attendees ;

-- 4b)Registering an attendee for an event(example registering attendee 6 for )
INSERT INTO Registrations (Registration_Id, Event_Id, Attendee_Id, Registration_Date, Registration_Amount) 
VALUES
(5006, 1003, 6, '2025-12-01 12:30:00', 15000.00);

--- to view results
select * from Attendees; 

-- 5a)Develop queries to retrieve event information

Select Event_Id, Event_Name, Event_Date, Event_Location,Event_Description
from Events
ORDER BY Event_Date;


-- 5b)Develop query to generate attendee lists
SELECT a.Attendee_Name,e.Event_Name,Event_Date,e.Event_Location, Registration_Date, a.Attendee_City,a.Attendee_Email
FROM Events e
inner join Registrations r ON e.Event_Id = r.Event_Id
inner join Attendees a ON r.Attendee_Id = a.Attendee_Id
ORDER BY e.Event_Id, r.Registration_Date;


-- 5C) Develop queries to  calculate event attendance statistics
select Events.Event_Name, COUNT(Registrations.Registration_Id) as Total_Registrations,
CASE 
WHEN count(Registrations.Registration_Id) = 0 then 'No-Registrations'
WHEN count(Registrations.Registration_Id) < 2 then 'Low-Turnout'
else 'High-Turnout'
END as Registration_Turnout,
IFNULL(sum(Registrations.Registration_Amount), 0) as Total_Revenue, Event_Date
FROM Events
left join Registrations ON Events.Event_Id = Registrations.Event_Id
group by 
Events.Event_Name,Events.Event_Date
order by Total_Registrations DESC;






