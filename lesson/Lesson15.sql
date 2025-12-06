--  Вычислите суммарную прибыль компании для каждой категории для продуктов с 
-- target_level больше 40
-- Прибыль компании вычисляется как list_price - standard_cost

SELECT * FROM northwind.products;

SELECT 
category, group_concat(product_name),
sum(list_price - standard_cost) as total_profit

 FROM northwind.products
 where target_level > 40
 group by category;
 
-- 4. Посчитайте количество продуктов, для которых отсутсвует minimum_reorder_quantity 

-- 4.1 Посчитайте количество продуктов для каждой категории, для которых отсутсвует minimum_reorder_quantity  и отобразите те, которых больше 3

select count(id) as prod_count from products
where minimum_reorder_quantity is NULL;

-- variant2
select count(*) from products
where minimum_reorder_quantity is NULL;

select category, count(*) as prod_count from products
GROUP BY category
HAVING prod_count > 3;

-- 7. Найти средний standard_cost только для тех продуктов, которые продаются коробками quantity_per_unit