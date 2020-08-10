/*
Change GradeDetails table always to insert value 100 in AchievementMaxPoints column if no value is provided on insert
Change GradeDetails table to prevent inserting AchievementPoints that will more than AchievementMaxPoints
Change AchievementType table to guarantee unique names across the Achievement types
*/

ALTER TABLE [dbo].[GradeDetails]
ADD CONSTRAINT DF_GradeDetails_AchievementMaxPoints
DEFAULT 100 FOR [AchievementMaxPoints]
GO

ALTER TABLE [dbo].[GradeDetails] WITH CHECK
ADD CONSTRAINT CHK_GradeDetails_AchievementPoints
CHECK ([AchievementPoints] <= [AchievementMaxPoints]);
GO

ALTER TABLE [dbo].[AchievementType] WITH CHECK
ADD CONSTRAINT UC_AchievementType_Name UNIQUE (Name)
GO

