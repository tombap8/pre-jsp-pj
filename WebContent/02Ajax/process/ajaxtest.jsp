<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%
	// 상단 페이지 디렉티브도 화면구성에 태그이므로 한줄이 빈칸으로 표시됨
	// 이것을 없애는 것은  trimDirectiveWhitespaces="true"

	// [ 비동기 통신 테스트 처리페이지 ] //
	// -> 결과리턴시 화면에 찍어주는 값이 리턴되므로
	// 처리페이지에서는 html형식을 모두 지워준다!
	
	//POST 방식의 한글처리 : 이것 안쓰면 한글깨짐!!!
	request.setCharacterEncoding("UTF-8");
	
	// POST 방식으로 넘어온 값 받기
	String name = request.getParameter("name");
	
	// 넘어온값 화면출력!
	// out.print("받은값 : "+name);
	
	// 결과값을 화면에 출력한다!
	// 넘어온값만 정확히 비교하기 위해 equals() 사용!
	if (name.equals("고양이")) {
		out.print("야옹야옹");
	} else if (name.equals("강아지")) {
		out.print("멍멍");
	} else {
		out.print("넌 누구냐?");
	}
%>