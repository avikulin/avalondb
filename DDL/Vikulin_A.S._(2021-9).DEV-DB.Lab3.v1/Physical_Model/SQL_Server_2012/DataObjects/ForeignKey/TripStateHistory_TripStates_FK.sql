ALTER TABLE PLANS.TripStateHistory 
    ADD CONSTRAINT TripStateHistory_TripStates_FK FOREIGN KEY 
    ( 
     StateID
    ) 
    REFERENCES DICT.TripStates 
    ( 
     StateID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO