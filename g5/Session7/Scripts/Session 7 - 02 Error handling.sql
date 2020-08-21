--ERROR_NUMBER
BEGIN TRY
	-- Generate a divide-by-zero error.
	SELECT 1/0;
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrorNumber;
END CATCH;
GO


--ERROR_NUMBER
BEGIN TRY
	-- Generate a divide-by-zero error.
	if 1 = 2
		RAISERROR ('Error raised in TRY block.', -- Message text.  
               16, -- Severity.  
               1 -- State.  
               );   
END TRY
BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrorNumber;
END CATCH;
GO

--ERROR_SEVERITY
BEGIN TRY  
	-- Generate a divide-by-zero error.
	SELECT 1/0;
END TRY
BEGIN CATCH
	SELECT ERROR_SEVERITY() AS ErrorSeverity;
END CATCH;
GO

--ERROR_STATE
BEGIN TRY
	-- Generate a divide by zero error
	SELECT 1/0;
END TRY
BEGIN CATCH
	SELECT ERROR_STATE() AS ErrorState;
END CATCH;
GO

--ERROR_PROCEDURE
IF OBJECT_ID ( 'usp_ExampleProc', 'P' ) IS NOT NULL
	DROP PROCEDURE usp_ExampleProc;
GO
-- Create a stored procedure that Generate a divide by zero error
CREATE PROCEDURE usp_ExampleProc
AS
	SELECT 1/0;
GO
BEGIN TRY
	-- Execute the stored procedure inside the TRY block.
	EXECUTE usp_ExampleProc;
END TRY
BEGIN CATCH
	SELECT ERROR_PROCEDURE() AS ErrorProcedure;
END CATCH;
GO

--ERROR_MESSAGE
BEGIN TRY
    -- Generate a divide-by-zero error.
    SELECT 1/0;
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO

--ALL TOGETHER
IF OBJECT_ID ( 'usp_GetErrorInfo', 'P' ) IS NOT NULL   
	DROP PROCEDURE usp_GetErrorInfo;  
GO  
-- Create procedure to retrieve error information.  
CREATE PROCEDURE usp_GetErrorInfo
AS
SELECT
	ERROR_NUMBER() AS ErrorNumber
,	ERROR_SEVERITY() AS ErrorSeverity
,	ERROR_STATE() AS ErrorState
,	ERROR_PROCEDURE() AS ErrorProcedure
,	ERROR_LINE() AS ErrorLine
,	ERROR_MESSAGE() AS ErrorMessage;
GO
BEGIN TRY  
	-- Generate divide-by-zero error.
	SELECT 1/0;
END TRY
BEGIN CATCH
	-- Execute error retrieval routine.
	EXECUTE usp_GetErrorInfo;
END CATCH;

--SAME in ANOTHER way
IF OBJECT_ID ( 'usp_ExampleProc', 'P' ) IS NOT NULL
	DROP PROCEDURE usp_ExampleProc;
GO
-- Create a stored procedure that generates a divide-by-zero error.
CREATE PROCEDURE usp_ExampleProc
AS
	SELECT 1/0;
GO
BEGIN TRY
    -- Execute the stored procedure inside the TRY block.  
    EXECUTE usp_ExampleProc;
END TRY
BEGIN CATCH
SELECT
	ERROR_NUMBER() AS ErrorNumber
,	ERROR_SEVERITY() AS ErrorSeverity
,	ERROR_STATE() AS ErrorState
,	ERROR_PROCEDURE() AS ErrorProcedure
,	ERROR_LINE() AS ErrorLine
,	ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO

--Stored Procedure ErrorNadling TEMPLATE
CREATE PROCEDURE usp_ExampleProcedureErrorHandling
AS
BEGIN
	BEGIN TRY
		SELECT 1/0;
	END TRY
	BEGIN CATCH
		SELECT
			ERROR_NUMBER() AS ErrorNumber
		,	ERROR_SEVERITY() AS ErrorSeverity
		,	ERROR_STATE() AS ErrorState
		,	ERROR_PROCEDURE() AS ErrorProcedure
		,	ERROR_LINE() AS ErrorLine
		,	ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END
GO
EXEC usp_ExampleProcedureErrorHandling
GO