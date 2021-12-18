CREATE DATABASE Db2_Project;
USE Db2_Project;
--------------------------------------------------------

drop table if exists Room_Occupancy
create table Room_Occupancy
(
    id tinyint primary key,
    name_ char(10)
)

drop table if exists Room_Bed
create table Room_Bed
(
    id tinyint primary key,
    name_ char(10)
)

drop table if exists Room_Layout
create table Room_Layout
(
    id tinyint primary key,
    name_ char(10)
)

--------------------------------------------------------

drop table if exists Room_Category
create table Room_Category
(
    id tinyint primary key,
    name_ char(10),
    room_occupancy tinyint foreign key references Room_Occupancy(id),
    room_bed tinyint foreign key references Room_Bed(id),
    room_layout tinyint foreign key references Room_Layout(id)
)

drop table if exists Rooms
create table Rooms
(
    id smallint primary key,
    room_category tinyint foreign key references Room_Category(id)
)

----------------------------------------

drop table if exists Booked_Rooms
create table Booked_Rooms
(
    id smallint primary key,
    booking_date datetime2,
    check_in_date datetime2,
    check_out_date datetime2,
    duration as check_out_date - check_in_date,
    total_price smallmoney
)

drop table if exists Used_Rooms
create table Used_Rooms
(
    rooms smallint foreign key references Rooms(id),
    booked_rooms smallint foreign key references Booked_Rooms(id),
    primary key (rooms, booked_rooms)
)

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

drop table if exists Services
create table Services
(
    id tinyint primary key,
    name_ varchar(20),
    details text,
    price smallmoney
)

drop table if exists Booked_Services
create table Booked_Services
(
    id smallint primary key,
    booking_date datetime2,
    total_price smallmoney
)

drop table if exists Used_Services
create table Used_Services
(
    services tinyint foreign key references Services(id) ,
    booked_services tinyint foreign key references Booked_Services(id) ,
    primary key (services, booked_services)
)

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

drop table if exists Companion
create table Companion
(
    id smallint primary key,
    full_name varchar(40),
)

drop table if exists Bookings_Details__Companion
create table Bookings_Details__Companion
(
    companion smallint foreign key references Companion(id),
    bookings_details smallint foreign key references Bookings_Details(id),
    primary key (companion, bookings_details)
)