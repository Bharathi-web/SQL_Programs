create database Country;  /*create a database contry*/
show databases;
use country;
/*create table */
create table countries(country_id int,country_name varchar(40),region_id int);
desc Countries;
select * from countries;
insert into countries values(1001,'India',789987);
insert into countries values(1001,'Africa',98874); /* it accepts duplication*/
select * from countries;
set sql_safe_updates = 0;
Delete from countries where country_id = 1001 and country_name = 'Africa';
set sql_safe_updates=1;
alter table countries add primary key(country_id); /*add unqiueness to country_id to avoid duplication*/
insert into countries value(1001,'USA',877657); /*now it shows error while duplicate appears*/
insert into countries value(1002,'USA',877678);
/* add column country_monsoon*/
alter table countries add country_monsoon varchar(50);
select * from countries;
/* droping the column country_monsoon*/
alter table countries drop country_monsoon;
desc countries;
