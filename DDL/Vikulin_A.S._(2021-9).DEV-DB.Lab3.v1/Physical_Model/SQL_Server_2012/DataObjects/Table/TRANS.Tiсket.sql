CREATE TABLE TRANS.Tiсket 
    (
     TicketNumber VARCHAR (100) , 
     TripCode VARCHAR NOT NULL , 
     ModelId NVARCHAR (20) NOT NULL , 
     SeatID VARCHAR (5) NOT NULL , 
     PersonId INTEGER NOT NULL , 
     TariffId INTEGER NOT NULL , 
     Price NUMERIC (28) NOT NULL , 
     DateOfSelling DATE NOT NULL 
    )
GO