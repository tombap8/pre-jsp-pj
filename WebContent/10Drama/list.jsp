<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- DB연결 객체 임포트 필수! -->
<%@page import="java.sql.*"%>
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
		
		// ***** 페이징 변수 ****** 
		// 1.시작 레코드번호 : LIMIT의 시작값
		int startNum = 0; 
		// 2.페이지당 레코드개수 : LIMIT의 개수
		int onePageCnt = 3;
		// 3.전체 레코드수
		int totalCnt = 0;
		// 4.리스트 그룹수 : 전체개수 ÷ 페이지당개수
		int listGroup = 0;
		// 5.남은 레코드수 : 리스트 그룹에서 남은 레코드수
		int etcRecord = 0;
		// 6.페이징링크 코드 저장변수
		String pgCode = "";
		

		try {

			// DB와 연결하려면 해당 DB의 jar파일이 DB폴더의
			// lib 폴더안에 위치해 있어야한다!
			// MySQL 설치폴더
			// C:\Program Files\Apache Software Foundation
			// \Tomcat 9.0\lib
			// mysql-connector.jar 파일 이것!!!! 확인!
			// 다이나믹 웹 프로젝트에서는 WEB-INF>lib 폴더에 넣는다!(관리용이)

			// 여러줄 주석: 컨쉬+슬래쉬
			/*
				[ JDBC 프로세스 ]
				- JAVA DataBase Connection
				
				1. DB연결하기 : java.sql.Connection 객체
			- 사용메서드: 
				DriverManager
				-> jdbc의 종류별 DB에 연결해주는 드라이버를 선별하는 객체
				-> DB 드라이버문자열은 Class객체의 forName()메서드에
				등록한 것을 읽어와서 연결객체를 셋팅한다!
				
				-> 연결전 드라이버 종류 셋업!
				Class.forName(DB종류별 드라이버문자열);-> 주문을 넣는다!
				-> MySQL은 "com.mysql.jdbc.Driver" 사용!
				
				드라어버 셋업 후
				결국 사용할 메서드는?
				DriverManager
				.getConnection(DB연결문자열,DB계정아이디,DB계정비번);
				
				get 가져와!
				Connection 연결을!
				->>> 메모리상에 목적한 DB와 연결된 시스템 장치가 셋팅된다!
				정확히는 DB와 통신망이 열렸다!!!
				
				2. 쿼리구성하기 :
			-> 우선 유효성이 확인된 쿼리문을 String형(문자형)으로 할당해 둔다!
			-> java.sql.PreparedStatement 객체가 이것을 가져간다!
			-> 쿼리를 가져가는 메서드는?
			Connection객체 하위의 메서드인
			prepareStatement(쿼리문)으로 호출하여
			결과값을 PreparedStatement객체에 담는다!!!
			
			->> 이름주의! prepareStatement()            					
				
				3. 쿼리실행과 결과값 받기
				
			-> 쿼리실행 메서드는 
			java.sql.PreparedStatement 객체가 가진다!
			
			Prepared 준비된
			Statement 진술,서술 -> 쿼리문
			
			-> executeQuery() 이미 셋팅된 쿼리를 DB에 실행한다!
			execute 실행하라!
			Query -> 쿼리를
			-> executeQuery() 메서드는 DB의 쿼리결과를 리턴한다!
			
			이 결과를 누가 담는가?????
			
				java.sql.ResultSet 객체다!
				-> 결과값을 집합의 형태로 마치 배열과 같이 레코드들을 저장함!
				-> next() 메서드로 담겨진 레코드를 순회할 수 있다!
				-> 결과적으로 하나씩 값을 돌아다니며 찍는다!
				-> 하나의 레코드 안에서 각 컬럼명을 DB에 셋팅된 이름으로 가져올 수 있다!
				-> 방법: 데이터 형에 따라 get데이터형(컬럼명) 형태로 접근한다!
				예) 
			-> ResultSet 을 변수에 선언과 할당 후
				ResultSet rs = null;
			-> String 형이고 컬럼명이 "name"이면
				rs.getString("name")
			-> int형이고 컬럼명이 "idx"이면
				rs.getInt("idx")
			-> boolean형이고 컬럼명이 "yorn"이면
				rs.getBoolean("yorn")
				
				4. 연결닫기 : 메모리 해제를 위해 모든 연결을 닫아준다!
			-> close() 메서드 사용!
			
			1) Connection 객체 닫기 
			Connection conn;
			conn.close();
			
			2) PreparedStatement 객체 닫기 
			PreparedStatement pstmt;
			pstmt.close();
			
			3) ResultSet 객체 닫기 
			ResultSet rs;
			rs.close();
			*/

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
			
			/***************************************** 
				[ 페이징 기능 구현하기 ]
				1. 페이징 사용이유 : 많은 데이터를 부분적으로 보이기
				-> 최신데이터보기, 가독성, 페이지 및 쿼리의 거대함 해결

				2. 원리: 한 페이지당 특정 레코드수를 정하여 나누어서
				마치 페이지를 넘기는것 처럼 데이터를 모아서 본다.
				
				3. 페이징 쿼리:
					SELECT * FROM 테이블명 limit 시작번호,개수
					-> 단, 시작번호는 0부터!
					쿼리문 작성시 물음표(?)로 시작번호와 개수를 변수처리함
					SELECT * FROM 테이블명 limit ?,?
				4. 페이지 쿼리의 변수처리 : PreparedStatement 에서함!
					시작번호와 개수를 변수로 만들어서 페이징 컨트롤함
				5. 현재 페이지 정보 필요에 따라
					URL의 키값 쌍을 생성한다!
					예) url?키=값
					   url?pgnum=3
					 =>>> 어디에 생성하나?
					리스트 하단의 페이지 이동번호 a링크에 생성한다!
				6. 전체페이지수는 어떻게 구하나?
				  게시물전체개수 ÷ 한페이지당개수(onPageCnt)
				  -> 게시물이 넘칠 경우를 위해 나머지연산자로 
				  나머지가 있으면 다음 페이지까지 표시함!
				
			*******************************************/

			// 7. 쿼리문작성 할당
			String query = "SELECT * FROM `drama_info` ORDER BY `idx` DESC LIMIT ?,?";
			// 쿼리문의 ORDER BY 는 내림차순/올림차순 정렬을 지정함
			// DESC 는 내림차순, ASC는 올림차순
			// DESC (descendent), ASC(ascendent)

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
			
			/**************************************** 
			[ 페이징 변수처리전 페이지번호로 시작번호 변경하기 ]
			*****************************************/
			// 페이지번호 가져오기
			String pgNum = request.getParameter("pgnum");
			out.println("파라미터:"+pgNum+"<br>");
			
			// 파라미터 형변환 변수
			int pageSeq = 1; // 기본값 1(파라미터가 없으면 1들어감!)
			
			// 파라미터가 있으면 시작값 처리하기
			if(pgNum != null){ // null이 아니면!
				// 파라미터 형변환!
				try{
					pageSeq = Integer.parseInt(pgNum);
				}
				catch(NumberFormatException ex){
					out.println("파라미터가 숫자가 아닙니다!<br>");
					// 기본값으로 돌려보낸다!
					pageSeq = 1;
				}
				// 시작번호 계산하기 : 페이지당 레코드수 * (페이지번호-1)
				startNum = onePageCnt * (pageSeq -1);
				
			} //////////// if //////////////
			
			/****************************************
				12. 페이징 변수 처리하기
			*****************************************/
			// LIMIT 쿼리의 시작번호셋팅
			pstmt.setInt(1, startNum);
			// LIMIT 쿼리의 개수셋팅
			pstmt.setInt(2, onePageCnt);

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

			// 일련번호용 변수
			int listNum = 1;

			/// 결과셋에 레코드가 있는 동안 계속 순회함!
			// rs.getString(컬럼명)
			// -> 문자형일 경우 getString(), 숫자형은 getInt()
			// -> 컬럼명은 DB 테이블에 실제로 생성된 컬럼명이다!
			while (rs.next()) {
				// += 대입연산자로 기존값에 계속 더함!
				result += "<tr>" + "   <td>" + listNum + "</td>" +
				// "   <td>"+rs.getInt("idx")+"</td>"+
				// 일련번호는 DB의 idx 기본키를 쓰지 않고
				// 반복되는 동안 순번을 만들어서 사용한다!
				"   <td><a href='modify.jsp?idx=" + rs.getInt("idx") + "'>" +
				// 조회수정 페이지인 modify.jsp로 갈때
				// ?idx=유일키값 : Get방식으로 전송함!
				rs.getString("dname") + "</a></td>" + "   <td>" + rs.getString("actors") + "</td>" + "   <td>"
				+ rs.getString("broad") + "</td>" + "   <td>" + rs.getString("gubun") + "</td>" + "   <td>"
				+ rs.getString("stime") + "</td>" + "   <td>" + rs.getString("total") + "</td>" + "</tr>";

				// 일련번호증가
				listNum++;

			} //////////// while //////////////

			// 결과화면출력 	
			//    out.println(result);
			
			/********************************* 
				15. 페이징 링크 생성하기
				______________________________
				
				1)시작 레코드번호 : startNum
				2)페이지당 레코드개수 : onePageCnt
				3)전체 레코드수 : totalCnt
				4)리스트 그룹수 : listGroup
							(전체개수 ÷ 페이지당개수) 
				5)남은 레코드수 : etcRecord
				6)페이징링크 코드 저장변수 pgCode
				
			*********************************/
			// 15-1. 전체 레코드 수 구하기
			// 레코드수 구하기 쿼리
			String cntQuery = 
			"SELECT COUNT(*) FROM `drama_info`";
			// 쿼리를 PreparedStatement에 넣기
			PreparedStatement pstmt2 = 
			conn.prepareStatement(cntQuery);
			// 쿼리실행! -> 개수정보를 리턴받아 ResultSet에 담는다!
			ResultSet rs2 = pstmt2.executeQuery();
			
			// 개수결과가 있으면 가져오기
			if(rs2.next()){
				totalCnt = rs2.getInt(1);
				// getInt(1)은 정수형 결과를 가져옴!
			} ////// if ///////////
			
			// 15-2. 리스트 그룹수 : 전체개수 ÷ 페이지당개수
			listGroup = totalCnt / onePageCnt;
			
			// 15-3. 남은 레코드수 : 전체개수 % 페이지당개수
			// 나머지 구할땐 %연산자
			etcRecord = totalCnt % onePageCnt;
			
			// 한계수 체크: 나머지가 있고 없고에 따라 1개차이남
			int limit = etcRecord==0 ? listGroup : listGroup + 1;
			// 나머지가 있으면 1페이지 더 추가!
			
			// 15-4. 페이징 링크 코드 만들기
			for(int i=0; i < limit; i++){
				// pgCode변수에 모두 넣는다
				pgCode += 
				"<a href='list.jsp?pgnum="+
				(i+1)+
				"'>"+
				(i+1)+
				"</a>";
				
				// 사이바 찍기 
				// (한계값-1,즉 마지막번호 전까지만 사이바출력)
				if(i < limit-1){
					pgCode += " | ";					
				}
				
			} ////////// for //////////////
			
			
			// 화면에 찍어보기
			out.println("<h1>");
			out.println("# 전체개수:"+totalCnt+"개<br>");
			out.println("# 페이지당개수:"+onePageCnt+"개<br>");
			out.println("# 리스트 그룹수:"+listGroup+"개<br>");
			out.println("# 남은 레코드수:"+etcRecord+"개<br>");
			out.println("</h1>");

			// 16. 연결해제하기
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

		/////////////////////////////////////////////////
		%>

		<!-- 3.테이블 메인부분 -->
		<tbody>
			<%=result%>
		</tbody>

		<!-- 4.테이블 하단부분-->
		<tfoot>
			<tr>
				<td colspan="7">◀ <%=pgCode%> ▶</td>
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
				<!-- 
                        rowspan 속성은 위아래 행을 합치는 속성
                        여기서는 4줄을 합치므로 값을 4로 설정함
                        아래쪽 행에서는 첫번째 td를 모두 쓰지 않는다!
                        row는 "행/줄"의 뜻
                     -->
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

	<!-- 
            [ 가장 복잡한 그룹요소인 테이블!!! ]
            1. table : 테이블 전체 부모요소
            2. tr : 테이블 레코드행 (table row)
            3. td : 테이블 데이터요소 (table data)
            4. th : 테이블 머릿부분에 사용될 경우 
            td대신 th를 사용할 수 있다.
            (기본디자인-중앙정렬+두꺼운글자)
            ________________________________  
            (테이블 구조를 위한 추가요소들)
            5. caption : 테이블 제목
            6. thead : 테이블 머릿부분
            7. tbody : 테이블 중앙 내용부분
            8. tfoot : 테이블 하단부분

            ※tbody는 일반적으로 table tr td 로 구성하는
            테이블일 경우 자동으로 생성되어 표시된다!

         -->


</body>
</html>