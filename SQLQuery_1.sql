-- CREATE DATABASE Db2_2;
-- USE Db2_2;
-- --------------------------------------------------------

-- use master;
-- drop database Db2_2;


create table Room_Occupancy(
    id tinyint,
    name_ char(10),
    primary key(id)
);

create table Room_Bed(
    id tinyint,
    name_ char(10),
    primary key(id)
);

create table Room_Layout(
    id tinyint,
    name_ char(10),
    primary key(id)
);

--------------------------------------------------------

create table Room_Category(
    id tinyint,
    name_ char(10),
    room_occupancy tinyint,
    room_bed tinyint,
    room_layout tinyint,
    primary key(id),
    foreign key(room_occupancy) references Room_Occupancy(id),
    foreign key(room_bed) references Room_Bed(id),
    foreign key(room_layout) references Room_Layout(id)
);

create index room_occupancy on Room_Category(room_occupancy);
create index room_bed on Room_Category(room_bed);
create index room_layout on Room_Category(room_layout);

create table Rooms(
    id smallint, -- LOOK: change(Rooms) to tinyint? 
    room_category tinyint,
    primary key(id),
    foreign key(room_category) references Room_Category(id)
);

create index room_category on Rooms(room_category);

----------------------------------------

create table Booked_Rooms(
    id smallint, -- chenge data type to int ? 
    booking_date datetime2,
    check_in_date datetime2,
    check_out_date datetime2,
    -- duration as check_out_date - check_in_date, -- invalid syntaxt => move to select (only)
    -- total_price smallmoney, -- why?Edit here Comment: @zakaria-shshen
    -- Where Loaction attr?
    primary key(id)
);


create table Booked_Rooms__Rooms(
    rooms smallint,
    booked_rooms smallint,
    primary key (rooms, booked_rooms),
    foreign key(booked_rooms) references Booked_Rooms(id),
    foreign key(rooms) references Rooms(id)
);

create index rooms on Booked_Rooms__Rooms(rooms);
create index booked_rooms on Booked_Rooms__Rooms(booked_rooms);

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

create table Services(
    id tinyint,
    name_ varchar(20),
    details text,
    price smallmoney,
    primary key(id)
);

-- this Table(Booked_Services) remove (in review)
-- chenge name to logs_services
create table Booked_Services(
    id smallint, -- change data tpye to int?
    booking_date datetime2,
    total_price smallmoney, -- Look here
    services tinyint,
    primary key(id),
    foreign key(services) references Services(id)
);

create index services on Booked_Services(services);

create table Booked_Services__Services(
    services tinyint,
    booked_services smallint,
    primary key (services, booked_services),
    foreign key(booked_services) references Booked_Services(id),
    foreign key(services) references Services(id)
)

create index booked_services on Booked_Services__Services(booked_services);
create index services on Booked_Services__Services(services);

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------


-- 
-- @zakaria-shahen next..
-- 

-- create database DB2_Project;
-- use DB2_Project;

create table People(
    id smallint,
    f_name varchar(20),
    m_name varchar(20),
    l_name varchar(20),
    country varchar(20),
    city varchar(20),
    street varchar(40),
    nationality_code char(5),
    brith date,
    email varchar(40),
    primary key(id)
);

create table People_Phone(
    id smallint,
    phone varchar(20),
    primary key(id, phone),
    foreign key(id) references People(id)
);

create index phone_index on People_Phone(phone);

create table Guests(
    id smallint,
    primary key(id),
    foreign key(id) references People(id)
);


create table Relationship(
    id tinyint identity(1, 1),
    type_ varchar(20),
    primary key(id)
)


create table Family(
    id tinyint,
    name_ varchar(40),
    guest smallint,
    relationship tinyint,
    primary key(id, guest), 
    foreign key(guest) references Guests(id),
    foreign key(relationship) references Relationship(id)
);

create index guest on Family(guest);
create index relationship on Family(relationship);

create table Payment_method(
    id tinyint,
    type_ varchar(10),
    primary key(id)
); 

-- Payment method
create table Payment(
    id tinyint identity(1, 1), -- Look here
    card_number tinyint,
    favorite bit,
    guests smallint unique not null,
    payment_method tinyint unique not null,
    primary key (id),
    foreign key(guests) references Guests(id),
    foreign key(payment_method) references Payment_method(id) 
);

create index guests on Payment(guests);
create index payment_method on Payment(payment_method);

create table Invoice(
    id smallint,
    fees smallmoney,
    price smallmoney,
    date_ date,
    bookings_details tinyint unique not null,
    primary key (id)
);

create index bookings_details on Invoice(bookings_details)

create table Discount(
    id tinyint,
    type_ varchar(40),
    discount_rate tinyint,
    start_ datetime2, 
    end_ datetime2,
    primary key(id)
);

create table Discount_Invoice(
    invoice smallint,
    discount tinyint,
    primary key(invoice, discount),
    foreign key(invoice) references Invoice(id),
    foreign key(discount) references Discount(id)

);

create index invoice on Discount_Invoice(invoice);
create index discount on Discount_Invoice(discount);

create table Job_Title(
    id tinyint,
    name_ varchar(40),
    primary key(id)
);


create table Employees(
    id smallint,
    salary smallmoney,
    work_hours tinyint,
    hire_date date,
    creer_level tinyint,
    job_title tinyint,
    primary key(id),
    foreign key(id) references People(id),
    foreign key(job_title) references Job_Title(id)
);

create index job_title on Employees(job_title);


-- After Guests and Employees and jobTitel

create table Rate(
    id smallint identity(1, 1),
    rate tinyint check(rate >= 1 and rate <= 5),
    bookings_details smallint,
    primary key(id)
);

create table Rate__Employees(
    employees smallint,
    rate smallint,
    foreign key(employees) references Employees(id),
    foreign key(rate) references Rate(id)
);

create index exmployees on Rate__Employees(employees);
create index rate on Rate__Employees(rate);

create table Bookings_Details(
    id smallint identity(1, 1),
    guests smallint,
    booked_rooms smallint,
    booked_services smallint,
    rate smallint not null,
    invoice smallint not null,
    primary key(id),
    -- primary key(guests, booked_rooms, booked_services),
    foreign key(guests) references Guests(id),
    foreign key(booked_rooms) references Booked_Rooms(id),
    foreign key(booked_services) references Booked_Services(id),
    foreign key(invoice) references Invoice(id)
    
);

create table Companion(
    id smallint,
    full_name varchar(40),
    primary key(id)
)

create table Bookings_Details__Companion(
    companion smallint,
    bookings_details smallint,
    primary key (companion, bookings_details),
    foreign key(companion) references Companion(id),
    foreign key(bookings_details) references Bookings_Details(id)
)

