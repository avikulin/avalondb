ALTER TABLE FLEET.Driver 
    ADD CONSTRAINT Driver_IdentityDocument_FK FOREIGN KEY 
    ( 
     DocId
    ) 
    REFERENCES REG.IdentityDocument 
    ( 
     DocId 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO