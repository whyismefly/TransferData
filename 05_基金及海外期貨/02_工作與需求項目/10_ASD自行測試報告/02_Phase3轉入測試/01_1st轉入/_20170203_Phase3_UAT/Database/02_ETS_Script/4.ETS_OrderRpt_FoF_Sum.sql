USE [ETS_P]
GO
/****** Object:  StoredProcedure [dbo].[P_Q_GetOrderRpt_FoF_Sum]    Script Date: 2017/2/3 上午 11:09:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[P_Q_GetOrderRpt_FoF_Sum] (@ddate Varchar(8),@fundtype varchar(1),@tradetype varchar(1),@batchno int) 
As

Begin



declare @ddate_fas as table
(
	ifund varchar(12),
	ddate varchar(8)
)

insert into @ddate_fas 
select ifund,ddate_w from 
			 (
			 select *,ROW_NUMBER () OVER(PARTITION BY ifund ORDER BY ddate_w DESC) as rn from 
			 (
			 select distinct ifund, ddate_w from v_fas_fn_dfd where ddate_w < @ddate and ddate_w >= convert(varchar,dateadd(day,-5 ,convert(datetime,@ddate,112)),112)
			 )a
			 ) b where b.rn = '1'

	/*
	Declare @ddate Varchar(8) 
	Set @ddate = '20150130' 
	*/

		--===========================================================
		-----------------------------------------------------
		Declare @TempMain Table 
		(
			ad_date Datetime,
			Data_Group Varchar(10),
			Data_Type Varchar(10),
			fundid Varchar(50),
			fundsname Varchar(100),
			stockid Varchar(20),
			stockname Varchar(100),
			storeamount Decimal(18, 6),
			lastprice Decimal(18, 6),
			cost Decimal(18, 6),
			currency varchar(10),
			currencyrate decimal(18,6),
			currencyDate varchar(10),
			amount Decimal(20, 8),
			amountrate Decimal(20, 8),		
			totalprice Decimal(18, 6),
			SILP Varchar(50),
			SILPLimit Varchar(50),
			capitalrate Varchar(50),
			capitalratelimit Varchar(50),
			totalcapitalrate Varchar(50),
			income Float,
			totalamountrate Decimal(18, 6),				
			StockPool Varchar(10),
			memo varchar(1000),
			FundUserTrans Varchar(10),
			FundCost Decimal(20, 6),
			FundCostTWD Decimal(20, 6),
			FundAUM Decimal(20, 6),
			TypeACount decimal(3,0),
			TypeBCount decimal(3,0),
			TypeCCount decimal(3,0),
			isAccAmt nvarchar(1),
			AccAmt decimal(18,6)
		)
		-----------------------------------------------------
		--===========================================================

		--===========================================================
		-----------------------------------------------------
		--買進子表
		DECLARE @tb_SILPLimit TABLE
		(
			stock Varchar(50),
			limitvalue Decimal(10,2)
		)

			Insert Into @tb_SILPLimit
				Select a.BTicker 
					, (Case When b.itemiddesc Is Not Null Then b.itemiddesc
								When a.AssetType = '17' Then (Select paramvalue From [dbo].[v_Riskmgt_Rules] Where ruleid = '18' And execsystem  = '2' and ParamPosition = '9')
								When a.AssetType = '02' or a.AssetType = '03' Then (Select paramvalue From [dbo].[v_Riskmgt_Rules] Where ruleid = '18' And execsystem  = '2' and ParamPosition = '10')
								When a.AssetType = '01' Then (Select paramvalue From [dbo].[v_Riskmgt_Rules] Where ruleid = '18' And execsystem  = '2' and ParamPosition = '11')
								When a.AssetType = '06' Then (Select paramvalue From [dbo].[v_Riskmgt_Rules] Where ruleid = '18' And execsystem  = '2' and ParamPosition = '12')
								When a.AssetType = '18' Then (Select paramvalue From [dbo].[v_Riskmgt_Rules] Where ruleid = '18' And execsystem  = '2' and ParamPosition = '13')
								Else 0
					End) As LimitValue
				From FofFundData a
				Left Join v_Riskmgt_RuleMultiValue b On b.ruleid = '18' And checklistid = '6' And a.BTicker = b.itemid
				

		DECLARE @tb_SILP TABLE
		(
			stock Varchar(50),
			value Decimal(20,2),
			amount Decimal(20,2)
		)
		Insert Into @tb_SILP
		select productid,sum(mamt) as mamt, sum(amount) as amount from 
		(
			select ifdid productid,isnull(sum(mamttwd),0) mamt, isnull(sum(q_qty),0) amount from v_fas_fn_dfd a
			inner join @ddate_fas b on a.ifund = b.ifund and a.ddate_w = b.ddate 
			 where  q_qty <> 0 and a.ifund in (select fundid from FundData where fundlevel = '2' and fundid not in (select orifund from v_fas_cm_monfund_relation) and fundkind = '1') group by ifdid
			union all
			select productid, IsNull(Sum(a.amount2), 0) , isnull(sum(a.amount),0) from vFundDecision a 
			Where a.Product = 'FoF' And a.bs = 'B' And a.IsDelete = '0' and a.RiskST in ('0','1')
			And convert(varchar,a.DecDT,112) = @ddate
			and a.fundid in (select fundid from FundData where  fundkind = '1')
			group by productid 
		)a
		group by productid


		DECLARE @tb_TotalAmount TABLE
		(
			stock Varchar(50),
			value Decimal(20,2),
			amount Decimal(20,2)
		)
		Insert Into @tb_TotalAmount
		select productid,sum(mamt) as mamt, sum(amount) as amount from 
		(
			select ifdid productid,isnull(sum(mamttwd),0) mamt, isnull(sum(q_qty),0) amount from v_fas_fn_dfd a
			inner join @ddate_fas b on a.ifund = b.ifund and a.ddate_w = b.ddate where q_qty <> 0 and a.ifund in (select fundid from FundData where fundlevel = '2' and fundid not in (select orifund from v_fas_cm_monfund_relation) ) group by ifdid
			union all
			select productid, IsNull(Sum(a.amount2), 0) , isnull(sum(a.amount),0) As Amount from vFundDecision a 
			Where a.Product = 'FoF' And a.bs = 'B' And a.IsDelete = '0' and a.RiskST in ('0','1')
			And convert(varchar,a.DecDT,112) = @ddate and a.BatchNo = @batchno 
			group by productid 
		)a
		group by productid

		


		-----------------------------------------------------
		DECLARE @tb_currency TABLE
		(
			ddate varchar(8),
			icurid Varchar(3),
			price numeric(18,7)
		)
		Insert Into @tb_currency
		select d.ddate_w,d.icurid,d.price from
		(
		select * from 
		(
		select *,ROW_NUMBER () OVER(PARTITION BY icurid ORDER BY ddate_w DESC) as rn from 
		(
		select distinct ddate_w, icurid from isdbtgl.dbo.fn_cur_priceTWD where ddate_w < @ddate and ddate_w >= convert(varchar,dateadd(day,-30 ,convert(datetime,@ddate,112)),112)
		) a 
		) b 
		where b.rn = 1
		)c 
		left join isdbtgl.dbo.fn_cur_priceTWD d on c.ddate_w = d.ddate_w and c.icurid = d.icurid 

		-----------------------------------------------------
		--買進
		Insert Into @TempMain (ad_date, Data_Group, Data_Type, fundid, fundsname,stockid, stockname, lastprice, cost, amount, totalprice, SILP, SILPLimit, capitalrate, capitalratelimit, totalcapitalrate, StockPool, FundUserTrans,currency,currencyrate, currencydate,isAccAmt,AccAmt )
			Select @ddate, 'B', '02', a.fundid, Isnull(c.fundsname, '') As fundsname,a.productid, (a.productid + '  ' + Isnull(e.ChtName , '')) As stockname
				, (select top 1 (pnav) from v_fas_fn_fd_pnav where ifdid = a.productid and ddate_w  < @ddate order by ddate_w desc) As lastprice
				, Convert(Decimal(18,2), f.avgprice) As cost
				, a.amount As amount
				, round( a.amount2 /1000 ,0) As totalprice
				, Convert(Varchar, Convert(Decimal(18,2), (i.value * cur.price ) / 100000000 )) + '億' As SILP
				, '上限 ' + Convert(Varchar, h.limitvalue ) + '億' As SILPLimit
				,  case when e.FundSize = 0 then '0' else (Convert(Varchar, Convert(Decimal(6,3), ((i.amount) / (e.FundSize )) * 100 ))) end + '%' As capitalrate
				, '上限 ' + Convert(Varchar, (Select Convert(Decimal(5,2), Convert(Float, paramvalue) * 100) From [dbo].[v_Riskmgt_Rules] Where ruleid = '28')) + '%' As capitalratelimit
				,  case when e.FundSize = 0 then '0' else (Convert(Varchar, Convert(Decimal(6,3), ((j.amount) / (e.FundSize )) * 100 ))) end + '%' As totalcapitalrate
				, (Case When d.product Is Null Then '否' Else '是' End) StockPool
				, (case when isnull(r.itemid,'') = '' then '否' else '是' End) As FundUserTrans
				, a.currency
				, cur.price 
				, cur.ddate 
				, case when isnull(ac.d_use ,0) = 0 then '否' else '是'End isAccAmt
				, isnull(ac.TotalAmt ,0)/1000
			From funddecision a
			Left Join funddata c On a.fundid = c.fundid
			Left Join InvestmentPool d On a.fundid = d.fundid And d.product = 'FoF' And a.productid = d.productid And d.setdate < Getdate() And d.Enddate Is Null
			Left Join FofFundData e On a.productid = e.BTicker  
			Left Join 
			(
				select a.ifund 'fundid',ifdid 'productid',round((sum(mcost )/sum(q_qty)),2) 'avgprice',sum(q_qty) amount  from v_fas_fn_dfd a 
				inner join @ddate_fas b on a.ifund = b.ifund and a.ddate_w = b.ddate where  q_qty <> 0   group by a.ifund,ifdid
			) f On a.fundid = f.fundid And a.productid = f.productid 
			Left Join @tb_SILPLimit h On a.productid = h.stock
			Left Join @tb_SILP i On a.productid = i.stock
			Left join @tb_TotalAmount j on a.productid = j.stock
			left join @tb_currency cur on a.currency = cur.icurid 
			left join v_Riskmgt_RuleMultiValue r on  r.fundtype = '0' and r.ruleid = '27' and r.CheckListId = '9'  and r.itemid = e.TaiwanCode  
			left join FofAccAmtDec ac on a.seq = ac.decseq 
			Where convert(varchar,a.decdt,112) =@ddate  And a.product = 'FoF' And a.bs = 'B'
				And a.IsDelete = '0' And a.RiskST in ('0','1') and a.FundType = @fundtype --and a.tradetype = @tradetype
				and a.batchno = @batchno
	

		-----------------------------------------------------
		--===========================================================	
	
		--===========================================================	
		--賣出
		Insert Into @TempMain (ad_date, Data_Group, Data_Type, fundid, fundsname,stockid, stockname, storeamount, lastprice, cost, amount, amountrate, totalprice, income, totalamountrate,currency,currencyrate,currencydate,isAccAmt, AccAmt  )
			Select @ddate, 'B', '03', a.fundid, Isnull(c.fundsname, '') As fundsname,a.productid, (a.productid + '  ' + Isnull(e.stockname, '')) As stockname
				, (f.amount/1000) As storeamount
				,(select top 1 (pnav) from v_fas_fn_fd_pnav where ifdid = a.productid and ddate_w  < @ddate order by ddate_w desc) As lastprice
				, Convert(Decimal(18,2), f.avgprice) As cost			
				, a.newamount As amount
				, Convert(Decimal(5,2), a.newamount / f.amount * 100) As amountrate
				, a.price * a.newamount / 1000 As totalprice
				, ( a.newamount * (a.price - f.avgprice)/1000) As income
				, (Select Convert(Decimal(5,2), a.newamount/sum(q_qty) * 100) From v_fas_fn_dfd z inner join @ddate_fas b on z.ifund = b.ifund and z.ddate_w = b.ddate Where  q_qty <> 0  And z.ifund = a.fundid) As totalamountrate
				, a.currency
				, cur.price 
				,cur.ddate 
				, case when isnull(ac.d_use ,0) = 0 then '否' else '是'End isAccAmt
				, isnull(ac.TotalAmt ,0)/1000
			From funddecision a
			Left Join funddata c On a.fundid = c.fundid
			Left Join glstkstockdata e On a.productid = e.stock 
			Left Join 
			(
				select a.ifund 'fundid',ifdid 'productid',(sum(mcost )/sum(q_qty)) 'avgprice',sum(q_qty) amount  from v_fas_fn_dfd a
				inner join @ddate_fas b on a.ifund = b.ifund and a.ddate_w = b.ddate where q_qty <> 0  group by a.ifund,ifdid
			) f On a.fundid = f.fundid And a.productid = f.productid 
			left join @tb_currency cur on a.currency = cur.icurid 
			left join FofAccAmtDec ac on a.seq = ac.decseq 
			Where convert(varchar,a.decdt,112) =@ddate And a.product = 'FoF' And a.bs = 'S'
				And a.IsDelete = '0' And a.RiskST in ('0','1') and a.FundType = @fundtype --and a.tradetype = @tradetype
				 and a.batchno = @batchno
	
	
		--===========================================================	

		--===========================================================	
		--總市值, FundData
		Insert Into @TempMain (ad_date, Data_Group, Data_Type, fundid, fundsname, FundAUM, FundCost, storeamount, amount, income)		
			Select @ddate, 'A', '01', a.fundid, a.fundsname
					, Isnull((Select Top 1 mvalue From v_fas_cm_fund_data_dtl Where fkind = 'SIZE' And ifund = a.fundid Order By ddate_w Desc), 0)/1000 As AUM
					, round((select sum(isnull(mcost,0) * cur.price) mcost from v_fas_fn_dfd z inner join @ddate_fas b on z.ifund = b.ifund and z.ddate_w = b.ddate left join @tb_currency cur on z.icurid = cur.icurid where  q_qty  <> 0 and z.ifund = a.fundid  )/1000,0)
					, Sum(Case When a.Data_Type = '02' Then a.totalprice * a.currencyrate Else 0 End) As totalprice_B
					, Sum(Case When a.Data_Type = '03' Then a.totalprice * a.currencyrate Else 0 End) As totalprice_S
					, Sum(Case When a.Data_Type = '03' Then income * currencyrate  Else 0 End) As income
				From @TempMain a
				Group By a.fundid, a.fundsname

		update @TempMain set totalamountrate = round((amount / fundcost)*100,2) where data_group = 'A' and data_type = '01'

		Insert Into @TempMain (ad_date, Data_Group, Data_Type, fundid, fundsname, FundAUM, FundCost, FundCostTWD, storeamount, amount, income,currency,currencyrate,currencydate )		
			Select @ddate, 'A', '02' + a.currency, a.fundid, a.fundsname
					, Isnull((Select Top 1 mvalue From v_fas_cm_fund_data_dtl Where fkind = 'SIZE' And ifund = a.fundid Order By ddate_w Desc), 0)/1000 As AUM
					, round((select sum(mcost) mcost from v_fas_fn_dfd z inner join @ddate_fas b on z.ifund = b.ifund and z.ddate_w = b.ddate where q_qty <> 0 and z.ifund = a.fundid and z.icurid = a.currency )/1000,0)
					, round((select sum(isnull(mcost,0) *  cur.price ) mcost from v_fas_fn_dfd z inner join @ddate_fas b on z.ifund = b.ifund and z.ddate_w = b.ddate left join @tb_currency cur on z.icurid = cur.icurid where q_qty <> 0 and z.ifund = a.fundid and z.icurid = a.currency  )/1000,0)
					, Sum(Case When a.Data_Type = '02' Then a.totalprice Else 0 End) As totalprice_B
					, Sum(Case When a.Data_Type = '03' Then a.totalprice Else 0 End) As totalprice_S
					, Sum(Case When a.Data_Type = '03' Then income Else 0 End) As income
					, a.currency
					, max(a.currencyrate )
					, max(a.currencydate)
				From @TempMain a where a.data_group = 'B'
				Group By a.currency, a.fundid, a.fundsname

				update @TempMain set totalamountrate = round((amount / fundcost)*100,2) where data_group = 'A' and data_type like '02%'

				--把庫存有的但今天沒下的幣別加上去
			insert into @TempMain (ad_date, Data_Group, Data_Type, fundid, fundsname, FundAUM, FundCost, FundCostTWD, currency,currencyrate,currencydate )		
			select @ddate, 'A', '02' + a.icurid, a.ifund, Isnull(c.fundsname, '')
			,Isnull((Select Top 1 mvalue From v_fas_cm_fund_data_dtl Where fkind = 'SIZE' And ifund = a.ifund Order By ddate_w Desc), 0)/1000 As AUM
			, round((select sum(mcost) mcost from v_fas_fn_dfd z inner join @ddate_fas b on z.ifund = b.ifund and z.ddate_w = b.ddate where q_qty <> 0 and z.ifund = a.ifund and z.icurid = a.icurid )/1000,0)
			, round((select sum(isnull(mcost,0) * cur.price ) mcost from v_fas_fn_dfd z inner join @ddate_fas b on z.ifund = b.ifund and z.ddate_w = b.ddate left join @tb_currency cur on z.icurid = cur.icurid where q_qty <> 0 and z.ifund = a.ifund and z.icurid = a.icurid  )/1000,0)
			, a.icurid
			, cur.price 
			, cur.ddate
			from (select distinct z.ifund,z.icurid from v_fas_fn_dfd z inner join @ddate_fas b on z.ifund = b.ifund and z.ddate_w = b.ddate where q_qty <> 0 and z.icurid <> 'TWD') a
			Left Join funddata c On a.ifund = c.fundid
			left join @tb_currency cur on a.icurid = cur.icurid 
			where  a.icurid not in (select distinct  currency  from @TempMain where data_group = 'B' )
					and a.ifund in (select distinct fundid from @tempmain )


	
		


		--是否要公告
		Insert Into @TempMain (ad_date, Data_Group, Data_Type, fundid, fundsname,stockid, stockname, AccAmt)		
			Select @ddate, 'A', '11', fundid, fundsname,stockid, stockname, AccAmt
				From @TempMain a		
				Where Data_Group = 'B'			
					And isAccAmt = '是'

			

		

					
		--新買進個股
		Insert Into @TempMain (ad_date, Data_Group, Data_Type, fundid, fundsname,stockid, stockname, storeamount, lastprice, cost, amount, amountrate, totalprice, SILP, SILPLimit, capitalrate, capitalratelimit, totalcapitalrate, income, totalamountrate, StockPool, FundUserTrans, FundCost, FundAUM)		
			Select @ddate, 'A', '12', fundid, fundsname,stockid, stockname, storeamount, lastprice, cost, amount, amountrate, totalprice, SILP, SILPLimit, capitalrate, capitalratelimit, totalcapitalrate, income, totalamountrate, StockPool, FundUserTrans, FundCost, FundAUM
				From @TempMain a		
				Where Data_Group = 'B'				
					And cost Is NULL


		--要找新買進個股的庫存
		declare  @tbnewstock table	(stockid varchar(20) )
		declare  @tbfundname table (fundname varchar(100))
		
		insert into @tbnewstock
		select stockid from  @tempmain where Data_Group = 'A' and Data_Type = '12'
		
		declare @sid varchar(20)
		declare @fsname varchar(100)
		declare @fundlist varchar(500)



		while EXISTS(SELECT * FROM @tbnewstock)
		Begin
			set @fundlist = ''
			select top 1 @sid = stockid from @tbnewstock 

			insert into @tbfundname
			select b.fundsname from v_fas_fn_dfd a
			inner join @ddate_fas c  on a.ifund = c.ifund and a.ddate_w = c.ddate 
			left join funddata b on a.ifund = b.fundid 
			where ifdid = @sid  and b.fundlevel = '3' and a.q_qty <>0

			while EXISTS(select * from @tbfundname)
			Begin
				select top 1 @fsname = fundname from @tbfundname 
				set	@fundlist = @fundlist + @fsname + ' 已有庫存' + CHAR(10) --+ CHAR(13) 
				delete @tbfundname where fundname = @fsname 
			End
			delete @tbnewstock where stockid = @sid

			update @TempMain set memo = @fundlist where Data_Group = 'A' and Data_Type = '12' and stockid = @sid 

		End

		--===========================================================	



		update @TempMain set TypeACount = (select count(*) from @TempMain where Data_Group = 'A' and Data_Type = '01') --where Data_Group = 'A' and Data_Type = '01'
		update @TempMain set TypeBCount = (select count(*) from @TempMain where Data_Group = 'A' and Data_Type = '11') --where Data_Group = 'A' and Data_Type = '11'
		update @TempMain set TypeCCount = (select count(*) from @TempMain where Data_Group = 'A' and Data_Type = '12') --where Data_Group = 'A' and Data_Type = '12'
		update @TempMain set TypeACount = (select count(*) from @TempMain where Data_Group = 'A' and Data_Type = '02')

		

		Select * From @TempMain Where Data_Group = 'A' Order By Data_Group, Data_Type, fundaum desc
 
End


