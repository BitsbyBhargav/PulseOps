------ BASIC SQL QUEERIES ------
-- QUESTION 1 TO 5 : BASIC ( SELECT, WHERE AND ORDER BY ) -- 


-- Q1. Select all columns for the first 10 rows where type='L'

select top 10  * from equipment_sensor_data where TYPE='L';

--Q2. Find all units where Torque [Nm] is greater than 60. Show only UDI, Type, and Torque.

select UDI,Type,[Torque [Nm]]] from equipment_sensor_data where [Torque [Nm]]] > 60;

--Q3.  List all units with Machine failure = 1, ordered by Tool wear [min] descending.

select * from equipment_sensor_data where [Tool wear [min]]]=1 order by [Tool wear [min]]] desc;

--Q4.Find units where Type = 'H' AND Rotational speed [rpm] is less than 1300.

select * from equipment_sensor_data where Type='H'and [Rotational speed [rpm]]]<1300;

--Q5. Count how many total rows exist in the table (just the count, one number).
 
 select count(UDI) as row_count from equipment_sensor_data;

 --------- Intermediate SQL queries ---------
 -- Question 6 to 10: Intermediate (GROUP BY, aggregates,HAVING, basic joins concept) -- 

 --Q6. For each Type, find the average Torque [Nm]. Round to 2 decimals.

select Type as Machine_Type, round(avg([Torque [Nm]]]),2) as avg_torque from equipment_sensor_data group by Type;

--Q7. Find the minimum and maximum Tool wear [min] for units that had Machine failure = 1.


select UDI,min([Tool wear [min]]]) as Minimum_tool_wear,max([Tool wear [min]]])  as Maximum_tool_wear from equipment_sensor_data where [Machine failure]=1
group by UDI;

-- Q8.Count how many units fall into each risk_flag_count value (0, 1, 2, 3) — hint: you'll need to calculate this sum inline, similar to Query 3 from earlier.

SELECT 
    (TWF + HDF + PWF + OSF + RNF) AS risk_flag_count,
    COUNT(*) AS unit_count
FROM equipment_sensor_data
GROUP BY (TWF + HDF + PWF + OSF + RNF)
ORDER BY risk_flag_count;

-- Q9.For each Type, count total units AND failed units (two separate counts in one query).

select Type,
count(*) as total_units,
count(case when [Machine failure]=1 then 1 end) as failed_units
from equipment_sensor_data
group by Type
order by total_units desc;

--Q10. Using HAVING, find which Type(s) have an average Torque [Nm] greater than 40.

select Type, avg([Torque [Nm]]]) as [Average torque]]] from equipment_sensor_data 
group by Type 
having avg([Torque [Nm]]])>40;

------ Intermediate and Advance level Queries -----
-- Q11 to 16: Intermediate+ (subqueries, CASE, multiple conditions) --

--Q11. Find all units where Air temperature [K] is ABOVE the overall average air temperature. (Hint: subquery inside WHERE)

select UDI,Type,[Air temperature [K]]] from equipment_sensor_data
where [Air temperature [K]]]> (
       select avg([Air temperature [K]]]) from equipment_sensor_data
       )
group by UDI,Type,[Air temperature [K]]];

--Q12. Using CASE, create a new column called wear_category:

SELECT 
    UDI,
    Type,
    [Tool wear [min]]],
    CASE 
        WHEN [Tool wear [min]]] <50 THEN 'Low Wear'
        WHEN [Tool wear [min]]] BETWEEN 50 AND 150 THEN 'Medium Wear'
        ELSE 'High / Critical Wear'
    END AS wear_category
FROM equipment_sensor_data;

--Q13. Find the top 5 units (by UDI) with the highest Torque [Nm] among units where Machine failure = 1.

select top 5 UDI, [Torque [Nm]]] from equipment_sensor_data
where [Machine failure]=1
order by [Torque [Nm]]] desc;

--Q14.For each HDF value (0 or 1), calculate the average temp_diff. (This validates Session 004's finding via SQL)

select HDF,AVG(temp_diff) as [Temperature Difference] from equipment_sensor_data
group by HDF;

-- Q.15 Find how many units have BOTH high_torque_flag = 1 AND low_temp_diff_flag = 1 simultaneously — and what % of THESE units actually failed (Machine failure = 1)

SELECT 
    COUNT(*) AS total_flagged_units,
    SUM(CASE WHEN [Machine failure] = 1 THEN 1 ELSE 0 END) AS failed_units,
    CAST(
        (SUM(CASE WHEN [Machine failure] = 1 THEN 1.0 ELSE 0.0 END) / COUNT(*)) * 100 
        AS DECIMAL(10,2)
    ) AS failure_percentage
FROM equipment_sensor_data
WHERE high_torque_flag = 1 AND low_temp_diff_flag = 1;