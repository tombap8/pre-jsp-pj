<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="common.Test" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
	function getit(){
		$.post( "process/test.jsp", { name: "John2", time: "2pm" } , 
				function( data ) {
			  console.log( data.trim());
			});
	}
</script>
</head>
<body>
<%
		// POST 방식의 한글처리
		request.setCharacterEncoding("UTF-8");
	Test tt = new Test();
	out.println("<h1>요기요!"+tt.myFn("어서오시오!!!")+"</h1>");
%>
<button id="my" onclick="getit()">클릭!!!</button>
</body>
</html>