CREATE TABLE DICT.VehicleCathegory 
    (
     CatId INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     LevelCode VARCHAR (2) NOT NULL , 
     LevelInfo VARCHAR (100) NOT NULL 
    )
GO 

    


CREATE NONCLUSTERED INDEX 
    VehicleCathegory_IDX ON DICT.VehicleCathegory 
    ( 
     LevelCode 
    ) 
GO