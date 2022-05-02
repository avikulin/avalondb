ALTER TABLE REG.IdentityDocument 
    ADD CONSTRAINT IdentityDocument_Person_FK FOREIGN KEY 
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