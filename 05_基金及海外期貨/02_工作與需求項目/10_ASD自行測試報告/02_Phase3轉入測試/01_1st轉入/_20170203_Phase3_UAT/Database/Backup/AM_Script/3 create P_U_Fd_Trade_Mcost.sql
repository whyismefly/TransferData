USE [isdbTGL]
GO
/****** Object:  StoredProcedure [dbo].[P_U_Fd_Trade_Mcost]    Script Date: 2017/1/20 下午 03:40:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[P_U_Fd_Trade_Mcost] (@ddate varchar(8) , @ifund varchar (12))
--Update 基金賣出交易的成本(含除息成本)


AS     
begin
--exec P_U_Fd_Trade_DivMcost  '20141029','VVV6'
declare @itdno  varchar(26)
declare @ifdid  varchar (15)
declare @icurid  varchar (3)
declare @iagtid varchar (5)
declare @qty  numeric(20,0)
declare @AccountType varchar(10) 

declare @mscost  numeric (20,4)
declare @mscostTWD  numeric (20,4)
declare @mscostCur  numeric (20,4)

declare @sell_mscost  numeric(20,4)
declare @sell_mscostTWD  numeric(20,4)
declare @sell_mscostCur  numeric(20,4)
declare @sell_qty numeric(20,0)
declare @sell_ifdid  varchar (10)
declare @sell_AccountType varchar(10) 
declare @dfd_mcost numeric(20,4)
declare @dfd_mcostTWD numeric(20,4)
declare @dfd_mcostCur numeric(20,4)
declare @dfd_qty numeric(20,6)
declare @decimal int --幣別小數位數
declare @err_desc varchar(50)

--尚未考慮轉換代號的狀況
Declare sell Cursor 
For
	select a.ifdid, a.icurid, a.ts_qty, a.itdno, a.AccountType, a.iagtid
	from fn_fd_sell  a 
	where a.ifund = @ifund and a.dtrans_w = @ddate
	order by a.ifdid ,a.itdno 
 
open sell
Fetch Next From sell Into  @ifdid, @icurid, @qty, @itdno, @AccountType, @iagtid
							
While (@@fetch_status = 0)
Begin
	--未含除息成本
	select @err_desc = errdesc, @mscost = mscost, @mscostTWD = mscostTWD, @mscostCur = mscostCur from [dbo].[F_Q_Get_FdSaleCost](@ddate, @ifund ,@ifdid,@icurid,@qty,@AccountType,@iagtid)

	Update fn_fd_sell set mscost = @mscost, mscostTWD = @mscostTWD, mscostCur = @mscostCur
		where ifund = @ifund and  ifdid = @ifdid and AccountType = @AccountType and dtrans_w = @ddate and ts_qty = @qty

	--含除息成本
	select @err_desc = errdesc, @mscost = mscost, @mscostTWD = mscostTWD, @mscostCur = mscostCur from [dbo].[F_Q_Get_FdSaleDivCost](@ddate, @ifund ,@ifdid,@icurid,@qty,@AccountType,@iagtid)

	Update fn_fd_sell set msdiv = @mscost, msdivTWD = @mscostTWD, msdivCur = @mscostCur
		where ifund = @ifund and  ifdid = @ifdid and AccountType = @AccountType and dtrans_w = @ddate and ts_qty = @qty

FETCH NEXT FROM sell
INTO @ifdid , @icurid ,@qty ,@itdno, @AccountType, @iagtid

END
close sell
Deallocate sell


--當日全賣，如賣出成本大於前日庫存成本，需分配比例。

--未含除息成本
Declare dfd Cursor 
For
  	Select sum(mscost), sum(mscostTWD ), sum(mscostCur ), sum(ts_qty), ifdid, AccountType 
	from fn_fd_sell where ifund = @ifund AND dtrans_w >= @ddate AND dtrans_w <= @ddate 
	Group by ifdid, AccountType

open dfd
Fetch Next From dfd Into @sell_mscost, @sell_mscostTWD, @sell_mscostCur, @sell_qty , @sell_ifdid, @sell_AccountType
							
While (@@fetch_status = 0)
Begin
	Select @dfd_mcost = mscost, @dfd_mcostTWD = mscostTWD, @dfd_mcostCur = mscostCur, @dfd_qty = q_qty from fn_dfd
		where ifund =@ifund AND ddate_w =dbo.F_Q_DateAfterType_w('C','0' ,'9' ,-1 ,@ddate) and ifdid = @sell_ifdid and AccountType = @sell_AccountType
	If  @dfd_qty  = @sell_qty  
	begin
		 if  @dfd_mcost <> @sell_mscost or @dfd_mcostTWD <> @sell_mscostTWD or @dfd_mcostCur <> @sell_mscostCur
		 begin
			--差額調整在當天的最後一筆單號中
			Update fn_fd_sell Set mscost = mscost + (@dfd_mcost - @sell_mscost), mscostTWD = mscostTWD + (@dfd_mcostTWD - @sell_mscostTWD), mscostCur = mscostCur + (@dfd_mcostCur - @sell_mscostCur)
			where itdno in (select max(itdno) from fn_stk_trade where ifund =@ifund AND ddate_w >=@ddate AND ddate_w <=@ddate and istkid =@sell_ifdid and AccountType = @sell_AccountType )
		 end 
 	end 

FETCH NEXT FROM dfd
INTO  @sell_mscost, @sell_mscostTWD, @sell_mscostCur, @sell_qty , @sell_ifdid, @sell_AccountType

END
close dfd
Deallocate dfd


--未含除息成本
Declare dfd Cursor 
For
  	Select sum(msdiv), sum(msdivTWD ), sum(msdivCur ), sum(ts_qty), ifdid, AccountType 
	from fn_fd_sell where ifund = @ifund AND dtrans_w >= @ddate AND dtrans_w <= @ddate 
	Group by ifdid, AccountType

open dfd
Fetch Next From dfd Into @sell_mscost, @sell_mscostTWD, @sell_mscostCur, @sell_qty , @sell_ifdid, @sell_AccountType
							
While (@@fetch_status = 0)
Begin
	Select @dfd_mcost = mdcost1, @dfd_mcostTWD = mdcost1TWD, @dfd_mcostCur = mdcost1Cur, @dfd_qty = q_qty from fn_dfd
		where ifund =@ifund AND ddate_w =dbo.F_Q_DateAfterType_w('C','0' ,'9' ,-1 ,@ddate) and ifdid = @sell_ifdid and AccountType = @sell_AccountType
	If  @dfd_qty  = @sell_qty  
	begin
		 if  @dfd_mcost <> @sell_mscost or @dfd_mcostTWD <> @sell_mscostTWD or @dfd_mcostCur <> @sell_mscostCur    
		 begin
			--差額調整在當天的最後一筆單號中
			Update fn_fd_sell Set mscost = mscost + (@dfd_mcost - @sell_mscost), mscostTWD = mscostTWD + (@dfd_mcostTWD - @sell_mscostTWD), mscostCur = mscostCur + (@dfd_mcostCur - @sell_mscostCur)
			where itdno in (select max(itdno) from fn_stk_trade where ifund =@ifund AND ddate_w >= @ddate AND ddate_w <=@ddate and istkid =@sell_ifdid and AccountType = @sell_AccountType )
		 end 
 	end 

FETCH NEXT FROM dfd
INTO  @sell_mscost, @sell_mscostTWD, @sell_mscostCur, @sell_qty , @sell_ifdid, @sell_AccountType

END
close dfd
Deallocate dfd





end



