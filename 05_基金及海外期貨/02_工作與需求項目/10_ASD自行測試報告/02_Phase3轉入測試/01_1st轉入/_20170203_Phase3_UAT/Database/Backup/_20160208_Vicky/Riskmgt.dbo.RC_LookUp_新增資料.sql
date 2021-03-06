/****** SSMS 中 SelectTopNRows 命令的指令碼  ******/
SELECT TOP 1000 [LpId]
      ,[LpType]
      ,[LpName]
      ,[LpShortName]
      ,[Description]
  FROM [Riskmgt].[dbo].[RC_Lookup]

  insert into Riskmgt.dbo.RC_Lookup Values(5,'Rule_RuleCategory','內規_SOP','內規_SOP' ,Null)

  Update Riskmgt.dbo.RC_Lookup Set LpId = 7,LpName='投前_提醒',LpShortName='投前_提醒' Where LpId = 0 And LpType = 'Rule_ExecSystem'
  Update Riskmgt.dbo.RC_Lookup Set LpName='投後檢查',LpShortName='投後檢查' Where LpId = 1 And LpType = 'Rule_ExecSystem'
  Update Riskmgt.dbo.RC_Lookup Set LpName='投中_系統放行',LpShortName='投中_系統放行' Where LpId = 2 And LpType = 'Rule_ExecSystem'
  Update Riskmgt.dbo.RC_Lookup Set LpName='投中_人員放行',LpShortName='投中_人員放行' Where LpId = 3 And LpType = 'Rule_ExecSystem'
  Update Riskmgt.dbo.RC_Lookup Set LpName='投中_提醒',LpShortName='投中_提醒' Where LpId = 4 And LpType = 'Rule_ExecSystem'
  insert into Riskmgt.dbo.RC_Lookup Values(5,'Rule_ExecSystem','投前_系統放行','投前_系統放行' ,Null)
  insert into Riskmgt.dbo.RC_Lookup Values(6,'Rule_ExecSystem','投前_人員放行','投前_人員放行' ,Null)


insert into Riskmgt.dbo.RC_Lookup Values(0,'Rule_RuleClassCod','通用','通用' ,Null)
insert into Riskmgt.dbo.RC_Lookup Values(1,'Rule_RuleClassCod','台幣基金','台幣基金' ,Null)
insert into Riskmgt.dbo.RC_Lookup Values(2,'Rule_RuleClassCod','外幣基金','外幣基金' ,Null)
insert into Riskmgt.dbo.RC_Lookup Values(3,'Rule_RuleClassCod','外幣資產','外幣資產' ,Null)