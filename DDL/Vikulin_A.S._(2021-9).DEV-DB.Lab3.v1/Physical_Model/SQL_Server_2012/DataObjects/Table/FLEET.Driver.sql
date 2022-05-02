CREATE TABLE FLEET.Driver 
    (
     DriverId INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     PersonId INTEGER NOT NULL , 
     CatId INTEGER NOT NULL , 
     DocId INTEGER NOT NULL 
    )
GO 

    


CREATE UNIQUE NONCLUSTERED INDEX 
    Driver_Person_Cathegory_IDX ON FLEET.Driver 
    ( 
     PersonId , 
     CatId 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    Driver_Licence_IDX ON FLEET.Driver 
    ( 
     DocId 
    ) 
GO 


CREATE UNIQUE NONCLUSTERED INDEX 
    Driver__IDX ON FLEET.Driver 
    ( 
     PersonId 
    ) 
GO