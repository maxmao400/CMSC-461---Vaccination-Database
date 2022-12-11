drop database if exists vc22;

-- show databases;

create database vc22;

use vc22;

set sql_safe_updates = 0;



drop table if exists normal_folks;
drop table if exists health_staff;
drop table if exists doctors;
drop table if exists nurses;
drop table if exists assisstants;
drop table if exists administrators;
drop table if exists vaccines;
drop table if exists places;
drop table if exists residence;
drop table if exists health_centers;
drop table if exists offer;
drop table if exists work_at;
drop table if exists live_at;
drop table if exists register;
drop table if exists located_at;
drop table if exists folks;

create table folks
	(ID		varchar(16),
	 first_name		varchar(15),
	 last_name		varchar(15),
	 date_of_birth  date,
     work			numeric(10,0),
     mobile 		numeric(10,0),
     home			numeric(10,0),
     email			varchar(20) not null,
     primary key (ID)
	);

create table normal_folks
	(ID		varchar(16),
     primary key (ID),
     foreign key (ID) references folks(ID)
	);



create table doctors
	(ID		varchar(16),
     department varchar(20),
     
     primary key (ID),
     foreign key (ID) references folks(ID)
	);

create table nurses
	(ID		varchar(16),
     nurse_station_location varchar(20),
     
     primary key (ID),
     foreign key (ID) references folks(ID)
	);

create table assisstants
	(ID		varchar(16),
     assigned_administator varchar(20),
     
     primary key (ID),
     foreign key (ID) references folks(ID)
	);
    
create table administrators
	(ID			varchar(16),
     department varchar(20),
     
     primary key (ID),
     foreign key (ID) references folks(ID)
	);

create table vaccines
	(vaccine_name		varchar(4),
     long_name 			varchar(20),
     start_date_1		date,
     end_date_1			date,
	 start_date_2		date,
     end_date_2			date,
	 start_date_3		date,
     end_date_3			date,
     
     primary key (vaccine_name)
	);

create table places
	(X_coordinates		numeric(4,0),
     Y_coordinates      numeric(4,0),
     street 			varchar(30),
     city				varchar(15),
     state				varchar(15),
     zip				numeric(5,0),
     
     primary key (X_coordinates, Y_coordinates,city,state),
     unique(X_coordinates, Y_coordinates)
	);
    
create table health_staff
	(ID		varchar(16),
     start_date date,
     end_date date,
     X_coordinates		numeric(4,0),
     Y_coordinates      numeric(4,0),
     
     primary key (ID,X_coordinates, Y_coordinates),
     foreign key (ID) references folks(ID),
     foreign key (X_coordinates, Y_coordinates) references places(X_coordinates, Y_coordinates)
	);
    
create table residence
	(X_coordinates		numeric(4,0),
     Y_coordinates      numeric(4,0),
     households			numeric(3,0),
	 city				varchar(15),
     state				varchar(15),

     
     primary key (X_coordinates, Y_coordinates, city, state),
     foreign key (X_coordinates, Y_coordinates,city, state) references places(X_coordinates, Y_coordinates,city, state)

	);

create table health_centers
	(X_coordinates		numeric(4,0),
     Y_coordinates      numeric(4,0),
     acronyms			varchar(6),
     weekday			varchar(10),
     start_time			time,
     end_time			time,
     
     
     primary key (X_coordinates, Y_coordinates),
     foreign key (X_coordinates, Y_coordinates) references places(X_coordinates, Y_coordinates)

	);

create table offer
	(ID				varchar(16),
	 vaccine_name	varchar(4),
     
     primary key (ID, vaccine_name),
     foreign key (ID) references doctors (ID)
		on delete cascade,
	 foreign key (vaccine_name) references vaccines(vaccine_name)
		on delete cascade
	);

create table work_at
	(ID				varchar(16),
	 X_coordinates		numeric(4,0),
     Y_coordinates      numeric(4,0),
     
     primary key (ID, X_coordinates, Y_coordinates),
     foreign key (ID) references health_staff(ID)
		on delete cascade,
     foreign key (X_coordinates, Y_coordinates) references places(X_coordinates, Y_coordinates)
	);
    
create table live_at
	(ID					varchar(16),
	 X_coordinates		numeric(4,0),
     Y_coordinates      numeric(4,0),
     
     primary key (ID, X_coordinates, Y_coordinates),
     foreign key (ID) references folks(ID)
		on delete cascade,
     foreign key (X_coordinates, Y_coordinates) references places(X_coordinates, Y_coordinates)
	);

