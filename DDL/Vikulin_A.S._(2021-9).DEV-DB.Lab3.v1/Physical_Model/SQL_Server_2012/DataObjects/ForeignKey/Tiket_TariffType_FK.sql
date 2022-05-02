ALTER TABLE TRANS.Tiсket 
    ADD CONSTRAINT Tiket_TariffType_FK FOREIGN KEY 
    ( 
     TariffId
    ) 
    REFERENCES DICT.TariffType 
    ( 
     TariffId 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO