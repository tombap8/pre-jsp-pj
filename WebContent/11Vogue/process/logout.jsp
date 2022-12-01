<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// ### 로그아웃 처리 페이지 ###
	try{
		// 세션을 유효하지 않게 하라! 세션해제함!
		// (유효하지 않다 -> invalidate)
		session.invalidate();
		out.print("ok");
	} /// try /////////
	catch(Exception e){
		out.print(e.toString());
	} //// catch ////////
%>