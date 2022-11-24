<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="common.JDBConnector"%>
<%@ page import="common.SHA256" %>

<%
//POST 방식의 한글처리
		request.setCharacterEncoding("UTF-8");

//try문 바깥에 선언하여 아래 html에서 사용할 수 있다!
	// 1.아이디
		String mid = request.getParameter("mid");
		// 2.비번
		String mpw = request.getParameter("mpw");
		// 3.db비번
		String dbmpw = "";
		// 4.이름
		String name = "";
		// 5.성별
		String auth = "";
		
		JDBConnector jdbc = new JDBConnector();
		SHA256 sha = new SHA256();

	try {
		

		// 7. 쿼리문작성 할당
		String query = "SELECT `mid`,`mpw`,`name`,`auth` FROM `member` WHERE `mid` = ?";
		// 해당 유일키 idx값을 넣어서 선택하면 하나의 레코드만 선택된다!
		// 데이터가 들어갈 자리만 물음표(?)로 처리하면 끝!

		
		// 11. 쿼리문 연결 사용준비하기
		// conn연결된 DB객체
		jdbc.pstmt = jdbc.conn.prepareStatement(query);
		// prepareStatement(쿼리문변수)
		// - 쿼리문을 DB에 보낼 상태완료!
		// - 중간에 쿼리문에 넣을 값을 추가할 수 있음!

		// 12. 쿼리에 추가할 데이터 셋팅하기!
		// -> 파라미터값이 숫자지만 String이므로 형변환 해야함!
		// 문자형을 숫자형으로 변환: Integer.parseInt(변수)
		jdbc.pstmt.setString(1, mid);
		// 형변환시 에러가 발생할 수 있으므로 try,catch문 안에서 변환한다!

		// 13. 쿼리를 DB에 전송하여 실행후 결과집합(결과셋)을 가져옴!
		// ResultSet객체는 DB에서 쿼리결과를 저장하는 객체임!
		jdbc.rs = jdbc.pstmt.executeQuery();
		// executeQuery() 쿼리실행 메서드

		// 14. 저장된 결과집합의 레코드 수 만큼 돌면서 코드만들기!
		// 돌아주는 제어문은? while(조건){실행문}
		// 레코드 유무 체크 메서드는? next()
		// rs는 ResultSet 객체임!!!
		// rs.next() -> 첫라인 다음라인이 있으면 true / 없으면 false!
		// 첫번째 라인은 항상 컬럼명이 첫번째 라인이다!
		// 따라서 다음라인이 있다는 것은 결과 레코드가 있다는 말!!!

		/// 결과셋에 레코드가 있는 동안 계속 순회함!
		// rs.getString(컬럼명)
		// -> 문자형일 경우 getString(), 숫자형은 getInt()
		// -> 컬럼명은 DB 테이블에 실제로 생성된 컬럼명이다!
		// 레코드가 하나있는 경우
		if (jdbc.rs.next()) {
			dbmpw = jdbc.rs.getString("mpw");
			name = jdbc.rs.getString("name");
			auth = jdbc.rs.getString("auth");
			
			// 레코드가 있으나 비밀번호와 비교(소금쳐서 변환함!)
			String shampw = sha.encSha256(mpw);
			
			out.println(
					"<h1>" +
					"♣ 입력아이디 : " + mid + "<br>" +
					"♣ 디비비번 : " + dbmpw + "<br>" +
					"♣ 변환비번 : " + shampw + "<br>" +
					"♣ 입력비번 : " + mpw + "<br>" +
					"♣ 디비이름 : " + name + "<br>" +
					"♣ 디비권한 : " + auth + "</h1>"
				);
			
			if(dbmpw.equals(shampw)){
				out.print("<h1>비밀번호가 일치합니다!</h1>");
				session.setAttribute("name", name);
				response.sendRedirect("../index.jsp");
			}
			else{
				out.print("<h1>비밀번호가 다릅니다!</h1>");
			}
			
		} //////////// if //////////////
		else{
			out.print("<h1>아이디가 존재하지 않습니다!</h1>");
		}
		
		

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