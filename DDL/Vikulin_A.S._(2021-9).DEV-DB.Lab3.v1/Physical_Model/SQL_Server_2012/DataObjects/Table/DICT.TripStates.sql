CREATE TABLE DICT.TripStates 
    (
     StateID NVARCHAR (10) NOT NULL , 
     PrevStateID NVARCHAR (10) , 
     Description VARCHAR (50) NOT NULL , 
     IsInitial BIT NOT NULL , 
     IsInProgress BIT NOT NULL , 
     isTerminal BIT NOT NULL , 
     AllowBooking BIT NOT NULL 
    )
GO 

    


CREATE NONCLUSTERED INDEX 
    TripStates_Desc_IDX ON DICT.TripStates 
    ( 
     Description 
    ) 
GO