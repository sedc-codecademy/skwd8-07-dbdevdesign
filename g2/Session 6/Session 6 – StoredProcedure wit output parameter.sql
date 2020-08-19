select * from product
go

drop procedure if exists uspFindProductByName


ALTER PROCEDURE uspFindProductByName (
    @product_name varchar(100),
    @product_count INT OUTPUT,
	@Price_out decimal output
) AS
BEGIN
    SELECT 
        Name,
		Code,
        Price
    FROM
        dbo.Product
    WHERE
        Name Like '%'+@product_name +'%';

    SELECT @product_count = @@ROWCOUNT;
	-- @@ROWCOUNT -Returns the number of rows affected by the last statement. 
	set @Price_out = (select  price from product
	where Name=@product_name)
END;
go
----

DECLARE @count INT;
declare @cena decimal;

EXEC uspFindProductByName 'Raw bars', @count output, @cena output
SELECT @count AS 'Number of products found'
select @cena as Cena;
go