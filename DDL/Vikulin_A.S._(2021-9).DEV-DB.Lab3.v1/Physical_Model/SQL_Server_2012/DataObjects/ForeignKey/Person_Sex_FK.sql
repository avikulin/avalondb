ALTER TABLE REG.Person 
    ADD CONSTRAINT Person_Sex_FK FOREIGN KEY 
    ( 
     SexId
    ) 
    REFERENCES DICT.Sex 
    ( 
     SexId 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO