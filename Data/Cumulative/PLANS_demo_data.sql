INSERT INTO DevDB2022_andvik.PLANS.Route (RouteDescription,RouteLength,TimeToDriveEst,FromLocationID,ToLocationID) VALUES
	 (N'SPB-HELSINKI-A',390,310,1,5),
	 (N'SPB-HELSINKI-B',395,335,2,5),
	 (N'SPB-HELSINKI-C',392,450,3,5),
	 (N'SPB-HELSINKI-D',387,370,4,5);
	 
EXEC PLANS.CreateTrip 2, N'Ford-12', 1, '2022-05-12';
EXEC PLANS.CreateTrip 2, N'Ford-12', 1, '2022-05-18';
EXEC PLANS.CreateTrip 2, N'Ford-12', 1, '2022-05-22';
EXEC PLANS.CreateTrip 3, N'Sprinter-2-1', 2, '2022-05-10';
EXEC PLANS.CreateTrip 3, N'Sprinter-2-1', 2, '2022-05-16';
EXEC PLANS.CreateTrip 3, N'Sprinter-2-1', 2,'2022-05-20';
EXEC PLANS.CreateTrip 3, N'Ford-12', 2, '2022-06-01';	

EXEC PLANS.SetTripState 'TRP-10/2022', 'PREPARED';
EXEC PLANS.SetTripState 'TRP-10/2022', 'READY';
EXEC PLANS.SetTripState 'TRP-10/2022', 'ON_THE_WAY';
EXEC PLANS.SetTripState 'TRP-10/2022', 'ARRIVING';
EXEC PLANS.SetTripState 'TRP-10/2022', 'FINISHED';
