
/****** Object:  Table [dbo].[DetailLog]    Script Date: 8/22/2020 10:35:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetailLog](
	[ErrorNumber] [int] NULL,
	[ErrorSeverity] [int] NULL,
	[ErrorState] [int] NULL,
	[ErrorProcedure] [nvarchar](128) NULL,
	[ErrorLine] [int] NULL,
	[ErrorMessage] [nvarchar](4000) NULL,
	[Date] [datetime] NULL
) ON [PRIMARY]
GO


CREATE OR ALTER PROCEDURE usp_GetErrorInfo  
AS 
	INSERT into [dbo].[DetailLog] 
	([ErrorNumber],
	[ErrorSeverity] ,
	[ErrorState] ,
	[ErrorProcedure] ,
	[ErrorLine] ,
	[ErrorMessage],
	[Date] 
	)
	SELECT  
     ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    ,ERROR_PROCEDURE() AS ErrorProcedure  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage
	,GETDATE();  
GO 