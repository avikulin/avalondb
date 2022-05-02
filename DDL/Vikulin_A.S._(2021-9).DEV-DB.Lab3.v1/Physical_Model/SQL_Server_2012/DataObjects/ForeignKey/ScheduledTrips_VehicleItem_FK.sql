ALTER TABLE PLANS.ScheduledTrips 
    ADD CONSTRAINT ScheduledTrips_VehicleItem_FK FOREIGN KEY 
    ( 
     VehicleID
    ) 
    REFERENCES FLEET.VehicleItem 
    ( 
     VehicleID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO