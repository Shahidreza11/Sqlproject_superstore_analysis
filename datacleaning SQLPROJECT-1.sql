select orderid From orderslist where orderid is null;

alter table superstore rename to orderslist;

alter table superstore rename to orderslist;


select * from orderslist;
select * From eachorder;



--DATA CLEANING
1) --Establish a relationship between the tables as per the ER Diagram

Alter table orderslist add constraint pk_orderid primary key (orderid) ;

Alter table eachorder add constraint fk_orderid foreign key (orderid) references orderslist(orderid);

--2) split city_state_country column into 3 individual columns namely 'City','State', 'Country';

--alter table orderslist add country varchar2(40);
--alter table orderslist add state varchar2(40);
--alter table orderslist add city varchar2(40);

select * from orderslist;

--update orderslist set city=;
--method1


update orderslist set city=substr(city_state_country,1,instr(city_state_country,',')-1);

update orderslist 
set city = SUBSTR(city_state_country, INSTR(city_state_country, ',') + 1, 
INSTR(city_state_country, ',',
INSTR(city_state_country, ',') + 1) - INSTR(city_state_country, ',') - 1);

update orderslist
set country=SUBSTR(city_state_country, INSTR(city_state_country, ',', INSTR(city_state_country, ',') + 1) + 1);
 
 
--method 2 (using regular expressions) 
update orderslist 
set city = REGEXP_SUBSTR(city_state_country, '[^,]+',1,1);
 
update orderslist 
set state = regexp_substr(city_state_country,'[^,]+',1,2);

update orderslist 
set country=REGEXP_SUBSTR(city_state_country, '[^,]+', 1, 3);

select * from orderslist;

--3. Add a new category column using the following mapping as per the first 3 characters in the product name column:
--a) TEC-Technology
--b) OFS-Office Supplies
--c) FUR-Furniture
select * From eachorder;
--STEP-1 CREATE A NEW CATEGORY COLUMN
alter table eachorder add category varchar2(40);
--STEP-2 UPDATE THE VALUES INTO CATEGORY COLUMN
update eachorder set category = case
    when regexp_substr(productname,'[^-]+',1,1)= 'OFS' THEN 'Office supplies'
    when regexp_substr(productname, '[^-]+',1,1)='TECH' THEN 'Technology'
    when regexp_substr(productname,'[^-]+',1,1)='FUR' THEN 'Furniture'
end;

select * from eachorder;

--4) Delete the first 4 characters from the product Name column;

--update eachorder set productname=

method-1 using(substr with instr)
update eachorder set productname=
substr(productname,instr(productname,'-')+1);

--method 2 using (regex)
update eachorder set productname=
substr(REGEXP_SUBSTR(productname,'-.+'),2) from eachorder;

--(select  substr(productname,instr(productname,'-')+1) from eachorder;
--so the arguments for substr is 
--substr(string,starting_pos, num_of_characters)
--if we give starting_Pos as a 1 then it starts from 1st pos of str 
--if we give num_of_Chars as 10 it returns 10 strings
--in the above question to get desired result 
-- we have to use instr() fun as a starting pos in SUBSTR and
-- we dont mention anything in num_of_Charracters argument
-- so if we dont mention anything it takes the number of characters upto the end.) 

commit;

--5) Remove duplicate rows from eachorder table , if all columns are matching.
select * from eachorder;

delete from eachorder where rowid not in (select min(rowid) from eachorder
group by orderid,productname,discount,sales,profit,quantity,subcategory,category);
COMMIT;

--6) replace blank with 'NA' in OrderPriority column in orderslist table;

update orderslist set orderpriority='NA' WHERE ORDERPRIORITY IS NULL;




COMMIT;

