
rem 01
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\01_createF_Q_Get_FdSaleCost.sql           -o .\01_AM_Script\Log\01.txt                                 
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\02_createF_Q_Get_FdSaleDivCost.sql        -o .\01_AM_Script\Log\02.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\03_createP_U_Fd_Trade_Mcost.sql          -o .\01_AM_Script\Log\03.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\04_createF_Q_GL_Get_Fd_Pnav.sql           -o .\01_AM_Script\Log\04.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\05_createF_Q_Get_RebateDetail.sql         -o .\01_AM_Script\Log\05.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\06_createP_U_fd_estRebate.sql             -o .\01_AM_Script\Log\06.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\07_createP_U_FS_FD_Trade.sql              -o .\01_AM_Script\Log\07.txt                                
rem sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\08_CREATEVgl_cash_trade_FOF.sql           -o .\01_AM_Script\Log\08.txt                                
rem sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\09_ALTERVgl_cash_trade.sql                -o .\01_AM_Script\Log\09.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\10_CREATEfn_fd_data.sql                   -o .\01_AM_Script\Log\10.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\11_CREATEfn_fd_com.sql                    -o .\01_AM_Script\Log\11.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\12_CREATEfn_fd_pnav.sql                   -o .\01_AM_Script\Log\12.txt                                 
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\13_CREATEfn_dfd.sql                       -o .\01_AM_Script\Log\13.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\14_CREATEfn_fd_buy.sql                    -o .\01_AM_Script\Log\14.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\15_CREATEfn_fd_sell.sql                   -o .\01_AM_Script\Log\15.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\16_CREATEfn_fd_getch.sql                  -o .\01_AM_Script\Log\16.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\17_CREATEfn_fd_rebate.sql                 -o .\01_AM_Script\Log\17.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\18_CREATEfn_fd_iagtfdtype.sql             -o .\01_AM_Script\Log\18.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\19_CREATEfn_fd_EstRebate.sql              -o .\01_AM_Script\Log\19.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\20_CREATEfn_Fd_data_mapping.sql           -o .\01_AM_Script\Log\20.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\21_CREATEfn_fd_buyACCTdata.sql            -o .\01_AM_Script\Log\21.txt                           
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\22_CREATETmpfn_dfd99.sql                  -o .\01_AM_Script\Log\22.txt                         
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\23_CREATELog_fn_fd_iagtfdtype.sql         -o .\01_AM_Script\Log\23.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\24_CREATELog_fn_fd_com.sql                -o .\01_AM_Script\Log\24.txt                                 
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\25_CREATELog_fn_fd_buy.sql                -o .\01_AM_Script\Log\25.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\26_CREATELog_fn_fd_data.sql               -o .\01_AM_Script\Log\26.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\27_CREATELog_fn_fd_pnav.sql               -o .\01_AM_Script\Log\27.txt                                    
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\28_CREATELog_fn_fd_getch.sql              -o .\01_AM_Script\Log\28_getch.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\28_CREATELog_fn_fd_sell.sql               -o .\01_AM_Script\Log\28_sell.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\29_CREATELog_fn_fd_rebate.sql             -o .\01_AM_Script\Log\29.txt                                 
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\30_CREATELog_fn_fd_buyACCTdata.sql        -o .\01_AM_Script\Log\30.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\31_CREATELog_fn_fd_data_mapping.sql       -o .\01_AM_Script\Log\31.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\36_cm_broker_SSI_tmp.sql                  -o .\01_AM_Script\Log\36.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\37_cm_MarketName_tmp.sql                  -o .\01_AM_Script\Log\37.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\38_cm_SEC_SSI_tmp.sql                     -o .\01_AM_Script\Log\38.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\42_log fn_fd_buyACCTdata(ForTG0402).sql   -o .\01_AM_Script\Log\42.txt                               
rem sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\43_log_fn_fd_com(ForTG0401).sql           -o .\01_AM_Script\Log\43.txt                               
rem sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\44_log_fn_fd_data(ForTG0402).sql          -o .\01_AM_Script\Log\44.txt                               
rem sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\45_log_fn_fd_getch(ForTG9939).sql         -o .\01_AM_Script\Log\45.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\46_log_fn_invest_credit(ForTG0020).sql    -o .\01_AM_Script\Log\46.txt                               
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\47_log_st_ds_client(ForTG0401).sql        -o .\01_AM_Script\Log\47.txt                               
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\48_P_Q_GET_TG9939(ForTG9939).sql          -o .\01_AM_Script\Log\48.txt                               
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\49_st_ds_client(ForTG0401).sql            -o .\01_AM_Script\Log\49.txt                               
rem sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\50_TGL_基金_Eddie.sql                     -o .\01_AM_Script\Log\50.txt                                 
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\51_P_Q_Get_TG9941_Dfd.sql                 -o .\01_AM_Script\Log\51.txt                                 
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\52_TABLE開新欄位.sql                      -o .\01_AM_Script\Log\52.txt                                 
rem sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\53_CREATEfn_Fd_data_mapping.sql           -o .\01_AM_Script\Log\53.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\54_CREATEVgl_cash_trade_FOF.sql           -o .\01_AM_Script\Log\54.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\55_ALTERVgl_cash_trade.sql                -o .\01_AM_Script\Log\55.txt                                
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\AC_COMM目錄SQL.sql                        -o .\01_AM_Script\Log\AM_COMM.txt                           
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\UPDATEcm_symbol.sql                       -o .\01_AM_Script\Log\UPDATEcm_symbol.txt                  
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\UPDATEGL_acc_data.sql                     -o .\01_AM_Script\Log\UPDATEGL_acc_data.txt         
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\UPDATEGL_auto_vouchor.sql                 -o .\01_AM_Script\Log\UPDATEGL_auto_vouchor.txt            
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\01_AM_Script\UpdateSQL.sql                             -o .\01_AM_Script\Log\UpdateSQL.txt                        

