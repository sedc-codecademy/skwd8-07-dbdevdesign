
CREATE VIEW vv_OpstPregledPoVraboten
AS
SELECT e.FirstName+' '+e.LastName as imeiprezime, o.TotalPrice, c.Name as custmerName,
		b.Name as BEName, b.Region as BERegion, STRING_AGG(p.Name,',') as ProduktiVoNaracka,
		STRING_AGG(CAST(p.price as VARCHAR(10)),',') as cenipoprodukti, SUM(od.quantity) as Quantity
FROM Employee e
INNER JOIN dbo.[Order] o ON e.id = o.EmployeeId
INNER JOIN Customer c ON c.id = o.CustomerId
INNER JOIN BusinessEntity b ON b.id = o.BusinessEntityId
INNER JOIN OrderDetails od ON od.OrderId = o.Id
INNER JOIN Product p ON p.id = od.ProductId
WHERE o.EmployeeId=1
GROUP BY e.FirstName+' '+e.LastName, o.TotalPrice, c.Name, b.Name, b.Region 
HAVING SUM(od.quantity)>5

SELECT * FROM vv_OpstPregledPoVraboten