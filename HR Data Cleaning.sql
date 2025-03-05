create database project;
use project;
show tables;
select * from hr;

alter table hr
change column id emp_id varchar(20) null;

describe hr;

select birthdate from hr;

set sql_safe_updates =0 ;

UPDATE hr
SET birthdate = CASE
    WHEN birthdate LIKE "%/%" THEN DATE_FORMAT(STR_TO_DATE(birthdate, "%m/%d/%Y"), "%Y-%m-%d")
    WHEN birthdate LIKE "%-%" THEN DATE_FORMAT(STR_TO_DATE(birthdate, "%m-%d-%Y"), "%Y-%m-%d")
    ELSE NULL 
END;

alter table hr 
modify column birthdate date;

UPDATE hr
SET hire_date = CASE
    WHEN hire_date LIKE "%/%" THEN DATE_FORMAT(STR_TO_DATE(hire_date, "%m/%d/%Y"), "%Y-%m-%d")
    WHEN hire_date LIKE "%-%" THEN DATE_FORMAT(STR_TO_DATE(hire_date, "%m-%d-%Y"), "%Y-%m-%d")
    ELSE NULL 
END;

alter table hr 
modify column hire_date date;

UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate from hr;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

alter table hr add column age int;

update hr 
set age = timestampdiff(year, birthdate, curdate());

select 
min(age) as youngest,
max(age) as oldest
from hr;

select count(*) from hr where age <18;