rem 02
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\1.Riskmgt_InsertRules.sql                    -o .\02_ETS_Script\Log\1.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\10.ETS_UpdateData.sql                        -o .\02_ETS_Script\Log\10.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\11.ETS_Function_GetProductName.sql           -o .\02_ETS_Script\Log\11.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\12.ETS_FofAccAmt.sql                         -o .\02_ETS_Script\Log\12.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\13.ETS_FofAccAmtDec.sql                      -o .\02_ETS_Script\Log\13.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\14.ETS_View_FOData.sql                       -o .\02_ETS_Script\Log\14.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\15.ETS_View_v_fas_fn_dfd.sql                 -o .\02_ETS_Script\Log\15.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\16.ETS_View_v_fas_fn_fd_pnav.sql             -o .\02_ETS_Script\Log\16.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\17.Riskmgt_View_v_fas_fn_fd_data.sql         -o .\02_ETS_Script\Log\17.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\18.ETS_View_vCm_act_data.sql                 -o .\02_ETS_Script\Log\18.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\19.ETS_FOHedgeMapping.sql                    -o .\02_ETS_Script\Log\19.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\2.Riskmgt_RawData.sql                        -o .\02_ETS_Script\Log\2.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\20.ETS_FOHedgeMappingHistory.sql             -o .\02_ETS_Script\Log\20.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\21.ETS_View_FofFundData.sql                  -o .\02_ETS_Script\Log\21.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\22.ETS_View_vTradeConfirmGlStkMappingData.sql -o .\02_ETS_Script\Log\22.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\23.ETS_TradeConfirmFileList.sql							-o .\02_ETS_Script\Log\23.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\24.ETS_InsertMenuProgramRole.sql							-o .\02_ETS_Script\Log\24.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\25.Riskmgt_View_v_fas_fn_dfd.sql							-o .\02_ETS_Script\Log\25.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\3.ETS_OrderRpt_FoF_Detail.sql                -o .\02_ETS_Script\Log\3.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\4.ETS_OrderRpt_FoF_Sum.sql                   -o .\02_ETS_Script\Log\4.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\5.ETS_OrderRpt_GlFTS.sql                     -o .\02_ETS_Script\Log\5.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\6.ETS_TradeConfirmFund.sql                   -o .\02_ETS_Script\Log\6.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\7.ETS_ProposalData.sql                       -o .\02_ETS_Script\Log\7.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\8.ETS_ProposalDataDec.sql                    -o .\02_ETS_Script\Log\8.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\02_ETS_Script\9.ETS_OrderRpt_FTS.sql                  			-o .\02_ETS_Script\Log\9.txt

