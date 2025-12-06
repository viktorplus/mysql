use northwind;
-- SELECT * FROM products;
-- SELECT product_name, standard_cost, list_price FROM products;
-- SELECT product_name, standard_cost, list_price, list_price - standard_cost FROM products;
-- SELECT product_name, list_price - standard_cost as newname FROM products; 
SELECT reorder_level, target_level FROM products WHERE reorder_level*2=target_level;
select * from northwind.products where product_code like '%NWTSO%' and standard_cost = 1 or list_price < 5 and target_level = 40;