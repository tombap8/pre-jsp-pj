<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<!-- DB연결 객체 임포트 필수! -->
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>드라마 데이터 조회/수정/삭제하기</title>
<link rel="stylesheet" href="css/drama.css">
<style>
body {
	text-align: center;
}

body, input {
	font-size: 26px;
}

label {
	display: block;
	margin: 25px 0;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(function() { /// jQB //////////////////
		// 수정하기 버튼
		$("#mbtn").click(function(e) {

			// 전송기능막기!
			e.preventDefault();

			// 각 항목이 비었는지 검사하기
			let res = true;//검사결과
			// 흰손수건의 법칙! 한번만 false여도 false!

			$("input[type=text]").each(function(idx, ele) {
				//console.log("순번:"+idx);

				// 각 입력양식 값이 빈값여부체크
				if ($(ele).val().trim() === "")
					res = false;

			});////// each /////////

			console.log("검사결과:" + res);

			/// 검사결과 모든 항목이 통과면 서브밋하기
			if (res) {
				$("#dform").submit();
				// 서브밋하면 form요소에 action속성에 지정된 
				// 페이지로 데이터와 함께 이동한다!
				// 서브밋(submit)은 "데이터 전송"의 의미를 가짐!
			}/////// if //////////
			/// 불통과시 메시지 보이기 /////
			else {
				alert("모든항목이 필수입니다!");
			}/////// else ////////////

		});////// click //////////////

		/// 삭제버튼 클릭시 ///////////
		$("#dbtn").click(
				function(e) {

					// 전송기능막기!
					e.preventDefault();

					let conf = confirm("정말 삭제하시겠습니까?");
					// confirm(메시지)
					// "확인"클릭시 true, "취소"클릭시 false 리턴
					console.log("삭제여부:", conf);

					// 분기하기(true일경우)
					if (conf) {
						// 삭제처리 페이지로 보내기!
						location.href = 
							"process/del.jsp?idx="
							+ $(this).attr("data-idx");
						// 클릭된버튼의 data-idx 속성값을 뒤에 붙여서 보낸다!
					} ////// if //////////

				}); /////// click ///////////////

		// 리스트가기 버튼 클릭시 //////
		$("#lbtn").click(function(e) {

			// 전송기능막기!
			e.preventDefault();

			// 리스트 페이지로 이동!
			location.href = "list.jsp";
		}); //////// click /////////////

	});////////// jQB //////////////////////
</script>
</head>
<body>
	<h1>드라마 데이터 조회·수정·삭제하기</h1>

	<%
		// 파라미터 받기(모든 파라미터는 숫자가 넘어와도 모두 문자형이다!)
	// idx값을 받아서 본 페이지에서 활용한다!
	String idnum = request.getParameter("idx");
	out.println("넘어온 레코드 idx키값:" + idnum);

	// try문 바깥에 선언하여 아래 html에서 사용할 수 있다!
	String dname = "";
	String actors = "";
	String broad = "";
	String gubun = "";
	String stime = "";
	String total = "";

	try {
		// 1. DB 연결 문자열값 만들기!
		String DB_URL = "jdbc:mysql://localhost:3306/mydb";
		// 형식 -> jdbc:db시스템종류://db아이피/db이름
		// MySQL -> jdbc:mysql://localhost:3306/mydb

		// 참고) 오라클 JDBC 드라이버 로드 문자열
		// Oracle -> jdbc:oracle:thin:@localhost:1521:xe

		// 2. DB 아이디계정 : root는 슈퍼어드민 기본계정임
		String DB_USER = "root";

		// 3. DB 비밀번호 : root는 최초에 비밀번호가 없음
		String DB_PWD = "";

		// 4. 연결객체 선언
		Connection conn = null;

		// 5. 쿼리문 저장객체
		PreparedStatement pstmt = null;

		// 6. 결과저장 객체
		ResultSet rs = null;

		// 7. 쿼리문작성 할당
		String query = "SELECT * FROM `drama_info` WHERE `idx`=?";
		// 해당 유일키 idx값을 넣어서 선택하면 하나의 레코드만 선택된다!
		// 데이터가 들어갈 자리만 물음표(?)로 처리하면 끝!

		// 8. DB 종류 클래스 등록하기 -> 해당 연결 드라이브 로딩!
		Class.forName("com.mysql.jdbc.Driver");
		// lib폴더의 jar파일과 연결!

		// 9. DB연결하기
		conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PWD);

		// 10. 성공메시지띄우기
		out.println("DB연결 성공하였습니다!");

		// 11. 쿼리문 연결 사용준비하기
		// conn연결된 DB객체
		pstmt = conn.prepareStatement(query);
		// prepareStatement(쿼리문변수)
		// - 쿼리문을 DB에 보낼 상태완료!
		// - 중간에 쿼리문에 넣을 값을 추가할 수 있음!

		// 12. 쿼리에 추가할 데이터 셋팅하기!
		// -> 파라미터값이 숫자지만 String이므로 형변환 해야함!
		// 문자형을 숫자형으로 변환: Integer.parseInt(변수)
		pstmt.setInt(1, Integer.parseInt(idnum));
		// 형변환시 에러가 발생할 수 있으므로 try,catch문 안에서 변환한다!

		// 13. 쿼리를 DB에 전송하여 실행후 결과집합(결과셋)을 가져옴!
		// ResultSet객체는 DB에서 쿼리결과를 저장하는 객체임!
		rs = pstmt.executeQuery();
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
		while (rs.next()) {
			dname = rs.getString("dname");
			actors = rs.getString("actors");
			broad = rs.getString("broad");
			gubun = rs.getString("gubun");
			stime = rs.getString("stime");
			total = rs.getString("total");
		} //////////// while //////////////

		// 14. 연결해제하기
		rs.close();
		pstmt.close();
		conn.close();

	} //// try /////
	catch (Exception e) {
		// DB연결 실패시 여기로 들어옴!
		out.println("에러메시지:");
		out.println(e.toString());
		// toString() 문자데이터로 변환하는 메서드
	} ///// catch //////
	%>

	<!-- 수정처리 페이지인 mod.jsp에 idx값을 전달한다! -->
	<form action="process/mod.jsp?idx=<%=idnum%>" method="post" id="dform">

		<label for="dname">드라마명</label> <input type="text" name="dname"
			id="dname" maxlength="100" value="<%=dname%>"> <label
			for="actors">주연</label> <input type="text" name="actors" id="actors"
			maxlength="100" value="<%=actors%>"> <label for="broad">제작사</label>
		<input type="text" name="broad" id="broad" maxlength="50"
			value="<%=broad%>"> <label for="gubun">구분</label> <input
			type="text" name="gubun" id="gubun" maxlength="10" value="<%=gubun%>">
		<label for="stime">방영시간</label> <input type="text" name="stime"
			id="stime" maxlength="50" value="<%=stime%>"> <label
			for="total">방영횟수</label> <input type="text" name="total" id="total"
			maxlength="20" value="<%=total%>"> <br> <br>
		<!-- 수정하기 버튼 -->
		<input type="submit" value="수정하기" id="mbtn">
		<!-- 삭제하기 버튼 : 클릭시 데이터속성 data-idx의 해당순번을 읽어간다 -->
		<input type="submit" value="삭제하기" id="dbtn" data-idx="<%=idnum%>">
		<!-- 리스트가기 버튼 -->
		<input type="submit" value="리스트가기" id="lbtn">
		<!--
           form요소 내부의 submit버튼을 클릭하면
           form요소에 셋팅된 action속성의 페이지로
           전송된다!
       -->
	</form>







</body>
</html>