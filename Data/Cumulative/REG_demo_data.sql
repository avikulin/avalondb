INSERT INTO DevDB2022_andvik.REG.Person (LastName,FirstName,MiddleName,BirthDate,SexId) VALUES
	 (N'Ivanov',N'Ivan',N'Ivanovich','1985-04-29',N'M'),
	 (N'Petrov',N'Petr',N'Petrovich','1978-09-30',N'M'),
	 (N'Sidorov',N'Sergey',N'Pavlovich','1986-07-11',N'M'),
	 (N'Vikulin',N'Andrey',N'Sergeevich','1982-02-11',N'M'),
	 (N'Vikulina',N'Anastasia',N'Sergeevna','1981-07-30',N'F');

INSERT INTO DevDB2022_andvik.REG.IdentityDocument (DocTypeId,PersonId,SeriesNum,DocumentNum,IssuerOrg,IssueDate) VALUES
	 (1,1,N'0703',N'111222',N'OVD Essentuky','2003-04-18'),
	 (2,2,N'4005',N'666777',N'OVD of Primorskiy dist., St-Peterburg','2008-05-16'),
	 (3,1,N'9963',N'888888888',N'OMVD Moscow','2019-11-06'),
	 (3,2,N'7875',N'666666666',N'OMVD Moscow','2011-10-24'),
	 (2,3,N'5236',N'253652',N'OVD Vyborg','1998-03-06'),
	 (2,4,N'4795',N'368741',N'OVD Lobnya','1996-07-29'),
	 (2,5,N'4320',N'379625',N'OVD Istra','2000-02-16'),
	 (3,4,N'9898',N'777777777',N'OMVD Ryazan','2001-08-27');