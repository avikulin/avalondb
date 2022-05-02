ALTER TABLE PLANS.Route 
    ADD CONSTRAINT Route_Location_FK FOREIGN KEY 
    ( 
     ToLocationId
    ) 
    REFERENCES DICT.Location 
    ( 
     LocationID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO