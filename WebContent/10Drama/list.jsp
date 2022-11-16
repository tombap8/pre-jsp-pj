<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>한국 최신 드라마 리스트</title>
    <style>
        /*테이블 공통 디자인*/
        .tbl {
            /*글자체*/
            font-family: "궁서체", "굴림";
            /*글자크기*/
            font-size: 14px;
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
            max-width: 900px;
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
    <!--한국 최신 드라마 리스트 테이블-->
    <table id="drama" class="tbl">
        <!--테이블제목-->
        <caption>한국 최신 드라마 리스트</caption>
        <!--테이블 머릿줄-->
        <thead>
            <tr>
                <!--머릿글은 td대신 th를 씀-->
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
        
            // POST 방식의 한글처리
            request.setCharacterEncoding("UTF-8");


            String DB_URL = "jdbc:mysql://localhost:3306/mydb";

            // DB URL Format = "jdbc:mysql://'DB IP':'Connector Port'/'DB_Name'";

            

            String DB_USER = "root";

            String DB_PASSWORD= "";

            // DB ID/PASSWORD

            

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String query = "SELECT * FROM `drama_info` ORDER BY `idx` DESC limit ?, ?";

            try {

            // Load JDBC Class
            int startPage = 0; // limit의 시작값 -> 첫 limit 0,10
            int onePageCnt= 3; // 한페이지에 출력할 행의 갯수
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Make Connection

            // 파라미터 받기(파라미터는 처음에 모두 문자형임!)
            String pgnum = request.getParameter("pgnum");
            out.println("파라미터:"+pgnum+"<br>");

           
            // 파라미터 형변환변수
            int pageSeq = 1;


            // 파라미터가 있으면 시작값 처리
            if (pgnum != null) { 
                // 파라미터 형변환!
                try{
                    pageSeq = Integer.parseInt(pgnum);
                }
                catch (NumberFormatException ex){
                    out.println("파라미터가 숫자가 아닙니다!<br>");
                    // 기본값으로 돌려보냄!
                    pageSeq = 1;
                }
                startPage = onePageCnt * (pageSeq - 1);
                // 시작 레코드 번호 = 단위개수 * (페이지번호 - 1)
            } // if //

            pstmt = conn.prepareStatement(query); // db에 연결하여 SQL 사용 준비
			pstmt.setInt(1, startPage);
			pstmt.setInt(2, onePageCnt);
			rs = pstmt.executeQuery();

           
            %>


                    <!--테이블 본문-->
                    <!--tbody는 일반 테이블에 안써도 출력됨-->
                    <tbody>
                    
            <%

            // 레코드 결과값 임시변수
            String result = "";

            while (rs.next())

            {

                result += 
                    "<tr>"+
                        "<td>"+rs.getString("idx")+"</td>"+
                        //// 수정페이지로 링크걸기 ////
                        "<td><a href='modify.jsp?num="+
                        rs.getString("idx")+//보내는 유일키
                        "&pgnum=" + pageSeq + "'>"+
                        rs.getString("dname")+
                        "</a></td>"+
                        /////////////////////////////
                        "<td>"+rs.getString("actors")+"</td>"+
                        "<td>"+rs.getString("broad")+"</td>"+
                        "<td>"+rs.getString("gubun")+"</td>"+
                        "<td>"+rs.getString("stime")+"</td>"+
                        "<td>"+rs.getString("total")+"</td>"+
                    "</tr>";

            } // while //

            // 결과값 출력
            out.println(result);

            //Print result to query

            // 전체 레코드 수 구하기 쿼리
            String cntQuery = "SELECT COUNT(idx) FROM `drama_info`";
            

           // stmt = conn.createStatement();

           // rs = stmt.executeQuery(query);

            // Do Query -> ( SELECT * FROM "test" )
            // 메서드명 prepareStatement() 소문자로 시작 prepare 철자주의!
            PreparedStatement pstmt2 = conn.prepareStatement(cntQuery);
            ResultSet rs2 = pstmt2.executeQuery();
        
            int totalNum=0;
            
            // next() 결과가 있으면 true
            if(rs2.next()){
                // getInt(1) 정수형 결과 가져오기
                totalNum = rs2.getInt(1);                
            } //////////// if ////////

            // 1.전체개수: totalNum
            // 2.리스트당 레코드수: onePageCnt
            // 3.리스트 그룹수: listGroup
            int listGroup = totalNum / onePageCnt;
            // 4.남은 레코드수: 
            int etcRecord = totalNum % onePageCnt;

            out.println("# 전체개수: "+ totalNum +"개<br>");
            out.println("# 리스트당 레코드수: "+ onePageCnt +"개<br>");
            out.println("# 리스트 그룹수: "+ listGroup +"개<br>");
            out.println("# 남은 레코드수: "+ etcRecord +"개<br>");

            %>

            
        <!--테이블 끝줄-->
        <tfoot>
            <tr>
                <td colspan="7">
                    ◀
        <%

            // 결과값 임시변수
            String temp = "";

            // etcRecord==0 ? listGroup : listGroup+1
            // 남은레코드가0인가? 아니면 리스트그룹수+1

            // 한계수 체크
            int limit = etcRecord==0 ? listGroup : listGroup+1;

            for(int i = 0; i < limit; i++){

                // 현재 페이지는 두꺼운글자로만!
                if(i == pageSeq-1) {
                    temp += "<b>" + (i + 1) + "</b>";
                     // 마지막 순번이 아니면 사이에 구분선 넣기
                    if(i < limit - 1) temp += " | ";
                    continue; // 다른거 있으면 계속해!
                } /// if ///

                temp +=
                "<a href='list.jsp?pgnum=" + 
                (i + 1) +"'>" + 
                (i + 1) + "</a>";

                // 마지막 순번이 아니면 사이에 구분선 넣기
                if(i < limit - 1) temp += " | ";


            } ////// for ////

            // 화면출력

            out.println(temp);

                     
        %>
                    ▶

                </td>
            </tr>
        </tfoot>

            <%
            

            rs.close();
            pstmt.close();
            conn.close();


           
            }

            catch(Exception e){

            out.print("Exception Error...");
            out.print(e.toString());

            }

            %>

        </tbody>


    </table>
    


    <!--구분테이블 박스-->
    <div class="gubun">
        <table id="gubun" class="tbl">
            <tr>
                <!--rowspan은 위아래 td를 터준다!
               rowspan="통합할 td의 개수"-->
                <td rowspan="3">구분</td>
                <td>월화:월화드라마</td>
            </tr>
            <tr>
                <!--<td>구분</td>-->
                <td>수목:수목드라마</td>
            </tr>
            <tr>
                <!--<td>구분</td>-->
                <td>토일:토일드라마</td>
            </tr>
        </table>
        
        <!--입력페이지이동-->
        <button onclick="location.href='insert.jsp'" style="float:right;">입력하기</button>
        
    </div>

</body>

</html>