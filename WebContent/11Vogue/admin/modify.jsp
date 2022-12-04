<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- DB연결 객체 임포트 필수! -->
<%@page import="common.JDBConnector"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원권한 수정하기</title>
    <style>
        body{
            text-align: center;
            font-size: 20px;
        }
        
        label{
            display: block;
            margin-top: 15px;
        }
        
        input, select{
            font-size: 20px;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
    $(function(){ /// jQB //////////////////
        $("#sbtn").click(function(e){
            
            // 전송기능막기!
            e.preventDefault();
            
            $("#dform").submit();
            // 서브밋하면 form요소에 action속성에 지정된 
            // 페이지로 데이터와 함께 이동한다!
            // 서브밋(submit)은 "데이터 전송"의 의미를 가짐!
           
            
        });////// click //////////////
       
        
        /// 리스트로 돌아가기 버튼 //////
        $("#lbtn").click(function(){
            history.back();
            //이전 페이지로 돌아가기
            // 좀전에 보던 리스트 페이지로 가야함!
        });////////// click ////////////////
        ////////////////////////////////////
        
        
        
    });////////// jQB //////////////////////
    </script>
</head>
<body>
   <h1>회원권한 수정하기</h1>
   <%
   	// JDBConnector 객체생성하기
   	JDBConnector jdbc = new JDBConnector();
   
		// 파라미터 받기(모든 파라미터는 숫자가 넘어와도 모두 문자형이다!)
	// idx값을 받아서 본 페이지에서 활용한다!
	String idnum = request.getParameter("idx");
	out.println("넘어온 레코드 idx키값:" + idnum);
	String pgnum = request.getParameter("pgnum");
	out.println("넘어온 페이지번호값:" + pgnum);

	// try문 바깥에 선언하여 아래 html에서 사용할 수 있다!
	String mid = "";
	String name = "";
	String gen = "";
	String email1 = "";
	String email2 = "";
	String auth = "";

	try {
		

		// 7. 쿼리문작성 할당
		String query = "SELECT * FROM `member` WHERE `idx`=?";
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
		jdbc.pstmt.setInt(1, Integer.parseInt(idnum));
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
		while (jdbc.rs.next()) {
			mid = jdbc.rs.getString("mid");
			name = jdbc.rs.getString("name");
			gen = jdbc.rs.getString("gen");
			email1 = jdbc.rs.getString("email1");
			email2 = jdbc.rs.getString("email2");
			auth = jdbc.rs.getString("auth");
		} //////////// while //////////////

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
      
       <label for="mid">아이디</label>
       <input type="text" name="mid" id="mid" maxlength="100" value="<%=mid %>" disabled>
       
       <label for="name">이름</label>
       <input type="text" name="name" id="name" maxlength="100" value="<%=name %>" disabled>
       
       <label for="gen">성별</label>
       <input type="text" name="gen" id="gen" maxlength="50" value="<%=gen %>" disabled>
       
       <label for="email">이메일</label>
       <input type="text" name="email" id="email" maxlength="10" value="<%=email1%>@<%=email2%>" disabled>
       
   <form action="process/mod.jsp?idx=<%=idnum %>&pgnum=<%=pgnum %>" method="post" id="dform">
      <!--form요소로 싸고 있는 input요소의 값만 보낼 수 있다!-->
      
       <label for="auth">권한</label>
       <select name="auth" id="auth">
           <option value="S">최고관리자</option>
           <option value="A">관리자</option>
           <option value="M">일반회원</option>
       </select>
       
       <%
       		// DB에서 가져온 auth권한으로 select박스의 선택을 바꿔준다!
       		out.print("<script>"+
       		"$('#auth').val('"+auth+"')"+
       		".prop('selected',true)"+
       		"</script>");
    		 // 제이쿼리 메서드 : prop(속성,true/false)
    		 // 선택select박스.prop("selected",true) -> 선택박스의 선택변경
       %>
       
       
       <!--히든필드!!! "idx"컬럼값 넣기(POST방식으로 함께보냄)-->
       <input type="hidden" name="num" id="num" value="">
       
       <br><br>       
       <input type="submit" value="권한수정하기" id="sbtn">
       <!--
           form요소 내부의 submit버튼을 클릭하면
           form요소에 셋팅된 action속성의 페이지로
           전송된다!
       -->
       
       <br><br>
       <!--리스트로 돌아가기-->
       <input type="button" value="리스트로 돌아가기" id="lbtn">
   </form>
   
</body>
</html>