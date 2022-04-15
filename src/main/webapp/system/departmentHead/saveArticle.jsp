<%@page import="com.zhuozhengsoft.pageoffice.FileSaver"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String src = (String)request.getSession().getAttribute("src");
FileSaver fs=new FileSaver(request,response);
fs.saveToFile(src);
fs.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>