ALTER TABLE PLANS.TripStateHistory ADD CONSTRAINT TripStateHistory_PK PRIMARY KEY CLUSTERED (StateID, TripCode)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE PLANS.TripStateHistory ADD CONSTRAINT TripStateHistory_TripCode_StateID_DateTimeRegister_UN UNIQUE NONCLUSTERED (StateID, DateTimeRegister)
GO