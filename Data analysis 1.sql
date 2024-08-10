-- Data Analysis

SELECT * 
FROM layoffs_staging2;

SELECT max(total_laid_off),max(percentage_laid_off)
FROM layoffs_staging2;

SELECT * 
FROM layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

SELECT company, sum(total_laid_off)
FROM layoffs_staging2
group by company
order by 2 desc;

SELECT min(`date`), max(`date`)
FROM layoffs_staging2;

SELECT industry, sum(total_laid_off)
FROM layoffs_staging2
group by industry
order by 2 desc;

SELECT country, sum(total_laid_off)
FROM layoffs_staging2
group by country
order by 2 desc;

SELECT `date`, sum(total_laid_off)
FROM layoffs_staging2
group by `date`
order by 2 desc;

SELECT Year(`date`), sum(total_laid_off)
FROM layoffs_staging2
group by Year(`date`)
order by 1 desc;

SELECT stage, sum(total_laid_off)
FROM layoffs_staging2
group by stage
order by 2 desc;

SELECT company, Avg(percentage_laid_off)
FROM layoffs_staging2
group by company
order by 2 desc;
WITH Rolling_total as (
select substring(`date`,1,7) AS 'MONTH', sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7)  IS not NULL
group by `MONTH`
order by 1 asc
)
select `MONTH` ,total_off,
 sum(total_off) over(order by `MONTH`) as rolling_total
from Rolling_total;

SELECT company, sum(total_laid_off)
FROM layoffs_staging2
group by company
order by 2 desc;

SELECT company, year(`date`),sum(total_laid_off)
FROM layoffs_staging2
group by company,year(`date`)
order by 3 desc
;
with company_year(comany,years,total_laid_off) as(
SELECT company, year(`date`),sum(total_laid_off)
FROM layoffs_staging2
group by company,year(`date`)
order by 3 desc
),
company_year_ranking as
(select * ,dense_rank() over(partition by years order by total_laid_off desc) as Ranking
from company_year
where years is not null)
select * 
from company_year_ranking
where Ranking <=  5
;