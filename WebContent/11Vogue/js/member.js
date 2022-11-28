// 보그 PJ 회원가입 페이지 JS - member.js

////////// 제이쿼리 코드블록 /////////////
$(() => {
  // 로딩완료
  console.log("로딩완료!");

  /********************************************* 
        [ 사용자 입력폼 유효성 검사 ]
        - 이벤트종류 : blur(포커스가 빠질때 발생)
        - 제이쿼리 이벤트 메서드 : blur()
        - 이벤트 대상:
        -> id가 'email2'가 아니고 class가 'search'가 
        아닌 type이 'text'인 입력요소 input
        과 함께 type이 'password'인 입력요소 input

        ->>>> 제이쿼리 선택표현법:
        input[type=text][id!=email2][class!=search],
        input[type=password]
        >>> 대괄호는 속성선택자(CSS원래문법) 
        != 같지않다(제이쿼리전용)

    *********************************************/
  $(`input[type=text][id!=email2][class!=search],
   input[type=password]`).blur(function () {
    /// 모든공백 제거함수 //////
    // get rid of space -> 공백을 제거하라!
    const groSpace = (cv) => cv.replace(/\s/g, "");
    // 원형: (cv) => {return cv.replace(/\s/g,"");}
    // 정규식: 슬래쉬(/)사이에 표현, \s 스페이스문자
    // g는 모두 찾으라는 global(전역) 플래그문자임
    // -> 플래그문자 Flag String 즉, 표시하면 작동하는 문법

    // 1. 방금 블러가 발생한 요소의 id는?
    let cid = $(this).attr("id");
    // cid는 current id 즉, 현재아이디라는 뜻으로 작명!

    // 2. 블러가 발생한 요소의 입력값은?
    let cv;
    // cv는 current value 즉, 현재값이라는 뜻으로 작명!

    // 2-1.이름일때 앞뒤공백만 제거
    if (cid === "mnm") cv = $(this).val().trim();
    // 2-2.기타경우엔 모든 공백제거
    else cv = groSpace($(this).val());
    // trim() 문자열 앞뒤공백제거 메서드

    // 제거된 공백문자로 입력창에 다시 출력하기
    $(this).val(cv);
    // val(값) -> 값넣기!

    console.log("블러발생!", cid, "/", cv);

    /**************************************** 
            3. 빈값 여부 체크하기
       ****************************************/
    if (cv === "") {
      // 메시지 출력
      $(this).siblings(".msg").text("필수입력!");
      // siblings(요소) - 다른형제요소 중 특정요소선택
      // siblings() - 아무값도 안쓰면 다른형제요소 모두선택

      // 불통과!
      pass = false;
    } /////////// if : 빈값체크 ///////////

    /****************************************************** 
            4. 아이디일 경우 유효성 검사하기
            - 검사기준: 영문자로 시작하는 6~20글자 영문자/숫자
        ******************************************************/
    else if (cid === "mid") {
      // console.log("검사결과:",vReg(cv,cid));

      if (!vReg(cv, cid)) {
        // 불통과시 if안으로 들어오기!
        // false일때 들어오려면 !(NOT)연산자로 결과 뒤집기함!
        // 메시지 띄우기
        $(this)
          .siblings(".msg")
          .text("영문자로 시작하는 6~20글자 영문자/숫자")
          .removeClass("on"); //빨간글자

        // 불통과!
        pass = false;
      } ///////// if : 불통과시 //////////
      else {
        // 검사결과가 통과시 /////
        // 메시지 띄우기
        $(this).siblings(".msg").text("훌륭한 아이디네요~!").addClass("on"); //글자녹색
      } ////////// else : 통과시 ///////////
    } //////////// else if : 아이디검사 /////////////

    /****************************************************** 
            5. 비밀번호일 경우 유효성 검사하기
            - 검사기준: 특수문자,문자,숫자포함 형태의 5~15자리
        ******************************************************/
    else if (cid === "mpw") {
      console.log("검사결과:", vReg(cv, cid));

      if (!vReg(cv, cid)) {
        // 불통과시 if안으로 들어오기!
        // false일때 들어오려면 !(NOT)연산자로 결과 뒤집기함!
        // 메시지 띄우기
        $(this).siblings(".msg").text("특수문자,문자,숫자포함 형태의 5~15자리");

        // 불통과!
        pass = false;
      } ///////// if : 불통과시 //////////
      else {
        // 검사결과가 통과시 /////
        // 메시지 지우기
        $(this).siblings(".msg").empty();
      } ////////// else : 통과시 ///////////
    } //////////// else if : 비밀번호검사 /////////////

    /****************************************************** 
            6. 비밀번호확인일 경우 유효성 검사하기
            - 검사기준: 입력된 비밀번호와 일치여부
        ******************************************************/
    else if (cid === "mpw2") {
      if (cv !== $("#mpw").val()) {
        // 메시지 띄우기
        $(this).siblings(".msg").text("비밀번호가 일치하지 않습니다!");

        // 불통과!
        pass = false;
      } ///////// if : 불통과시 //////////
      else {
        // 검사결과가 통과시 /////
        // 메시지 지우기
        $(this).siblings(".msg").empty();
      } ////////// else : 통과시 ///////////
    } //////////// else if : 비밀번호확인검사 /////////////

    /****************************************************** 
            7. 이메일 유효성 검사하기
            - 검사기준: 이메일 형식에 맞는지 여부검사
        ******************************************************/
    else if (cid === "email1") {
      // 이메일 주소 만들기 : 앞주소@뒷주소
      let comp =
        eml1.val() +
        "@" +
        (seleml.val() === "free" ? eml2.val() : seleml.val());
      // (비?집:놀이동산)
      // 선택박스의 값이 "직접입력"일경우(value가 "free")
      // 이메일 뒷주소가 입력창input#email2의 값을 읽어가고
      // 아니면 선택박스(#seleml)값을 넣는다!
      console.log("이메일주소:", comp);

      // 이메일 검사함수 호출하기!
      resEml(comp);
    } //////////// else if : 이메일검사 ////////////////

    //////////// 만약 통과시 메시지 지우기 //////////
    else {
      // 메지시 지우기
      $(this).siblings(".msg").empty();
      // empty() 내용지우기 메서드
    } /////// else : 통과시 /////////////
  }); ////////////////// blur ///////////////////

  ////// 이메일 관련 대상선정 ///////////
  // 이메일 앞주소
  let eml1 = $("#email1");
  // 이메일 뒷주소
  let eml2 = $("#email2");
  // 이메일 선택박스
  let seleml = $("#seleml");
  ///////////////////////////////////////

  /********************************************* 
         선택박스 변경시 이메일 검사하기
         _____________________________

         검사시점: 선택박스 변경할때
         이벤트 : change -> 제이쿼리 change() 메서드
         이벤트 대상: #seleml -> seleml변수

    *********************************************/
  seleml.change(function () {
    // 1. 선택박스 변경된 값 읽어오기
    let cv = $(this).val();
    console.log("선택값:", cv);

    // 2. 선택옵션별 분기문
    if (cv === "init") {
      // "선택해주세요"

      // 1. 메시지 출력
      eml1.siblings(".msg").text("이메일 옵션 선택필수!").removeClass("on");

      // 2. 직접입력창 숨기기
      eml2.fadeOut(300);
    } /////// if : 선택해주세요 /////////
    else if (cv === "free") {
      // "직접입력"

      // 1. 직접입력창 보이기
      eml2.fadeIn(300).val("").focus();
      // val(값) ->  입력창에 값넣기(빈값은 비우기)
      // focus() -> 입력창에 포커스(커서깜박임!)

      // 2. 메시지 지우기
      eml1.siblings(".msg").empty();
    } //////// else if : 직접입력 //////////
    else {
      // 기타 이메일 주소 선택시 ///////

      // 1. 직접입력창 숨기기
      eml2.fadeOut(300);

      // 2. 이메일 전체주소 조합하기
      let comp = eml1.val() + "@" + cv;
      // cv는 select의 선택옵션값

      // 3. 이메일 검사함수 호출하기
      resEml(comp);
    } ///////// else : 기타 이메일주소 ////////
  }); ///////////// change /////////////////////
  ///////////////////////////////////////////////

  /******************************************** 
        키보드 입력시 이메일 체크하기
        ____________________________

        - 키보드 관련 이벤트 : keypress, keyup, keydown
        1. keypress : 키가 눌렸을때
        2. keyup : 키가 눌렸다가 올라올때
        3. keydown : 키가 눌려져서 내려가있을때
        -> 과연 글자가 입력되는 순간은 어떤 키보드 이벤트가
        적용되는 걸까?
        ->>>>>>>>> keyup!!!

        - 이벤트 대상: #email1, #email2
        -> 모든 이벤트를 함수와 연결하는 메서드는?
        on(이벤트명,함수) -> 제이쿼리 메서드!

    ********************************************/
  $("#email1,#email2").on("keyup", function () {
    // 1. 현재 이벤트 대상 아이디 읽어오기
    let cid = $(this).attr("id");

    // 2. 현재 입력된 값 읽어오기
    let cv = $(this).val();
    console.log("입력아이디:", cid, "\n입력값:", cv);

    // 3. 이메일 뒷주소 셋팅하기
    let backeml = cid === "email1" ? seleml.val() : eml2.val();
    // 변수 = 조건연산자
    // 변수 = 조건식 ? 값1 : 값2
    // -> 조건연산자에서 결정된 값이 변수에 할당된다!
    // 조건: email1인가? 즉 앞주소인가?
    // 맞으면 선택박스값을 읽어가고 아니면 직접입력창임!

    // 4. 선택박스값이 "free"(직접입력)이면
    // 이메일 뒷주소로 변경함!
    if (seleml.val() === "free") backeml = eml2.val();

    // 5. 이메일 전체주소 조합하기
    let comp = eml1.val() + "@" + backeml;
    console.log("이메일주소:", comp);

    // 6. 이메일 유효성 검사함수 호출하기!
    resEml(comp);
  }); //////////////// keyup ///////////////////
  //////////////////////////////////////////////

  /**************************************** 
             함수명: resEml (result Email)
             기능: 이메일 검사결과 처리
    ****************************************/
  const resEml = (comp) => {
    // comp - 완성된 이메일 주소

    // 이메일 정규식 검사
    // 통과시 //////////////////////
    // vReg(검사할값,검사항목)
    if (vReg(comp, "eml")) {
      // 메시지 띄우기
      eml1.siblings(".msg").text("적합한 이메일 형식입니다!").addClass("on");
    } ///////// if : 통과시 ///////////
    else {
      /////// 불통과시 ////////////
      // 메시지 띄우기
      eml1
        .siblings(".msg")
        .text("맞지않는 이메일 형식입니다!")
        .removeClass("on");

      // 불통과!
      pass = false;
    } ////////// else : 불통과시 ///////////
  }; ////////////// resEml 함수 ///////////////
  /////////////////////////////////////////////

  /********************************************** 
        가입하기(submit) 버튼 클릭시 처리하기 
        __________________________________

        전체검사의 원리:
        전역변수 pass를 설정하여 true를 할당하고
        검사중간에 불통과 사유발생시 false로 변경!
        유효성 검사 통과여부를 판단한다!

        검사방법:
        기존 이벤트 blur 이벤트를 강제로 발생시킨다!
        이벤트 강제발생 메서드는? -> trigger(이벤트명)
    **********************************************/
  // 검사용 변수
  let pass;

  // 이벤트 대상: 서브밋 버튼 -> #btnj
  // 원래 서브밋 버튼은 클릭시 싸고 있는 form태그의
  // action속성에 지정되어 있는 페이지로 현재 페이지의
  // input요소들의 값을 가지고 이동하게 되어 있다!
  // 여기서는 버튼 클릭시 통과 여부 체크를 위해
  // 이것을 막는다!
  $("#btnj").click((e) => {
    // 0. 호출확인!
    console.log("가입해!");

    // 1. 기본이동막기
    e.preventDefault();

    // 2. pass 통과여부 변수에 true를 할당!
    // 처음에 true로 시작하여 검사 중간에 한번이라도
    // false로 할당되면 결과는  false다!
    pass = true;

    // 3. 입력창 blur 이벤트 강제발생시키기!
    // 대상: 블러 이벤트를 발생했던 요소들!
    $(`input[type=text][id!=email2][class!=search],
        input[type=password]`).trigger("blur");

    // 최종통과 여부
    console.log("통과여부:", pass);

    // 4. 검사결과에 따라 메시지 보이기
    if (pass) {
      //// 통과시 //////
      /******************************************** 
        [ Ajax를 이용한 POST방식으로 DB에
        데이터 입력하기!!! ]
        ___________________________________

        AJAX = Asynchronous JavaScript and XML

        - 비동기통신이란? 쉽게 말해서 페이지가
        새로고쳐지지 않고 그대로 있으면서 일부만
        서버통신을 하는 것을 말한다!

        - 제이쿼리는 POST방식으로 ajax를 할 수 있다!

        [ POST 방식 Ajax 메서드 ]
        $.post(URL,data,callback)
        $.post(전송할페이지,전송할데이터,전송후실행함수)
        
    
    ********************************************/

      $.post(
        //1. 전송할페이지
        "process/ins.jsp",
        //2. 전송할데이터
        {
          // 1. 아이디
          mid: $("#mid").val(),
          // 2.비번
          mpw: $("#mpw").val(),
          // 3.이름
          mnm: $("#mnm").val(),
          // 4.성별(라디오버튼)
          gen: $(":radio[name=gen]:checked").val(),
          // 5-1.이메일 앞주소
          email1: $("#email1").val(),
          // 5-2.이메일 뒷주소
          seleml: $("#seleml").val(),
          // 5-3.직접입력 이메일 뒷주소
          email2: $("#email2").val(),
        },
        //3. 전송후실행함수
        function (res) {
            res = res.replace(/\s/g,"");
          console.log("실행결과:", res);
          if (res === "ok") {
            /// 성공시 ////
            // 메시지 띄우기
            alert("회원가입을 축하드립니다! 짝짝짝!");
            // 원래는 post방식으로 DB에 회원정보를 입력후
            // DB에 입력완료시 위의 메시지를 띄워준다!

            // 로그인 페이지로 이동!
            location.replace("login.jsp");
            // location.href = 'login.php';
            /* 
                회원가입 후 이전페이지로 못가도록
                location.replace(주소) 를 사용하여
                페이지 캐쉬를 삭제하도록하여
                좀 더 안전한 보안을 유지한다!
            */
          } //////// if : 성공시 ///////
          else {
            ///////// 실패시 ///////
            alert("웹마스터에게 문의바랍니다!"+ res);
          } //////// else : 실패시 ////////
        } /////// 콜백함수 /////////
      ); ///////// Ajax POST ///////////////

      // 메시지 띄우시
      //alert("회원가입을 축하드립니다! 짝짝짝!!!");
      // 원래는 post방식으로 DB에 회원정보를 입력후
      // DB에 입력완료시 위의 메시지를 띄워준다!
      //$(".logF").submit();
    } ///////// if ///////////
    else {
      //// 불통과시 //////

      alert("입력을 수정하세요~!");
    } /////// else ///////////
  }); ///////////// click //////////////////
}); ///////////// jQB //////////////////

