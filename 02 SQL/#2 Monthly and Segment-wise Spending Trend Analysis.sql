-- What are the total and average monthly spending figures?

select month, sum(spend) as total_spend, avg(spend)
from fact_spends
group by month;

select c.age_group,
       s.month, 
       sum(s.spend) as total_spend, 
	   round (avg(s.spend), 2) as avg_spend
from fact_spends s
join dim_customers c
on s.customer_id = c.customer_id
group by s.month, c.age_group;

select c.gender,
       s.month, 
       sum(s.spend) as total_spend, 
	   round (avg(s.spend), 2) as avg_spend
from fact_spends s
join dim_customers c
on s.customer_id = c.customer_id
group by s.month, c.gender;

select c.occupation,
       s.month, 
       sum(s.spend) as total_spend, 
	   round (avg(s.spend), 2) as avg_spend
from fact_spends s
join dim_customers c
on s.customer_id = c.customer_id
group by s.month, c.occupation;

select c.city,
       s.month, 
       sum(s.spend) as total_spend, 
	   round (avg(s.spend), 2) as avg_spend
from fact_spends s
join dim_customers c
on s.customer_id = c.customer_id
group by s.month, c.city;