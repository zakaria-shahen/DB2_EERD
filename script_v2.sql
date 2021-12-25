-- Create a new database called 'Hotel'
use master;
drop database if exists Hotel;
create database Hotel;
use Hotel;

-- Cerate tables 

create table People(
    id int identity(1, 1),
    first_name varchar(20) not null,
    last_name varchar(40),
    email varchar(40),
    street varchar(100),
    city varchar(40),
    country varchar(40),
    brith_date date,
    primary key(id)
);

create table People__Phone(
    people int,
    phone varchar(20),
    primary key(people, phone),
    foreign key(people) references People(id)
);

create table Department(
    id tinyint identity(1, 1),
    name_ varchar(40),
    primary key(id)
);

create table Employee(
    id smallint identity(1, 1),
    salary smallmoney,
    work_hours tinyint,
    hire_date date,
    people int not null unique,
    department tinyint,
    primary key(id),
    foreign key(people) references People(id),
    foreign key(department) references Department(id)
);
create index people on Employee(people);
create index department on Employee(department);

create table Guest(
    id int identity(1, 1),
    people int not null unique,
    primary key(id),
    foreign key(people) references People(id)
);
create index people on Guest(people);


create table Reservation_Owner(
    id int,
    primary key(id),
    foreign key(id) references Guest(id)
);

--  other name table=> accompanying 
create table Attendant(
    id int,
    primary key(id),
    foreign key(id) references Guest(id)
);

create table Booked(
    id int identity(1, 1),
    Booking_date date,
    Check_in date,
    Check_out date,
    primary key(id)
);


create table Booked__Reservation_Owner(
    booked int,
    reservation_owner int,
    primary key(booked, reservation_owner),
    foreign key(booked) references Booked(id),
    foreign key(reservation_owner) references Reservation_Owner(id)
);

create table Booked__Attendant(
    booked int,
    attendant int,
    type_realtion varchar(40),
    primary key(booked, attendant),
    foreign key(booked) references Booked(id),
    foreign key(attendant) references Attendant(id)
);


create table Room_Bed (
    id tinyint identity(1, 1),
    names varchar(40),
    primary key(id)
);

create table Room_Occupancy(
    id tinyint identity(1, 1),
    names varchar(40),
    primary key(id)
);

create table Room_Layout(
    id tinyint identity(1, 1),
    names varchar(40),
    primary key(id)
);

create table Room_category(
    id tinyint identity(1, 1),
    description_ text,
    room_bed tinyint,
    room_occupancy tinyint,
    room_layout tinyint,
    primary key(id),
    foreign key(room_bed) references Room_Bed(id),
    foreign key(room_occupancy) references Room_Occupancy(id),
    foreign key(room_layout) references Room_Layout(id)
);
create index room_bed on Room_category(room_bed);
create index room_occupancy on Room_category(room_occupancy);
create index room_layout on Room_category(room_layout);

create table Room(
    id smallint identity(1, 1),
    room_category tinyint,
    location_ varchar(40),
    primary key(id),
    foreign key(room_category) references Room_category(id)
);
create index room_category on Room(room_category)

create table Booked__Room(
    booked int,
    room smallint,
    price smallmoney,
    primary key(booked, room),
    foreign key(booked) references Booked(id),
    foreign key(room) references Room(id)
);
create index booked on Booked__Room(booked)
create index room on Booked__Room(room)

create table Payment_Method(
    id tinyint,
    type_ varchar(40),
    primary key(id)
);

create table Payment_Saved(
    id int,
    card_number tinyint,
    payment_method tinyint,
    reservation_owner int,
    primary key(id),
    foreign key(payment_method) references Payment_Method(id),
    foreign key(reservation_owner) references Reservation_Owner(id)
);
create index payment_method on Payment_Saved(payment_method)
create index reservation_owner on Payment_Saved(reservation_owner)

create table Payment_Default(
    payment_saved int,
    primary key(payment_saved),
    foreign key(payment_saved) references Payment_Saved(id)
);

create table Invoice_Details(
    id_by_booked int,
    pay_date date,
    primary key(id_by_booked),
    foreign key(id_by_booked) references Booked(id)
);


create table Discount(
    id smallint,
    start_date_ date,
    end_date date,
    condition varchar(100), -- or JSON 
    Details text,
    primary key(id)
);

create table Invoice_Details__Discount(
    value_ smallint,
    invoice_details int,
    discount smallint,
    primary key(invoice_details, discount),
    foreign key(invoice_details) references Invoice_Details(id_by_booked),
    foreign key(discount) references Discount(id)
);

create table Fees(
    id tinyint,
    name_ varchar(40),
    condition varchar(100),
    Details text,
    primary key(id)
);

create table Invoice_Details__Fees(
    value_ smallint,
    fees tinyint,
    invoice_details int,
    primary key(fees, invoice_details),
    foreign key(fees) references Fees(id),
    foreign key(invoice_details) references Invoice_Details(id_by_booked)
);

create table rete(
    invoice_details int,
    rate tinyint check(rate >= 1 and  rate <= 10),
    description_ text,
    primary key(invoice_details),
    foreign key(invoice_details) references Invoice_Details(id_by_booked)
);

create table Service_(
    id tinyint identity(1, 1),
    name_ varchar(40),
    price smallmoney,
    details text,
    primary key(id)
);

create table Booked__Service(
    service_ tinyint,
    Booked int,
    price smallmoney,
    primary key(service_, Booked),
    foreign key(service_) references Service_(id),
    foreign key(booked) references Booked(id)
);