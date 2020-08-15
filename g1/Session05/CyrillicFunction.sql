create FUNCTION [dbo].[ToCyrillic](@str Nvarchar(MAX))
    RETURNS Nvarchar(MAX)
    AS
BEGIN
-- Declare the return variable here
DECLARE @inputLength int
DECLARE @i int
DECLARE @latinSymbol nVarchar(2)
DECLARE @latinSymbol2 nVarchar(2)
set @latinSymbol2=null
DECLARE @cyrillicSymbol nVarchar(2)
DECLARE @outputValue nVarchar(MAX)
SET @outputValue=N''
SET @inputLength=LEN(@str)
SET @i=1

DECLARE @TransTable table (upperCyr nvarchar(2) COLLATE Cyrillic_General_CI_AS, 
                            lowerCyr nvarchar(2) COLLATE Cyrillic_General_CI_AS, 
                            lowerLat nvarchar(2), cid int PRIMARY KEY IDENTITY(1,1))

insert into @TransTable values (N'А', N'а', N'a')
insert into @TransTable values (N'Б', N'б', N'b')
insert into @TransTable values (N'В', N'в', N'v')
insert into @TransTable values (N'Г', N'г', N'g')
insert into @TransTable values (N'Д', N'д', N'd')
insert into @TransTable values (N'Ђ', N'ђ', N'đ')
insert into @TransTable values (N'Е', N'е', N'e')
insert into @TransTable values (N'Ж', N'ж', N'ž')
insert into @TransTable values (N'З', N'з', N'z')
insert into @TransTable values (N'И', N'и', N'i')
insert into @TransTable values (N'Ј', N'ј', N'j')
insert into @TransTable values (N'К', N'к', N'k')
insert into @TransTable values (N'Л', N'л', N'l')
insert into @TransTable values (N'Љ', N'љ', N'lj')
insert into @TransTable values (N'М', N'м', N'm')
insert into @TransTable values (N'Н', N'н', N'n')
insert into @TransTable values (N'Њ', N'њ', N'nj')
insert into @TransTable values (N'О', N'о', N'o')
insert into @TransTable values (N'П', N'п', N'p')
insert into @TransTable values (N'Р', N'р', N'r')
insert into @TransTable values (N'С', N'с', N's')
insert into @TransTable values (N'Т', N'т', N't')
insert into @TransTable values (N'Ћ', N'ћ', N'ć')
insert into @TransTable values (N'У', N'у', N'u')
insert into @TransTable values (N'Ф', N'ф', N'f')
insert into @TransTable values (N'Х', N'х', N'h')
insert into @TransTable values (N'Ц', N'ц', N'c')
insert into @TransTable values (N'Ч', N'ч', N'č')
insert into @TransTable values (N'Џ', N'џ', N'dž')
insert into @TransTable values (N'Ш', N'ш', N'šˇ')


WHILE (@i<=@inputLength)
BEGIN
    SET @latinSymbol=SUBSTRING(@str,@i,1)
    SET @cyrillicSymbol=@latinSymbol    -- If not found below, then use that char (e.g. numbers etc)

        -- exceptions Љ,Њ,Џ
if (@i+1<=@inputLength) set @latinSymbol2=SUBSTRING(@str,@i+1,1)    
if lower(@latinSymbol+@latinSymbol2) in ('lj','nj','dž')    
    begin
        if ((@latinSymbol COLLATE Croatian_CS_AS)=UPPER(@latinSymbol))
            BEGIN
            SELECT TOP 1 @cyrillicSymbol=upperCyr FROM @TransTable WHERE lowerlat=lower(@latinSymbol+@latinSymbol2) ORDER BY CID
            END
            ELSE
            BEGIN
            SELECT TOP 1 @cyrillicSymbol=lowerCyr FROM @TransTable WHERE lowerlat=lower(@latinSymbol+@latinSymbol2) ORDER BY CID
            END     
            SET @i=@i+2    
        end
    else--end exceptions
    begin
        IF ((@latinSymbol COLLATE Croatian_CS_AS)=UPPER(@latinSymbol))
        BEGIN
        SELECT TOP 1 @cyrillicSymbol=upperCyr FROM @TransTable WHERE lowerlat=lower(@latinSymbol) ORDER BY CID
        END
        ELSE
        BEGIN
        SELECT TOP 1 @cyrillicSymbol=lowerCyr FROM @TransTable WHERE lowerlat=lower(@latinSymbol) ORDER BY CID
        END
        SET @i=@i+1
    end
    set @outputValue=@outputValue+@cyrillicSymbol
END

RETURN @outputValue

END


