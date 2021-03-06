USE [ETS_P]
GO
/****** Object:  StoredProcedure [dbo].[P_Q_GetOrderRpt_FTS]    Script Date: 2017/2/2 上午 10:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[P_Q_GetOrderRpt_FTS] (@ddate Varchar(8)) 
As

Begin

declare @ddate_fas as varchar(8)
select top 1 @ddate_fas =  ddate_w from v_fas_fn_dstk where ddate_w < @ddate order by ddate_w desc
declare @ddate_hedgemapping as varchar(8)
select top 1 @ddate_hedgemapping = ddate from FOHedgeMappingHistory where ddate <@ddate order by ddate desc


	select a.fundid,b.fundSname,d.fundid,e.fundsname hedgeFund,
a.productid + '  ' +c.ShortName as productname,a.Maturity,
(
  select sum(price * (case when qshare < (amount*1000) then qshare else (amount*1000) end)) from 
 (
 select qshare,price,ifund,istkid from v_fas_fn_dstk where ifund = d.fundid  and ddate_w = @ddate_fas
 ) a inner join FOHedgeSetting b on b.fofundid = d.fofundid and b.begindt <= @ddate and isnull(enddt,'29991231') >= @ddate and a.istkid = b.stock
) hedgevalue,
d.Correlation,
d.beta,
isnull(f.amount,0) samount, isnull(f.TotalPrice ,0) * c.point svalue,
a.bs,
a.Price,
a.Price2,
a.amount,
g.mname,
(a.Price * a.amount * c.point) + (isnull(f.TotalPrice ,0) * c.point)   as 'mvalue',b.AccountType,
(case when a.amount = f.amount then 0 else  (isnull((a.Price * a.amount * c.point),0)  + (isnull(f.TotalPrice ,0) * c.point))end) /
isnull(
(
  select sum(price * (case when qshare < (amount*1000) then qshare else (amount*1000) end)) from 
 (
 select qshare,price,ifund,istkid from v_fas_fn_dstk where ifund = d.fundid  and ddate_w = @ddate_fas
 ) a inner join FOHedgeSetting b on b.fofundid = d.fofundid and b.begindt <= @ddate and isnull(enddt,'29991231') >= @ddate and a.istkid = b.stock
)
,1) * 100 as rate,
(case when a.bs='B' then a.amount else (0-a.amount) end) + isnull(f.amount,0)  as bamount
from funddecision a 
left join funddata b on a.fundid = b.fundid  
left join fodata c on a.productid = c.foid 
left join FOHedgeMappingHistory d on a.fundid = d.fofundid and d.ddate = @ddate_hedgemapping
left join funddata e on d.fundid  = e.fundid  
left join 
(
	select ifund,iftsid,sum(qftss) amount,sum(qftss * price ) TotalPrice from v_fas_fn_dfts where ddate_w = @ddate_fas group by ifund,iftsid,ftrade
) f on a.fundid = f.ifund and a.productid+ a.Maturity  = f.iftsid 
left join mappingcode g on g.mcID = 'HedgeType' and g.mID = a.hedgetype
where a.product = 'FTS' and convert(varchar, a.decdt,112) = @ddate  and a.IsDelete = '0' And a.RiskST in ('0','1') and c.region = 'TW'
	

--select top 1 AX250D,* from [dbo].[v_Cmoney_CMoney_DailyTechIndex]
--where istkid = 'TWA00' and ddate <= convert(varchar,getdate(),112)
--order by ddate desc



--select top 1 close_price,* from [dbo].[v_Cmoney_Cmoney_FtsRateIndex]
--where idno = 'VIX15' and ddate < convert(varchar,getdate(),112)
--order by ddate desc

--select avg(close_price) close_price
--from 
--(
--select top 750 (close_price) from [dbo].[v_Cmoney_Cmoney_FtsRateIndex]
--where idno = 'VIX15' and ddate < convert(varchar,getdate(),112)
--order by ddate desc
--)a

--select * from 
--(
--select  rank() over(order by close_price) 'rank',* from 
--(
--select top 750 close_price from [dbo].[v_Cmoney_Cmoney_FtsRateIndex]
--where idno = 'VIX15' and ddate < convert(varchar,getdate(),112)
--order by ddate desc
--)a
--)b where b.rank = '38'




End
