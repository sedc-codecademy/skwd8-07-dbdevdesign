SELECT GETDATE() AS currentDate

--DODAVA intervali vo datumot. moze den, mesec ili godina i moze kolku sakame napred i nazad 
SELECT DATEADD(m, 1, getdate())
SELECT DATEADD(m, -10, getdate())
SELECT DATEADD(month, 1, getdate()) --mm isto funkcionira

--DAVA RAZLIKA pomegu 2 datumi vo odnos na referenten interval den, mesec ili godina
SELECT DATEDIFF(yy, getdate(), '20210202') --Y ne funkcionira!!! samo YY ili YYYY, moze da se pise i YEAR
SELECT DATEDIFF(d, getdate(), '20210202') --DD ili DAY

--ZA GOLEMI IMALI BUKVI 
SELECT UPPER('tREWjdfhsjf')

SELECT LOWER('tREWjdfhsjf')

--ZA TRGANJE NA PRAZNI MESTA OD LEVO/DESNO
SELECT LTRIM('       test') AS testLtrim, '       test'

SELECT RTRIM('Test d         ') AS testRtrim, 'Test d         '

SELECT LTRIM(RTRIM('       test d        ')) as testBoth

--ZA BARANJE NA KARAKTER/i VO KOLONA
SELECT CHARINDEX('a', 'barame ST na koja pozicija e vo kolonava', 3)

--CAST AND CONVERT -- same s*** different package
DECLARE @test varchar(10)
DECLARE @testConvert INT, @testCast INT

SET @test='005'

SELECT @testCast = CAST(@test as INT)

SELECT @testConvert = CONVERT(INT,@test)

SELECT @test TEST, @testCast testCast, @testConvert testConvert
GO

