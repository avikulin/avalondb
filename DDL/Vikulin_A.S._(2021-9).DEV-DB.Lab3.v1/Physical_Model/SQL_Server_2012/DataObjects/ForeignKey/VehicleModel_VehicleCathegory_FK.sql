ALTER TABLE DICT.VehicleModel 
    ADD CONSTRAINT VehicleModel_VehicleCathegory_FK FOREIGN KEY 
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