<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String callback_func = request.getParameter("callback_func");
	String bNewLine = request.getParameter("bNewLine");
	String errstr = request.getParameter("errstr");
	int fileCount = 0;
	try {
		fileCount = Integer.parseInt(request.getParameter("fileCnt")) ;
	} catch (Exception e) {
		fileCount = 0;
	}
	
	String[] sFileNames = request.getParameterValues("sFileName");
	String[] sFileURLs = request.getParameterValues("sFileURL");
	String[] alts= request.getParameterValues("alt");
	String[] widths= request.getParameterValues("width");
	
	String oResult = "";
	if(fileCount > 0){
		for(int i = 0; i < fileCount; i++){
			oResult = oResult + "{callback_func:\""+callback_func+"\", bNewLine:"+bNewLine+",";
			
			// 이미지 실제 이름과 변환 이름 받기
			oResult = oResult + "sFileName:\""+URLDecoder.decode(sFileNames[i],"utf-8")+"\", sFileURL:\""+sFileURLs[i]+"\",";
			
			// 이미지 설명 받아오기
			if(alts != null){
				oResult = oResult + "alt:\""+URLDecoder.decode(alts[fileCount - (1 + i)], "utf-8")+"\" ";
			}
			
			// width값이 있을때 해당 width값, 없으면 auto
			if(widths != null){
				if(!"".equals(widths[fileCount - (1 + i)])){ 
					oResult = oResult + ", width:\""+widths[fileCount - (1 + i)]+"px\" ";
				} else {
					oResult = oResult + ", width:\"auto\" ";
				}
			}
			
			// 마지막 배열값 닫기
			oResult = i < fileCount - 1 ? oResult + "}," : oResult + "}"; 
		}
	} else {
		oResult = oResult + "{errstr : \"error\", callback_func:\""+callback_func+"\"}";
	}
%>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>FileUploader Callback</title>
    <script type="text/javascript">
    var oResult = [<%=oResult%>];
    
		if ((oResult[0].errstr || '').length) { // on error
           (parent.jindo.FileUploader._oCallback[oResult[0].callback_func+'_error'])(oResult);
        } else {
	       (parent.jindo.FileUploader._oCallback[oResult[0].callback_func+'_success'])(oResult);
	   	}
    </script>
</head>
<body>

</body>
</html>