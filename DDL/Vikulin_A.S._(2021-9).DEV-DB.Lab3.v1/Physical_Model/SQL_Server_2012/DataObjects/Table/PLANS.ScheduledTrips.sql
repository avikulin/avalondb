CREATE TABLE PLANS.ScheduledTrips 
    (
     TripCode VARCHAR (20) NOT NULL , 
     RouteID INTEGER NOT NULL , 
     VehicleID NVARCHAR (20) NOT NULL , 
     DriverId INTEGER NOT NULL , 
     PlannedStartDate DATE NOT NULL 
    )
GO 

    


CREATE NONCLUSTERED INDEX 
    ScheduledTrips_Route_IDX ON PLANS.ScheduledTrips 
    ( 
     RouteID 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    ScheduledTrips_Route_Date_IDXv1 ON PLANS.ScheduledTrips 
    ( 
     RouteID , 
     PlannedStartDate 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    ScheduledTrips_Driver_Date_IDX ON PLANS.ScheduledTrips 
    ( 
     DriverId , 
     PlannedStartDate 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    ScheduledTrips_Vehicle_Date_IDX ON PLANS.ScheduledTrips 
    ( 
     VehicleID , 
     PlannedStartDate 
    ) 
GO