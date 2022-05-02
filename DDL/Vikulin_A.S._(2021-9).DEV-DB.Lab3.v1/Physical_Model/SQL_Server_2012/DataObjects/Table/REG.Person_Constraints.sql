ALTER TABLE REG.Person ADD CONSTRAINT Person_PK PRIMARY KEY CLUSTERED (PersonId)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE REG.Person ADD CONSTRAINT Person_LastName_FirstName_MiddleName_BirthDate_SexId_UN UNIQUE NONCLUSTERED (LastName, FirstName, MiddleName, BirthDate, SexId)
GO

ALTER TABLE REG.Person ADD CONSTRAINT Person_CK_1 CHECK ( BirthDate > '1920-01-01' ) 
GO