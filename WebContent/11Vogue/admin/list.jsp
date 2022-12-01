<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vogue.ListController"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>보그PJ - 회원관리 리스트</title>
    <link rel="stylesheet" href="css/main.css">

</head>

<body>
    
    <!--My Item 회원 리스트 테이블-->
    <table id="drama" class="tbl">
        <!--테이블제목-->
        <caption>My Item 회원 리스트</caption>
        <!--테이블 머릿줄-->
        <thead>
            <tr>
                <!--머릿글은 td대신 th를 씀-->
                <th>번호</th>
                <th>아이디</th>
                <th>이름</th>
                <th>성별</th>
                <th>이메일</th>
                <th>권한</th>
            </tr>
        </thead>
        <%
			/////// 동적 데이터 바인딩 영역 //////////

		// POST 방식의 한글처리
		request.setCharacterEncoding("UTF-8");
		
		// 페이지번호 파라미터 받기(만약없으면 null이므로 "1"할당!)
		String pgNum = request.getParameter("pgnum");
		if(pgNum==null) pgNum="1";
		
		// 리스트 컨트롤러 생성하기 ////
		ListController listcon = new ListController(); 

		
		/////////////////////////////////////////////////
		%>

        <!--테이블 본문-->
        <!--tbody는 일반 테이블에 안써도 출력됨-->
        <tbody>
            <%=listcon.setList(pgNum)%>
        </tbody>
        
        <!--테이블 끝줄-->
        <tfoot>
            <tr>
                <td colspan="6">◀ <%=listcon.setPaging()%> ▶</td>
            </tr>
        </tfoot>
   
    </table>



    <!--구분테이블 박스-->
    <div class="gubun">
        <!--구분테이블 삭제-->

        <!--입력페이지이동-->
        <button onclick="location.href='../index.jsp'" style="float:right;">사이트로 돌아가기</button>
        <br>
        <!--로그아웃버튼-->
        <button onclick="logout()">로그아웃</button>

    </div>






</body>

</html>
