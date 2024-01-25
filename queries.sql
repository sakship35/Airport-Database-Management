simple query:
-- retrieve all passengers' names and email addresses
use airport;
Select firstName, lastName, email from person;

aggregate query:
-- find the total weight of baggage for each passenger
select passengerID, sum(weight) as totalweight
from baggage
group by passengerID;

inner join:
-- retrieve details of flights and corresponding airlines
select flight.flightNo, flight.departureairportCode, flight.arrivalairportcode, airline.airlinename
from flight
inner join airline_airport_details on flight.departureairportcode = airline_airport_details.airportcode
inner join airline on airline_airport_details.airlinecode = airline.airlinecode;

outer join:
-- retrieve details of all passengers and their booked flights (including passengers without bookings)
select person.firstname, person.lastname, booking.flightno
from person
left join passenger on person.userid = passenger.passengerid
left join booking on passenger.passengerid = booking.passengerid;

nested query:
-- find passengers who booked flights departing from asheville regional airport
select firstname, lastname
from person
where userid in (
    select passengerid
    from Booking
    where flightNo in (
        select flightno
        from flight
        where departureairportcode = 'AVL'
    )
);

Correlated Query:
-- Find passengers who reported Lost and Found incidents and their details
select firstName, lastName, itemDescription
from Person
join Passenger_Incident_details ON Person.userID = Passenger_Incident_details.PID
join LostNFound on Passenger_Incident_details.reclaim_ID = LostNFound.reclaimID;

ALL:
-- Find flights with a duration greater than all flights departing from Hyderabad airport
select flightNo, duration
from Flight
where duration > all (
    select duration
    from flight
    where departureAirportCode = 'HDD'
);

exists:
-- Find passengers who have reported lost items and also have baggage
select * from person
where exists (
    select 1
    from passenger_incident_details p
    where p.pid = person.userid
)
and exists (
    select 1
    from baggage b
    where b.passengerid = person.userid
);

set operations (union):
-- combine the results of two queries to get a unique list of airport codes
select airportcode from airport
union
select departureairportcode from flight;

subqueries in select and from:
-- find the average weight of baggage for each passenger
select userid, 
       (select avg(weight) from baggage where baggage.passengerid = person.userid) as avgBaggageWeight
from person;




