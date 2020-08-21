
CREATE PROCEDURE Test_Default  
	@First as int=0,
	@second as int =1
AS
BEGIN
	PRINT 'First' 
	PRINT @First
	PRINT 'Second'
	PRINT @Second
END

-- Different ways of executing the procedure
EXEC Test_Default
EXEC Test_Default @First=1
EXEC Test_Default @second =10
EXEC Test_Default 10,20
EXEC Test_Default @second=50, @First=100
