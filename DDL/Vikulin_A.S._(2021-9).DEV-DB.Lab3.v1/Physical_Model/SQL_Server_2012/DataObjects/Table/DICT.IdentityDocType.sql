CREATE TABLE DICT.IdentityDocType 
    (
     DocTypeId INTEGER NOT NULL IDENTITY NOT FOR REPLICATION , 
     TypeDescription VARCHAR (50) NOT NULL , 
     AllowToDrive BIT NOT NULL , 
     AllowToTrip BIT NOT NULL 
    )
GO 

    


CREATE NONCLUSTERED INDEX 
    IdentityDocType_Desc_IDX ON DICT.IdentityDocType 
    ( 
     TypeDescription 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    IdentityDocType_AllowDrive_IDX ON DICT.IdentityDocType 
    ( 
     AllowToDrive 
    ) 
GO 


CREATE NONCLUSTERED INDEX 
    IdentityDocType_AllowTrip_IDX ON DICT.IdentityDocType 
    ( 
     AllowToTrip 
    ) 
GO