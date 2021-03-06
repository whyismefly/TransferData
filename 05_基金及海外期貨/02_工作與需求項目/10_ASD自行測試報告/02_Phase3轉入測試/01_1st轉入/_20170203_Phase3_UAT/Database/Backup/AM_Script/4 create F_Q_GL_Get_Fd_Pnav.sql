USE [isdbTGL]
GO
/****** Object:  UserDefinedFunction [dbo].[F_Q_GL_Get_Fd_Pnav]    Script Date: 2017/1/26 下午 04:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create FUNCTION [dbo].[F_Q_GL_Get_Fd_Pnav] (@ifdid varchar(20), @ddate_w varchar(8) ) 

/*
功能：取得該日基金價格(.Net結帳程式使用)

傳入參數: 
@@ifdid :期貨代號
@ddate_w  :取得日期 

select [dbo].[F_Q_GL_Get_Fd_Pnav] ('WTF201512','20150801')
*/
           
RETURNS numeric(20,6) AS      
BEGIN

	Declare @npnav numeric(20,6)
	Set @npnav = 0

		BEGIN	
			SELECT @npnav = pnav From fn_fd_pnav with(nolock) Where ifdID = @ifdid and ddate_w = @ddate_w
		END

	RETURN(@npnav) 

END

