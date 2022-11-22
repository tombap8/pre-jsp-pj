<%@page import="common.Paging"%>
<%@page import="common.JDBConnector"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>한국 최신 드라마 리스트</title>
<link rel="stylesheet" href="css/drama.css">
</head>
<body>
	<!-- 한국 최신 드라마 리스트 -->
	<table class="tbl" id="drama">
		<!-- 
           테이블 기본 사이간극은
           border="1" 속성을 넣고 확인해 본다!
           없애려면 CSS에서
           border-collapse:collapse 설정함!
        -->
		<!-- 1.테이블제목 -->
		<caption>한국 최신 드라마 리스트</caption>
		<!-- 2.테이블 머릿부분 -->
		<thead>
			<tr>
				<th>번호</th>
				<th>드라마명</th>
				<th>주연</th>
				<th>제작사</th>
				<th>구분</th>
				<th>방영시간</th>
				<th>방영횟수</th>
			</tr>
		</thead>

		<%
			/////// 동적 데이터 바인딩 영역 //////////

		// POST 방식의 한글처리
		request.setCharacterEncoding("UTF-8");

		// DB레코드결과변수
		String result = "";

		// 연결 클래스 생성
		JDBConnector jdbc = new JDBConnector();
		// 패이징 클래스 생성
		Paging paging = new Paging();
		
		try {

			// 7. 쿼리문작성 할당
			String query = "SELECT * FROM `drama_info` ORDER BY `idx` DESC LIMIT ?,?";

			// 11. 쿼리문 연결 사용준비하기
			// conn연결된 DB객체
			jdbc.pstmt = jdbc.conn.prepareStatement(query);
			// prepareStatement(쿼리문변수)
			// - 쿼리문을 DB에 보낼 상태완료!
			// - 중간에 쿼리문에 넣을 값을 추가할 수 있음!

			/**************************************** 
			[ 페이징 변수처리전 페이지번호로 시작번호 변경하기 ]
			*****************************************/
			paging.startNum =
			paging.changeStartNum(request.getParameter("pgnum"));

			/****************************************
				12. 페이징 변수 처리하기
			*****************************************/
			// LIMIT 쿼리의 시작번호셋팅
			jdbc.pstmt.setInt(1, paging.startNum);
			// LIMIT 쿼리의 개수셋팅
			jdbc.pstmt.setInt(2, paging.onePageCnt);

			// 13. 쿼리를 DB에 전송하여 실행후 결과집합(결과셋)을 가져옴!
			// ResultSet객체는 DB에서 쿼리결과를 저장하는 객체임!
			jdbc.rs = jdbc.pstmt.executeQuery();
			// executeQuery() 쿼리실행 메서드

			// 일련번호용 변수
			// 페이지에 따른 시작일련번호 구하기
			int listNum = 1;
			if(paging.startNum != 1) 
				listNum = (paging.pageSeq-1) * paging.onePageCnt + 1;
				// (2-1) * 3 + 1 = 4
				// (3-1) * 3 + 1 = 7
				// (4-1) * 3 + 1 = 10

			/// 결과셋에 레코드가 있는 동안 계속 순회함!
			// rs.getString(컬럼명)
			// -> 문자형일 경우 getString(), 숫자형은 getInt()
			// -> 컬럼명은 DB 테이블에 실제로 생성된 컬럼명이다!
			while (jdbc.rs.next()) {
				// += 대입연산자로 기존값에 계속 더함!
				result += "<tr>" + "   <td>" + listNum + "</td>" +
				// "   <td>"+rs.getInt("idx")+"</td>"+
				// 일련번호는 DB의 idx 기본키를 쓰지 않고
				// 반복되는 동안 순번을 만들어서 사용한다!
				"   <td><a href='modify.jsp?idx=" + jdbc.rs.getInt("idx") + "'>" +
				// 조회수정 페이지인 modify.jsp로 갈때
				// ?idx=유일키값 : Get방식으로 전송함!
				jdbc.rs.getString("dname") + "</a></td>" + "   <td>" + jdbc.rs.getString("actors") + "</td>" + "   <td>"
				+ jdbc.rs.getString("broad") + "</td>" + "   <td>" + jdbc.rs.getString("gubun") + "</td>" + "   <td>"
				+ jdbc.rs.getString("stime") + "</td>" + "   <td>" + jdbc.rs.getString("total") + "</td>" + "</tr>";

				// 일련번호증가
				listNum++;

			} //////////// while //////////////

			// 16. 연결해제하기
			jdbc.close();

		} //// try /////
		catch (Exception e) {
			// DB연결 실패시 여기로 들어옴!
			out.println("에러메시지:");
			out.println(e.toString());
			// toString() 문자데이터로 변환하는 메서드
		} ///// catch //////

		/////////////////////////////////////////////////
		%>

		<!-- 3.테이블 메인부분 -->
		<tbody>
			<%=result%>
		</tbody>

		<!-- 4.테이블 하단부분-->
		<tfoot>
			<tr>
				<td colspan="7">◀ <%=paging.makePaging()%> ▶
				</td>
			</tr>
		</tfoot>
	</table>

	<!-- 입력페이지 이동버튼 -->
	<div class="gubun" onclick="location.href='insert.jsp'"
		style="text-align: right; margin-bottom: 50px;">
		<button style="font-size: 24px;">입력하기</button>
	</div>

	<!-- 구분테이블 박스 -->
	<div class="gubun">
		<table class="tbl" id="gubun">
			<tr>
				<td rowspan="4">구분</td>
				<td>월화:월화드라마</td>
			</tr>
			<tr>
				<td>수목:수목드라마</td>
			</tr>
			<tr>
				<td>금토:금토드라마</td>
			</tr>
			<tr>
				<td>토일:토일드라마</td>
			</tr>
		</table>
	</div>

</body>
</html>