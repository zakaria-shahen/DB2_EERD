## Rooms

### Option One

- **schema** 

![rooms schema - modal 1](/rooms_schema_1.png)


- **T-SQL**

```sql
drop table if exists cetagory_value;
drop table if exists cetagory_column; 
drop table if exists rooms;
drop table if exists cetagory;  

create table cetagory(
  id int identity(1, 1),
  name varchar(50),
  primary key(id)
);

create table rooms(
  id int,
  price money,
  cetagory int,
  primary key(id),
  foreign key(cetagory) references cetagory(id)  
 
);

create table cetagory_column(
  id int identity(1, 1),
  name varchar(50),
  cetagory int,
  primary key(id),
  -- primary key(id, name, cetagory),
  foreign key(cetagory) references cetagory(id)
);

create table cetagory_value(
  value varchar(50),
  room_id int,
  cetagory_column int, 
  primary key(room_id, cetagory_column),
  foreign key(room_id) references rooms(id),
  foreign key(cetagory_column) references cetagory_column(id)
);
```



### Option Two 

- **schema**

![rooms schema - modal 2](/rooms_schema_2.png)


- **T-SQL**

```sql
drop table if exists rooms;
drop table if exists rooms_layout;
drop table if exists rooms_bed;
drop table if exists rooms_occupancy;


create table rooms_layout
(
    id int primary key,
    name varchar(50)
);


create table rooms_bed
(
    id int primary key,
    name varchar(50)
);


create table rooms_occupancy
(
    id int primary key,
    name varchar(50)
);


create table rooms
(
    id int,
    location_ varchar(50),
    price money,
    rooms_layout int,
    rooms_bed int,
    rooms_occupancy int,
    primary key(id),
    foreign key(rooms_layout) references rooms_layout(id),
    foreign key(rooms_bed) references rooms_bed(id),
    foreign key(rooms_occupancy) references rooms_occupancy(id)
);
```


## Option There

- **schema** 
  
- **T-SQL**

```sql

```