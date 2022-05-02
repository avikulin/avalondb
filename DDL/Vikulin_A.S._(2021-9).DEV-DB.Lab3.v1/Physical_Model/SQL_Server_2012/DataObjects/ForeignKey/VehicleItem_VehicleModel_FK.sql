ALTER TABLE FLEET.VehicleItem 
    ADD CONSTRAINT VehicleItem_VehicleModel_FK FOREIGN KEY 
    ( 
     ModelId
    ) 
    REFERENCES DICT.VehicleModel 
    ( 
     ModelId 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO