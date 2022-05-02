ALTER TABLE TRANS.Tiсket 
    ADD CONSTRAINT Tiket_Person_FK FOREIGN KEY 
    ( 
     PersonId
    ) 
    REFERENCES REG.Person 
    ( 
     PersonId 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO