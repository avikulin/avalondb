ALTER TABLE TRANS.Tiсket 
    ADD CONSTRAINT Tiket_SeatsLayoutPlan_FK FOREIGN KEY 
    ( 
     SeatID, 
     ModelId
    ) 
    REFERENCES DICT.SeatsLayoutPlan 
    ( 
     SeatID , 
     ModelId 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO