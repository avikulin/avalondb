CREATE TABLE DICT.Sex 
    (
     SexId CHAR (1) NOT NULL , 
     Name VARCHAR (20) NOT NULL 
    )
GO 

    


CREATE NONCLUSTERED INDEX 
    Sex_Name_IDX ON DICT.Sex 
    ( 
     Name 
    ) 
GO