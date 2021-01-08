drop  database if  exists TestHotel;

#testing the data Inside the First Hotel Schema

create database TestHotel;

use TestHotel;

#creating the Room Table

Create table Room(
RoomNumber Int primary key not null,
RoomType VARCHAR(20),
ADA  char(3),
StandardOccupancy Int Not Null,
MaximumOccupancy Int Not null,
BasePrice Decimal (5,2) ,
ExtraPerson Decimal(5,2) 
);

#Creating the Amenity table 

Create table Amenity(
AmenityID int primary key auto_increment,
AmenityType VARCHAR(50)
);

#creating the brige table between Room and Amenity

Create table RoomAmenity(
RoomNumber Int Not Null,
AmenityID Int Not Null,
Primary key pk_RoomAmenity(RoomNumber, AmenityID),
foreign key fk_RoomAmenity_Room(RoomNumber) references Room(RoomNumber),
foreign key fk_RoomAmenity_Amenity(AmenityID) references Amenity(AmenityID)
);


#Create the guest table

create table Guest(
GuestID int primary key auto_increment,
FirstName Varchar(50),
LastName Varchar(50),
Address Varchar(50),
City Varchar(50),
State char(2),
ZipCode char(5),
PhoneNumber char(15)
);



#Create Reservations table

Create table Reservations(
ReservationsID int primary key auto_increment,
FirstName VARCHAR(20),
LastName VARCHAR(20),
Adults int not null,
Children int not null,
CheckInDate DATE,
CheckOutDate DATE,
TotalRoomCost Decimal(9,2) not null
);


#Create the bridge table between Room and Reservations

Create table RoomReservations(
RoomNumber int,
ReservationsID int,
Primary key pk_RoomReservations(RoomNumber,ReservationsID),
foreign key fk_RoomReservations_RoomNumber(RoomNumber) references Room(RoomNumber),
foreign key fk_RoomReservations_ReservationsID(ReservationsID) references Reservations(ReservationsID)

);


#create the birdge table between guest and Reservations

Create table GuestReservations(
GuestID int,
ReservationsID int,
Primary key pk_GuestReservations(GuestID, ReservationsID),
foreign key fk_GuestReservations_Guest(GuestID) references Guest(GuestID),
foreign key fk_GuestReservations_Reservations(ReservationsID) references Reservations(ReservationsID)
);

#Inserting values into the Room Table

insert into Room (RoomNumber, RoomType, ADA, StandardOccupancy,  MaximumOccupancy,  BasePrice,  ExtraPerson ) values
 (201, ' Double ', 'No',	2,	4, 	199.99,	10.00),
(202,   'Double', 'Yes',	2,	4,     174.99,     10.00),
(203,	'Double',	'No',	2,	4,	   199.99,	  10.00),
(204,	'Double' ,	'Yes', 2,4,    174.99,   10.00),
(205,	'Single', 	'No',	 2,2,	 174.99, 0.00),
(206,	'Single', 	'Yes', 2, 2,	 149.99, 0.00),
(207,	'Single',	'No',	 2,	2,	 174.99, 0.00),
(208,	'Single'	,   'Yes',	2,	2,	 149.99, 0.00),
(301,	'Double',  'No',	2,	4,	199.99,	10.00),
(302,	'Double',	'Yes', 2,4,	174.99, 10.00),
(303,	'Double'	, 'No',	2,	4,	199.99, 10.00),
(304,	'Double',	 'Yes',	2,	4,	174.99,	10.00),
(305,	 'Single',	'No',	2,	2,	  174.99, 0.00),
(306,	'Single', 	'Yes',	2,	2,	149.99, 0.00),
(307,	'Single', 	'No',	2,	2,	174.99, 0.00),
(308,	'Single',	'Yes',	2,	2,	149.99, 0.00),
(401,	'Suite',	'Yes',	3,	8,	399.99,	20.00),
(402,	'Suite',	'Yes',	3,	8,	399.99,	20.00);

#Inserting Values into the Amenity Table

Insert into Amenity (AmenityType) values
	( 'Microwave' ),
	('Refrigerator'),
	(' Jacuzzi '),
	('Oven'),
    ('Microwave Jacuzzi'),
    ('Microwave Refrigator'),
    ('Microwave, Refrigator, Jacuzzi'),
    ('Microwave, Refrigator, Oven');
    
    #Inserting values into the RoomAmenity table to identify Rooms with there special Amenities 
    
    Insert into RoomAmenity(RoomNumber, AmenityID) values
    (201,  5 ),
    (202, 2 ),
    (203, 5),
    (204, 2),
    (205, 7),
    (206,  6),
    (207, 7),
    (208, 6),
    (301,5),
    (302, 2),
    (303, 5),
    (304, 2),
    (305, 7),
    (306, 6),
    (307, 7),
    (308, 6),
    (401, 8),
    (402 , 8);
    
    #Inserting values into the Guest Table
    
    Insert into Guest(FirstName, LastName, Address, City, State, ZipCode, PhoneNumber  ) values
	('Joseph',  'Liddell',  'Earth',   'PlaceOnEarth',   'EE',   '00000',        '(000) 000-0000' ),
    
('Mack',  'Simmer',	'379 Old Shore Street',	'Council Bluffs',	'IA',	'51501',	'(291) 553-0508'),

('Bettyann',  'Seery',	'750 Wintergreen Dr',	'Wasilla',	'AK', 	'99654',	'(478) 277-9632'),

('Duane',  'Cullison', 	'9662 Foxrun Lane',	'Harlingen',	'TX',	 '78552',	'(308) 494-0198'),

('Karie', 'Yang',	'9378 W. Augusta Ave.',	'West Deptford',	'NJ',	'08096',	'(214) 730-0298'),

('Aurore', 'Lipton',	'762 Wild Rose Street',	'Saginaw',	'MI',	'48601',	'(377) 507-0974'),

('Zachery',      'Luechtefeld',	'7 Poplar Dr.',	'Arvada',	'CO',	'80003',	'(814) 485-2615'),

('Jeremiah',  'Pendergrass',	 '70 Oakwood St.', 	'Zion',	'IL',	'60099' ,	'(279) 491-0960'),

('Walter',  'Holaway' ,	'7556 Arrowhead St. ', 	'Cumberland',	'RI', 	'02864' ,	'(446) 396-6785'),

('Wilfred',  'Vise', 	'77 West Surrey Street',	 'Oswego',	'NY', 	'13126',	 '(834) 727-1001'),

('Maritza', 'Tilton', 	'939 Linda Rd.',	'Burke',	'VA', 	'22015' ,	'(446) 351-6860'),

('Joleen',  'Tison', 	'87 Queen St.',	'Drexel Hil',	'PA', 	'19026',	'(231) 893-2755');

#Inserting values into the Reservations Table

insert Into  Reservations(FirstName, LastName, Adults, Children, CheckInDate, CheckOutDate,TotalRoomCost  ) values

	( 'Mack',  'Simmer',	1,	0, 	'2023-02-02  ',   ' 2023-02-04 ',		299.98),
    
	('Bettyann',  'Seery',	2,	1, 	'2023-02-05',   '2023-02-10',		999.95),
    
	( 'Duane',  'Cullison',	2,	0,	   '2023-02-22',     '2023-02-24', 	 	349.98),
    
	('Karie',  'Yang',	2,	2,       '2023-03-06', 	    '2023-03-07',		199.99),
    
	('Joseph', 'Liddell',	1,	1,	  '2023-03-17',      '2023-03-20',		 524.97),
    
	('Aurore',  'Lipton',	3,	0,    '2023-03-18',  	'2023-03-23', 	  	924.95),
    
	('Zachery',  'Luechtefeld',	2,	2,    '2023-03-29',     '2023-03-01',	 349.98),
    
	('Jeremiah',  'Pendergrass', 	2,	0,  '2023-03-31',	 '2023-04-05',	 	874.95),
    
	('Walter',  'Holaway',	1,	0,    '2023-04-09',  	  '2023-04-13',	 	 799.96),
    
	('Wilfred',  'Vise', 	1,	1,    '2023-04-23',    '2023-04-24',	  	174.99),
    
	('Maritza',  'Tilton',	2,	4,     '2023-05-30', 	 '2023-06-02',		1199.97),
    
	('Joleen',  'Tison',	 2,	0,    '2023-06-10',   '2023-06-14', 	 	599.96),
    
	('Joleen',  'Tison', 	1,  0,	'2023-06-10',     '2023-06-14',  		599.96),
    
	('Aurore',  'Lipton', 	3,	 0, 	'2023-06-17',   '2023-06-18', 	 	184.99),
    
	('Joseph', 'Liddell', 	2, 	0,    '2023-06-28', 	 '2023-07-02', 	 	699.96),
    
	('Walter',  'Holaway', 	3,	 1,   '2023-07-13', 	 '2023-07-14', 	 	184.99),
    
	('Wilfred',  'Vise', 	4, 	2,    '2023-07-18', 	'2023-07-21',  	 	1259.97),
    
	('Bettyann',  'Seery', 	2,	1,  '2023-07-28',	 '2023-07-29',   	199.99),
    
	('Bettyann',  'Seery', 	1,	0,    '2023-08-30', 	'2023-09-01',  	 	349.98),
    
	('Mack',   'Simmer',  	2,  0,   '2023-09-16', 	'2023-09-17',  	 	149.99),
    
	('Karie',  'Yang',	2,	2,    '2023-09-13', 	'2023-09-15', 	 	 399.98),
    
	('Duane',  'Cullison', 	2,	2,  '2023-11-22',	'2023-11-25', 	 	1199.97),
    
	('Mack',  'Simmer', 	2,	0,	  '2023-11-22',     '2023-11-25',		449.97),
    
	('Mack',  'Simmer',	2,	2,	 '2023-11-22',  '2023-11-25',	599.970),
    
	('Maritza',  'Tilton',	2,	0,  '2023-12-24',	   '2023-12-28', 	699.96);
    
    #Inserting values Into the GuestReservations bridge table
    
    insert  into GuestReservations(GuestID, ReservationsID) values
    (2,1),
    (3,2),
    (4,3),
    (5,4),
    (1,5),
    (6,6),
    (7,7),
    (8,8),
    (9,9),
    (10,10),
    (11,11),
    (12,12),
    (12,13),
    (6,14),
    (1,15),
    (9,16),
    (10,17),
    (3,18),
    (3,19),
    (2,20),
    (5,21),
    (4,22),
    (2,23),
    (2,24),
    (11,25);
    
   
    #Inserting values  into the Room Reservations bridge table
    
    insert into RoomReservations(RoomNumber, ReservationsID) values
    (308,1),
    (203,2),
    (305,3),
    (201,4),
    (307,5),
    (302,6),
    (202,7),
    (304,8),
    (301,9),
    (207,10),
    (401,11),
    (206,12),
    (208,13),
    (304,14),
    (205,15),
    (204,16),
    (401,17),
    (303,18),
    (305,19),
    (208,20),
    (203,21),
    (401,22),
    (206,23),
    (301,24),
    (302,25);
    
    
# After adding all of the data above, create SQL statements that will delete Jeremiah Pendergrass and his reservations from the database.

#Deleting data should start with records that reference Jeremiah Pendergrass using a foreign key and then delete the record from the guest table as the last step.

#The scripts should only delete records related to Jeremiah Pendergrass and his reservations. They should not delete any room data.


delete from GuestReservations  where GuestID = 8;

delete from RoomReservations Where ReservationsID = 8;

delete from Guest where GuestID = 8;
            
Delete From Reservations Where ReservationsID = 8;


    
    
