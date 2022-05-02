ALTER TABLE PLANS.ScheduledTrips ADD CONSTRAINT ScheduledTrips_PK PRIMARY KEY CLUSTERED (TripCode)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE PLANS.ScheduledTrips ADD CONSTRAINT ScheduledTrips_RouteID_VehicleId_PlannedStartDate_UN UNIQUE NONCLUSTERED (RouteID, VehicleID, PlannedStartDate)
GO

ALTER TABLE PLANS.ScheduledTrips ADD CONSTRAINT ScheduledTrips_Date_CK CHECK ( PlannedStartDate > '1990-01-01' ) 
GO