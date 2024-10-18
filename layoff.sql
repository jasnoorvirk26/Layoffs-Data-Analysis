-- Create a new database named LayoffRecordsDB
create database LayoffRecordsDB;

-- Use the newly created database
use LayoffRecordsDB;

-- Select all records from the layoff table (assuming it exists in the current database)
select * from layoff;

-- Create a new schema named s1
create schema s1;

-- Transfer the layoff table from the dbo schema to the newly created s1 schema
alter schema s1 transfer dbo.layoff;

-- Select all records from the layoff table now in the s1 schema
select * from s1.layoff;

-- Create a new staging table named layoffs_data in the s1 schema
-- This table will contain all records from the s1.layoff table
select * 
into s1.layoffs_data
from s1.layoff;

-- Select all records from the layoffs_data table to verify the transfer
select * 
from s1.layoffs_data;

---------------------------- Data Cleaning --------------------------------------------------------

-- Common Table Expression (CTE) to identify duplicates based on specific columns
with duplicates_cte as
(
    select row_number() over(
        partition by company, location_hq, industry, country, stage, [date], laid_off_count
        order by (select null)) as row_no,  -- Assigns a row number to duplicates
        s.*
    from s1.layoffs_data s
)

-- Select duplicates for examination
select *
from duplicates_cte
where row_no >= 2;  -- Identify duplicates with row numbers greater than or equal to 2

-- Examine records for the company 'Beyond Meat'
select * 
from s1.layoffs_data
where company = 'Beyond Meat';  -- Review specific company's records

-- CTE to identify duplicates again for deletion
with duplicates_cte as
(
    select row_number() over(
        partition by company, location_hq, industry, country, stage, [date], laid_off_count
        order by (select null)) as row_no,  -- Assigns row numbers for duplicates
        s.*
    from s1.layoffs_data s
)

-- Delete duplicate records, keeping only the first occurrence
delete 
from duplicates_cte
where row_no >= 2;  -- Remove all duplicates except the first one

-- Select all records from the layoffs_data table to view remaining data
select *
from s1.layoffs_data;

-- Standardizing Data:

-- Get distinct company names to check for inconsistencies
select distinct company
from s1.layoffs_data
order by company;  -- Identify unique company names

-- Compare original company names with trimmed versions for standardization
select company, ltrim(rtrim(company))  -- Trim leading and trailing spaces
from s1.layoffs_data
order by company;

-- Update company names to remove leading and trailing spaces
update s1.layoffs_data
set company = ltrim(rtrim(company));  -- Standardize the 'company' column

-- Get distinct location_hq values to identify inconsistencies
select distinct location_hq
from s1.layoffs_data
order by location_hq;  -- Identify unique location values

-- Identify specific location_hq values that need standardization
select location_hq
from s1.layoffs_data
where location_hq like 'D%dorf';  -- Find variations of 'Düsseldorf'

-- Update location_hq values to standardize 'Düsseldorf'
update s1.layoffs_data
set location_hq = 'Dusseldorf'
where location_hq like 'D%dorf';  -- Correct to standard name

-- Identify location_hq variations for Malmö
select location_hq
from s1.layoffs_data
where location_hq like 'Malm%';  -- Find variations of 'Malmö'

-- Update location_hq values to standardize 'Malmö'
update s1.layoffs_data
set location_hq = 'Malmö'
where location_hq like 'Malm%';  -- Correct to standard name

-- Identify location_hq variations for Florianópolis
select location_hq
from s1.layoffs_data
where location_hq like 'Florian%polis';  -- Find variations of 'Florianópolis'

-- Update location_hq values to standardize 'Florianópolis'
update s1.layoffs_data
set location_hq = 'Florianópolis'
where location_hq like 'Florian%polis';  -- Correct to standard name

-- Identify location_hq variations for Førde
select location_hq
from s1.layoffs_data
where location_hq like 'F%rde';  -- Find variations of 'Førde'

-- Update location_hq values to standardize 'Førde'
update s1.layoffs_data
set location_hq = 'Førde'
where location_hq like 'F%rde';  -- Correct to standard name

-- Identify location_hq variations for Wrocław
select location_hq
from s1.layoffs_data
where location_hq like 'Wroc%aw';  -- Find variations of 'Wrocław'

