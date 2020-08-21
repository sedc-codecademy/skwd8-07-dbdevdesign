
alter procedure dbo.CalculateSalary (@salarydate date) -- 01.07.2020
as
begin
     --deklariranje na promenlivi (pozelno e da bidat deklarirani na pocetokot)
	 declare @employeeid int, 
	         @Incentive decimal(18, 2),
			 @TotalSalary decimal(18,2),
			 @TotalPrice decimal(18,2),
			 @IncentiveCoef decimal(18,2)

	   -- za proverka dali postoi veke stavka, presmetana plata, za toj mesec
	   -- dokolku postoi da se prekine procedurata
      IF EXISTS (SELECT null FROM dbo.EmployeeSalariesEvidence WHERE YearMonth =  SUBSTRING(CONVERT(VARCHAR,@SalaryDate,112),1,6))
       BEGIN
	        RAISERROR('Platata e veke presmetana za ovoj mesec',16,1)
	        RETURN
      END

     --1--
	 /* Moze da se kreira #temp - temporary tabela so naredbata into #temp
	    Vo toj slucaj novata #temp tabela ke bide pandan na osnovnata tabela dbo.

     select id,fistname
	 into #tempEmployee
	 from dbo.Employee
	 */
	 --2--drop table #tempEmployee
	 create table #tempEmployee (id int)
	 insert into #tempEmployee (id)
	 select id
	 from dbo.Employee

	 --while ciklus sto ke se izvrshuva se dodeka e ispolnet uslovot
	 while (select count(*) from #tempEmployee)>0
	 begin
	       -- da se zeme prvata stavka od tabelata
		   select top 1 @employeeid = id
		   from #tempEmployee

		   --1-- presmetka na plata
	      	SELECT @TotalSalary = TotalSalary 
		    FROM dbo.fn_SalaryCalculation (@employeeid)

			--2--presmetka na bonus
			if (select count(*) from dbo.[Order] where employeeid = @employeeid)>0
			begin
			       select @TotalPrice = sum(TotalPrice)
				   from dbo.[Order]
				   where EmployeeID = @employeeid
				   and OrderDate>=@salarydate and orderdate<dateadd(month,1,@salarydate)
				   /*second alternative OrderDate<=eomonth(@salarydate)*/
			end
			     /*10000-2000 totalprice*incetivcoef
				   >20000 totalpric*(incetive*2)
				   0 nema bonus*/
                  select @IncentiveCoef = IncentiveCoef 
				                       from dbo.EmployeeSalariesRegistar
				                       where EmployeeID = @employeeid

				  set @Incentive = case when @TotalPrice between 10000 and 20000 
				                              then @TotalPrice * @IncentiveCoef
								        when @TotalPrice>20000
								             then @TotalPrice*2*@IncentiveCoef
                                        else 0 end
				
            --del za spravuvanje so greshki; dokolku vo tabelata [EmployeeSalariesEvidence] se vnese NULL ke pukne procedurata so greshka
			begin try
                 insert into [dbo].[EmployeeSalariesEvidence] 
				             (EmployeeID,YearMonth,Incentive,TotalSalary,PaymentDate)
				 values (@employeeid,SUBSTRING(CONVERT(VARCHAR,@SalaryDate,112),1,6)
							         ,@Incentive,@TotalSalary,
									 DATEADD(m, DATEDIFF(m, 0, @SalaryDate)+1, 0))
			end try

			begin catch
	         SELECT  
			 ERROR_NUMBER() AS ErrorNumber  
			,ERROR_SEVERITY() AS ErrorSeverity  
			,ERROR_STATE() AS ErrorState  
			,ERROR_PROCEDURE() AS ErrorProcedure  
			,ERROR_LINE() AS ErrorLine  
			,ERROR_MESSAGE() AS ErrorMessage;  
			return
	        end catch

			--da se izbrsihe stavkata od temp tabelata
             delete from #tempEmployee where id = @employeeid
	 end

	      select e.FirstName,e.LastName,e.NationalIdNumber,es.*
		  from Employee e
		  inner join [dbo].[EmployeeSalariesEvidence] es on es.EmployeeID=e.id
		  WHERE YearMonth=SUBSTRING(CONVERT(VARCHAR,@SalaryDate,112),1,6)
end

--povik na procedurata
--exec dbo.CalculateSalary '2019-05-01'
























