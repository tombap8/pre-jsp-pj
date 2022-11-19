<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <!-- 외부JSP 포함하기 -->
   <%@ include file="IncludeTime.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>include 지시어</title>
</head>
<body>
<h1>
	<%
		// 내장객체 중 out : 출력객체
		out.println("★오늘날짜출력:" + today);
		out.println("<br>");
		out.println("★오늘날짜출력:" + tomorrow);
	
	%>
</h1>
</body>
</html>