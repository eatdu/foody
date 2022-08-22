<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="util.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body onload="document.frm.submit();">
<%
String savePath = "/upload/editor/";
int EDITOR_MAXSIZE 			= 20*1024*1024;

// 폴더생성
File moveDir = new File(request.getRealPath(savePath));																								//복사될 디렉토리
if (!moveDir.exists()) {																										//복사될 경로가 없을경우 만든다.
	moveDir.mkdirs(); // 디렉토리 생성
}
System.out.println(request.getRealPath(savePath));
MultipartRequest multi = new MultipartRequest(request, request.getRealPath(savePath), EDITOR_MAXSIZE, "utf-8",  new DefaultFileRenamePolicy());

String callback= multi.getParameter("callback");
String callback_func= multi.getParameter("callback_func");
int fileCount = 0;

String url = callback + "?callback_func=" + callback_func;

Enumeration fileNameParams = multi.getFileNames();
String[] imgAlts = multi.getParameterValues("image_alt"); 
String[] widths = multi.getParameterValues("width"); 

String file_name = "";
String org_value = "";
%>
<form action="<%=callback%>" method="post" id="frm" name="frm">
	<input type="hidden" name="callback_func" value="<%=callback_func%>" />
	<input type="hidden" name="bNewLine" value="true" />
<%  
if(fileNameParams.hasMoreElements()){
	while (fileNameParams.hasMoreElements()) {
			String fileName = (String)fileNameParams.nextElement();
			file_name = multi.getFilesystemName(fileName);	// 실제이름
			org_value = multi.getOriginalFileName(fileName);
		if(!"".equals(file_name)){  
			%>
			<input type="hidden" name="sFileName" value="<%=org_value%>" />
			<input type="hidden" name="sFileURL" value="<%=request.getContextPath()+savePath+file_name%>" />
			<%if(imgAlts != null){ %>
			<input type="hidden" name="alt" value="<%=URLDecoder.decode(imgAlts[fileCount], "utf-8")%>" />
			<% } %>
			<%if(widths != null){ %>
			<input type="hidden" name="width" value="<%=widths[fileCount]%>" />
			<% } %>
			<%
			fileCount++;
		} else {
			continue;	
		}
	}
%>
	<input type="hidden" name="fileCnt" value="<%=fileCount%>" />
<%
}else{
%>
	<input type="hidden" name="errstr" value="error" />
<%
}
//response.sendRedirect(url);
%>
</form>
</body>
</html>
