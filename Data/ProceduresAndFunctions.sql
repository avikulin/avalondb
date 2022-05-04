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

DROP FUNCTION PLANS.GetTripState;
CREATE  FUNCTION PLANS.GetTripState(@trip_id NVARCHAR(20))
RETURNS TABLE
AS
RETURN
	SELECT TOP(1) StateID as state_id
	FROM PLANS.TripStateHistory tsh
	WHERE tsh .TripCode = @trip_id
	ORDER BY DateTimeRegister DESC;

DROP FUNCTION PLANS.GetPrevState;
CREATE FUNCTION PLANS.GetPrevState(@state_id NVARCHAR(10))
RETURNS TABLE
AS
RETURN
	SELECT ts.PrevStateID as prev_state_id
	FROM DICT.TripStates ts
	WHERE ts.StateID = @state_id;

DROP FUNCTION TRANS.CheckSeatIsAvailable;
CREATE FUNCTION TRANS.CheckSeatIsAvailable(@trip_id NVARCHAR(20), @seat_id NVARCHAR(5))
RETURNS TABLE
AS
	RETURN
		SELECT slp.SeatID as seat_id
		FROM DICT.SeatsLayoutPlan slp WITH (NOLOCK) INNER JOIN FLEET.VehicleItem vi WITH (NOLOCK) 
		ON vi.ModelId = slp .ModelId INNER JOIN PLANS.ScheduledTrips st WITH (NOLOCK)
		ON vi.VehicleID = st.VehicleID 
		WHERE st.TripCode = @trip_id
		
		EXCEPT 
		
		SELECT t.SeatID as seat_id
		FROM TRANS.Tiñket t WITH (NOLOCK)
		WHERE t.TripCode  = @trip_id;


DROP SEQUENCE PLANS.TripCodeSeq;
CREATE SEQUENCE PLANS.TripCodeSeq AS INT START WITH 1 INCREMENT BY 1 CACHE 10;

