<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="common.JDBConnector"%>
<%
	// ### 아이디 중복검사 처리 페이지 ###
		
		//POST 방식의 한글처리 : 이것 안쓰면 한글깨짐!!!
		request.setCharacterEncoding("UTF-8");
		
		// DB연결 객체 생성
		JDBConnector jdbc = new JDBConnector();
		
		
		// 검사할 아이디 받기
		String mid = request.getParameter("mid");
		

	try {

		// 7. 쿼리문작성 할당
		String query = 
		"SELECT * FROM `member` WHERE `mid` = ?";
		// 해당 유일키 idx값을 넣어서 선택하면 하나의 레코드만 선택된다!
		// 데이터가 들어갈 자리만 물음표(?)로 처리하면 끝!
		

		// 11. 쿼리문 연결 사용준비하기
		// conn연결된 DB객체
		jdbc.pstmt = jdbc.conn.prepareStatement(query);
		// prepareStatement(쿼리문변수)
		// - 쿼리문을 DB에 보낼 상태완료!
		// - 중간에 쿼리문에 넣을 값을 추가할 수 있음!

		// 12. 쿼리에 추가할 데이터 셋팅하기!
		jdbc.pstmt.setString(1, mid);
		// 아이디로 쿼리조건값을 설정함!

		// 13. 쿼리를 DB에 전송하여 실행후 결과집합(결과셋)을 가져옴!
		// ResultSet객체는 DB에서 쿼리결과를 저장하는 객체임!
		jdbc.rs = jdbc.pstmt.executeQuery();
		// executeQuery() 쿼리실행 메서드

		// 14. 저장된 결과집합의 레코드가 있다면 next() 메서드가 true임!
		// 해당 아이디가 있으면 "no", 아이디가 없으면 "ok"를 화면에 출력해서 전달!
		if (jdbc.rs.next()) { // 기존에 아이디있음
			out.print("no");			
		} //////////// if //////////////
		else{ // 기존에 아이디 없음 (사용가능)
			out.print("ok");
		} /////////// else ///////////////

		// 14. 연결해제하기
		jdbc.close();

	} //// try /////
	catch (Exception e) {
		// DB연결 실패시 여기로 들어옴!
		out.println("에러메시지:");
		out.println(e.toString());
		// toString() 문자데이터로 변환하는 메서드
	} ///// catch //////
%>