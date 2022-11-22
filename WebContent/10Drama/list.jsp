<%@page import="common.Paging"%>
<%@page import="common.PagingDTO"%>
<%@page import="drama.ListController"%>
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

		// 페이지 번호 파라미터
		String pgnum = request.getParameter("pgnum");
		if (pgnum == null)
			pgnum = "1";
		
		// 리스트 컨트롤러 생성
		ListController listCon = new ListController();
		
		// 페이징 생성
		Paging paging = new Paging();

		/////////////////////////////////////////////////
		%>

		<!-- 3.테이블 메인부분 -->
		<tbody>
			<%=listCon.setList(pgnum)%>
		</tbody>

		<!-- 4.테이블 하단부분-->
		<tfoot>
			<tr>
				<td colspan="7">◀ <%=paging.makePaging()%> ▶</td>
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