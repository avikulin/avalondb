CREATE TABLE REG.Person 
    (
     PersonId INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     LastName VARCHAR (100) NOT NULL , 
     FirstName VARCHAR (100) NOT NULL , 
     MiddleName VARCHAR (100) NOT NULL , 
     BirthDate DATE NOT NULL , 
     SexId CHAR (1) NOT NULL 
    )
GO 

    


CREATE NONCLUSTERED INDEX 
    Person_Name_IDX ON REG.Person 
    ( 
     LastName , 
     FirstName , 
     MiddleName 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    Person_BirthDate_IDX ON REG.Person 
    ( 
     BirthDate 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    Person_Sex_IDX ON REG.Person 
    ( 
     SexId 
    ) 
GO