-- Update location_hq values to standardize 'Wrocław'
update s1.layoffs_data
set location_hq = 'Wrocław'
where location_hq like 'Wroc%aw';  -- Correct to standard name

-- Select records with location_hq values of 'Non-U.S.' or 'Unknown' for review
select *
from s1.layoffs_data
where location_hq in ('Non-U.S.', 'Unknown');  -- Check for unstandardized locations

-- Select records for the company 'Product Hunt' to review their data
select *
from s1.layoffs_data
where company = 'Product Hunt';  -- Review data for Product Hunt

-- Update location_hq for 'Product Hunt' to 'SF Bay Area'
update s1.layoffs_data
set location_hq = 'SF Bay Area'
where company = 'Product Hunt';  -- Standardize location to reflect operational area

-- Select records again for 'Product Hunt' to verify the update
select *
from s1.layoffs_data
where company = 'Product Hunt';  -- Verify location update

-- Select records for the company 'BitMEX' for review
select *
from s1.layoffs_data
where company = 'BitMEX';  -- Review data for BitMEX

-- Update location_hq for 'BitMEX' to 'Mahé'
update s1.layoffs_data
set location_hq = 'Mahé'
where company = 'BitMEX';  -- Standardize location to reflect operational area

-- Select records for the company 'WeDoctor' for review
select *
from s1.layoffs_data
where company = 'WeDoctor';  -- Review data for WeDoctor

-- Update location_hq for 'WeDoctor' to 'Hangzhou'
update s1.layoffs_data
set location_hq = 'Hangzhou'
where company = 'WeDoctor';  -- Standardize location to reflect operational area

-- Selecting distinct countries from the layoffs_data table and ordering them alphabetically
select distinct country
from s1.layoffs_data
order by country;

-- Selecting distinct dates from the layoffs_data table to analyze date entries
select distinct [date] 
from s1.layoffs_data;

-- Retrieving all records where the date is either 'Null' or is actually NULL
select *
from s1.layoffs_data
where [date] ='Null' or [date] is null;

-- Selecting records where the date column is valid (ISDATE returns 1)
SELECT *
FROM s1.layoffs_data
WHERE ISDATE([date]) != 0;

-- Selecting records where the date column is invalid (ISDATE returns 0)
SELECT *
FROM s1.layoffs_data
WHERE ISDATE([date]) = 0;

-- Updating the date column by converting its format to DATE type using the specified style (105 = 'DD-MM-YYYY')
UPDATE s1.layoffs_data
SET [date] = CONVERT(DATE, [date], 105);

-- Altering the data type of the date column to DATE
alter table s1.layoffs_data
alter column [date] date;

-- Selecting records with NULL values in the industry column to identify missing industry data
select industry
from s1.layoffs_data
where industry is null;

-- Selecting distinct industries from the layoffs_data table and ordering them alphabetically
select distinct industry
from s1.layoffs_data
order by industry;

-- Retrieving all records where the industry is labeled as 'Unknown'
select *
from s1.layoffs_data
where industry ='Unknown' ;

-- Selecting all records related to a specific company (Appsmith)
select *
from s1.layoffs_data
where company ='Appsmith' ;

-- Updating the industry field for 'Appsmith' to 'Technology'
update s1.layoffs_data
set industry= 'Technology'
where company ='Appsmith';

-- Ordering the table records by company for better visibility
select *
from s1.layoffs_data
order by company ;

-- Selecting records where laid_off_count is marked as 'Null' to identify misrepresented null values
select * 
from s1.layoffs_data
where laid_off_count='Null';

-- Updating laid_off_count entries from 'Null' string to actual NULL values
update s1.layoffs_data
set laid_off_count=null
where laid_off_count='Null';

-- Selecting records where percentage_laid_off is marked as 'Null'
select * 
from s1.layoffs_data
where percentage_laid_off='Null';

-- Updating percentage_laid_off entries from 'Null' string to actual NULL values
update s1.layoffs_data
set percentage_laid_off=null
where percentage_laid_off='Null';

-- Selecting records where funds_raised_millions is marked as 'Null'
select * 
from s1.layoffs_data
where funds_raised_millions='Null';

