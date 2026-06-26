select *
from layoffs;

create table layoff_staging
like layoffs;
select *
from layoff_staging;

insert into layoff_staging
select *
from layoffs;

select *,
row_number() 
over(partition by company , location , industry , total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions)as rownum
from layoff_staging;

CREATE TABLE `layoff_staging3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `rownum` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoff_staging3;

insert into layoff_staging3
select *,
row_number() 
over(partition by company , location , industry , total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions)as rownum
from layoff_staging;

delete
from layoff_staging3 
WHERE rownum>1 ;

update layoff_staging3 
set company = trim(company);

select distinct industry
from layoff_staging3
order by 1;

update layoff_staging3
set industry = "Crypnto"
where industry like "Crypto%";

select distinct country
from layoff_staging3
order by 1;

update layoff_staging3
set country= trim(trailing '.' from country)
where country like "United States%";

select `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoff_staging3;

update layoff_staging3 
set `date` = str_to_date(`date`,'%m/%d/%Y');

select *
from layoff_staging3 ;

alter table layoff_staging3 
modify column `date` date;

update  layoff_staging3 
set industry = null
where industry = '';


select *
from layoff_staging3 
where industry is null;

select *
from layoff_staging3 as t1
join layoff_staging3 as t2
on t1.company=t2.company
where t1.industry is null 
and t2.industry is not null;

update layoff_staging3 as t1
join layoff_staging3 as t2
on t1.company=t2.company
set t1.industry=t2.industry
where t1.industry is null 
and t2.industry is not null;


select *
from layoff_staging3
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoff_staging3
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoff_staging3 ;

alter table layoff_staging3
drop column rownum;





