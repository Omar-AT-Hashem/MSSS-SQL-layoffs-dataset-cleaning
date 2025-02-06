USE layoffsCleaning;

SELECT * FROM layoffs;

SELECT * INTO layoffs_staging1 FROM layoffs;

SELECT * FROM layoffs_staging1;

--- Marking dulplicates (row num > 1)
SELECT *, ROW_NUMBER()
OVER(PARTITION BY company, [location], industry, total_laid_off, percentage_laid_off, [date], stage, country, funds_raised_millions ORDER BY company) as row_num
INTO layoffs_staging2
FROM layoffs_staging1;


SELECT * FROM layoffs_staging2;

-- Removing Duplicates
DELETE FROM layoffs_staging2 WHERE row_num > 1

--Trim company names
UPDATE layoffs_staging2 set company = TRIM(company);

SELECT DISTINCT(location) FROM layoffs_staging2 ORDER BY 1;
SELECT DISTINCT(country)  FROM layoffs_staging2 ORDER BY 1;														  

--remove the trailing '.' from country names
UPDATE layoffs_staging2 SET country = TRIM(TRAILING '.' from country)

SELECT DISTINCT(industry) FROM layoffs_staging2 ORDER BY 1;

--convert all variations of the crypto industry to just 'Crypto'
UPDATE layoffs_staging2 SET industry = 'Crypto' WHERE industry LIKE 'Crypto%';

update layoffs_staging2 set date = '' where (date is NULL OR date = 'NULL')
--standardizing date (yyyy-mm-dd)
UPDATE layoffs_staging2 SET [date] = CONVERT(date, [date])

select CONVERT(date, [date])as date2 from layoffs_staging2

--- set nulls to ''
create procedure setColumNulls 
@column nvarchar(50)
as
begin

DECLARE @query nvarchar(MAX)

SET @query = 'UPDATE layoffs_staging2 
                     SET ' + QUOTENAME(@column) + ' = ''''
                     WHERE ' + QUOTENAME(@column) + ' IS NULL OR ' + QUOTENAME(@column) + ' = ''NULL''';

    EXEC sp_executesql @query;
end;


exec setColumNulls @column = 'location'
exec setColumNulls @column = 'industry'
exec setColumNulls @column = 'total_laid_off'
exec setColumNulls @column = 'percentage_laid_off'
exec setColumNulls @column = 'stage'
exec setColumNulls @column = 'country'
exec setColumNulls @column = 'funds_raised_millions'



select l.company, l.location, l.country, l.industry, r.industry from layoffs_staging2 l
inner join layoffs_staging2 r on l.company = r.company 
where r.industry != '' and l.industry = '';


--Set missing industry label on same location businesses
update l
set l.industry = r.industry
from layoffs_staging2 l
inner join layoffs_staging2 r on l.company = r.company 
where r.industry != '' and l.industry = ''

select * from layoffs_staging2

--remove the row_num column
alter table layoffs_staging2 drop column row_num

--copying the final form of data into a table to be used for further analytics 
select * into layoffsFinal from layoffs_staging2


select * from layoffsFinal


