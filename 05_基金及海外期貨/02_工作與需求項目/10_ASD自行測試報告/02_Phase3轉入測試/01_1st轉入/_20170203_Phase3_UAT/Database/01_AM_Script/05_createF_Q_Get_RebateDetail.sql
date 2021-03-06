USE [isdbTGL]
GO
/****** Object:  UserDefinedFunction [dbo].[F_Q_Get_RebateDetail]    Script Date: 2017/1/20 下午 03:39:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create FUNCTION [dbo].[F_Q_Get_RebateDetail]  --查詢rebate明細
   (@dstart varchar(8),@dend varchar(8)) 
   --所需參數:日期,Portfolio代號,基金代號,幣別,MyQty交易單位數,會計科目,基金公司代碼  


RETURNS @RTNtable TABLE (
	iagtid varchar(5),
    ddate_w varchar(8),    
    ifdid varchar(25),
	ifdname varchar(200), 
	qty decimal(20,4),
	pnav decimal(20,4),
	mamt decimal(20,4),
	fdtype varchar(1),
	fdicurid varchar(3),
	isincode varchar(25)
	)
AS 

BEGIN     
	insert into @RTNtable
	select b.compno , a.ddate_w, a.ifdid, b.ifdname, round(sum(a.q_qty),4) as qty, a.pnav, round(sum(a.q_qty)*a.pnav,2) as mamt, s.svalue, b.icurid, b.isincode
	from fn_dfd a
	inner join fn_fd_data b on a.ifdid = b.ifdid and b.duse_w <= a.ddate_w and b.dexpire_w >= a.ddate_w
	inner join cm_fund_data c on a.ifund = c.ifund and c.fund_type = '1' and level = '2'
	inner join cm_symbol s on b.fkind = s.sid and stype = 'FN33' 
	where ddate_w between @dstart and @dend
	group by b.compno, a.ddate_w, a.ifdid, b.isincode, b.ifdname, a.pnav, s.svalue, b.icurid
	order by b.compno, ddate_w, s.svalue

    RETURN
END