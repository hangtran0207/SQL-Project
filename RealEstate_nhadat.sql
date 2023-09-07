--Cleaning Data in SQL Queries 
Select*
from dbo.final$


--Standardize Data Format 





-----------------------------------------------------------
--Populate Property Address data 


Select *
From dbo.final$
--where Location is null
order by id

Select a.ID, a.Location, b.ID, b.Location, ISNULL (a.Location,b.Location)
From dbo.final$ a
JOIN dbo.final$ b
	 on a.ID = b.ID
	 and a.[category] <> b.[category]
where a.Location is NULL

Update a
Set location = ISNULL (a.Location,b.Location)
From dbo.final$ a
JOIN dbo.final$ b
	 on a.ID = b.ID
	 and a.[category] <> b.[category]
where a.Location is NULL






-----------------------------------------------------------
-- Breaking out Address into Individual Columns (Address, City, State)

Select location
from dbo.final$
--where Location is null
--order by ID

SELECT
    PARSENAME(REPLACE(Location, ', ', '.'), 3) AS Address,
    PARSENAME(REPLACE(Location, ', ', '.'), 2) AS Address,
    PARSENAME(REPLACE(Location, ', ', '.'), 1) AS Address
FROM dbo.final$;

ALTER TABLE dbo.final$
Add Ward Nvarchar(255);

Update dbo.final$
SET Ward = PARSENAME(REPLACE(Location, ', ', '.'), 3)

ALTER TABLE dbo.final$
Add District Nvarchar(255);

Update dbo.final$
SET District = PARSENAME(REPLACE(Location, ', ', '.'), 2)

ALTER TABLE dbo.final$
Add City Nvarchar(255);

Update dbo.final$
SET City = PARSENAME(REPLACE(Location, ', ', '.'), 1)


Select *
From dbo.final$





------------------------------------
--Delete All NULL VALUES 

ALTER TABLE dbo.final$
DROP COLUMN [direction], [rooms], [kitchen], [living room], [floor]




--------------------------------------
--Check duplicate

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY Category,
				 Price,
				 Area,
				 [Estate type],
				 Bathrooms
				 ORDER BY
					ID
					) row_num
From dbo.final$
--order by ID
)
Select *
From RowNumCTE
Where row_num > 1
Order by ID



Select *
From dbo.final$

