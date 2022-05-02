ALTER TABLE DICT.TripStates 
    ADD CONSTRAINT TripStates_TripStates_FK FOREIGN KEY 
    ( 
     PrevStateID
    ) 
    REFERENCES DICT.TripStates 
    ( 
     StateID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO