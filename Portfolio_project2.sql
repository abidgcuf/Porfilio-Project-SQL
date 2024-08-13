select * 
from PortfolioProject..CovidDeaths
order by 3,4

--select * 
--from PortfolioProject..CovidVaccinations
--order by 3,4
-- Select the data which we are going to use
select Location,date,total_cases,new_cases,population
from PortfolioProject..CovidDeaths
order by 1,2