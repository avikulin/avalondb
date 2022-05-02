ALTER TABLE REG.IdentityDocument ADD CONSTRAINT IdentityDocument_PK PRIMARY KEY CLUSTERED (DocId)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE REG.IdentityDocument ADD CONSTRAINT IdentityDocument_DocTypeId_PersonId_SeriesNum_DocumentNum_UN UNIQUE NONCLUSTERED (DocTypeId, PersonId, SeriesNum, DocumentNum)
GO

ALTER TABLE REG.IdentityDocument ADD CONSTRAINT IdentityDocument_CK_1 CHECK ( IssueDate > '1920-01-01' ) 
GO