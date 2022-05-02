ALTER TABLE DICT.Location 
    ADD CONSTRAINT Location_LocationTypes_FK FOREIGN KEY 
    ( 
     TypeID
    ) 
    REFERENCES DICT.LocationTypes 
    ( 
     TypeID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO