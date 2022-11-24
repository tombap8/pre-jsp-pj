<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.invalidate();
	out.println("<script>alert('로그아웃되었습니다');location.replace('../index.jsp');</script>");
// 	response.sendRedirect("../index.jsp");

%>