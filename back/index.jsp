<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 첫페이지입니다!</title>
<%! // 느낌표가 있는 선언부!
	// 함수를 만들때는 여기에 만들어야한다!
	// 느낌표가 없는 스크립트릿에 만들면 에러가 난다!
	public String myFn(){
		return "<h1>나야나!</h1>";
	}
%>
</head>
<body>
<h1>JSP 첫페이지입니다!</h1>

	<% // 스크립트릿 구역 
		// 문자형 변수에 url로 전달되는 값을 받는다!
		// request.getParameter(파라미터 변수)
		String user = request.getParameter("msg");
		// if문으로 전달값이 없는 경우 거르기
		if(user == null){
			user = "나는 풀스택개발자 입니다!";  
		}
	%>
	
	<!-- 스크립트 표현식 (출력) -->
	<h1><%=user%></h1>
	<h2>
		<a href="index.jsp?msg='Perfect Coding'">완전한코딩!</a>
		<br>
		<a href="index.jsp?msg='Poor Coding'">거지같은코딩!</a>
		<br>
		<a href="index.jsp">처음으로!</a>
	</h2>
	<div><%=myFn() %></div>
	
	
	
	
	
	
</body>
</html>