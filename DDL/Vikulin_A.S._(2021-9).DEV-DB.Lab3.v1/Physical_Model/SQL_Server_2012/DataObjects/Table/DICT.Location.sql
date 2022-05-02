CREATE TABLE DICT.Location 
    (
     LocationID INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     TypeID NVARCHAR (20) NOT NULL , 
     LocationAddress NVARCHAR (1000) NOT NULL , 
     GPSlatitude NUMERIC (10,6) NOT NULL , 
     GPSlongtitude NUMERIC (10,6) NOT NULL 
    )
GO 

    


CREATE NONCLUSTERED INDEX 
    LOCATION_ID_IDX ON DICT.Location 
    ( 
     LocationID 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    LOCATION_ADDRESS_IDX ON DICT.Location 
    ( 
     LocationAddress 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    LOCATION_TYPE_IDX ON DICT.Location 
    ( 
     TypeID 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    LOCATION_GRP_IDX ON DICT.Location 
    ( 
     GPSlatitude , 
     GPSlongtitude 
    ) 
GO