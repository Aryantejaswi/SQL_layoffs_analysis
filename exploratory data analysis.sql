select * from layoff_staging3;

select max(total_laid_off) ,max(percentage_laid_off)
from layoff_staging3;

select company, percentage_laid_off, total_laid_off
from layoff_staging3
where percentage_laid_off=1
order by total_laid_off desc;

select company, sum(total_laid_off)
from layoff_staging3
group by company
order by 2 desc;

select min(`date`), max(`date`)
from layoff_staging3;

select industry, sum(total_laid_off)
from layoff_staging3
group by industry
order by 2 desc;

select country, sum(total_laid_off)
from layoff_staging3
group by country
order by 2 desc;

select year(`date`), sum(total_laid_off)
from layoff_staging3
group by year(`date`)
order by 1 desc;

select stage, sum(total_laid_off)
from layoff_staging3
group by stage
order by 2 desc;

select substring(`date`,1,7) as `month`,sum(total_laid_off)
from layoff_staging3
where substring(`date`,1,7) is not null 
group by `month`
order by 1 asc;

with rolltotal as(
select substring(`date`,1,7) as `month`,sum(total_laid_off)as toff
from layoff_staging3
where substring(`date`,1,7) is not null 
group by `month`
order by 1 asc
)
select `month`, toff, sum(toff) over(order by `month`) as rollingtotal
from rolltotal;

select company , year(`date`),sum(total_laid_off)
from layoff_staging3
group by company , year(`date`)
order by 3 desc;

with companyyear(company , years,total_laid_off) as(
select company , year(`date`),sum(total_laid_off)
from layoff_staging3
group by company , year(`date`)
), companyrank as(
select *,
dense_rank()over(partition by years order by total_laid_off desc) as ranking
from companyyear
where years is not null
)
select *
from companyrank
where ranking <= 5;







