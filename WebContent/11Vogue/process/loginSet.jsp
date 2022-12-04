<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="common.JDBConnector" %>
<%@ page import="common.SHA256" %>
<%
	// ### 로그인 처리 페이지 ###
		
		//POST 방식의 한글처리 : 이것 안쓰면 한글깨짐!!!
		request.setCharacterEncoding("UTF-8");
		
		// DB연결 객체 생성
		JDBConnector jdbc = new JDBConnector();
		
		// 암호화 객체 생성
		SHA256 sha = new SHA256();
		
		//1.아이디(입력항목)
		String mid = request.getParameter("mid");
		// 2.비번(입력항목)
		String mpw = request.getParameter("mpw");
		
		// 3.비번(db)
		String dbmpw = "";
		// 4.이름(db)
		String name = "";
		// 5.권한(db)
		String auth = "";

	try {

		// 7. 쿼리문작성 할당
		String query = 
		"SELECT `mid`,`mpw`,`name`,`auth` FROM `member` WHERE `mid` = ?";
		// 회원의 아이디값을 넣어서 선택하여 레코드를 가져오는 쿼리를 작성한다.
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
		// 해당 아이디가 있다는 말임!!!
		if (jdbc.rs.next()) {
			// 1. 비밀번호
			dbmpw = jdbc.rs.getString("mpw");
			// 2. 이름
			name = jdbc.rs.getString("name");
			// 3. 권한
			auth = jdbc.rs.getString("auth");
			// ********************************
			// 비밀번호 비교를 위해 입력한 비밀번호를 암호화
			String shampw = sha.encSha256(mpw);
			// *********************************
// 			out.println(
// 				"<h1>" +
// 				"♣ 입력아이디 : " + mid + "<br>" +
// 				"♣ 디비비번 : " + dbmpw + "<br>" +
// 				"♣ 변환비번 : " + shampw + "<br>" +
// 				"♣ 입력비번 : " + mpw + "<br>" +
// 				"♣ 디비이름 : " + name + "<br>" +
// 				"♣ 디비권한 : " + auth + "</h1>"
// 			);
			
			// 입력된 비밀번호 암호화후 DB비밀번호와 비교한다!
			if(dbmpw.equals(shampw)){ // 로그인 성공!!
				out.print("ok");
				/*
					[ 로그인 성공시 필수 셋팅할 것은? ]
					-> 세션변수셋팅하기!
					세션이란? Session
					-> 로그인 한 사용자 정보를 저장하여
					사용하는 시간동안 로그인 상태를 유지해주는
					서버 메모리 관리 규칙
					-> 로그인한 사용자 정보는 세션변수에 저장하여
					로그인한 같은 도메인 안에서 어느곳에서든지
					사용될 수 있도록 제공해준다!
					-> 시스템을 사용하지 않은 상태로 제한시간을
					주는데 20분이 기본적인 세션 한계시간이다!
					
					[ 세션의 시작은 언제부터인가? ]
					-> 자바웹에서는 매우 간단히 세션변수를 셋팅하면
					바로 세션이 시작된다!(고유세션아이디가 생성됨)
					-> 세션변수 셋팅법:
					session.setAttribute(세션변수명,값)
					-> 세션변수 호출법:
					session.getAttribute(세션변수명)
						
					
					[ 세션은 어떻게 강제 종료하나? ]
					-> 세션 강제 종료 메서드를 호출한다!
					session.invalidate()
					-> 세션이 유효하지 않게 해라!
				*/
				
				// 세션변수에 사용자 이름을 생성한다!(세션시작!)
				session.setAttribute("name", name);
				// 사용자 권한도 세션 변수에 생성한다!
				session.setAttribute("auth", auth);
				// 페이지 강제이동하기(첫페이지) - Ajax 처리시 불필요
				// response.sendRedirect("../index.jsp");
				
				// 세션,리퀘스트,리스폰스 내장객체는
				// 바로 생성없이 사용할 수 있는 static객체로 설정됨
			
			
			
			
			} //// if /////
			else{ // 비밀번호 불일치로 인한 로그인 실패!!
				out.print("again");
			} ////// else //////
			
			
		} //////////// if //////////////
		else{
			out.print("no");
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