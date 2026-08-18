use PROJECTSA
-- 2a. Total Sales for each product name 
create view ProductName as 
	(select ProductName, round(sum(SalesAmount),2) as TotalSales
	from AdventureWork_Sales
	inner join AdventureWorks_Products
	on AdventureWork_Sales.ProductKey=AdventureWorks_Products.ProductKey
	group by ProductName)

select * from ProductName

-- 2b. Total tax amount for each product color
create view TaxAmount as 
	(select ProductColor, sum(TaxAmt) as TotalTaxAmount
	from AdventureWork_Sales
	inner join AdventureWorks_Products
	on AdventureWork_Sales.ProductKey=AdventureWorks_Products.ProductKey
	group by ProductColor)

select * from TaxAmount

-- 2c. Total freight for each product name 
create view TotalFreight as 
	(select ProductName, round(sum(Freight),2) as TotalFreight
	from AdventureWork_Sales
	inner join AdventureWorks_Products
	on AdventureWork_Sales.ProductKey=AdventureWorks_Products.ProductKey
	group by ProductName)

select * from TotalFreight

-- 2d. The sum of proportion of the sum of total product cost for each product name
create view TotalProductCost as 
	(select ProductName, round(sum(TotalProductCost),2) as TotalProductCost
	from AdventureWork_Sales
	inner join AdventureWorks_Products
	on AdventureWork_Sales.ProductKey=AdventureWorks_Products.ProductKey
	group by ProductName)

select * from TotalProductCost

-----------------------------------------------------------------------------------------------------

-- 3a. Total sales amount and total freight from each country
create view TotalCountryFreight as 
	(select Country, round(sum(SalesAmount),2) as TotalSales,round(sum(Freight),2) as TotalFreight
	from AdventureWork_Sales
	inner join AdventureWorks_Territories
	on AdventureWork_Sales.SalesTerritoryKey=AdventureWorks_Territories.SalesTerritoryKey
	group by Country)

select * from TotalCountryFreight

-- 3b. Percentage of Total tax amount for each region
create view RegionTaxAmount as 
	(select Region, round(sum(TaxAmt)*100/sum(sum(TaxAmt)) over(),0) as TotalTaxPercent
	from AdventureWork_Sales
	inner join AdventureWorks_Territories
	on AdventureWork_Sales.SalesTerritoryKey=AdventureWorks_Territories.SalesTerritoryKey
	group by Region)

select * from RegionTaxAmount

-----------------------------------------------------------------------------------------------------

--4a. United Nations Estimate for each Country Territory in Europe
create view UNEstimateEurope as
	(select CountryTerritory, sum(UnitedNationsEstimate) as UNEstimate
	from WorldGDP
	where UNRegion = 'Europe'
	group by CountryTerritory)

select * from UNEstimateEurope

-- 4b. Total World Bank Estimate in each UN Region
create view UNRegionWrldBnkEst as 
	(select UNRegion, sum(WorldBankEstimate) as TotalEstimate
	from WorldGDP
	group by UNRegion)

select * from UNRegionWrldBnkEst

-- 4c. UN Region with Average World Bank Estimate greater than 1000000 
create view AvgUNReg as
	(select UNRegion, avg(WorldBankEstimate) as AvgWrldBnkEst
	from WorldGDP
	group by UNRegion
	having avg(WorldBankEstimate) > 100000)

select * from AvgUNReg


-- 4d. Country Territory with total World Bank Estimate greater than 2000000 
create view WorldBnkTerritoryTotal as 
	(select CountryTerritory, sum(WorldBankEstimate) as TotalWrldBnkEst
	from WorldGDP
	group by CountryTerritory
	having sum(WorldBankEstimate) > 2000000)

select * from WorldBnkTerritoryTotal