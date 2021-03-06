USE [Riskmgt]
GO
/****** Object:  StoredProcedure [dbo].[ITC_RB_SP_UI_GetRawData]    Script Date: 2017/2/2 上午 09:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER   PROCEDURE [dbo].[ITC_RB_SP_UI_GetRawData]
	 @ddate AS VARCHAR(8),
	 @fundtype as varchar(2)
AS



select b.blgno 'Bloomberg',a.istkid 'Security Name', b.isin 'ISIN', b.ncstk 'Security Desc'
,'' IssueDate, '' MaturityDate, '' CouponRate, b.nEstk 'Issuer Desc'
,'' SPRatingIssuer,'' SPRatingIssue, '' MoodyRatingIssuer, '' MoodyRatingIssue, '' FitchRatingIssuer, '' FitchRatingIssue
, '' TRCRatingIssuer, '' TRCRatingIssue, '' FitchNationalIssuer, '' FitchNationalIssue, '' InternalRating, '' SILRating
, '' IssuerRating, '' IssueRating, '' ComplianceRating, '' ClaimPriority
, b.industry_group  Industry
, case when b.ftype = '15' then 'FIXED INCOME' else  'EQUITY' end 'Asset Class'
, case when b.ftype in  ('4','ETF') then 'ETF' when b.ftype  in ('9','REITS') then 'REIT' when b.ftype in ('15') then 'PREFERRED SHARES OTHER' else 'COMMON SHARE' end 'Asset Sub Class'
, case when b.icountry = 'TW' then 'T' when a.ifund = '1FUBP' then 'EUR' when a.ifund = 'ZFUBP3' then 'USD' else b.icurid end + '_' + case when b.ftype in ('4','ETF') then 'ETF' when b.ftype  in ('9','REITS') then 'REIT' when b.ftype in ('15') then 'PREFERRED' else  'STOCK' end    'Oracle Class'
,a.ifund + '-' + d.FundName  'Portfolio',a.mntamt 'MV'
, a.mcost* isdbtgl.dbo.F_Q_Change2TWD(case when a.ifund = '1FUBP' then 'EUR' when a.ifund = 'ZFUBP3' then 'USD' else b.icurid end,@ddate) 'BV'
,qshare 'QTY'
, '' Compliance1 , '' Compliance2
, case when a.ifund = '1FUBP' then 'EUR' when a.ifund = 'ZFUBP3' then 'USD' else b.icurid end 'Currency'
, isdbtgl.dbo.F_Q_Change2TWD(case when a.ifund = '1FUBP' then 'EUR' when a.ifund = 'ZFUBP3' then 'USD' else b.icurid end, @ddate) 'CurrencyRate'
, a.AccountType, case when a.AccountType in ('AFS','TRADING','FVTPL') then a.mntamt else a.mcost* isdbtgl.dbo.F_Q_Change2TWD(b.icurid,@ddate) end 'RV', '' '預算分類'
from [dbo].[v_fas_fn_dstk] a
left join [dbo].[v_fas_fn_stk_data] b on a.istkid = b.istkid and b.dexpire_w >= @ddate and b.duse_w <= @ddate
left join v_fas_cm_fund_data c on a.ifund = c.ifund and c.dfund_w >@ddate and c.dbuild_w < @ddate
left join v_fas_FundData d on c.ifund = d.fundid 
where ddate_w = @ddate and c.[level] = 2 and  (d.fundtype = @fundtype or @fundtype = '0')
	and a.ifund not in (select orifund from v_fas_cm_monfund_relation ) 
	and qshare >0

	union all

select a.ifdid, case when b.fkind = '14' then ifdname else b.ifdid end 'Security Name',b.isincode, ifdname 'Security Desc.'
,'' IssueDate, ''MaturityDate, ''CouponRate, b.ifdename 'Issuer Desc'
,'' SPRatingIssuer,'' SPRatingIssue, '' MoodyRatingIssuer, '' MoodyRatingIssue, '' FitchRatingIssuer, '' FitchRatingIssue
, '' TRCRatingIssuer, '' TRCRatingIssue, '' FitchNationalIssuer, '' FitchNationalIssue, '' InternalRating, '' SILRating
, '' IssuerRating, '' IssueRating, '' ComplianceRating, '' ClaimPriority
, b.fund_industry_focus 'Industry'
, case when b.fkind = '06' then 'CASH' when b.fkind in ('02','13','03','04') then 'EQUITY' when b.fkind in ('01') then 'FIXED INCOME' when b.fkind in ('14','15','08') then 'ALTERNATIVES' else '' end 'Asset Class'
, case when b.fkind = '06' then 'MM FUND' when b.fkind = '02' then 'EQUITY FUND'when b.fkind = '13' then 'REITS FUND' when b.fkind = '01' then 'DEBT FUND' when b.fkind = '14' then 'PE FUND' when b.fkind = '15' then 'INFRA FUND' when b.fkind = '08' then 'HEDGE FUND' when b.fkind = '03' then 'BALANCE FUND' when b.fkind = '04' then 'FUND OF FUND' else '' end 'Asset Sub Class'
, case when b.icurid = 'TWD' then 'T' else b.icurid end + '_' + case when b.fkind = '06' then 'MM FUND' when b.fkind = '02' then 'STOCK FUND'when b.fkind = '13' then 'REITS FUND' when b.fkind = '01' then 'BOND FUND' when b.fkind = '14' then 'PRIVATE FUND' when b.fkind = '15' then 'INFRA FUND' when b.fkind = '08' then 'HEDGE FUND' when b.fkind = '03' then 'BALANCE FUND' when b.fkind = '04' then 'FUND OF FUND' else '' end 'Oracle Class'
,a.ifund + '-' + d.FundName  'Portfolio', a.mamttwd 'MV'
,a.mcost * isdbtgl.dbo.F_Q_Change2TWD( b.icurid ,@ddate) 'BV'
,a.q_qty 'QTY'
, '' Compliance1 , '' Compliance2
, b.icurid 'Currency'
, isdbtgl.dbo.F_Q_Change2TWD( b.icurid, @ddate) 'CurrencyRate'
, a.AccountType 
,case when a.AccountType in ('AFS','TRADING','FVTPL') then a.mamttwd else a.mcost* isdbtgl.dbo.F_Q_Change2TWD(b.icurid,@ddate) end 'RV', '' '預算分類'
from [dbo].[v_fas_fn_dfd] a
left join [dbo].[v_fas_fn_fd_data] b on a.ifdid = b.ifdid and b.dexpire_w >=  @ddate  and b.duse_w <=  @ddate 
left join v_fas_cm_fund_data c on a.ifund = c.ifund and c.dfund_w > @ddate  and c.dbuild_w <  @ddate 
left join v_fas_FundData d on c.ifund = d.fundid 
where ddate_w =  @ddate  and c.[level] = 2 and  (d.fundtype =@fundtype  or @fundtype  = '0')
	and a.ifund not in (select orifund from v_fas_cm_monfund_relation ) 
	and q_qty >0