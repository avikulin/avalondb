CREATE TABLE DICT.LocationTypes 
    (
     TypeID NVARCHAR (20) NOT NULL , 
     TypeName NVARCHAR (200) NOT NULL 
    )
GO 

    


CREATE NONCLUSTERED INDEX 
    LOCATION_TYPES_IDX ON DICT.LocationTypes 
    ( 
     TypeID 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    LOCATION_NAME_IDX ON DICT.LocationTypes 
    ( 
     TypeName 
    ) 
GO