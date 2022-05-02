CREATE TABLE REG.IdentityDocument 
    (
     DocId INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     DocTypeId INTEGER NOT NULL , 
     PersonId INTEGER NOT NULL , 
     SeriesNum VARCHAR (20) NOT NULL , 
     DocumentNum VARCHAR (100) NOT NULL , 
     IssuerOrg VARCHAR (200) NOT NULL , 
     IssueDate DATE NOT NULL 
    )
GO 

    


CREATE NONCLUSTERED INDEX 
    IdentityDocument_Person_IDX ON REG.IdentityDocument 
    ( 
     PersonId 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    IdentityDocument_Person_DocType_IDXv1 ON REG.IdentityDocument 
    ( 
     DocTypeId , 
     PersonId 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    IdentityDocument_SerNum_IDX ON REG.IdentityDocument 
    ( 
     SeriesNum , 
     DocumentNum 
    ) 
GO