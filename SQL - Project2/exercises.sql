--How can you retrieve all the information from the cd.facilities table?
SELECT * FROM cd.facilities;

--You want to print out a list of all of the facilities and their cost to members. How do you retrieve a list of only facility names and costs?
SELECT name,membercost FROM cd.facilities;

--How can you produce a list of facilities that charge a fee to members? 
SELECT *
FROM cd.facilities
WHERE membercost > 0;

--How can you produce a list of facilities that charge a fee to members, and that fee is less than 1/50th of the monthly maintencance cost?
--Return the facid, facility name, membercost, and monthly maintenance of the facilities in question.
SELECT facid, name, membercost, monthlymaintenance
FROM cd.facilities
WHERE membercost IN
(SELECT membercost FROM cd.facilities WHERE (membercost < (monthlymaintenance/50)) AND membercost !=0);

--How can you produce a list of all facilities with the word 'Tennis' in their name?
SELECT * FROM cd.facilities
WHERE name LIKE '%Tennis%';

--How can you retrieve the details of facilitites with ID1 and 5? Try to do it whithout using the OR operator.
SELECT * FROM cd.facilities
WHERE facid IN (1,5);

--How can you produce a list of members who joined after the start of September 2017? 
--Return the memid, surname, firstname, and joindate of the members in question.
SELECT memid,surname, firstname, joindate
FROM cd.members
WHERE joindate >= '2012-09-01';

-- How can you produce an ordered list of the first 10 surnames in the members table? The list must not contain duplicates.
SELECT DISTINCT(surname) FROM cd.members
ORDER BY surname
LIMIT 10;

--You'd like to get the signup date of your last member. How can you retrieve this information?
SELECT MAX(joindate) FROM cd.members;

--Produce a count of the number of facilitites that have a cost to guests of 10 or more.
SELECT COUNT(*) 
FROM cd.facilities
WHERE guestcost >= 10;

--Produce a list of the total number of slots booked per facility in the month of Semptember.
--Produce an output table consisting of facility id and slots by the number of slots.
SELECT facid, SUM(slots) AS total_slots FROM cd.bookings
WHERE (SELECT EXTRACT (MONTH FROM starttime)) = 09
GROUP BY facid
ORDER BY SUM(slots);

--Produce a list of facilities with more than 1000 slots booked. 
--Produce an output table consisting of facility id and total slots, sorted by facility id.
SELECT facid, SUM(slots) AS total_slots FROM cd.bookings
GROUP BY facid
HAVING SUM(slots) > 1000
ORDER BY facid;

--How can you produce a list of the start times for bookings  for tennis courts, for the date '2012-09-21'?
--Return a list of start time and facility name pairings, ordered by the time.
SELECT starttime, name 
FROM cd.bookings
INNER JOIN cd.facilities
ON cd.bookings.facid = cd.facilities.facid
WHERE (TO_CHAR(starttime, 'yyyy-mm-dd') = '2012-09-21') AND name ILIKE '%tennis court%'
ORDER BY starttime;

--How can you produce a list of the start times for bookings by members named 'David Farrell'?
SELECT starttime FROM cd.bookings
INNER JOIN cd.members 
ON cd.bookings.memid = cd.members.memid
--WHERE (firstname || ' ' || surname) = 'David Farrell'
WHERE firstname = 'David' AND surname = 'Farrell'