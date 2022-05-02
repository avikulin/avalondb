CREATE TABLE FLEET.VehicleItem 
    (
     VehicleID NVARCHAR (20) NOT NULL , 
     ModelId NVARCHAR (20) NOT NULL , 
     SerialNumber NVARCHAR (100) NOT NULL , 
     RegNumber NVARCHAR (100) NOT NULL , 
     YearOfIssue INTEGER NOT NULL , 
     GuaranteePeriod DATE , 
     MaxTotalMileage INTEGER NOT NULL , 
     IsActive INTEGER NOT NULL 
    )
GO 

    


CREATE NONCLUSTERED INDEX 
    VehicleItem_Model_IDX ON FLEET.VehicleItem 
    ( 
     ModelId 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    VehicleItem_RegNum_IDXv1 ON FLEET.VehicleItem 
    ( 
     RegNumber 
    ) 
GO