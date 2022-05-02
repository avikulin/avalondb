ALTER TABLE DICT.SeatsLayoutPlan 
    ADD CONSTRAINT SeatsLayoutPlan_VehicleModel_FK FOREIGN KEY 
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