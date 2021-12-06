## Rooms

### option One

- **schema** 

![rooms schema](/rooms_schema_1.png)


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



### option Two 

