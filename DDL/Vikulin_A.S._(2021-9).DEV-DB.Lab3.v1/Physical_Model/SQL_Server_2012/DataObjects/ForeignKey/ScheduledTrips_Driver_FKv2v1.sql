ALTER TABLE PLANS.ScheduledTrips 
    ADD CONSTRAINT ScheduledTrips_Driver_FKv2v1 FOREIGN KEY 
    ( 
     RouteID
    ) 
    REFERENCES PLANS.Route 
    ( 
     RouteID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO