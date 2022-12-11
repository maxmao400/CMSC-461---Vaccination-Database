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

