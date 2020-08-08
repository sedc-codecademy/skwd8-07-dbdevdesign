
-- Try to insert Order for non-existing Business entity

Insert into dbo.[Order] (OrderDate, Status, BusinessEntityId, CustomerId,EmployeeId,TotalPrice,Comment)
select '2019.05.01' as OrderDate, 0 as Status, 100 as BusinessEntityId , 1 as CustomerId , 1 as EmployeeId , 1000 as TotalPrice, N'' as comment
 
-- add table constraint
ALTER TABLE [dbo].[Order]  WITH CHECK 
ADD CONSTRAINT [FK_Order_BusinessEntity] FOREIGN KEY([BusinessEntityId])
REFERENCES [dbo].[BusinessEntity] ([Id])
GO

-- Open diagram and add foreign keys manually (or with script if needed)

-- drop constraints if exists
/*
ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK_Order_BusinessEntity];
ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK_Order_Employee];
ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK_Order_Customer];
ALTER TABLE [dbo].[OrderDetails] DROP CONSTRAINT [FK_OrderDetails_Order];
ALTER TABLE [dbo].[OrderDetails] DROP CONSTRAINT [FK_OrderDetails_Product];
*/

-- create constraints
ALTER TABLE [dbo].[OrderDetails] ADD CONSTRAINT [FK_OrderDetails_Order] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Order]([Id]);
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [FK_Order_BusinessEntity] FOREIGN KEY ([BusinessEntityId]) REFERENCES [dbo].[BusinessEntity]([Id]);
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [FK_Order_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee]([Id]);
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [FK_Order_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer]([Id]);
ALTER TABLE [dbo].[OrderDetails] ADD CONSTRAINT [FK_OrderDetails_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product]([Id]);


-- Try to insert Order for non-existing Business entity
Insert into dbo.[Order] (OrderDate, Status, BusinessEntityId, CustomerId,EmployeeId,TotalPrice,Comment)
select '2019.05.01' as OrderDate, 0 as Status, 100 as BusinessEntityId , 1 as CustomerId , 1 as EmployeeId , 1000 as TotalPrice, N'' as comment
 