/*
Create Foreign key constraints from diagram or with script
*/

/*
ALTER TABLE [dbo].[Grade] DROP CONSTRAINT [FK_Grade_Course];
ALTER TABLE [dbo].[Grade] DROP CONSTRAINT [FK_Grade_Student];
ALTER TABLE [dbo].[Grade] DROP CONSTRAINT [FK_Grade_Teacher];
ALTER TABLE [dbo].[GradeDetails] DROP CONSTRAINT [FK_GradeDetails_AchievementType];
ALTER TABLE [dbo].[GradeDetails] DROP CONSTRAINT [FK_GradeDetails_Grade];
*/

ALTER TABLE [dbo].[Grade]  WITH CHECK ADD  CONSTRAINT [FK_Grade_Course] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([ID])
GO
ALTER TABLE [dbo].[Grade]  WITH CHECK ADD  CONSTRAINT [FK_Grade_Student] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([ID])
GO
ALTER TABLE [dbo].[Grade]  WITH CHECK ADD  CONSTRAINT [FK_Grade_Teacher] FOREIGN KEY([TeacherID])
REFERENCES [dbo].[Teacher] ([ID])
GO
ALTER TABLE [dbo].[GradeDetails]  WITH CHECK ADD  CONSTRAINT [FK_GradeDetails_AchievementType] FOREIGN KEY([AchievementTypeID])
REFERENCES [dbo].[AchievementType] ([ID])
GO
ALTER TABLE [dbo].[GradeDetails]  WITH CHECK ADD  CONSTRAINT [FK_GradeDetails_Grade] FOREIGN KEY([GradeID])
REFERENCES [dbo].[Grade] ([ID])
GO
