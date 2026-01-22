use world_layoff;

select * from layoffs;

-- Removing duplicates

create table layoffs_staging
like layoffs; -- creating staging 1 for removing duplicates

select * from layoffs_staging;

insert layoffs_staging
select * from layoffs;

with duplicate_cte as 
(
select *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select * from duplicate_cte
where row_num > 1; -- created CTE for identifying the duplicate values

select * from layoffs_staging
where company = 'Casper'; -- recheck CTE output

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row-numb` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci; -- creating a staging area 2 to host the cte seperately to remove duplicate values

select * from layoffs_staging2;

insert into layoffs_staging2
select *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

select * from layoffs_staging2
where `row-numb` > 1;

delete from layoffs_staging2
where `row-numb` > 1; -- deleting the duplicate values

select * from layoffs_staging2;

-- Standardize Data

select (trim(company)) as trimmed, company from layoffs_staging2; -- checked for extra spaces

update layoffs_staging2
set company = trim(company); -- removed extra spaces in company name

select distinct industry
from layoffs_staging2
order by 1; -- checking if same industry is registered with different aliases

select * from layoffs_staging2
where industry like 'Crypto%'; --  focusing on crypto industry aliases

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%'; -- updated all the crypto related industry as crypto, removed the duplicate aliases

select distinct location
from layoffs_staging2
order by 1; -- no issues here

select distinct country
from layoffs_staging2
order by 1; -- someone added a period at the end of United States, who does that!

select * from layoffs_staging2
where country like 'United States%';

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%'; -- removed the period from the country name

select `date`, str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y'); -- changing the format of date from str to date

select `date`
from layoffs_staging2;

alter table layoffs_staging2
modify column `date` date; -- changing the type from str to date

-- Null Values

select * from layoffs_staging2
where industry is null 
or industry = '';

select industry from layoffs_staging2
where company = 'Airbnb';

select * from layoffs_staging2
where company like 'Bally%';

select industry from layoffs_staging2
where company = 'Carvana';

select industry from layoffs_staging2
where company = 'Juul';

select * from layoffs_staging2 as t1
join layoffs_staging2 as t2
	on t1.company = t2.company
    and t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;  

update layoffs_staging2
set industry = null
where industry = ''; --  changin the blank spaces to null inorder to remove null values from industry column

select industry from layoffs_staging2
where industry = null;

update layoffs_staging2 as t1
join layoffs_staging2 as t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

select distinct industry
from layoffs_staging2;

-- since we don't have enough data for total employess we cannot calculate the missing values aka null values for percentage_laid_off and total_laid_off columns
-- similary there is no enoough data for fund_raised so we cannnot populate data for fund_raised column

-- Remove unneccessary data

-- since there are some entries in the data that we don't have in both total laid off and percentage laid off, so we can and cannot delete those entries depend on business requirement if they are of no use to us we can delete.

select * from layoffs_staging2;

alter table layoffs_staging2
drop column `row-numb`;


