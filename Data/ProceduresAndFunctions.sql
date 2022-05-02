DROP FUNCTION PLANS.GetAvailableFleet;
CREATE FUNCTION PLANS.GetAvailableFleet()
RETURNS TABLE
AS
RETURN
	SELECT
		VehicleID as vehicle_id,
		ModelId as model_id,
		RegNumber as reg_number
	FROM FLEET.VehicleItem
	WHERE IsActive = 1;


DROP FUNCTION PLANS.GetFleetCategory;
CREATE FUNCTION PLANS.GetFleetCategory( @vehicle_id NVARCHAR(20) )
RETURNS TABLE
AS
RETURN
	SELECT vc.CatId as cat_id
	FROM 
		FLEET.VehicleItem vi INNER JOIN DICT.VehicleModel vm 
		ON vi.ModelId = vm.ModelId INNER JOIN DICT.VehicleCathegory vc 
		ON vm.CatId = vc.CatId 
	WHERE vi.VehicleID = @vehicle_id;

DROP FUNCTION PLANS.GetSuitableDriverFor;
CREATE FUNCTION  PLANS.GetSuitableDriverFor(@vehicle_id NVARCHAR(20))
RETURNS TABLE 
AS
RETURN
	SELECT 
		p.PersonId as id,
		p.LastName as last_name, 
		p.FirstName as first_name, 
		p.BirthDate as birth_date
	FROM FLEET.Driver d INNER JOIN REG.Person p 
	ON d.PersonId = p.PersonId 
	WHERE d.CatId >= (SELECT TOP(1) * FROM GetFleetCategory( @vehicle_id ));

DROP FUNCTION PLANS.GetPassengersList;
CREATE FUNCTION PLANS.GetPassengersList()
RETURNS TABLE 
AS
RETURN 
	SELECT 
		p.PersonId as id, 
		p.LastName as last_name, 
		p.FirstName as first_name, 
		p.MiddleName as middle_name,
		s.Name as sex, 
		p.BirthDate as birth_date
	FROM REG.Person p INNER JOIN REG.IdentityDocument id 
	ON p.PersonId = id.PersonId INNER JOIN DICT.IdentityDocType idt 
	ON id.DocTypeId = idt.DocTypeId INNER JOIN DICT.Sex s 
	ON p.SexId = s.SexId 
	WHERE idt.AllowToTrip = 1;


DROP SEQUENCE PLANS.TripCodeSeq;
CREATE SEQUENCE PLANS.TripCodeSeq AS INT START WITH 1 INCREMENT BY 1 CACHE 10;

DROP PROCEDURE PLANS.CreateTrip;
CREATE PROCEDURE PLANS.CreateTrip
	@route_id INT, 
	@vehicle_id NVARCHAR(20), 
	@driver_id INT,
	@planned_date DATE
AS
	BEGIN TRAN;

		DECLARE @msg NVARCHAR(100);
	
		IF @planned_date < GETDATE() + 1
		BEGIN
			RAISERROR('Planned date must be at least tomorrow.',11,1);
			RETURN;
		END
		
		IF NOT EXISTS (SELECT 1 FROM PLANS.Route r WHERE r.RouteID = @route_id)
		BEGIN 
			SET @msg = 'Route #'+ @route_id + ' not found.'; 
			RAISERROR(@msg,11,1);
			RETURN;
		END
		
		
		IF NOT EXISTS (SELECT 1 FROM GetAvailableFleet() f WHERE f.vehicle_id = @vehicle_id)
		BEGIN 
			SET @msg = 'Vehicle item '''+@vehicle_id+''' not found.';
			RAISERROR(@msg,11,1);
			RETURN;
		END
		
		IF NOT EXISTS (SELECT 1 FROM GetSuitableDriverFor(@vehicle_id) d WHERE d.id = @driver_id)
		BEGIN
			SET @msg = 'The driver #'+@driver_id+' have no appropriate cathegory to drive '+@vehicle_Id+'.';
			RAISERROR(@msg, 11, 1);
			RETURN;
		END
		
		DECLARE @new_trip_code NVARCHAR(20);
		SET @new_trip_code = 'TRP-'+CONVERT (NVARCHAR(5), NEXT VALUE FOR PLANS.TripCodeSeq)+'/'+
									CONVERT (NVARCHAR(4), YEAR (GETDATE()));
	
		BEGIN TRY
			INSERT INTO PLANS.ScheduledTrips (TripCode, RouteID, VehicleId, DriverId, PlannedStartDate)
			VALUES(@new_trip_code, @route_id, @vehicle_id, @driver_id, @planned_date);
		
			INSERT INTO TRANS.TripStateHistory (TripCode, StateID, DateTimeRegister)
			VALUES (@new_trip_code, (SELECT MIN(ts.StateID) FROM DICT.TripStates ts WHERE ts.IsInitial = 1), GETDATE());
		END TRY
		BEGIN CATCH
			RAISERROR('Can''t insest rows into "ScheduledTrips" and "TripStateHistory".', 11, 1);
			ROLLBACK TRAN;
			RETURN;
		END CATCH
		
	COMMIT;
	PRINT 'New trip #'+@new_trip_code+' created';

EXEC PLANS.CreateTrip @route_id=3, @vehicle_id='Ford-12', @driver_id=2, @planned_date='2022-06-01' ;

DROP PROCEDURE
CREATE PROCEDURE PLANS.SetTripStateReady 
	@trip_id NVARCHAR(20)
AS
	BEGIN TRAN;
		DECLARE @msg NVARCHAR(200);
		---with implicit shared lock
		IF NOT EXISTS (SELECT 1 FROM PLANS.ScheduledTrips st WHERE st.TripCode = @trip_id )
		BEGIN 
			SET @msg = 'Trip #'+@trip_id+' not found.';
			RAISERROR(@msg, 11, 1);
			RETURN;
		END

		IF NOT EXISTS (SELECT 1 FROM TRANS.TripStateHistory tsh WHERE tsh.TripCode = @trip_id AND )
		BEGIN 
			SET @msg = 'Trip #'+@trip_id+' not found.';
			RAISERROR(@msg, 11, 1);
			RETURN;
		END
		BEGIN TRY;
		END TRY;