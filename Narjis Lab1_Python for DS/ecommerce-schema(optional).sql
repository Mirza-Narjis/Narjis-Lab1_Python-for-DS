-- Note: optional file for creating e_commerce database in MySQL workbench instead of jupyter notebook

-- CREATING DATABASE
DROP DATABASE if EXISTS `e_commerce`;
create database e_commerce;
use e_commerce;
-- ------------------------------------------------------------------------------------------
/*Q1. Create tables for supplier, customer, category, product, productDetails, order, rating to store the data for the E-commerce with the schema definition given below.
  
  supplier(SUPP_ID int primary key, SUPP_NAME varchar(50), SUPP_CITY varchar(50), SUPP_PHONE varchar(10))
  customer (CUS_ID INT NOT NULL, CUS_NAME VARCHAR(20) NULL DEFAULT NULL, CUS_PHONE VARCHAR(10), CUS_CITY varchar(30) ,CUS_GENDER CHAR,PRIMARY KEY (CUS_ID))
  category (CAT_ID INT NOT NULL, CAT_NAME VARCHAR(20) NULL DEFAULT NULL,PRIMARY KEY (CAT_ID))
  product (PRO_ID INT NOT NULL, PRO_NAME VARCHAR(20) NULL DEFAULT NULL, PRO_DESC VARCHAR(60) NULL DEFAULT NULL, CAT_ID INT NOT NULL,PRIMARY KEY (PRO_ID),FOREIGN KEY (CAT_ID) REFERENCES CATEGORY (CAT_ID))
  product_details (PROD_ID INT NOT NULL, PRO_ID INT NOT NULL, SUPP_ID INT NOT NULL, PROD_PRICE INT NOT NULL, PRIMARY KEY (PROD_ID),FOREIGN KEY (PRO_ID) REFERENCES PRODUCT (PRO_ID), FOREIGN KEY (SUPP_ID) REFERENCES SUPPLIER(SUPP_ID))
  order (ORD_ID INT NOT NULL, ORD_AMOUNT INT NOT NULL, ORD_DATE DATE, CUS_ID INT NOT NULL, PROD_ID INT NOT NULL,PRIMARY KEY (ORD_ID),FOREIGN KEY (CUS_ID) REFERENCES CUSTOMER(CUS_ID),FOREIGN KEY (PROD_ID) REFERENCES PRODUCT_DETAILS(PROD_ID))
  rating (RAT_ID INT NOT NULL, CUS_ID INT NOT NULL, SUPP_ID INT NOT NULL, RAT_RATSTARS INT NOT NULL,PRIMARY KEY (RAT_ID),FOREIGN KEY (SUPP_ID) REFERENCES SUPPLIER (SUPP_ID),FOREIGN KEY (CUS_ID) REFERENCES CUSTOMER(CUS_ID))
*/

-- supplier table 
CREATE TABLE supplier(
                SUPP_ID INT PRIMARY KEY,
                SUPP_NAME VARCHAR(50),
                SUPP_CITY VARCHAR(50),
                SUPP_PHONE VARCHAR(50)
                );
                
-- customer table
CREATE TABLE customer(
              CUS_ID INT PRIMARY KEY NOT NULL,
              CUS_NAME VARCHAR(20) NULL DEFAULT NULL,
              CUS_PHONE VARCHAR(10),
              CUS_CITY VARCHAR(30),
              CUS_GENDER CHAR
              );
              
-- category table
CREATE TABLE category(
              CAT_ID INT PRIMARY KEY NOT NULL,
              CAT_NAME VARCHAR(20) NULL DEFAULT NULL
              );

-- product table
CREATE TABLE product(
            PRO_ID INT PRIMARY KEY NOT NULL,
            PRO_NAME VARCHAR(20) NULL DEFAULT NULL,
            PRO_DESC VARCHAR(60) NULL DEFAULT NULL,
            CAT_ID INT NOT NULL,
            FOREIGN KEY (CAT_ID) REFERENCES category(CAT_ID)
            );

-- product_details table
CREATE TABLE product_details(
                     PROD_ID INT PRIMARY KEY NOT NULL,
                     PRO_ID INT NOT NULL,
                     SUPP_ID INT NOT NULL,
                     PROD_PRICE INT NOT NULL,
                     FOREIGN KEY (PRO_ID) REFERENCES product(PRO_ID),
                     FOREIGN KEY (SUPP_ID) REFERENCES supplier(SUPP_ID)
                     );

-- orders table
CREATE TABLE orders(
            ORD_ID INT PRIMARY KEY NOT NULL,
            ORD_AMOUNT INT NOT NULL,
            ORD_DATE DATE,
            CUS_ID INT NOT NULL,
            PROD_ID INT NOT NULL,
            FOREIGN KEY (CUS_ID) REFERENCES customer(CUS_ID),
            FOREIGN KEY (PROD_ID) REFERENCES product_details(PROD_ID)
            );

-- rating table
CREATE TABLE rating(
            RAT_ID INT PRIMARY KEY NOT NULL,
            CUS_ID INT NOT NULL,
            SUPP_ID INT NOT NULL,
            RAT_RATSTARS INT NOT NULL,
            FOREIGN KEY (SUPP_ID) REFERENCES supplier (SUPP_ID),
            FOREIGN KEY (CUS_ID) REFERENCES customer (CUS_ID)
            );
-- ------------------------------------------------------------------------------------------
-- Q2) Insert the following data in the table created above
-- INSERTING VALUES INTO TABLES
insert into supplier values(1, "Rajesh Retails", "Delhi", 1234567890 ),
						   (2, "Appario Ltd.", "Mumbai", 258963147032),
						   (3, "Knome products", "Bangalore", 9785462315),
						   (4, "Bansal Retails", "Kochi", 8975463285),
						   (5, "Mittal Ltd.", "Lucknow", 7898456532);

insert into customer values(1, "AAKASH", 9999999999, "DELHI", "M"),
						   (2, "AMAN", 9785463215, "NOIDA", "M"),
						   (3, "NEHA", 9999999998, "MUMBAI", "F"),
						   (4, "MEGHA", 9994562399, "KOLKATA", "F"),
						   (5, "PULKIT", 7895999999, "LUCKNOW", "M");

insert into category values(1, "BOOKS"),
						   (2, "GAMES"),
						   (3, "GROCERIES"),
						   (4, "ELECTRONICS"),
						   (5, "CLOTHES");

insert into product values(1, "GTA V", "DFJDJFDJFDJFDJFJF", 2),
						  (2, "TSHIRT", "DFDFJDFJDKFD", 5),
						  (3, "ROG LAPTOP", "DFNTTNTNTERND", 4),
						  (4, "OATS", "REURENTBTOTH", 3),
						  (5, "HARRY POTTER", "NBEMCTHTJTH", 1);
       
insert into product_details values(1, 1, 2, 1500),
								  (2, 3, 5, 30000),
								  (3, 5, 1, 3000),
								  (4, 2, 3, 2500),
								  (5, 4, 1, 1000);
                                  
insert into orders values(20, 1500, '2021-10-12', 3, 5),
						 (25, 30500, '2021-09-16', 5, 2),
						 (26, 2000, '2021-10-05', 1, 1),
                         (30, 3500, '2021-08-16', 4, 3),
						 (50, 2000, '2021-10-06', 2, 1);                         
                         
insert into rating values(1, 2, 2, 4),
					 	 (2, 3, 4, 3),
						 (3, 5, 1, 5),
						 (4, 1, 3, 2),
						 (5, 4, 5, 4);
-- ----------------------------------------------------------------------------------------
-- Q3) Display the number of the customer group by their genders who have placed any order of amount greater than or equal to Rs.3000.
SELECT count(CUS_GENDER) as Total_number_of_customers, 
                   CUS_GENDER FROM
                   (SELECT CUS_GENDER, CUS_NAME FROM customer AS customer_details
                   INNER JOIN
                   (SELECT ORD_ID, CUS_ID FROM orders WHERE ORD_AMOUNT >= 3000) AS order_details
                   ON customer_details.CUS_ID = order_details.CUS_ID
                   GROUP BY customer_details.CUS_ID) AS Tab
                   GROUP BY CUS_GENDER;