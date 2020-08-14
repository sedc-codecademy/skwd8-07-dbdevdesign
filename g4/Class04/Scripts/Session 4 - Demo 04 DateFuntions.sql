-- Date Functions

declare @dt datetime
set @dt = GETDATE()

select @dt as DateNow, DATEADD(day, -7, @dt) as DateLastWeek, DATEADD(day, 7, @dt) as DateNextWeek

select @dt as DateNow, DATEADD(minute, -15, @dt) as DateBefore15Minutes, DATEADD(minute, 15, @dt) as DateAfter15Minutes