create table located_at
	(vaccine_name		varchar(6),
	 X_coordinates		numeric(4,0),
     Y_coordinates      numeric(4,0),
     
     primary key (vaccine_name, X_coordinates, Y_coordinates),
     foreign key (vaccine_name) references vaccines(vaccine_name)
		on delete cascade,
     foreign key (X_coordinates, Y_coordinates) references places(X_coordinates, Y_coordinates)
	);

create table register
	(ID					varchar(16),
     vaccine_name		varchar(4),
	 X_coordinates		numeric(4,0),
     Y_coordinates      numeric(4,0),
     date 				date,
     city				varchar(15),
     X_live_at	    	numeric(4,0),
     Y_live_at	    	numeric(4,0),
     primary key (ID, vaccine_name, X_coordinates, Y_coordinates,city),
     foreign key (ID) references folks(ID)
		on delete cascade,
     foreign key (vaccine_name) references vaccines(vaccine_name)
		on delete cascade,
     foreign key (X_coordinates, Y_coordinates,city) references places(X_coordinates, Y_coordinates,city),
     foreign key (X_live_at, Y_live_at) references live_at(X_coordinates, Y_coordinates)
	);

delete from normal_folks;
delete from health_staff;
delete from doctors;
delete from nurses;
delete from assisstants;
delete from administrators;
delete from vaccines;
delete from places;
delete from residence;
delete from health_centers;
delete from offer;
delete from work_at;
delete from live_at;
delete from register;
delete from located_at;
delete from folks;

insert into folks values ('1111111111111111', 'Max','Mao','1965-10-24',1111111111, null, null, 'maxmao1@gmail.com');
insert into folks values ('1111111111111112', 'Matt','Mao','1965-10-25',1111111112, null, null, 'maxmao2@gmail.com');
insert into folks values ('1111111111111113', 'May','Mao','1965-10-26',1111111113, null, null, 'maxmao3@gmail.com');
insert into folks values ('1111111111111114', 'Mia','Mao','1965-10-27',1111111114, null, null, 'maxmao4@gmail.com');
insert into folks values ('1111111111111115', 'Mason','Mao','1965-10-28',1111111115, null, null, 'maxmao5@gmail.com');
insert into folks values ('1111111111111116', 'Madison','Mao','1965-10-29',1111111116, null, null, 'maxmao6@gmail.com');
insert into folks values ('1111111111111117', 'Malia','Mao','1965-10-30',1111111117, null, null, 'maxmao7@gmail.com');
insert into folks values ('1111111111111118', 'Maria','Mao','1965-10-31',1111111118, null, null, 'maxmao8@gmail.com');
insert into folks values ('1111111111111119', 'Mira','Mao','1965-11-01',1111111119, null, null, 'maxmao9@gmail.com');
insert into folks values ('1111111111111110', 'Maverick','Mao','1965-11-02',111111110, null, null, 'maxmao10@gmail.com');
insert into folks values ('1111111111111101', 'Michael','Mao','1965-11-03',1111111101, null, null, 'maxmao11gmail.com');
insert into folks values ('1111111111111102', 'Mike','Mao','1965-11-04',1111111102, null, null, 'maxmao12@gmail.com');



insert into normal_folks values ('1111111111111117');
insert into normal_folks values ('1111111111111118');
insert into normal_folks values ('1111111111111119');
insert into normal_folks values ('1111111111111110');
insert into normal_folks values ('1111111111111101');
insert into normal_folks values ('1111111111111102');

insert into doctors values('1111111111111111', 'General Surgery');
insert into doctors values('1111111111111112', 'Infectious Disease');

insert into nurses values('1111111111111113', 'Third Floor');

insert into assisstants values('1111111111111115', 'Madison Mao');

insert into administrators values('1111111111111116', 'General Surgery');
insert into administrators  values('1111111111111114', 'Infectious Disease');

insert into vaccines values('AA00', 'Pfizer','2019-01-01','2019-01-07','2019-01-08', '2019-01-15','2019-01-16','2019-01-23');
insert into vaccines values('AB01', 'Moderna','2019-02-01','2019-02-07','2019-02-08', '2019-02-15','2019-02-16','2019-02-23');
insert into vaccines values('AC02', 'Johnson&Johnson','2019-03-01','2019-03-07','2019-03-08', '2019-03-15','2019-03-16','2019-03-23');
insert into vaccines values('AD03', 'CMSC461','2019-04-01','2019-04-07','2019-04-08', '2019-04-15','2019-04-16','2019-04-23');

