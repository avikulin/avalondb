CREATE TABLE PLANS.TripStateHistory 
    (
     TripCode VARCHAR (20) NOT NULL , 
     StateID NVARCHAR (10) NOT NULL , 
     DateTimeRegister DATETIME NOT NULL 
    )
GO 

    


CREATE NONCLUSTERED INDEX 
    TripStateHistory_DateTime_IDX ON PLANS.TripStateHistory 
    ( 
     DateTimeRegister 
    ) 
GO