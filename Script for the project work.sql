-- DATA CLEANING IN MYSQL
select* 
from product_order;
select*
From product_category;
select*
from sales_order;

-- checking data type and null values
describe product_order;
describe productcategorytext;
describe sales_order;

-- deleting unecessary columns from table product_order
alter table product_order
drop column  QUANTITYUNIT;

-- renaming columns name (first name) First_name
alter table product_order
change ï»¿PRODUCTID ProductId varchar(255);

alter table product_order
change PRODCATEGORYID productcategoryId text,
change TYPECODE TypeCode text,
change CREATEDBY Createdby int,
change CREATEDAT CreateDate date,
change CHANGEDBY ChangedBy int,
change CHANGEDAT ChangedAt date,
change SUPPLIER_PARTNERID SupplierPartnerId int,
change TAXTARIFFCODE TaxTariffCode int,
change WEIGHTMEASURE WeightMeasure double,
change WEIGHTUNIT WeightUnit text,
change CURRENCY Currency text,
change PRICE Price int;

-- renaming table name 
alter table productorder
rename product_order;

alter table salesorder
rename sales_order;

alter table productcategorytext
rename product_category;

alter table product_category
change ï»¿PRODCATEGORYID ProductCategoryId text,
change LANGUAGE Language text,
change Product_category_name ProductCategoryName varchar(225);

alter table sales_order
drop column QUANTITYUNIT,
drop column delivery_date;

alter table sales_order
change ï»¿SALESORDERID SalesOrderId Int,
change SALESORDERITEM SalesOrderItem int,
change PRODUCTID ProductId varchar(225),
change CURRENCY Currency text,
change GROSSAMOUNT GrossAmount int,
change NETAMOUNT NetAmount double,
change TAXAMOUNT TaxAmount double,
change QUANTITY Quantity int,
change DELIVERYDATE DeliveryDate int;

-- joining tables
select*
from product_order Po
join product_category Pc
on Po.productcategoryId = Pc.ProductCategoryId
join sales_order So
on Po.ProductId = So. ProductId;

-- Find the total number of products for each product category
select ProductCategoryName CATEGORY, count(Quantity) QUANTITY
from product_order Po
join product_category Pc
on Po.productcategoryId = Pc.ProductCategoryId
join sales_order So
on Po.ProductId = So.ProductId
Group by ProductCategoryName
Order by QUANTITY DESC
limit 5;


-- make the netamount and the taxamount 2 decimal places
update sales_order
set NetAmount = round(NetAmount, 2);
update sales_order
set TaxAmount = round(TaxAmount, 2);

-- List the top 5 most expensive products category
select  ProductCategoryName Category, sum(Price) Price
from product_order po
join product_category pc
on po.ProductCategoryId = pc.ProductCategoryId
group by Category
order by price desc
limit 5;
 -- Find all products that belongs to the mountain bike category
 select  ProductId, ProductCategoryName
from product_order po
join product_category pc
on po.ProductCategoryId = pc.ProductCategoryId
WHERE ProductCategoryName = "Mountain Bike";

-- List the total sales amount(gross) for each product category
select ProductCategoryName CATEGORY, sum(GrossAmount) Amount
from product_order Po
join product_category Pc
on Po.productcategoryId = Pc.ProductCategoryId
join sales_order So
on Po.ProductId = So.ProductId
group by CATEGORY
Order by Amount desc;

-- Top 5 suppliers by Grossamount (merge all tables)
select SupplierPartnerId suppliers, sum(GrossAmount) Sales_amount
from product_category pc
join product_order po
on pc.ProductCategoryId = po.ProductCategoryId
join sales_order so
on po.ProductId =so.ProductId
group by suppliers
order by Sales_amount desc
limit 5;

-- total grossamount for each sales order (use sales_order table only)
select SalesOrderId Sales_order, sum(GrossAmount) Gross_sales
from sales_order
group by Sales_order
order by Gross_sales desc
limit 10;


-- highest selling product by net amount (use sales_order table)
select ProductId Product, ROUND(sum(NetAmount), 2) Amount
from sales_order
group by Product
ORDER BY Amount DESC
limit 1;

-- product category with the highest quantity (join all tables)
select ProductCategoryName Product_category, sum(Quantity) Quantity
from product_category pc
join product_order po
on pc.ProductCategoryId = po.ProductCategoryId
join sales_order so
on po.ProductId =so.ProductId
group by Product_category
order by Quantity desc
limit 1;

-- total revenue for mountain bike and BMX
select ProductCategoryName Product_category, ROUND(sum(NetAmount), 2) Amount
from product_category pc
join product_order po
on pc.ProductCategoryId = po.productcategoryId
join sales_order so
on po.ProductId =so.ProductId
where ProductCategoryName in ("Mountain Bike", "BMX")
group by Product_category
order by Amount desc;
