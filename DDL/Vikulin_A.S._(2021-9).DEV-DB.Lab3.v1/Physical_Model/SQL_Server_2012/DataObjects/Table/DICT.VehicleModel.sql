CREATE TABLE DICT.VehicleModel 
    (
     ModelId NVARCHAR (20) NOT NULL , 
     ModelName NVARCHAR (200) NOT NULL , 
     CatId INTEGER NOT NULL 
    )
GO 

    


CREATE NONCLUSTERED INDEX 
    VehicleModel_Name_IDX ON DICT.VehicleModel 
    ( 
     ModelName 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    VehicleModel_Cathegory_IDX ON DICT.VehicleModel 
    ( 
     CatId 
    ) 
GO