-- questions

-- 1. what is the gender breakdown of employees in the company?
select gender, count(*) as count
from hr
where age>=18 and termdate= "0000-00-00"
group by gender;

-- 2. what is the race/ethnicity breakdown of employees in the company?
select race, count(*) as count 
from hr
where age>=18 and termdate= "0000-00-00"
group by race
order by count desc;

-- 3.what is the age distribution of employees in the company?
select 
min(age) as youngest,
max(age) as oldest
from hr
where age>=18 and termdate= "0000-00-00";

select 
	case
		when age>= 18 and age <=24 then "18-24"
        when age>= 25 and age <=34 then "25-34"
        when age>= 35 and age <=44 then "35-44"
        when age>= 45 and age <=54 then "45-54"
        when age>= 55 and age <=64 then "55-64"
        else "65+"
	end as age_group,
    count(*) as count
from hr 
where age>=18 and termdate= "0000-00-00"
group by age_group
order by age_group;

select 
	case
		when age>= 18 and age <=24 then "18-24"
        when age>= 25 and age <=34 then "25-34"
        when age>= 35 and age <=44 then "35-44"
        when age>= 45 and age <=54 then "45-54"
        when age>= 55 and age <=64 then "55-64"
        else "65+"
	end as age_group, gender,
    count(*) as count
from hr 
where age>=18 and termdate= "0000-00-00"
group by age_group, gender
order by age_group, gender;


-- 4 how many emplyess work at headquaters versus remote location? 
select location,count(*)as count 
from hr
where age>=18 and termdate= "0000-00-00"
group by location;

-- 5 what is the avg length of employment for employees who have been terminated?
select 
	round(avg(datediff(termdate,hire_date))/365,0) as avg_length_employment
from hr
where termdate <= curdate() and termdate <> "0000-00-00" and age>=18; 


-- 6 how does the gender distribution vary across departments and job titiles?
select department, gender, count(*) as count
from hr
where age>=18 and termdate= "0000-00-00"
group by department, gender
order by department;

-- 7 what is the distrition of job titles across the company?
select jobtitle, count(*) as count
from hr
where age>=18 and termdate= "0000-00-00"
group by jobtitle
order by jobtitle desc;

-- 8 which department as highest turnover rate?
select department, total_count, terminated_count,
	   terminated_count/total_count as termination_rate
from (
	 select department, 
     count(*) as total_count,
     sum(case when termdate <> "0000-00-00" and termdate <= curdate() then 1 else 0 end) as terminated_count
     from hr
     where age >= 18
     group by department
     ) as subquery
order by termination_rate desc;


-- 9 what is the disturibution of employess across locations by city and state?
select location_state, count(*) as count
from hr
where age>=18 and termdate= "0000-00-00"
group by location_state
order by count desc;

-- 10 how has the comapny's employee count chnaged over time based on hire and terms dates 
SELECT 
    year, 
    hires, 
    terminations, 
    hires - terminations AS net_change,  
    ROUND((hires - terminations) / hires * 100, 2) AS net_change_percent 
FROM (
    SELECT 
        YEAR(hire_date) AS year, 
        COUNT(*) AS hires, 
        SUM(CASE 
            WHEN termdate <> "0000-00-00" AND termdate <= CURDATE() 
            THEN 1 ELSE 0 
        END) AS terminations
    FROM hr 
    WHERE age >= 18 
    GROUP BY YEAR(hire_date)
) AS subquery 
ORDER BY year ASC;

-- 11 what is the tensure disturibution for each department?
select department, round(avg(datediff(termdate,hire_date)/365),0) as avg_tenure
from hr
WHERE termdate <= curdate() AND termdate <> "0000-00-00" and age>= 18
group by department;



