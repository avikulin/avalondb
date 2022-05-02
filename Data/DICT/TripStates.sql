INSERT INTO DevDB2022_andvik.DICT.TripStates (Description,IsInitial,IsInProgress,isTerminal) VALUES
	 (N'Planned',1,0,0),
	 (N'Prepared',0,1,0),
	 (N'Ready',0,1,0),
	 (N'On the way',0,1,0),
	 (N'Arriving',0,1,0),
	 (N'Finished',0,0,1);