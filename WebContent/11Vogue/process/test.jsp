<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
//POST 방식의 한글처리 : 이것 안쓰면 한글깨짐!!!
	request.setCharacterEncoding("UTF-8");
	String val = request.getParameter("name");
	String tm = request.getParameter("time");
// 	out.print(val.trim());
	if(val.equals("John")){
		out.print("좐이네!");
	}
	else{
		out.print("아니네!");
	}

%>
