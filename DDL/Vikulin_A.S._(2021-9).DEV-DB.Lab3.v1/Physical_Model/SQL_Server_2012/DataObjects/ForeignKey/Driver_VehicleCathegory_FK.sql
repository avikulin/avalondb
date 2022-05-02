ALTER TABLE FLEET.Driver 
    ADD CONSTRAINT Driver_VehicleCathegory_FK FOREIGN KEY 
    ( 
     CatId
    ) 
    REFERENCES DICT.VehicleCathegory 
    ( 
     CatId 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO