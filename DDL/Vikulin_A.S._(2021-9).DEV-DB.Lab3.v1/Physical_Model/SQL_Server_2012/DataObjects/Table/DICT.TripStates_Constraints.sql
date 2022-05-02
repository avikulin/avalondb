ALTER TABLE DICT.TripStates ADD CONSTRAINT TripStates_PK PRIMARY KEY CLUSTERED (StateID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE DICT.TripStates ADD CONSTRAINT TripStates_StateID_IsInitial_IsInProgress_isTerminal_UN UNIQUE NONCLUSTERED (StateID, IsInitial, IsInProgress, isTerminal)
GO
ALTER TABLE DICT.TripStates ADD CONSTRAINT TripStates_Description_UN UNIQUE NONCLUSTERED (Description)
GO

ALTER TABLE DICT.TripStates ADD CONSTRAINT TripStates_Type_CK CHECK ( 1 = 
(IsInitial & ~IsInProgress & ~IsTerminal) | 
(~IsInitial & IsInProgress & ~IsTerminal) | 
(~IsInitial & ~IsInProgress & IsTerminal) ) 
GO