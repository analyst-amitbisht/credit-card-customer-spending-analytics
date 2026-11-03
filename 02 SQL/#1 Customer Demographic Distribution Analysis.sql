-- How many customers belong to each age group, gender, occupation and city?

select age_group, 
       count(customer_id) as total_customers
from dim_customers
group by age_group
order by age_group;

select gender, 
       count(customer_id) as total_customers
from dim_customers
group by gender;

select occupation, 
       count(customer_id) as total_customers
from dim_customers
group by occupation;

select city, 
       count(customer_id) as total_customers
from dim_customers
group by city;