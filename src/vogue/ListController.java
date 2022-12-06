package vogue;

import common.JDBConnector;
import common.Paging;
import common.PagingDTO;

/////////////////////////////////////
// MVC 모델에서 컨트롤러 역할을 하는 클래스//
/////////////////////////////////////

// 역할: DB관련 작업 및 비즈니스로직 수행,뷰생성
// 모델(Model) : DB작업, 비즈니스 로직 모듈
// 뷰(View) : 화면에 정보를 구성하는 모듈
// 컨트롤러(Controller) : 모델을 기반으로 뷰를 구성하는 모듈

public class ListController {

	// DB연결 클래스 생성
	JDBConnector jdbc = new JDBConnector();

	// 페이징 클래스 생성 : 생성시 페이징 대상 테이블명을 보낸다!
	Paging pg = null;

	// 페이징 DTO 클래스 생성
	PagingDTO pgdto = new PagingDTO();
	
	// 생성자 메서드는 값을 리턴할 수 없으므로
	// 별도의 메서드를 생성하여 리스트 결과값을 리스트 페이지에 전달한다!
	
	///////////////////////////////////
	// 리스트 뷰를 구성하여 리턴하는 메서드 ///
	///////////////////////////////////
	// pgNum은 리스트 페이지에서 생성시 파라미터값을 전달해 준다!
	// 검색어 관련 파라미터 pmCol, pmKey 를 전달해 준다!
	public String setList(String pgNum,String bkNum, String pmCol, String pmKey) {
		// pgNum - 페이지번호 / bkNum - 페이징블록번호 / pmCol - 검색항목 / pmKey - 검색어

		// 파라미터 전달값 확인!
		System.out.println("페이지번호:"+pgNum+"\n블록번호:"+bkNum
				+"\n검색항목:"+pmCol+"\n검색어:"+pmKey);
		
		pg = new Paging("member",bkNum,pmCol,pmKey);
		
		// DB레코드결과변수
		String result = "";

		try {

			// 1. 쿼리문작성 할당
			String query = 
					"SELECT * FROM `member` "+
					"ORDER BY `name` ASC LIMIT  ?,?";
			
			// 1.5. 만약 검색어가 있으면 쿼리 변경!
			if(pmKey!=null) {
				query = "SELECT * FROM `member` "
						+ "WHERE `"+pmCol+"` "
						+ "LIKE \"%"+pmKey+"%\" "
						+ "ORDER BY `name` ASC LIMIT  ?,?";
				System.out.println("널이 아냐!");
			}

			// 2. 쿼리문 연결 사용준비하기
			jdbc.pstmt = jdbc.conn.prepareStatement(query);

			/**************************************** 
				[ 페이징 변수처리전 페이지번호로 시작번호 변경하기 ]
			 *****************************************/
			// 3.startNum을 변경하는 것이므로 setStartNum()으로 변경함!
			// DB쿼리에서 limit 시작번호다!
			pgdto.setStartNum(pg.changeStartNum(pgNum));

			// 4.pageSeq 변수 초기 셋팅 필수!(파라미터값으로 셋팅!)
			// 각 페이지별 시작번호를 맞춰준다!
			pgdto.setPageSeq(Integer.parseInt(pgNum));

			/****************************************
					5. 페이징 변수 처리하기
			 *****************************************/
			// LIMIT 쿼리의 시작번호셋팅
			jdbc.pstmt.setInt(1, pgdto.getStartNum());
			// LIMIT 쿼리의 개수셋팅
			jdbc.pstmt.setInt(2, pgdto.getOnePageCnt());

			// 6. 쿼리를 DB에 전송하여 실행후 결과집합(결과셋)을 가져옴!
			// ResultSet객체는 DB에서 쿼리결과를 저장하는 객체임!
			jdbc.rs = jdbc.pstmt.executeQuery();
			// executeQuery() 쿼리실행 메서드

			// 7. 저장된 결과집합의 레코드 수 만큼 돌면서 코드만들기!
			// 돌아주는 제어문은? while(조건){실행문}
			// 레코드 유무 체크 메서드는? next()
			// rs는 ResultSet 객체임!!!
			// rs.next() -> 첫라인 다음라인이 있으면 true / 없으면 false!
			// 첫번째 라인은 항상 컬럼명이 첫번째 라인이다!
			// 따라서 다음라인이 있다는 것은 결과 레코드가 있다는 말!!!

			// [ 일련번호용 변수 ]
			// 페이지에 따른 시작일련번호 구하기
			int listNum = 1;
			if (pgdto.getPageSeq() != 1){
				listNum = 
						(pgdto.getPageSeq() - 1) * pgdto.getOnePageCnt() + 1;
				// (현재 페이지번호 - 1) * 한페이지당개수 + 1
			} ////// if ////////

			// 예시 계산 :
			// (2-1) * 3 + 1 = 4
			// (3-1) * 3 + 1 = 7
			// (4-1) * 3 + 1 = 10

			/// 결과셋에 레코드가 있는 동안 계속 순회함!
			// rs.getString(컬럼명)
			// -> 문자형일 경우 getString(), 숫자형은 getInt()
			// -> 컬럼명은 DB 테이블에 실제로 생성된 컬럼명이다!
			while (jdbc.rs.next()) {
				// += 대입연산자로 기존값에 계속 더함!
				result += "<tr>" + "   <td>" + listNum + "</td>" +
						// "   <td>"+rs.getInt("idx")+"</td>"+
						// 일련번호는 DB의 idx 기본키를 쓰지 않고
						// 반복되는 동안 순번을 만들어서 사용한다!
						"   <td><a href='modify.jsp?idx=" + 
						jdbc.rs.getInt("idx") + "&pgnum=" + 
						pgdto.getPageSeq() + "'>" +
						// 조회수정 페이지인 modify.jsp로 갈때
						// ?idx=유일키값 : Get방식으로 전송함!
						// pgnum=현재페이지번호 : 추가전송!
						// 순서대로 : 아이디,이름,성별,이메일1,이메일2,권한
						jdbc.rs.getString("mid") + "</a></td>" + "   <td>" + 
						jdbc.rs.getString("name") + "</td>" + "   <td>" + 
						jdbc.rs.getString("gen") + "</td>" + "   <td>" + 
						jdbc.rs.getString("email1") + "@" + 
						jdbc.rs.getString("email2") + "</td>" + "   <td>" + 
						jdbc.rs.getString("auth") + "</td>" + "</tr>";
				// 일련번호증가
				listNum++;

			} //////////// while //////////////

			// 결과화면출력 	
			//    out.println(result);

			// 16. 연결해제하기
			jdbc.close();

		} //// try /////
		catch (Exception e) {
			e.printStackTrace();
		} ///// catch //////
		
		// 결과 리턴
		return result;
		
	} ////////////// setList 메서드 //////
	
	//////////////////////////////////////////
	// 페이징 코드 생성 메서드를 중계해 주는 메서드 ///
	/////////////////////////////////////////
	public String setPaging() {
		// 페이징 클래스의 페이징 코드 생성 메서드를 호출
		// 그 결과값을 리턴한다!
		return pg.makePaging();
	} //////// setPaging 메서드 /////////////
	
	
	
	
	

} //////// 클래스 //////////////////
