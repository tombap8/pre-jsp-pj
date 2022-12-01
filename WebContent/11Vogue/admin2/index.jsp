<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>My Item 회원 리스트</title>
    <style>
        /*테이블 공통 디자인*/
        .tbl {
            /*글자체*/
            font-family: "맑은 고딕", "굴림";
            /*글자크기*/
            font-size: 18px;
            /*글자색*/
            color: #222;

            /*테이블에는 기본적으로 간극이 존재한다.
            이것을 border-collapse 로 없애야함!*/
            border-collapse: collapse;
            /*사이간극이 무너짐!*/


        }

        /*개별테이블*/
        #drama {
            /*테이블 중앙정렬*/
            margin: 0 auto;
            /*테이블도 마영오가 된다!*/
            max-width: 990px;
            /*최대사이즈 지정, 화면이 작아지면 
            자동으로 화면만큼 작아짐*/
        }

        /*테이블 타이틀*/
        #drama caption {
            font-size: 24px;
            font-weight: bold;
            padding: 10px 0;
        }

        /**/
        #drama td,
        #drama th {
            padding: 5px 10px;
            /*
                [안쪽 여백 설정방법]
                padding : 4방향;(1개)
                padding: 위아래 양쪽;(2개)
                padding: 위 양쪽 아래;(3개)
                padding: 위 오른 아래 왼;(4개)
            */
        }

        /*td에 밑줄넣기*/
        #drama tbody tr td {
            border-bottom: 1px solid #ccc;

            /*
                border 경계선
                따로 설정시엔
                border-width(선두께)
                border-style(선종류)
                border-color(선색상)
            
                한번에
                border : 두께 종류 색상;
                1) 두께 : 선두께로 px등 단위사용
                2) 종류: solid(실선), dotted(점선)
                        dashed(데쉬선), ridge(액자)
                3) 색상: hash코드, rgb코드 등으로 표시
                - 기본적으로 박스 크기에 포함된다!
            */

        }

        /*tbody 첫번째 tr의 td에 두꺼운 보더 윗줄만 넣기*/
        #drama tbody tr:first-child td {
            border-top: 2px solid #999;
        }

        /*tbody 마지막 tr의 td에 두꺼운 보더 아랫줄만 넣기*/
        #drama tbody tr:last-child td {
            border-bottom: 2px solid #999;
        }

        /*첫번째 줄 th 위에 두꺼운 보더 윗줄만 넣기*/
        #drama thead tr th {
            border-top: 2px solid #999;
        }

        /*테이블 본문 짝수번째 배경색 넣기*/
        /*
            :nth-child(짝수/홀수) 
            짝수 even, 홀수 odd
        */
        #drama tbody tr:nth-child(even) td {
            background-color: #ebebeb;
        }


        /*테이블 하단영역 td 디자인*/
        #drama tfoot tr td {
            text-align: center;
            padding: 20px 0;
        }



        /*구분박스*/
        div.gubun {
            max-width: 590px;
            margin: 0 auto;
            /*마영오!*/
            /*border: 1px solid red;*/
        }

        /*구분테이블*/
        table#gubun {
            border: 1px solid #ccc;
            font-size: 12px;
        }

        table#gubun td {
            padding: 5px 7px;
        }

        /*구분 첫줄 첫td에 오른쪽 보더 넣기*/
        #gubun tr:first-child td:first-child {
            border-right: 1px solid #ccc;
        }

        /*구분 가운데 줄 tr의 td에 윗줄, 아랫줄 넣기*/
        #gubun tr:nth-child(3) td {
            border-top: 1px solid #ccc;
            border-bottom: 1px solid #ccc;
        }

    </style>

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

        <!--테이블 본문-->
        <!--tbody는 일반 테이블에 안써도 출력됨-->
        <tbody>
            

        </tbody>
        
        
        
        <!--테이블 끝줄-->
        <tfoot>
            <tr>
                <td colspan="6">
                 

                </td>
            </tr>
        </tfoot>
   
   
   
   
   
   
    </table>



    <!--구분테이블 박스-->
    <div class="gubun">
        <!--구분테이블 삭제-->

        <!--입력페이지이동-->
        <button onclick="location.href='../index.php'" style="float:right;">사이트로 돌아가기</button>
        <br>
        <!--로그아웃버튼-->
        <button onclick="logout()">로그아웃</button>

    </div>




    <script src="../js/jquery-3.6.0.min.js"></script>
    <script>
        /*//////////////////////////////////////////////
            함수명: logout
            기능: 관리자모드에서 로그아웃후 사용자 첫페이지로 감
        */ //////////////////////////////////////////////
        function logout() {

            // Ajax(비동기통신)로그아웃 처리 페이지를 호출함!
            // 참고: inc/login_session.inc파일 중 로그아웃기능
            
            // 비동기통신으로 로그아웃 처리 페이지호출!
            // Ajax - $.post() 로 처리!
            // $.post(호출페이지, 전달변수셋팅, 콜백함수)
            $.post(
                // 1. 호출페이지(현재위치가 admin폴더임!)
                "../process/logOut.jsp",
                // 2. 전달변수셋팅
                {},
                // 3. 콜백함수
                function(res) { // res-결과값

                    res = res.trim(); //앞뒤공백제거(혹시)

                    if (res === "ok") {

                        // 메시지
                        alert("안전하게 로그아웃 되었습니다!");

                        // 첫페이지로 리로드
                        location.replace("../index.php");

                        } ////// if ////////////////
                        else {

                            // 메시지
                            alert("로그아웃시 문제가 발생하였습니다!" + res);

                        } ///// else ///////////////


                    } /// 콜백함수 ///////

                ); ///////// Ajax - post /////////

            } ////// logout 함수 /////////////////////////////
            /////////////////////////////////////////////////
            /////////////////////////////////////////////////

        </script>





</body>

</html>
