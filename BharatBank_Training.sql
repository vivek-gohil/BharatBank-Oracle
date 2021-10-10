--DDL ::  Data Defination
--1.Create Table - Done
CREATE TABLE persons (
    person_id NUMBER(5),
    first_name VARCHAR2(20),
    last_name varchar(20)
);

DESC persons;
DESCRIBE persons;

SELECT
    *
FROM
    persons;

--Oracle Alter Table
--1.Add column 
ALTER TABLE persons
ADD birthdate DATE NOT NULL;

DESC persons;

--2.Add multiple columns
ALTER TABLE persons
ADD (
    phone VARCHAR(20),
    email VARCHAR(50)
);

DESC persons;

--3. change the birthdate column to a null-able column
ALTER TABLE persons
MODIFY birthdate DATE NULL;

DESC persons;

--4. Modify multiple columns
ALTER TABLE persons
MODIFY (
    phone  VARCHAR2(20) NOT NULL,
    email VARCHAR2(50) NOT NULL
);

ALTER TABLE persons
MODIFY email VARCHAR2(30);

DESC persons;

--5. Drop Single Column
ALTER TABLE persons
DROP COLUMN birthdate;

DESC persons;

--6. Drop Multiple Column
ALTER TABLE persons
DROP (
 email,phone
);
DESC persons;

--7.Rename column
ALTER TABLE persons
RENAME COLUMN first_name TO firstname;

--8.Rename Table 
ALTER TABLE persons RENAME TO people;

DESC persons;
DESC people;

DROP TABLE people;

--Creating a table with virtual column
CREATE TABLE parts(
    part_id NUMBER(4),
    part_name VARCHAR2(50) NOT NULL,
    capacity INT NOT NULL,
    cost DEC(15,2) NOT NULL,
    list_price DEC(15,2) NOT NULL,
    gross_margin as (list_price - cost) --virtual column
);

--Insert recoreds in table
INSERT INTO parts(part_id,part_name,capacity,cost,list_price) VALUES(1,'RGB Screen',16,80,150);

SELECT 
    *
FROM
    parts;
    
TRUNCATE TABLE parts;


