<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>page 지시어 - errorPage, isErrorPage 속성</title>
</head>
<body>
<%
try {  // 예외 발생 부분을 감쌉니다.
	int myLine = Integer.parseInt(request.getParameter("line")) + 10;  // 에러 발생
	out.println("어제부터 당신의 코딩라인은 " + myLine + "라인 입니다.");  // 실행되지 않음
}
catch (Exception e) {
    out.println("예외 발생 : 매개변수 line값이 없습니다!");
}
%>
</body>
</html>