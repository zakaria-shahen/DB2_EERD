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
-- Comment

-- ============================================================================


-- ============================================================================
-- Comment

-- ============================================================================


-- ============================================================================
-- Comment

-- ============================================================================


-- ============================================================================
-- Comment

-- ============================================================================


-- ============================================================================
-- Comment

-- ============================================================================

