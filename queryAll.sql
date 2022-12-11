set session transaction isolation level read uncommitted;

-- activities
start transaction;

-- 1. a folk registering for a vaccine
insert into folks values ('1111111111111103', 'Folk','New','1964-10-24',1111111111, 001101011, 444433333, 'maxmao199@gmail.com');
insert into register values ('1111111111111103','AA00',0,3,'2019-01-02');
select* from register;


-- 2. a folk modifying the vaccine, date, or health center of a one of their prior registrations 
-- (never modify past registrations, i.e. with a date prior to current date)

insert into folks values ('1111111111111103', 'Folk','New','1964-10-24',1111111111, 001101011, 444433333, 'maxmao199@gmail.com');
insert into register values ('1111111111111103','AA00',0,3,'2019-01-02');
update register
set date = '2019-01-03' where ID = '1111111111111103';
select* from register;

-- 3. scheduling a staff member for a given health center and time period;
-- raise a warning/exception if there are no registration during that period at the center
insert into health_staff values('1111111111111103', '2018-01-01','2021-01-01',0,3);

select'Warning: No Registration' from register where date 
not between 
(select start_date from health_staff where id = '1111111111111103') and
(select end_date from health_staff where id = '1111111111111103');

-- 4. modifying the availability dates of an existing vaccine
update vaccine
set start_date_3 = '2022-05-17' where vaccine_name = 'AA00';
update vaccine
set end_date_3 = '2022-05-17' where vaccine_name = 'AA00';
select* from vaccine;

-- 5. removing a folk (and all of their associated information)
delete from folks where ID = '1111111111111103';
select* from folks;

rollback;

-- queries/reports:
start transaction;
-- 1. List the name and age of all folks.
select first_name,last_name,
YEAR(curdate()) - YEAR(date_of_birth)
    - (DATE_FORMAT(curdate(), '%m%d') < DATE_FORMAT(date_of_birth, '%m%d')) as age
from folks;

-- 2. List the city, state, and the number of residents of each city in Wonderland (skip cities with no residents)
-- in decreasing order of number of residents.
select city, state, households from residence order by households desc;

-- 3. List each state together with its number of currently inhabited places (include states with no inhabited places) 
-- in increasing alphabetical order.
select count(*),state from residence group by state order by state asc;

-- 4. Find the unique identifiers of folks registered to a given health center for a given time period.
select ID from register;

-- 5. Find for a given month, the number of unique staff scheduled to any center which is within 5 miles of the center of Megapolis
-- except for centers in a given list of locations.
select '2020-05', count(*) from health_staff where 
'2020-05-01' between start_date and end_date;


-- 6. Find the most popular health center(s) (in terms of number of registrations) in a given time period among those in a given city.
select count(*), X_coordinates, Y_coordinates,city from register where date between '2019-01-01' and '2019-04-16'
group by X_coordinates, Y_coordinates;


-- 7. Find the unique staff that have been scheduled to every health center in a given state.
select ID,X_coordinates,Y_coordinates from work_at where X_coordinates in 
(select X_coordinates from health_centers) 
and Y_coordinates in (select Y_coordinates from health_centers)
order by ID asc;

-- 8. Find folks that registered to a health center that is farther away than the health center closest to their residence.
select ID,X_coordinates,Y_coordinates,X_live_at,Y_live_at from register 
where (Y_coordinates = '4' and Y_live_at = '0')
or (Y_coordinates = '5' and Y_live_at = '0')
or (Y_coordinates = '4' and Y_live_at = '1')
or (Y_coordinates = '5' and Y_live_at = '1')
or (Y_coordinates = '4' and Y_live_at = '2')
or (Y_coordinates = '5' and Y_live_at = '2');


-- 9. Write a SQL function to compute the total unique folks registered for a given vaccine for a given time period that reside
-- closer to a given location L1 than another given location L2.

delimiter $$
create function closer(ID varchar(16), date date,L1 numeric(4,0),L2 numeric(4,0), vaccine_name varchar(4))
returns varchar(16)
    
begin
	declare ID varchar(16);
    declare date date;
    declare L1 numeric(4,0);
    declare L2 numeric(4,0);
    declare vaccine_name varchar(4);
    
    if (L2 > L1)
    then
		select ID from register where (date between '2019-01-01' and '2019-04-16') and vaccine_name = 'AA00';
        
    end if;
    return ID;
end$$
delimiter ;

select ID, closer(ID,date,Y_coordinates,Y_live_at) from register;
-- 10. A cross-tabulation of vaccines (short-name) as rows, month (name) as columns, and cells indicating number of doses of 
-- the row’s vaccine dispensed during the column’s month.
select monthname(str_to_date(month(date), '%m')) as 'month',
count(ID) as doses,
vaccine_name
from register
group by month(date), vaccine_name
order by month(date);

rollback;