-- Updating funds_raised_millions entries from 'Null' string to actual NULL values
update s1.layoffs_data
set funds_raised_millions=null
where funds_raised_millions='Null';

--------------------------------------------------------------------------

-- Changing data types for better data integrity and usability

-- Altering the data type of laid_off_count to integer
alter table s1.layoffs_data
alter column laid_off_count int;

-- Altering the data type of percentage_laid_off to decimal with precision and scale
alter table s1.layoffs_data
alter column percentage_laid_off decimal(5,2);

-- Altering the data type of funds_raised_millions to decimal with precision and scale
alter table s1.layoffs_data
alter column funds_raised_millions decimal(10,3);

-- selecting records where both laid_off_count and percentage_laid_off are NULL
select top 5 *
from s1.layoffs_data
where laid_off_count is null
and percentage_laid_off is null;

-- Performing the delete operation to remove records identified above
delete
from s1.layoffs_data
where laid_off_count is null
and percentage_laid_off is null;

-- Selecting remaining records from the layoffs_data table to review the current state of the data
select top 5 *
from s1.layoffs_data;


--------------------------------EDA------------------------------------------------------

-- 1. Retrieve the top 5 industries with the highest total number of layoffs

select top 5 industry, sum(laid_off_count) as total_laid_off
from s1.layoffs_data
where industry != 'Other'  -- Exclude the 'Other' category for accuracy
group by industry
order by 2 desc;  -- Order by total laid off in descending order

-- 2. Calculate the average percentage of layoffs for the top 5 industries

select top 5 industry, convert(decimal(5,2), avg(percentage_laid_off)) as avg_percentage_laid_off
from s1.layoffs_data
where industry != 'Other'  -- Exclude the 'Other' category for accuracy
group by industry
order by 2 desc;  -- Order by average percentage of layoffs in descending order

-- 3. Identify the top 3 industries with the highest layoffs for each year
with cte as
(
    select year(date) as [year], industry, sum(laid_off_count) as laid_off_count,
           dense_rank() over(partition by year(date) order by sum(laid_off_count) desc) as rn
    from s1.layoffs_data
    where industry != 'Other'  -- Exclude the 'Other' category for accuracy
    group by year(date), industry
)
select [year], industry, laid_off_count
from cte 
where rn <= 3;  -- Select only the top 3 industries for each year

-- 4. Retrieve the top 5 countries with the highest total number of layoffs
select top 5 country, sum(laid_off_count) as laid_off_count
from s1.layoffs_data
group by country
order by 2 desc;  -- Order by total laid off in descending order

-- 5. Identify the top 5 stages with the highest total number of layoffs (excluding 'Unknown')
select top 5 stage, sum(laid_off_count) as laid_off_count
from s1.layoffs_data
where stage != 'Unknown'  -- Exclude the 'Unknown' category for accuracy
group by stage
order by 2 desc;  -- Order by total laid off in descending order

-- 6. Retrieve the top 5 companies with the highest total number of layoffs
select top 5 company, sum(laid_off_count) as laid_off_count
from s1.layoffs_data
group by company
order by 2 desc;  -- Order by total laid off in descending order

-- 7. Calculate the average percentage of layoffs for each year
select year(date) as year, convert(decimal(5,2), avg(percentage_laid_off)) as avg_percentage_laid_off
from s1.layoffs_data
group by year(date)
order by 1;  -- Order by year in ascending order

-- Determine the minimum and maximum date in the dataset
select min(date) as min_date, max(date) as max_date
from s1.layoffs_data;

-- 8. Retrieve total layoffs for each year
select year(date) as Year, sum(laid_off_count) as total_laid_off
from s1.layoffs_data
group by year(date)
order by 2;  -- Order by total laid off in ascending order

-- 9. Identify which companies laid off the most employees in each year (top 3)
with selecting as 
(
    select company, [year], total_laid_off, 
           dense_rank() over(partition by [year] order by total_laid_off desc) as Ranking
    from
    (
        select company, year([date]) as [year], sum(laid_off_count) as total_laid_off
        from s1.layoffs_data
        group by year([date]), company
    ) as ranking
)
select company, [year], total_laid_off
from selecting
where Ranking <= 3  -- Select only the top 3 companies for each year
order by year, Ranking;  -- Order by year and ranking