insert into places values(0,0,'1000 Hilltop Cir','Baltimore','MD','21025');
insert into places values(0,1,'1001 Hilltop Cir','Sacramento','CA','21025');
insert into places values(0,2,'1002 Hilltop Cir','Detroit','MI','21025');
insert into places values(0,3,'1003 Hillbot','College Park','CA','20742');
insert into places values(0,4,'1004 Hillbot','College Park','CA','20742');
insert into places values(0,5,'1005 Hillbot','College Park','CA','20742');

insert into residence values (0,0,7,'Baltimore','MD');
insert into residence values (0,1,3,'Sacramento','CA');
insert into residence values (0,2,2,'Detroit','MI');

insert into health_centers values (0,3,'BA00','Monday','00:00:00','12:00:00');
insert into health_centers values (0,4,'BC00','Tuesday','01:00:00','13:00:00');
insert into health_centers values (0,5,'BD00','Wednesday','02:00:00','14:00:00');

insert into health_staff values('1111111111111111', '2019-01-01','2021-01-01',0,3);
insert into health_staff values('1111111111111112', '2019-01-02','2021-01-02',0,4);
insert into health_staff values('1111111111111113', null,null,0,5);
insert into health_staff values('1111111111111114', '2019-01-03','2021-01-03',0,3);
insert into health_staff values('1111111111111115', '2019-01-04','2021-01-04',0,4);
insert into health_staff values('1111111111111116', '2019-01-05','2021-01-05',0,5);

insert into offer values ('1111111111111111', 'AA00');
insert into offer values ('1111111111111111', 'AB01');
insert into offer values ('1111111111111112','AC02');
insert into offer values ('1111111111111112','AD03');

insert into work_at values('1111111111111111',0,3);
insert into work_at values('1111111111111111',0,4);
insert into work_at values('1111111111111111',0,5);
insert into work_at values('1111111111111112',0,3);
insert into work_at values('1111111111111113',0,3);
insert into work_at values('1111111111111115',0,4);
insert into work_at values('1111111111111116',0,4);
insert into work_at values('1111111111111114',0,4);

insert into live_at values('1111111111111111',0,0);
insert into live_at values('1111111111111112',0,0);
insert into live_at values('1111111111111113',0,1);
insert into live_at values('1111111111111115',0,1);
insert into live_at values('1111111111111116',0,2);
insert into live_at values('1111111111111114',0,2);
insert into live_at values('1111111111111117',0,0);
insert into live_at values('1111111111111118',0,0);
insert into live_at values('1111111111111119',0,1);
insert into live_at values('1111111111111110',0,1);
insert into live_at values('1111111111111101',0,2);
insert into live_at values('1111111111111102',0,2);

insert into located_at values ('AA00',0,3);
insert into located_at values ('AB01',0,3);
insert into located_at values ('AC02',0,4);
insert into located_at values ('AD03',0,5);

insert into register values ('1111111111111111','AA00',0,3,'2019-01-01','College Park',0,0);
insert into register values ('1111111111111112','AA00',0,3,'2019-01-05','College Park',0,0);
insert into register values ('1111111111111113','AA00',0,3,'2019-01-08','College Park',0,1);
insert into register values ('1111111111111114','AB01',0,3,'2019-02-09','College Park',0,2);
insert into register values ('1111111111111115','AB01',0,3,'2019-02-14','College Park',0,1);
insert into register values ('1111111111111116','AB01',0,3,'2019-02-23','College Park',0,2);
insert into register values ('1111111111111117','AC02',0,4,'2019-03-23','College Park',0,0);
insert into register values ('1111111111111118','AC02',0,4,'2019-03-01','College Park',0,0);
insert into register values ('1111111111111119','AC02',0,4,'2019-03-22','College Park',0,1);
insert into register values ('1111111111111110','AD03',0,5,'2019-04-23','College Park',0,1);
insert into register values ('1111111111111101','AD03',0,5,'2019-04-02','College Park',0,2);
insert into register values ('1111111111111102','AD03',0,5,'2019-04-16','College Park',0,2);

select* from folks;


-- use the commented code below to test and load things from queryAll
-- set session transaction isolation level read uncommitted;

-- start transaction;

-- insert code here

-- rollback;
