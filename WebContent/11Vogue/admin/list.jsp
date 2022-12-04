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
	<%
		// 세션변수가 셋팅되었고 auth 데이터가 "A" 또는 "S"가
		// 아니면 돌려보내고 맞으면 관리자 환영 메시지를 띄워준다!
		if(session.getAttribute("auth")!=null){
			// 세션변수 가져오기!(이름과 권한)
			String name = session.getAttribute("name").toString();
			String auth = session.getAttribute("auth").toString();
			
			/// 권한자일 경우 if문 //////
			if(auth.equals("A") || auth.equals("S")){
				out.println("<h2 style='text-align:center'>"+ 
				name +" 관리자님 환영합니다!</h2>");
			} /// 권한자일 경우 if문 //////
			else{ // 만약 권한이 없으면 메시지와 함께 다시 첫페이지로!
				out.println("<script>"+
				"alert('권한이 없으므로 본 페이지를 열람할 수 없습니다.');"+
				"location.replace('../index.jsp');"+
				"</script>");
			} //// 권한없는 경우 else문 ///////
			
		} /////// 로그인 사용자 접근 if문 ////////////
		else{ /// 로그인을 안한 경우
			out.println("<script>"+
			"alert('먼저 로그인을 해야합니다!');"+
			"location.replace('../login.jsp');"+
			"</script>");
		} ////////// 로그인을 안한 경우 //////////
	
	
	%>
    
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
        <button id="lobtn">로그아웃</button>

    </div>
    
    <!-- 제이쿼리 라이브러리 -->
    <script src="../js/jquery-3.6.1.min.js"></script>
    <script>
    $(()=>{ ///////// jQB ///////////////
    	// 3. 로그아웃 클릭시 로그아웃하기
        // 주의: linksys.js에 "로그아웃"예외처리필요!
        // 이것을 안해주면 sns중 하나로 분류되어 404새창이 뜸!
        $("#lobtn").click(function(){
            // 비동기통신으로 로그아웃 처리 페이지호출!
            // Ajax - $.post() 로 처리!
            // $.post(호출페이지, 전달변수셋팅, 콜백함수)
            $.post(
              // 1. 호출페이지:현재 admin폴더에서 한단계위로 이동
                "../process/logout.jsp",
                // 2. 전달변수셋팅
                {},
                // 3. 콜백함수
                function(res){// res-결과값
                  res = res.replace(/\s/g,"");
                  console.log("실행결과:", res);
                    if(res==="ok"){

                        // 메시지
                        alert("안전하게 로그아웃 되었습니다!");                          

                        // 첫페이지로 리로드
                        location.replace("../index.jsp");
                        
                    } ////// if ////////////////
                    else{

                        // 메시지
                        alert("로그아웃시 문제가 발생하였습니다!"+res);

                    } ///// else ///////////////
                  

                } /// 콜백함수 ///////

            );///////// Ajax - post /////////
        }) ///// click /////////////////////
    	
    }); ///////////// jQB ///////////////
    </script>






</body>

</html>
