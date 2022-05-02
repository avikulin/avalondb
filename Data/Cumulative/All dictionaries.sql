INSERT INTO DICT.VehicleCathegory (LevelCode,LevelInfo) VALUES
	 (N'B',N'Passenger cars'),
	 (N'C',N'Miniwans'),
	 (N'D',N'Autobuses');

INSERT INTO DICT.VehicleModel (ModelId,ModelName,CatId) VALUES
	 (N'Sprinter-2',N'Mercedes-Benz Sprinter II',2),
	 (N'Tourneo-2017',N'Ford Tourneo Custom 2017',2);

INSERT INTO DICT.SeatsLayoutPlan (SeatID,ModelId,AllowKids,AllowPets) VALUES
	 (N'A1',N'Tourneo-2017',0,0),
	 (N'B1',N'Tourneo-2017',0,1),
	 (N'B2',N'Tourneo-2017',0,1),
	 (N'B3',N'Sprinter-2',0,1),
	 (N'B4',N'Sprinter-2',0,1),
	 (N'C1',N'Tourneo-2017',1,0),
	 (N'C2',N'Tourneo-2017',1,0),
	 (N'C3',N'Tourneo-2017',1,0),
	 (N'C5',N'Sprinter-2',0,0),
	 (N'C6',N'Sprinter-2',0,0);
INSERT INTO DICT.SeatsLayoutPlan (SeatID,ModelId,AllowKids,AllowPets) VALUES
	 (N'C7',N'Sprinter-2',0,0),
	 (N'D10',N'Sprinter-2',1,0),
	 (N'D8',N'Sprinter-2',1,0),
	 (N'D9',N'Sprinter-2',1,0),
	 (N'E11',N'Sprinter-2',1,0),
	 (N'E12',N'Sprinter-2',1,0),
	 (N'E13',N'Sprinter-2',1,0),
	 (N'F14',N'Sprinter-2',1,0),
	 (N'F15',N'Sprinter-2',1,0),
	 (N'F16',N'Sprinter-2',1,0);
INSERT INTO DICT.SeatsLayoutPlan (SeatID,ModelId,AllowKids,AllowPets) VALUES
	 (N'G17',N'Sprinter-2',0,0),
	 (N'G18',N'Sprinter-2',0,0),
	 (N'G19',N'Sprinter-2',0,0);

INSERT INTO DICT.TariffType (CodeName,Description) VALUES
	 (N'ECONOM',N'Economy class tariff'),
	 (N'BUSINESS',N'Business class tariff');

INSERT INTO DICT.TripStates (Description,IsInitial,IsInProgress,isTerminal) VALUES
	 (N'Planned',1,0,0),
	 (N'Prepared',0,1,0),
	 (N'Ready',0,1,0),
	 (N'On the way',0,1,0),
	 (N'Arriving',0,1,0),
	 (N'Finished',0,0,1);
 
INSERT INTO DICT.Sex (SexId, Name) VALUES
	 (N'F', N'Female'),
	 (N'M', N'Male');

INSERT INTO DICT.IdentityDocType (TypeDescription,AllowToDrive,AllowToTrip) VALUES
	 (N'Passport',0,1),
	 (N'International Passport',0,1),
	 (N'Driving Licence',1,0);
 
INSERT INTO DevDB2022_andvik.DICT.LocationTypes (TypeID,TypeName) VALUES
	 (N'EXT',N'External locality'),
	 (N'INT',N'Internal locality');

INSERT INTO DICT.Location 
	(TypeID, LocationAddress, GPSlatitude, GPSlongtitude) VALUES
	(N'INT', N'Санкт-Петербург, м. Площадь Восстания', 59.931483, 30.36036),
	(N'INT', N'Санкт-Петербург, м. Проспект Ветеранов', 59.84188, 30.251543),
	(N'INT', N'Санкт-Петербург, м. Ленинский проспект', 59.851677, 30.268279),
	(N'INT', N'Санкт-Петербург, м. Автово', 59.867369, 30.261345),
	(N'EXT', N'Хельсинки, ж/д вокзал', 60.171883, 24.941426);