/*////////////////////////////////////////////////////////
    함수명: vReg (validation with Regular Expression)
    기능: 값에 맞는 형식을 검사하여 리턴함
    (주의: 정규식을 따옴표로 싸지말아라!-싸면문자가됨!)
*/ ////////////////////////////////////////////////////////
function vReg(val, cid) {
  // val - 검사할값, cid - 처리구분아이디
  // //console.log("검사:"+val+"/"+cid);

  // 정규식 변수
  let reg;

  // 검사할 아이디에 따라 정규식을 변경함
  switch (cid) {
    case "mid": // 아이디
      reg = /^[a-z]{1}[a-z0-9]{5,19}$/g;
      // 영문자로 시작하는 6~20글자 영문자/숫자
      // /^[a-z]{1} 첫글자는 영문자로 체크!
      // [a-z0-9]{5,19} 첫글자 다음 문자는 영문 또는 숫자로
      // 최소 5글자에서 최대 19글자를 유효범위로 체크!
      // 첫글자 한글자를 더하면 최소 6글자에서 최대 20글자체크!
      break;
    case "mpw": // 비밀번호
      reg = /^.*(?=^.{5,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
      // 특수문자,문자,숫자포함 형태의 5~15자리
      // (?=^.{5,15}$) 시작부터 끝까지 전체 5~15자릿수 체크!
      // (?=.*\d) 숫자 사용체크!
      // (?=.*[a-zA-Z]) 영문자 대문자 또는 소문자 사용체크!
      // (?=.*[!@#$%^&+=]) 특수문자 사용체크!
      break;
    case "eml": // 이메일
      reg =
        /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
      // 이메일 형식에 맞는지 검사하는 정규식
      break;
  } //////////// switch case문 //////////////////

  // //console.log("정규식:"+reg);

  // 정규식 검사를 위한 JS메서드
  // -> 정규식.test(검사할값) : 결과 true/false
  return reg.test(val); //호출한 곳으로 검사결과리턴!
} //////////// vReg 함수 //////////////////////////////////
///////////////////////////////////////////////////////////