--Modifiying Data
--1.Insert 
CREATE TABLE discounts(
    disount_id NUMBER(5),
    discount_name VARCHAR2(50) NOT NULL,
    amount NUMBER(2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

INSERT INTO discounts VALUES(1,'Diwali Promotion' ,30, DATE '2021-10-01' , DATE '2021-10-11');
INSERT INTO discounts VALUES(2,'Summer Promotion' ,20, DATE '2021-04-01' , DATE '2021-04-11');
INSERT INTO discounts VALUES(3,'X-mas Promotion' ,10, DATE '2021-12-01' , DATE '2021-12-11');
INSERT INTO discounts VALUES(4,'Holi Promotion' ,10, DATE '2021-05-01' , DATE '2021-05-11');

SELECT 
    *
FROM 
    discounts;
    
CREATE TABLE promotion_2021(
    disount_id NUMBER(5),
    discount_name VARCHAR2(50) NOT NULL,
    amount NUMBER(2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

SELECT 
    *
FROM 
    promotion_2021;
    
INSERT INTO promotion_2021
SELECT * FROM discounts;

DROP TABLE promotion_2021;

CREATE TABLE promotion_2021
AS
    SELECT
        * 
    FROM
        discounts;

DESCRIB promotion_2021;

--INSERT ALL

CREATE TABLE fruits (
    fruit_name VARCHAR2(50),
    color VARCHAR2(50)
);

INSERT ALL 
    INTO fruits VALUES('Apple','Red')
    INTO fruits VALUES('Orange','Orange')    
    INTO fruits VALUES('Banana','Yello')
SELECT 1 FROM dual;

SELECT
    *
FROM
    fruits;
--2.Update
DROP TABLE parts;

 CREATE TABLE parts (
  part_id NUMBER,
  part_name VARCHAR(50) NOT NULL,
  lead_time NUMBER(2,0) NOT NULL,
  cost NUMBER(9,2) NOT NULL,
  status NUMBER(1,0) NOT NULL
);

INSERT INTO parts VALUES (1,'sed dictum',5,134,0);
INSERT INTO parts VALUES (2,'tristique neque',3,62,1);
INSERT INTO parts VALUES (3,'dolor quam,',16,82,1);
INSERT INTO parts VALUES (4,'nec, diam.',41,10,1);
INSERT INTO parts VALUES (5,'vitae erat',22,116,0);
INSERT INTO parts VALUES (6,'parturient montes,',32,169,1);
INSERT INTO parts VALUES (7,'metus. In',45,88,1);
INSERT INTO parts VALUES (8,'at, velit.',31,182,0);
INSERT INTO parts VALUES (9,'nonummy ultricies',7,146,0);
INSERT INTO parts VALUES (10,'a, dui.',38,116,0);
INSERT INTO parts VALUES (11,'arcu et',37,72,1);
INSERT INTO parts VALUES (12,'sapien. Cras',40,197,1);
INSERT INTO parts VALUES (13,'et malesuada',24,46,0);
INSERT INTO parts VALUES (14,'mauris id',4,153,1);
INSERT INTO parts VALUES (15,'eleifend egestas.',2,146,0);
INSERT INTO parts VALUES (16,'cursus. Nunc',9,194,1);
INSERT INTO parts VALUES (17,'vivamus sit',37,93,0);
INSERT INTO parts VALUES (18,'ac orci.',35,134,0);
INSERT INTO parts VALUES (19,'arcu. Aliquam',36,154,0);
INSERT INTO parts VALUES (20,'at auctor',32,56,1);
INSERT INTO parts VALUES (21,'purus, accumsan',33,12,1);

SELECT 
    *
FROM 
    parts; 

--Update one colum of a single row
--Change the cost to 130 of part with partid = 1
UPDATE
    parts
SET
    cost = 130
WHERE
    part_id = 1;

--Update multiple columns of a single row
--Change the lead_time = 30  , cost = 150 , status = 1 of part with partid = 5;
UPDATE
    parts
SET
    lead_time=30,
    cost=150,
    status=1
WHERE
    part_id=5;
    
SELECT 
    *
FROM 
    parts
WHERE 
    part_id=5;    

--Update multiple rows
--Increate the cost of all parts by 5%
UPDATE 
    parts
SET
    cost = cost * 1.05;

SELECT 
    *
FROM 
    parts;

--3.Delete
--Delete one row from table
--Remove product with part_id = 5;
DELETE
FROM
    parts
WHERE
    part_id = 5;
    
--Delete multiple rows
--Delete parts which have status is 0
DELETE
FROM
    parts
WHERE
    status=0;

SELECT 
    *
FROM 
    parts;
    
--Delete all rows from table
DELETE
FROM
    parts;

--Introduction to the primary key
--A primary key is a column of a combination of columns in a table that uniquely identifies a row in the table.

--The following are rules that make a column a primary key:

--A primary key column cannot contain a NULL value or an empty string.
--A primary key value must be unique within the entire table.
--A primary key value should not be changed over time.

CREATE TABLE purchase_orders (
    po_number NUMBER(5) PRIMARY KEY,
    vendor_id NUMBER(4) NOT NULL,
    po_status NUMBER(1) NOT NULL,
    created_date DATE
);

INSERT INTO purchase_orders
VALUES (NULL,11,1,DATE '2021-10-01');

DESC purchase_orders;

SELECT 
    *
FROM
    USER_CONSTRAINTS
WHERE
    table_name = 'PURCHASE_ORDERS';
    
DROP TABLE purchase_orders;    

CREATE TABLE purchase_orders (
    po_number NUMBER(5) ,
    vendor_id NUMBER(4) NOT NULL,
    po_status NUMBER(1) NOT NULL,
    created_date DATE ,
    CONSTRAINT pk_purchase_orders PRIMARY KEY(po_number)
);

INSERT INTO purchase_orders
VALUES (1,11,1,DATE '2021-10-01');

--Composit Primary key
CREATE TABLE purchase_order_items (
    po_number NUMBER(5),
    item_number NUMBER(4),
    product_id NUMBER(5),
    quantity NUMBER(5),
    delivery_date DATE,
    CONSTRAINT pk_purchase_order_items PRIMARY KEY(po_number,item_number)
);

INSERT INTO purchase_order_items
VALUES (101,1,445,5,DATE '2021-01-01');

INSERT INTO purchase_order_items
VALUES (101,2,446,2,DATE '2021-01-01');

--ERROR
INSERT INTO purchase_order_items
VALUES (101,1,446,2,DATE '2021-01-01');


--Adding a primary key to a table.
--Sometimes you may want to add a primary key constraint to an existing table.

CREATE TABLE vendors (
    vendor_id NUMBER(4),
    vendor_name VARCHAR2(50) NOT NULL,
    address VARCHAR2(100) NOT NULL
);

DELETE FROM vendors;
--Add primary key
ALTER TABLE vendors
ADD CONSTRAINT pk_vendors PRIMARY KEY(vendor_id);

SELECT 
    *
FROM
    USER_CONSTRAINTS
WHERE
    table_name = 'VENDORS';

INSERT INTO vendors
VALUES(1,'Pragati Software','Mumbai');

--Remove Primary key

ALTER TABLE vendors
DROP CONSTRAINT pk_vendors;

SELECT * FROM vendors;

--Enable / Disable an Oracle Primary Key
ALTER TABLE vendors
DISABLE CONSTRAINT pk_vendors;

ALTER TABLE vendors
ENABLE CONSTRAINT pk_vendors;


--Foregin key
--SupplierGroup - supplier_group_id 
CREATE TABLE supplier_groups (
    group_id NUMBER(5),
    group_name VARCHAR2(50),
    CONSTRAINT pk_supplier_groups PRIMARY KEY (group_id)
);

--Supplier - supplier_id
CREATE TABLE supplier (
    supplier_id NUMBER(5),
    supplier_name VARCHAR2(50),
    group_id NUMBER(5) NOT NULL,
    CONSTRAINT pk_supplier PRIMARY KEY (supplier_id),
    CONSTRAINT fk_group_id FOREIGN KEY(group_id) REFERENCES supplier_groups(group_id)
);

INSERT INTO supplier_groups
VALUES(101,'One-Time Supplier');

INSERT INTO supplier_groups
VALUES(102,'Third-party Supplier');

INSERT INTO supplier_groups
VALUES(103,'Inter-cont Supplier');

--Insert records in to supplier

INSERT INTO supplier
VALUES(1,'Toshiba',101);

INSERT INTO supplier
VALUES(2,'Samsung',102);

INSERT INTO supplier
VALUES(3,'Bluestar',102);

INSERT INTO supplier
VALUES(4,'Daikin',103);

INSERT INTO supplier
VALUES(5,'Voltas',103);

INSERT INTO supplier
VALUES(6,'LG',104);


ALTER TABLE supplier
DROP CONSTRAINT fk_group_id;

ALTER TABLE supplier
ADD CONSTRAINT fk_group_id FOREIGN KEY(group_id) REFERENCES supplier_groups(group_id);

ALTER TABLE supplier
DISABLE CONSTRAINT fk_group_id;

ALTER TABLE supplier
ENABLE CONSTRAINT fk_group_id;


--Unique Constraint
DROP TABLE clients;

CREATE TABLE clients (
    client_id NUMBER(5),
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    company_name VARCHAR(40) NOT NULL,
    email VARCHAR2(40) NOT NULL,
    --phone VARCHAR2(12) NOT NULL UNIQUE
    phone VARCHAR2(12) NOT NULL,
    CONSTRAINT unique_phone UNIQUE(phone)
);

INSERT INTO clients
VALUES(1,'Vivek','Gohil','Technial Prashikshan','ghl_vivek@hotmail.com','1234567890');

ALTER TABLE clients
DROP CONSTRAINT unique_phone;

--CHECK CONSTRAINT
DROP TABLE parts;
CREATE TABLE parts (
  part_id NUMBER,
  part_name VARCHAR(50) NOT NULL,
  lead_time NUMBER(2,0) NOT NULL,
  cost NUMBER(9,2) NOT NULL,
  status NUMBER(1,0) NOT NULL,
  CONSTRAINT check_positive_cost CHECK(cost > 0)
);

INSERT INTO parts VALUES (1,'sed dictum',5,134,0);

DELETE FROM parts;

--ADD CONSTRAINT ON parts table which checks part_name should start with 'P_'
ALTER TABLE parts
ADD CONSTRAINT check_part_name  CHECK(part_name like 'P_%');

INSERT INTO parts VALUES (1,'sed dictum',5,134,0);

--ADD CONSTRAINT ON parts table which checks STATUS should be 0 or 1 no other values are allowed

ALTER TABLE parts
ADD CONSTRAINT check_status  CHECK(status IN (0,1));

INSERT INTO parts VALUES (2,'P_sed dictum',5,134,0);


SELECT 
    *
FROM
    USER_CONSTRAINTS
WHERE
    table_name = 'PARTS';
    
--Default

CREATE TABLE orders (
    order_id NUMBER(5),
    order_date DATE DEFAULT SYSDATE
);

INSERT INTO orders(order_id) VALUES(101);
INSERT INTO orders VALUES(102,DEFAULT);

SELECT 
    *
FROM 
    orders;
    
select count(*) from CONTACTS;
select count(*) from COUNTRIES;
select count(*) from CUSTOMERS;
select count(*) from EMPLOYEES;
select count(*) from INVENTORIES;
select count(*) from LOCATIONS;
select count(*) from ORDERS;
select count(*) from ORDER_ITEMS;
select count(*) from PRODUCT_CATEGORIES;
select count(*) from PRODUCTS;
select count(*) from REGIONS;
select count(*) from WAREHOUSES;

--Section 1. Querying Data
DESC customers;

SELECT
    name
FROM
    customers;
    
SELECT 
    customer_id,
    name,
    credit_limit
FROM 
    customers;
    
SELECT
    *
FROM
    customers;
    
--Section 2. Sorting data
SELECT 
    customer_id,
    name,
    credit_limit
FROM 
    customers;
    
--Sort the customer data by names 
SELECT 
    customer_id,
    name,
    credit_limit
FROM 
    customers
ORDER BY
    name ASC;
    
SELECT 
    customer_id,
    name,
    credit_limit
FROM 
    customers
ORDER BY
    UPPER(name) DESC;

SELECT 
    first_name,
    last_name
FROM
    contacts;

SELECT 
    first_name,
    last_name
FROM
    contacts
ORDER BY
    first_name ,last_name desc;
    

SELECT 
    first_name,
    last_name
FROM
    contacts
ORDER BY
    first_name ,last_name;    
    
    
SELECT 
    job_title, --1
    first_name, --2
    last_name --3
FROM
    employees
ORDER BY
    job_title,first_name;
    
    
SELECT 
    job_title, --1
    first_name, --2
    last_name --3
FROM
    employees
ORDER BY
    1,2 desc;
    
SELECT 
    country_id,
    city,
    state
FROM 
    locations;
    
SELECT 
    country_id,
    city,
    state
FROM 
    locations
ORDER BY
    state desc NULLS LAST;
    
    
SELECT 
    country_id,
    city,
    state
FROM 
    locations
ORDER BY
    state ASC NULLS FIRST;

SELECT
    order_id,
    customer_id,
    status,
    order_date
FROM
    orders
ORDER BY
    order_date desc;

--Section 3. Filtering data
--DISTINCT
SELECT 
    first_name
FROM
    contacts
ORDER BY
    first_name;
    
SELECT 
    DISTINCT first_name
FROM
    contacts
ORDER BY
    first_name;
   
SELECT
    DISTINCT product_id,quantity
FROM
    order_items
ORDER BY
    product_id;
    
SELECT 
    DISTINCT state
FROM 
    locations
ORDER BY
    state;   

--Where
SELECT
    *
FROM
    products
WHERE
    product_name = 'Kingston';

SELECT
    *
FROM
    products 
WHERE 
    list_price > 500;
    
SELECT
    *
FROM
    products 
WHERE 
    list_price > 500
    AND
    category_id = 4;


--Between
SELECT
    *
FROM
    products 
WHERE
    list_price BETWEEN 650 AND 680
ORDER BY
    list_price;

    
SELECT
    *
FROM
    products
WHERE
    category_id IN(1,4);
    --category_id = 1
    --OR
    --category_id = 4;

SELECT
    *
FROM
    products
WHERE
    product_name like 'A%';

--write a query returns the orders that belong to the customer id 44 and have canceled or pending status.
--Use orders table

SELECT  
    *
FROM
    orders
WHERE
    status IN ('Canceled','Pending')
    AND
    customer_id = 44;

--Get the order details placed in between 01-12-2016 and 31-12-2016
SELECT  
    *
FROM
    orders
WHERE
    order_date BETWEEN DATE '2016-12-01' AND DATE '2016-12-31'
ORDER BY
    order_date;
    
SELECT  
    *
FROM
    orders;


--all sales orders which do not have a no salesman:
SELECT  
    *
FROM
    orders
WHERE
    salesman_id IS NULL;

SELECT  
    *
FROM
    orders
WHERE
    salesman_id IS NOT NULL;
    
--Joins

CREATE TABLE palette_a (
    id NUMBER PRIMARY KEY,
    color VARCHAR2(40) NOT NULL
);

CREATE TABLE palette_b (
    id NUMBER PRIMARY KEY,
    color VARCHAR2(40) NOT NULL
);

INSERT INTO palette_a VALUES (1,'Red');
INSERT INTO palette_a VALUES (2,'Green');
INSERT INTO palette_a VALUES (3,'Blue');
INSERT INTO palette_a VALUES (4,'Purple');

INSERT INTO palette_b VALUES (1,'Green');
INSERT INTO palette_b VALUES (2,'Red');
INSERT INTO palette_b VALUES (3,'Cyan');
INSERT INTO palette_b VALUES (4,'Brown');

SELECT * FROM palette_a;
SELECT * FROM palette_b;

--Oracle inner Join
SELECT 
    a.id id_a,
    a.color color_a,
    b.id id_b,
    b.color color_b
FROM
    palette_a a,
    palette_b b;
-----------------------------
SELECT 
    a.id id_a,
    a.color color_a,
    b.id id_b,
    b.color color_b
FROM
    palette_a a
    INNER JOIN
    palette_b b
ON
    a.color = b.color;
    
--Left outer join
SELECT 
    a.id id_a,
    a.color color_a,
    b.id id_b,
    b.color color_b
FROM
    palette_a a LEFT JOIN palette_b b
ON
    a.color = b.color;
    
--Right outer join
SELECT 
    a.id id_a,
    a.color color_a,
    b.id id_b,
    b.color color_b
FROM
    palette_a a RIGHT JOIN palette_b b
ON
    a.color = b.color;

--full outer join
SELECT 
    a.id id_a,
    a.color color_a,
    b.id id_b,
    b.color color_b
FROM
    palette_a a FULL JOIN palette_b b
ON
    a.color = b.color;
    
--orders and order_items
SELECT * FROM orders;
SELECT * FROM order_items;

SELECT 
    orders.order_id order_number,
    order_items.unit_price price
FROM
    orders
    INNER JOIN
    order_items
ON
    order_items.order_id = orders.order_id
WHERE 
    order_items.order_id = 1;
-------------------------------------------
SELECT 
    o.order_id order_number,
    oi.unit_price price
FROM
    orders o
    INNER JOIN
    order_items oi
ON
    oi.order_id = o.order_id
WHERE 
    oi.order_id = 1;    
    
--USING CLAUSE IN JOIN
SELECT 
 *
FROM
    orders 
    INNER JOIN
    order_items
USING(order_id);


--Left Outer Join
SELECT * FROM orders;
SELECT * FROM employees;

--Print the first name and last name of salesman all orders
SELECT 
    order_id,
    status,
    first_name salesman_first_name,
    last_name salesman_last_name
FROM
    orders 
    LEFT JOIN
    employees
ON
    employee_id = salesman_id;
    
    
SELECT * FROM orders;
SELECT * FROM customers;

--Print the name(customer name) ,orderid ,status , order date of customer
SELECT
    name,
    order_id,
    status,
    order_date
FROM
    customers
        LEFT JOIN
    orders USING(customer_id);
    


--Print the first name and last name of salesman all orders
SELECT 
 
    first_name salesman_first_name,
    last_name salesman_last_name,
    order_id,
    status
FROM
    orders 
    RIGH JOIN
    employees
ON
    employee_id = salesman_id;
    
--Oracle Full outer join
CREATE TABLE projects (
    project_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    project_name VARCHAR(50) NOT NULL
);

INSERT INTO projects(project_name) VALUES ('ERP');
INSERT INTO projects(project_name) VALUES ('Sales CRM');

SELECT  * FROM projects;

CREATE TABLE members(
    member_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_name VARCHAR(100) NOT NULL,
    project_id NUMBER(4)
);

INSERT INTO members(member_name,project_id)
VALUES('Vivek Gohil',1);

INSERT INTO members(member_name,project_id)
VALUES('Adarsh Poojary',2);

INSERT INTO members(member_name,project_id)
VALUES('Jack Daniel',NULL);

SELECT * FROM members;

--Full outer join
SELECT
    member_name,
    project_name
FROM
    members m
    FULL OUTER JOIN 
    projects p
ON
    p.project_id = m.project_id;
    
--Self join
SELECT * FROM employees;

select 
    (e.first_name || ' ' || e.last_name) employee,
    (m.first_name || ' ' || m.last_name) manager,
    e.job_title
FROM
    employees e
    LEFT JOIN
    employees m
ON
    m.employee_id = e.manager_id;

--Section 5. Grouping data
SELECT
    *
FROM
    orders;
    
--Retrive the unique status
SELECT
    DISTINCT status
FROM
    orders;
    
--Count of orders for each status.
SELECT 
    status,
    COUNT(order_id)
FROM
    orders
WHERE
    status = 'Shipped';
    
SELECT 
    status,
    COUNT(order_id)
FROM
    orders
GROUP BY
    status;
    
SELECT
    job_title
FROM
    employees;
    
--Print the count of each job title 
SELECT
    job_title,
    count(job_title)
FROM
    employees
GROUP BY
    job_title;
    
 
SELECT
    *
FROM
    orders;

SELECT 
    EXTRACT(YEAR FROM SYSDATE) YEAR
FROM
    dual;
    
SELECT 
    EXTRACT(MONTH FROM SYSDATE) MONTH
FROM
    dual;
    
--PRINT THE COUNT OF ORDERS PLACED PER YEAR

SELECT
    EXTRACT(YEAR FROM order_date) YEAR,
    COUNT(order_id)
FROM
    orders
GROUP BY
    EXTRACT(YEAR FROM order_date)
ORDER BY
    YEAR;
    
SELECT
    order_id,
    SUM(unit_price * quantity) order_value
FROM
    order_items
GROUP BY
    order_id
HAVING 
     SUM(unit_price * quantity) > 1000000
ORDER BY
    order_value desc;

--Find the orders whose values are greater than 500,000 
--and the number of products in each order is between 10 and 12.

SELECT 
    order_id,
    COUNT(item_id) item_count,
    SUM(unit_price * quantity) order_value
FROM
    order_items
GROUP BY
    order_id
HAVING
    SUM(unit_price * quantity) > 500000
    AND
    COUNT(item_id) BETWEEN 10 AND 12
ORDER BY
    order_value DESC,
    item_count DESC;
    
--Subquery

SELECT
    *
FROM
    products;
    
SELECT 
    MAX(LIST_PRICE)
FROM
    products;
    
SELECT 
    product_id,
    product_name,
    list_price
FROM
    products
where 
    list_price = 8867.99;


--Using SubQuery
SELECT 
    product_id,
    product_name,
    list_price
FROM
    products
where 
    list_price = (
        SELECT 
            MAX(LIST_PRICE)
        FROM
        products
    );

SELECT 
    product_id,
    product_name,
    list_price
FROM
    products
where 
    list_price = (
        SELECT 
            MIN(LIST_PRICE)
        FROM
        products
    );

--Exisits
--Find all the customers who have the order
SELECT
    *
FROM
    customers;

SELECT
    *
FROM
    orders;
    
SELECT
    name
FROM
    customers c
WHERE
    EXISTS (
        SELECT
            *
        FROM
            orders
        WHERE
            customer_id = c.customer_id
    );
    
SELECT
    name
FROM
    customers c
WHERE
    NOT EXISTS (
        SELECT
            *
        FROM
            orders
        WHERE
            customer_id = c.customer_id
    );




