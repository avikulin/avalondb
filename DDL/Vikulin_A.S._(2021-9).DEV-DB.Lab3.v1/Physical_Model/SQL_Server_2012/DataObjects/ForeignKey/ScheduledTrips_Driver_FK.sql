ALTER TABLE PLANS.ScheduledTrips 
    ADD CONSTRAINT ScheduledTrips_Driver_FK FOREIGN KEY 
    ( 
     DriverId
    ) 
    REFERENCES FLEET.Driver 
    ( 
     DriverId 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO