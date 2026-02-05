-- Пронумеруйте строки в соответствии с убывание inventory_id. Выведите только 13 строчку.
-- purchase_order_details
USE nortwind;
SELECT * FROM purchase_order_details;
select *, 
	row_number () over (order by invertory_id desc)
from purchase_order_details;

with t as 
(select *, 
row_number () over (order by inventory_id desc) as row_num
from purchase_order_details)
select * from t
where row_num = 13;

select *
from purchase_order_details
order by inventory_id desc
limit 1;

