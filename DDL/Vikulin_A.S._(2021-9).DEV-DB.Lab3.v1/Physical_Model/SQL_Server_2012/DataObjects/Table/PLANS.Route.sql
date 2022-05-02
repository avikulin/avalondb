CREATE TABLE PLANS.Route 
    (
     RouteID INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     RouteDescription NVARCHAR (200) NOT NULL , 
     RouteLength INTEGER NOT NULL , 
     TimeToDriveEst INTEGER NOT NULL , 
     FromLocationId INTEGER NOT NULL , 
     ToLocationId INTEGER NOT NULL 
    )
GO 

    


CREATE NONCLUSTERED INDEX 
    Route_Desc_IDX ON PLANS.Route 
    ( 
     RouteDescription 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    Route_From_To_IDX ON PLANS.Route 
    ( 
     FromLocationId , 
     ToLocationId 
    ) 
GO