rem 03
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\00_Create_Tab_RMD_DFD.sql          		-o .\03_Yvonne\Log\00_Create_Tab_RMD_DFD.txt       
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\00_Create_TAB_RMD_DFTS.sql      				-o .\03_Yvonne\Log\00_Create_TAB_RMD_DFTS.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\00_Insert_Data.sql              				-o .\03_Yvonne\Log\00_Insert_Data.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\00_Update_TAB_PRT_MSREPORT_L.sql				-o .\03_Yvonne\Log\00_Update_TAB_PRT_MSREPORT_L.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\01_Uf_RMD_Dfd_IfExist.sql            	-o .\03_Yvonne\Log\01_Uf_RMD_Dfd_IfExist.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\01_Uf_RMD_Dfts_IfExist.sql      				-o .\03_Yvonne\Log\01_Uf_RMD_Dfts_IfExist.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\02_Up_RMD_Dfd_D.sql             				-o .\03_Yvonne\Log\02_Up_RMD_Dfd_D.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\02_Up_RMD_DFts_D.sql            				-o .\03_Yvonne\Log\02_Up_RMD_DFts_D.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\03_UP_RMD_Dfd_Add.sql           				-o .\03_Yvonne\Log\03_UP_RMD_Dfd_Add.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\03_UP_RMD_Dfts_Add.sql          				-o .\03_Yvonne\Log\03_UP_RMD_Dfts_Add.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\03_UP_RMD_DStk_Add.sql          				-o .\03_Yvonne\Log\03_UP_RMD_DStk_Add.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\04_UP_RMD_Dfd_Add_All.sql       				-o .\03_Yvonne\Log\04_UP_RMD_Dfd_Add_All.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\04_UP_RMD_DFts_Add_All.sql      				-o .\03_Yvonne\Log\04_UP_RMD_DFts_Add_All.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\05_UP_RMD_Dfd_Add_All_SE.sql    				-o .\03_Yvonne\Log\05_UP_RMD_Dfd_Add_All_SE.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\05_UP_RMD_DFts_Add_All_SE.sql   				-o .\03_Yvonne\Log\05_UP_RMD_DFts_Add_All_SE.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\UP_MSRprt_Add_Rcode07.sql       				-o .\03_Yvonne\Log\UP_MSRprt_Add_Rcode07.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\UP_MSRprt_Add_Rcode08.sql       				-o .\03_Yvonne\Log\UP_MSRprt_Add_Rcode08.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\UP_MSRprt_Add_Rcode09_1.sql     				-o .\03_Yvonne\Log\UP_MSRprt_Add_Rcode09_1.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\UP_MSRprt_Add_Rcode10.sql       				-o .\03_Yvonne\Log\UP_MSRprt_Add_Rcode10.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\03_Yvonne\UP_MSRprt_Add_Rcode11.sql         			-o .\03_Yvonne\Log\UP_MSRprt_Add_Rcode11.txt

rem 04
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\04_Vicky\cm_fund_data_FOF.sql              			-o .\04_Vicky\Log\cm_fund_data_FOF.sql              
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\04_Vicky\cm_fund_data_relation_FOF.sql     			-o .\04_Vicky\Log\cm_fund_data_relation_FOF.sql
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\04_Vicky\Riskmgt.dbo.RB_Rule_新增欄位.sql  			-o .\04_Vicky\Log\Riskmgt.dbo.RB_Rule_新增欄位.sql
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\04_Vicky\Riskmgt.dbo.RC_LookUp_新增資料.sql      -o .\04_Vicky\Log\Riskmgt.dbo.RC_LookUp_新增資料.sql

rem 05
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\05_Jack\0101_EquityIndexFieldMapping.sql          -o .\05_Jack\Log\0101.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\05_Jack\0201_CreateTable_CMoney_SIT.sql           -o .\05_Jack\Log\0201.txt 
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\05_Jack\0202_CreateTable_CMoney_SITFund.sql       -o .\05_Jack\Log\0202.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\05_Jack\0203_JobColumnMappingCreate.sql           -o .\05_Jack\Log\0203.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\05_Jack\0204_JobListCreateSQL.sql                 -o .\05_Jack\Log\0204.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\05_Jack\0301_FundDataCreate.sql                   -o .\05_Jack\Log\0301.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\05_Jack\0302_FundPriceCreate.sql                  -o .\05_Jack\Log\0302.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\05_Jack\0303_FundFieldMapping.sql                 -o .\05_Jack\Log\0303.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\05_Jack\0401_CreateTable_FutureOptionProduct.sql  -o .\05_Jack\Log\0401.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\05_Jack\0402_CreateTable_FuturesContractDetail.sql -o .\05_Jack\Log\0402.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\05_Jack\0403_CreateTable_FuturesContractPrice.sql  -o .\05_Jack\Log\0403.txt
sqlcmd -S 10.67.99.107 -U tgl_admin -P 1qaz@WSX -i .\05_Jack\0404_Futures_FieldMapping.sql          		-o .\05_Jack\Log\0404.txt
            