ALTER TABLE PLANS.Route 
    ADD CONSTRAINT Route_Location_FKv2 FOREIGN KEY 
    ( 
     FromLocationId
    ) 
    REFERENCES DICT.Location 
    ( 
     LocationID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO