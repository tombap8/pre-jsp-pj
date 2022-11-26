<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="common.JDBConnector"%>
<%@ page import="common.SHA256"%>

<%
	//POST 방식의 한글처리 : 이것 안쓰면 한글깨짐!!!
	request.setCharacterEncoding("UTF-8");
	
	// DB연결 객체 생성
	JDBConnector jdbc = new JDBConnector();
	// 암호화 객체 생성
	SHA256 sha = new SHA256();
	
	try{
		
		// 파라미터 정보 가져오기
		// 1.아이디
		String mid = request.getParameter("mid");
		// 2.비번
		String mpw = request.getParameter("mpw");
		
		// 비밀번호 암호화!
		String shampw = sha.encSha256(mpw);
		
		// 3.이름
		String mnm = request.getParameter("mnm");
		// 4.성별
		String gen = request.getParameter("gen");
		// 5-1.이메일 앞주소
		String email1 = request.getParameter("email1");
		// 5-2.이메일 뒷주소
		String seleml = request.getParameter("seleml");
		// 5-3.직접입력 이메일 뒷주소
		String email2 = request.getParameter("email2");
		
		// 넘어온값 찍기!
// 		out.println(
// 			"<h1>" +
// 			"♣ mid : " + mid + "<br>" +
// 			"♣ mpw : " + mpw + "<br>" +
// 			"♣ sha256 : " + shampw + "<br>" +
// 			"♣ mnm : " + mnm + "<br>" +
// 			"♣ gen : " + gen + "<br>" +
// 			"♣ email1 : " + email1 + "<br>" +
// 			"♣ seleml : " + seleml + "<br>" +
// 			"♣ email2 : " + email2 + "</h1>"
// 		);

		
		
     	
     	// 7. 쿼리문작성 할당
     	String query = "INSERT INTO `member` "+
     			"(`mid`, `mpw`, `name`, `gen`, `email1`, `email2`) "+
     			"VALUES (?,?,?,?,?,?)";
     	// 쿼리문작성시 삽입될 데이터 부분을 물음표(?)로 처리하면
     	// PreparedStatement 객체에서 이부분을 입력하도록 해준다!
     	
     
     	// 11. 쿼리문 연결 사용준비하기
     	// conn연결된 DB객체
     	jdbc.pstmt = jdbc.conn.prepareStatement(query);
     	// prepareStatement(쿼리문변수)
     	// - 쿼리문을 DB에 보낼 상태완료!
     	// - 중간에 쿼리문에 넣을 값을 추가할 수 있음!
     	
     	// 12. 준비된 쿼리에 물음표부분을 처리하는 순서!
     	// set데이터형(순번, 값변수)
     	// 순번은 1부터 시작!
     	// 데이터형이름은 대문자로 시작
     	// 예) setString(), setInt(), setDouble(),...
     	jdbc.pstmt.setString(1, mid);
     	jdbc.pstmt.setString(2, shampw);
     	jdbc.pstmt.setString(3, mnm);
     	jdbc.pstmt.setString(4, gen);
     	jdbc.pstmt.setString(5, email1);
     	jdbc.pstmt.setString(6, email2);
     	// 물음표 순서대로 값을 셋팅해 준다!
     	
     	// 13. 쿼리를 DB에 전송하여 실행한다.
     	jdbc.pstmt.executeUpdate(); // insert문을 실행하는 메서드는?
     	// executeQuery() 쿼리실행 메서드 -> select 데이터셋을 가져옴
		// executeUpdate() 쿼리실행 메서드 -> insert문을 실행함     	
  
     	// 14. 연결해제하기
     	jdbc.close();
     	
     	// 15. 입력성공시 메시지 띄우기
     	// JS alert창 띄우고 확인시 list페이지로 돌아가기!
     	out.println("ok");
     	
     	// [ 입력시 한글 깨짐 문제발생 해결 ]
     	// -> 입력성공후 한글이 물음표(?)로 입력된 경우 원인은?
     	// DB를 살펴보면 utf8_general_ci 형식으로 잘 만들어져있음!
     	// 원인은 MySQL 환경설정파일에 있다!!!
     	
     	// XAMPP 패널에 config버튼 클릭시 my.ini파일에서 "utf"검색
     	// 결과: utf8mb4 가 설정되어 있음 이것을 모두 utf8로 변경함!
     	// 참고주의) #이 앞에 있는 문장은 주석문이므로 고칠필요가 없다!
     	
     	// [아래 3가지를 변경함!]
     	// default-character-set=utf8
     	// character-set-server=utf8
     	// collation-server=utf8_general_ci
     	
     	// 변경후 반드시 MySQL 서버를 내렸다 올려야 my.ini를 다시 읽는다!
     	
     	// 실제 my.ini 위치는
     	// C:\xampp\mysql\bin\my.ini
	       
		
	} ////////// try //////////
	catch(Exception e){
 		// DB연결 실패시 여기로 들어옴!
 		out.println("no");
//  		out.println(e.toString());
 		// toString() 문자데이터로 변환하는 메서드
	} ///////// catch //////////


%>