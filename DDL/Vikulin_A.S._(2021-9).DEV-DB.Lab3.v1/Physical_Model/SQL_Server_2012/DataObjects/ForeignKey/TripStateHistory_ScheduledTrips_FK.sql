ALTER TABLE PLANS.TripStateHistory 
    ADD CONSTRAINT TripStateHistory_ScheduledTrips_FK FOREIGN KEY 
    ( 
     TripCode
    ) 
    REFERENCES PLANS.ScheduledTrips 
    ( 
     TripCode 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO