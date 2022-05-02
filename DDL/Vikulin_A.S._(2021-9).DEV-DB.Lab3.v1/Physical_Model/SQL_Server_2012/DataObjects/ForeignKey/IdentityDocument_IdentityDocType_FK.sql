ALTER TABLE REG.IdentityDocument 
    ADD CONSTRAINT IdentityDocument_IdentityDocType_FK FOREIGN KEY 
    ( 
     DocTypeId
    ) 
    REFERENCES DICT.IdentityDocType 
    ( 
     DocTypeId 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO