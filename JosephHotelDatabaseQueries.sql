Use hotel;

#Query1
#Write a query that returns a list of reservations that end in July 2023,
# including the name of the guest, the room number(s), and the reservation dates.

select g.FirstName,  g.LastName,  res.CheckInDate, res.CheckOutDate
from guest as g
inner join GuestReservations as gr on g.GuestID = gr.GuestID
inner join Reservations as Res on gr.ReservationsID = res.ReservationsID
inner join RoomReservations as RoomRes on Res.ReservationsID = RoomRes.ReservationsID
inner join Room as r on RoomRes.RoomNumber = r.RoomNumber
where res.CheckOutDate between '2023-07-01' and '2023-07-31';

#Query1 Results
/*
# FirstName, LastName, CheckInDate, CheckOutDate
'Joseph', 'Liddell', '2023-06-28', '2023-07-02'
'Walter', 'Holaway', '2023-07-13', '2023-07-14'
'Wilfred', 'Vise', '2023-07-18', '2023-07-21'
'Bettyann', 'Seery', '2023-07-28', '2023-07-29'


*/


---------------------------------------------------------------------------

#Query2
#Write a query that returns a list of all reservations for rooms with a jacuzzi, 
#displaying the guest's name, the room number, and the dates of the reservation.

select g.FirstName,  g.LastName,  res.CheckInDate, res.CheckOutDate
from guest as g
inner join GuestReservations as gr on g.GuestID = gr.GuestID
inner join Reservations as Res on gr.ReservationsID = res.ReservationsID
inner join RoomReservations as RoomRes on Res.ReservationsID = RoomRes.ReservationsID
inner join Room as r on RoomRes.RoomNumber = r.RoomNumber
inner join RoomAmenity as Ra on r.RoomNumber = ra.RoomNumber
inner join Amenity as a on ra.AmenityID = a.AmenityID
where a.AmenityID = 3 or 5 or 7;

--------------------------------------------------------------------------------------

#Query 3
#Write a query that returns all the rooms reserved for a specific guest,
# including the guest's name, the room(s) reserved, the starting date of the reservation, 
#and how many people were included in the reservation.
# (Choose a guest's name from the existing data.)

select g.FirstName, g.LastName, res.CheckInDate, res.CheckOutDate, res.Adults + res.Children as Total
from Guest as g
inner join GuestReservations as gr on g.GuestID = gr.GuestID
inner join Reservations as Res on gr.ReservationsID = res.ReservationsID
inner join RoomReservations as RoomRes on Res.ReservationsID = RoomRes.ReservationsID
inner join Room as r on RoomRes.RoomNumber = r.RoomNumber
where g.FirstName = 'Karie' and g.LastName = 'Yang' and g.GuestID = 5;

#Results of  Query 3
/*
# FirstName, LastName, CheckInDate, CheckOutDate, Total
'Karie', 'Yang', '2023-03-06', '2023-03-07', '4'
'Karie', 'Yang', '2023-09-13', '2023-09-15', '4'

*/

--------------------------------------------------------------------------------------------------------------------------


#Query 4
#Write a query that returns a list of rooms, reservation ID, and per-room cost for each reservation. 
#The results should include all rooms, whether or not there is a reservation associated with the room.
Select R.RoomNumber, Res.ReservationsID,
    CASE
		WHEN (((R.RoomNumber BETWEEN '201' AND '204') OR (R.RoomNumber BETWEEN '301' AND '304')) AND Res.Adults <= 2)
			THEN ((R.BasePrice) * DATEDIFF(Res.CheckOutDate, Res.CheckInDate))
            
		 WHEN (((R.RoomNumber BETWEEN '201' AND '204') OR (R.RoomNumber BETWEEN '301' AND '304')) AND Res.Adults > 2)
			 THEN ((R.BasePrice + ((Res.Adults - R.StandardOccupancy) * 10) * DATEDIFF(Res.CheckOutDate, Res.CheckInDate)))
             
		WHEN ((R.RoomNumber BETWEEN '205' AND '208') OR (R.RoomNumber BETWEEN '305' AND '308'))
			 THEN ((R.BasePrice) * DATEDIFF(Res.CheckOutDate, Res.CheckInDate))
             
		WHEN (((R.RoomNumber BETWEEN '401' AND '402')) AND Res.Adults <= 3)
			THEN ((R.BasePrice) * DATEDIFF(Res.CheckOutDate, Res.CheckInDate))
            
		WHEN (((R.RoomNumber BETWEEN '401' AND '402')) AND Res.Adults > 3)
			THEN ((R.BasePrice + ((Res.Adults - R.StandardOccupancy) * 20) * DATEDIFF(Res.CheckOutDate, Res.CheckInDate)))
	END AS Total
FROM Guest as g
right outer join GuestReservations as gr on g.GuestID = gr.GuestID
right outer join Reservations as Res on gr.ReservationsID = res.ReservationsID
right outer join RoomReservations as RoomRes on Res.ReservationsID = RoomRes.ReservationsID
right outer join Room as r on RoomRes.RoomNumber = r.RoomNumber;

--------------------------------------------------------------------------------------------------
#Query 5
#Write a query that returns all the rooms accommodating at least three guests 
#and that are reserved on any date in April 2023.

select r.RoomNumber
from Room as r
inner join RoomReservations as RoomRes on r.RoomNumber = RoomRes.RoomNumber
inner join Reservations as res on RoomRes.ReservationsID = res.ReservationsID
where (Res.Adults + Res.Children) > 2
		AND ((Res.CheckInDate BETWEEN '2023-04-01' AND '2023-04-30')
		OR (Res.CheckOutDate BETWEEN '2023-04-01' AND '2023-04-30'));
        
        #Results of Query5
        #No Rows Returned
----------------------------------------------------------------------
#Query 6
#Write a query that returns a list of all guest names and the number of reservations per guest,
# sorted starting with the guest with the most reservations and then by the guest's last name.

SELECT g.Firstname, g.Lastname, COUNT(gr.GuestId) AS TotalReservations
FROM Guest as g
INNER JOIN GuestReservations gr ON g.GuestID = gr.GuestID
INNER JOIN Reservations as r on gr.ReservationsID = r.ReservationsID
GROUP BY g.FirstName, g.LastName
ORDER BY TotalReservations DESC, g.LastName;
/*
Results for Query6
 Firstname, Lastname, TotalReservations

'Mack', 'Simmer', '4'
'Bettyann', 'Seery', '3'
'Duane', 'Cullison', '2'
'Walter', 'Holaway', '2'
'Joseph', 'Liddell', '2'
'Aurore', 'Lipton', '2'
'Maritza', 'Tilton', '2'
'Joleen', 'Tison', '2'
'Wilfred', 'Vise', '2'
'Karie', 'Yang', '2'
'Zachery', 'Luechtefeld', '1'
'Jeremiah', 'Pendergrass', '1'

*/


---------------------------



#Query7
#Write a query that displays the name, address,
# and phone number of a guest based on their phone number.
# (Choose a phone number from the existing data.)

SELECT 
	g.FirstName,
    g.LastName,
    g.Address,
    g.City,
    g.State,
    g.ZipCode,
    g.PhoneNumber
FROM Guest as g
WHERE g.PhoneNumber LIKE '%(446) 396-6785';

#Results of Query7
# FirstName, LastName, Address, City, State, ZipCode, PhoneNumber
#'Walter', 'Holaway', '7556 Arrowhead St. ', 'Cumberland', 'RI', '02864', '(446) 396-6785'