DROP SEQUENCE TRANS.TicketCodeSeq;
CREATE SEQUENCE TRANS.TicketCodeSeq AS INT START WITH 1 INCREMENT BY 1 CACHE 10;

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
			ROLLBACK TRAN;
			RETURN;
		END
		
		IF NOT EXISTS (SELECT 1 FROM PLANS.Route r WHERE r.RouteID = @route_id)
		BEGIN 
			SET @msg = 'Route #'+ @route_id + ' not found.'; 
			RAISERROR(@msg,11,1);
			ROLLBACK TRAN;
			RETURN;
		END
		
		
		IF NOT EXISTS (SELECT 1 FROM GetAvailableFleet() f WHERE f.vehicle_id = @vehicle_id)
		BEGIN 
			SET @msg = 'Vehicle item '''+@vehicle_id+''' not found.';
			RAISERROR(@msg,11,1);
			ROLLBACK TRAN;
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
		
			INSERT INTO PLANS.TripStateHistory (TripCode, StateID, DateTimeRegister)
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

DROP PROCEDURE PLANS.SetTripState;
CREATE PROCEDURE PLANS.SetTripState 
	@trip_id NVARCHAR(20),
	@state_id NVARCHAR(10)
AS
	BEGIN TRAN;
		DECLARE @msg NVARCHAR(200);
		---with implicit shared lock on ScheduledTrips item
		IF NOT EXISTS (SELECT 1 FROM PLANS.ScheduledTrips st WHERE st.TripCode = @trip_id )
		BEGIN 
			SET @msg = 'Trip #'+@trip_id+' is not found.';
			RAISERROR(@msg, 11, 1);
			ROLLBACK TRAN;
			RETURN;
		END
		
		---with implicit shared lock on TripStates item
		IF NOT EXISTS (SELECT 1 FROM DICT.TripStates ts WHERE StateID = @state_id)
		BEGIN 
			SET @msg = 'State '''+@state_id+''' not found.';
			RAISERROR(@msg, 11, 1);
			ROLLBACK TRAN;
			RETURN;
		END
		
		IF NOT EXISTS (
						SELECT 1 
						FROM PLANS.GetTripState(@trip_id) 
						WHERE state_id = (
											SELECT prev_state_id 
											FROM PLANS.GetPrevState(@state_id))
					  )
		BEGIN
			SET @msg = 'Passed state '''+@state_id+''' is not applicable.';
			RAISERROR(@msg, 11, 1);
			ROLLBACK TRAN;
			RETURN;
		END

		BEGIN TRY
			INSERT INTO PLANS.TripStateHistory (TripCode, StateID, DateTimeRegister)
			VALUES (@trip_id, @state_id, GETDATE());
		END TRY
		BEGIN CATCH
			RAISERROR('Can''t insest rows into "TripStateHistory".', 11, 1);
			ROLLBACK TRAN;
			RETURN;
		END CATCH
	COMMIT;	
	PRINT 'New state '''+@state_id+''' is registered.';

DROP PROCEDURE RegisteANewBooking;

DROP PROCEDURE TRANS.RegisteANewBooking;
CREATE PROCEDURE TRANS.RegisteANewBooking
	@trip_id NVARCHAR(20),
	@passenger_id NVARCHAR(10),
	@seat_id NVARCHAR(5),
	@tariff_id INT,
	@price NUMERIC(10,2)
AS
	BEGIN TRAN;
		DECLARE @msg NVARCHAR(200);

		BEGIN TRY
			---explicit exclusive lock of the ScheduledTrip item
			SET @trip_id = (SELECT st.TripCode FROM PLANS.ScheduledTrips st WITH(XLOCK) WHERE st.TripCode = @trip_id);
		END TRY
		BEGIN CATCH
			SET @msg = 'Can''t aquire exclusive lock on trip #' + @trip_id;
			RAISERROR(@msg, 11, 1);
			ROLLBACK TRAN;
			RETURN;
		END CATCH
		
		IF NOT EXISTS (
						SELECT 1
						FROM PLANS.GetTripState(@trip_id) ts 
								INNER JOIN DICT.TripStates ts2
								ON ts.state_id = ts2.StateID 
						WHERE ts2.AllowBooking = 1)
		BEGIN 
			SET @msg = 'Trip #' + @trip_id + ''' is not applicable for booking due to it''s state.';
			RAISERROR(@msg, 11, 1);
			ROLLBACK TRAN;
			RETURN;
		END
		
		---implicit shared lock on Person and IdentityDocument items
		IF NOT EXISTS (SELECT 1 FROM PLANS.GetPassengersList() pl WHERE pl.id = @passenger_id)
		BEGIN 
			SET @msg = 'Passenger #' + @passenger_id + ''' is not found.';
			RAISERROR(@msg, 11, 1);
			ROLLBACK TRAN;
			RETURN;
		END

		IF NOT EXISTS (SELECT 1 FROM TRANS.CheckSeatIsAvailable(@trip_id, @seat_id) sa WHERE sa.seat_id = @seat_id)
		BEGIN 
			SET @msg = 'Unbooked seat #' + @seat_id + ''' is not found.';
			RAISERROR(@msg, 11, 1);
			ROLLBACK TRAN;
			RETURN;
		END

		DECLARE @model_id NVARCHAR(20);
		SET @model_id = (
							SELECT vi.ModelId 
							FROM PLANS.ScheduledTrips st
							INNER JOIN FLEET.VehicleItem vi 
							ON st.VehicleID = vi.VehicleID
							WHERE st.TripCode = @trip_id);

		BEGIN TRY
			DECLARE @new_ticket_code NVARCHAR(20);
			SET @new_ticket_code = 'TCKT-'+CONVERT (NVARCHAR(5), NEXT VALUE FOR TRANS.TicketCodeSeq);
			
			
		
			INSERT INTO TRANS.Tiñket (TicketNumber, TripCode, ModelId, SeatID, PersonId, TariffId, Price, DateOfSelling)
			VALUES (@new_ticket_code, @trip_id, @model_id, @seat_id, @passenger_id, @tariff_id, @price, GETDATE());
		END TRY
		BEGIN CATCH
			RAISERROR('Can''t insest rows into "Tickets" table.', 11, 1);
			ROLLBACK TRAN;
			RETURN;
		END CATCH
	COMMIT;	
	PRINT 'New ticket is registered:';
	PRINT @new_ticket_code
	PRINT @trip_id;
	PRINT @model_id;
	PRINT @seat_id;
	PRINT @passenger_id;
	PRINT @price
	PRINT GETDATE();

EXEC TRANS.RegisteANewBooking 'TRP-13/2022', 3, 'B3', 1, 5048.26;

DROP VIEW PLANS.CurrentTripsStates;
CREATE VIEW PLANS.CurrentTripsStates
AS 
	SELECT 
			st.TripCode as trip_code, 
			st.RouteId as route_id, 
			st.VehicleId as vehicle_id, 
			st.DriverId as driver_id, 
			st.PlannedStartDate as planned_date, 
			(SELECT * FROM PLANS.GetTripState(st.TripCode)) as state_id
		FROM PLANS.ScheduledTrips st;

	
SELECT *
FROM PLANS.CurrentTripsStates;

DROP VIEW TRANS.TripAvailableForBooking;
CREATE VIEW TRANS.TripAvailableForBooking
AS
	SELECT 
		trips.trip_code, 
		trips.route_id, 
		trips.vehicle_id, 
		trips.driver_id, 
		trips.planned_date, 
		(CASE ts.AllowBooking WHEN 0 THEN 'NO' WHEN 1 THEN 'YES' END) as allow_booking
	FROM PLANS.CurrentTripsStates as trips 
			INNER JOIN DICT.TripStates ts 
			ON trips.state_id= ts.StateID 

SELECT *
FROM TRANS.TripAvailableForBooking;