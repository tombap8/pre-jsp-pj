<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
/////////////////////////////////////////////////////////////
	// JSP 세션이 셋팅된 경우에 if문 중괄호 안이 표현됨
	if (session.getAttribute("name") != null) {
		// 중괄호열고 맨 아래 JSP코드블럭에 중괄호를 닫았음
		// 이 방법은 중간에 html,css,js를 그대로 코딩해서
		// 화면에 바로 출력 시키는 방법이다!(out.print로 출력시 복잡함!)
/////////////////////////////////////////////////////////////
%>
<script>
  /*/////////////////////////////////////////////////
    함수명: loginSet
    기능: JSP코드에서 세션변수로 셋팅된 값을 화면에 반영한다
  *//////////////////////////////////////////////////
  function loginSet(msg, auth){// msg-메시지, auto-권한
      // JSP에서 이 함수를 호출할 예정!
      // 따라서 내부의 실행코드는 html이 로딩된 후 실행해야함!
      // 그래서 반드시 제이쿼리 실행구역으로 싸줘야함!!!
      $(function(){ /// jQB //////////////////

          // 콘솔창에 전달값을 찍어봄!
          console.log(msg+"/"+auth);

          // 1. 로그인 환영 메시지 출력하기
          $("#loginMsg").text(msg);

          // 2. 로그인 버튼을 로그아웃 버튼으로 변경하기
          // 대상: .sns a:nth-child(5)
          $(".sns a").eq(4)
          .attr("title","로그아웃")
          .css("color","hotpink")

          // 3. 로그아웃 클릭시 로그아웃하기
          // 주의: linksys.js에 "로그아웃"예외처리필요!
          // 이것을 안해주면 sns중 하나로 분류되어 404새창이 뜸!
          .click(function(){
              // 비동기통신으로 로그아웃 처리 페이지호출!
              // Ajax - $.post() 로 처리!
              // $.post(호출페이지, 전달변수셋팅, 콜백함수)
              $.post(
                // 1. 호출페이지
                  "process/logout.jsp",
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
                          location.replace("index.jsp");
                          
                      } ////// if ////////////////
                      else{

                          // 메시지
                          alert("로그아웃시 문제가 발생하였습니다!"+res);

                      } ///// else ///////////////
                    

                  } /// 콜백함수 ///////

              );///////// Ajax - post /////////
          }) ///// click /////////////////////
          .find("span").text("로그아웃");
          // 내부 숨긴 글자도 "로그아웃"으로 변경함!
          // 그래야 common.js의 링크 "로그인"처리가 적용안됨!

          // 4. 회원가입 버튼 제거하기
          // 대상: .sns a:eq(5)
          $(".sns a").eq(5).remove();
          
        // 5. auth 권한 값이 "A"일 경우 
        //    "생성하여 추가하기
        // 대상: .sns a:eq(4관리자" 메뉴 ) 로그인버튼 다음에 추가!
        if (auth === "A" || auth === "S") {
            $(".sns a").eq(4)
                .after(`
                  <a href="#" class="fi fi-user-secret" title="관리자" style="color:red">
                      <span class="ir">
                          관리자
                      </span>
                  </a>
                `);

                // 추가된 관리자 버튼에 링크셋팅!
                $(".sns a").eq(5)
                .click(()=>location.href="admin/list.jsp");
                
        } /////////// if /////////////////



      });////////// jQB //////////////////////

  }////////// loginSet 함수 /////////////////////////
  //////////////////////////////////////////////////

  /// 로그인 메시지 박스 만들기 ////
  $(function(){ /// jQB //////////////////
    // 1. 상단영역(#top)에 로그인 박스넣기
      $("#top").append('<div id="loginMsg"></div>');
      // 2. 로그인 박스 CSS 디자인하기
      $("#loginMsg").css({
          position: "absolute",
          width: "400px",
          top: "5%",
          left: "50%",
          transform: "translateX(-50%)",
          fontSize: "14px",
          fontWeight: "bold",
          textAlign: "center",
          whiteSpace: "nowrap",
          zIndex:"-1"
      }); ////// css //////////


  });////////// jQB //////////////////////


</script>
<%
/////////////////////////////////////////////////////////////
	// 권한 세션값 읽어오기 : 먼저 값을 읽고 권한중 "A"또는"S"이면 
	// 환영메시지에 "관리자"라는 말을 추가해준다!
	String auth = session.getAttribute("auth").toString();

	// 어드민이면 "관리자" 할당!
	String admin = " 회원"; // 일반회원은 "회원님...으로출력"
	if(auth.equals("A") || auth.equals("S")) admin = " 관리자";
	
	// 메시지 세션값 읽어오기 - session.getAttribute() 사용
	String msg = session.getAttribute("name") + admin + "님, 환영합니다!";
	// 로그인 셋팅 JS함수 호출하기!!!
	// 위쪽에 출력되는 JS함수를 호출함
	// loginSet(메시지,권한)
	out.print("<script>loginSet('" + msg + "','" + auth + "');</script>");

} /////// if //////////////
// 맨위에서 열어놓은 if문이 여기서 닫힘! 여기까지 세션셋팅시 출력됨!
////////////////////////////////////////////////////////////////
%>
