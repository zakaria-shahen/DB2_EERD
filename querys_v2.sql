-- ============================================================================
-- لمعرفة اجمالي الفاتورة قبل الضرائب والخصم
-- Create view
create view Invoice_Before as
select 
    iif(sum(Booked__Service.price) is null, sum(Booked__Room.price), 
        sum(Booked__Room.price) + sum(Booked__Service.price)) as "Total berfore Discount"
from Invoice_Details
Left join Booked__Room on Invoice_Details.id_by_booked = Booked__Room.booked
left join Booked__Service on Invoice_Details.id_by_booked = Booked__Service.booked;

-- usgin View
select * from Invoice_Before;
-- ============================================================================


-- ============================================================================
-- لمعرفة قيمة الفاتورة مع الضرائب والخصم
-- create view  
create view Invoice as
select
    iif(sum(Booked__Service.price) is null, sum(Booked__Room.price), 
        sum(Booked__Room.price) + sum(Booked__Service.price)) as "Price",
    sum(Invoice_Details__Discount.value_) as "Discount",
    sum(Invoice_Details__Fees.value_) as "Fees"
from Invoice_Details
Left join Booked__Room on Invoice_Details.id_by_booked = Booked__Room.booked
left join Booked__Service on Invoice_Details.id_by_booked = Booked__Service.booked
left join Invoice_Details__Discount on Invoice_Details.id_by_booked = Invoice_Details__Discount.invoice_details
left join Invoice_Details__Fees on invoice_details.id_by_booked = Invoice_Details__Fees.invoice_details;

-- using view
select * from Invoice;
-- ============================================================================


-- ============================================================================
--  عرض بيانات كل الغرف الفندق
select 
    Room.id as "ID",
    Room.location_ as "Loaction",
    Room_Bed.name_ as "Room_Bed",
    Room_Layout.name_ as "Room_Layout",
    Room_Occupancy.name_ as "Room_Occupancy",
    Room_category.description_ as "description_"
from Room 
left join Room_category on Room.room_category = Room_category.id
left join Room_Bed on Room_category.room_bed = Room_Bed.id
left join Room_Layout on Room_category.room_bed = Room_Layout.id
left join Room_Occupancy on Room_category.room_bed = Room_Occupancy.id
-- ============================================================================