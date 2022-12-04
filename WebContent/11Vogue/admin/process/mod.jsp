<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- DB연결 객체 임포트 필수! -->
<%@page import="common.JDBConnector"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	// JDBConnector 객체생성하기
	JDBConnector jdbc = new JDBConnector();

	//POST 방식의 한글처리 : 이것 안쓰면 한글깨짐!!!
	request.setCharacterEncoding("UTF-8");

	try {
		// 수정할 레코드의 유일키인 idx값을 GET방식으로 전달받는다!
		// JSP에서는 GET방식이든 POST방식이든 하나의 메서드로 관리함
		// requset.getParameter(이름)
		String idnum = request.getParameter("idx");
		// 페이지번호 받기 : 수정후 리스트페이지 갈때 사용함!
		String pgnum = request.getParameter("pgnum");

		// 파라미터 정보 가져오기
		// 전송한 페이지인 insert.jsp의 form태그 안의 input요소들의
		// name 속성명으로 읽어온다!
		// request객체를 사용한다 -> HttpServletRequest 객체로 생성함!
		// request는 "요청"이라는 뜻!
		// 파라미터를 요청한다 -> 파라미터는 전달값을 말함!
		// 가져오는 메서드는? -> getParameter(name속성값)
		// ->>> request.getParameter(name속성값)
		String auth = request.getParameter("auth");

		// 넘어온값 찍기!
// 		out.println("<h1>" + "♣ idx : " + idnum + "<br>" + "♣ dname : " + dname + "<br>" + "♣ actors : " + actors + "<br>"
// 		+ "♣ broad : " + broad + "<br>" + "♣ gubun : " + gubun + "<br>" + "♣ stime : " + stime + "<br>"
// 		+ "♣ total : " + total + "</h1>");

		// 7. 쿼리문작성 할당
		String query = "UPDATE `member` SET `auth`=? WHERE `idx` = ?";
		// 쿼리문작성시 삽입될 데이터 부분을 물음표(?)로 처리하면
		// PreparedStatement 객체에서 이부분을 입력하도록 해준다!

		// 11. 쿼리문 연결 사용준비하기
		// conn연결된 DB객체
		jdbc.pstmt = jdbc.conn.prepareStatement(query);
		// prepareStatement(쿼리문변수)
		// - 쿼리문을 DB에 보낼 상태완료!
		// - 중간에 쿼리문에 넣을 값을 추가할 수 있음!

		// 12. 준비된 쿼리에 물음표부분을 처리하는 순서!
		// set데이터형(순번, 값변수)
		// 순번은 1부터 시작!
		// 데이터형이름은 대문자로 시작
		// 예) setString(), setInt(), setDouble(),...
		jdbc.pstmt.setString(1, auth);
		jdbc.pstmt.setInt(2, Integer.parseInt(idnum));
		// 물음표 순서대로 값을 셋팅해 준다!

		// 13. 쿼리를 DB에 전송하여 실행한다.
		jdbc.pstmt.executeUpdate(); // update문을 실행하는 메서드는?
		// executeQuery() 쿼리실행 메서드 -> select 데이터셋을 가져옴
		// executeUpdate() 쿼리실행 메서드 -> update문을 실행함 
		// -> insert 나 update 모두 DB가 변경되는 것이므로
		// executeUpdate() 메서드가 모두 처리한다!

		// 14. 연결해제하기
		jdbc.close();

		// 15. 입력성공시 메시지 띄우기
		// JS alert창 띄우고 확인시 list페이지로 돌아가기!
		out.println("<script>" + "alert('업데이트 성공!');" + 
		"location.href='../list.jsp?pgnum="+pgnum+"';" + "</script>");

		// [ 입력시 한글 깨짐 문제발생 해결 ]
		// -> 입력성공후 한글이 물음표(?)로 입력된 경우 원인은?
		// DB를 살펴보면 utf8_general_ci 형식으로 잘 만들어져있음!
		// 원인은 MySQL 환경설정파일에 있다!!!

		// XAMPP 패널에 config버튼 클릭시 my.ini파일에서 "utf"검색
		// 결과: utf8mb4 가 설정되어 있음 이것을 모두 utf8로 변경함!
		// 참고주의) #이 앞에 있는 문장은 주석문이므로 고칠필요가 없다!

		// [아래 3가지를 변경함!]
		// default-character-set=utf8
		// character-set-server=utf8
		// collation-server=utf8_general_ci

		// 변경후 반드시 MySQL 서버를 내렸다 올려야 my.ini를 다시 읽는다!

		// 실제 my.ini 위치는
		// C:\xampp\mysql\bin\my.ini

	} ////////// try //////////
	catch (Exception e) {
		// DB연결 실패시 여기로 들어옴!
		out.println("에러메시지:");
		out.println(e.toString());
		// toString() 문자데이터로 변환하는 메서드
	} ///////// catch //////////
	%>

</body>
</html>