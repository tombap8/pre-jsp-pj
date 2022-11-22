package drama;

import common.JDBConnector;
import common.Paging;
import common.PagingDTO;

public class ListController {
	// 연결 클래스 생성
	JDBConnector jdbc = new JDBConnector();
	// 패이징 클래스 생성
	Paging paging = new Paging();
	// 패이징DTO 클래스 생성
	PagingDTO pgdto = new PagingDTO();


	public String setList(String pgnum) {
		// DB레코드결과변수
		String result = "";

		try {

			// 7. 쿼리문작성 할당
			String query = "SELECT * FROM `drama_info` ORDER BY `idx` DESC LIMIT ?,?";

			// 11. 쿼리문 연결 사용준비하기
			// conn연결된 DB객체
			jdbc.pstmt = jdbc.conn.prepareStatement(query);
			// prepareStatement(쿼리문변수)
			// - 쿼리문을 DB에 보낼 상태완료!
			// - 중간에 쿼리문에 넣을 값을 추가할 수 있음!

			/**************************************** 
			[ 페이징 변수처리전 페이지번호로 시작번호 변경하기 ]
			 *****************************************/
			pgdto.setStartNum(paging.changeStartNum(pgnum));
			
			// pageSeq변수 초기 셋팅 필수!(파리미터값으로 셋팅)
			pgdto.setPageSeq(Integer.parseInt(pgnum));

			/****************************************
						12. 페이징 변수 처리하기
			 *****************************************/
			// LIMIT 쿼리의 시작번호셋팅
			jdbc.pstmt.setInt(1, pgdto.getStartNum());
			// LIMIT 쿼리의 개수셋팅
			jdbc.pstmt.setInt(2, pgdto.getOnePageCnt());

			// 13. 쿼리를 DB에 전송하여 실행후 결과집합(결과셋)을 가져옴!
			// ResultSet객체는 DB에서 쿼리결과를 저장하는 객체임!
			jdbc.rs = jdbc.pstmt.executeQuery();
			// executeQuery() 쿼리실행 메서드

			// 일련번호용 변수
			// 페이지에 따른 시작일련번호 구하기
			int listNum = 1;
			if(pgdto.getStartNum() != 1) 
				listNum = (pgdto.getPageSeq()-1) * pgdto.getOnePageCnt() + 1;
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
						"   <td><a href='modify.jsp?idx=" + jdbc.rs.getInt("idx") + "'>" +
						// 조회수정 페이지인 modify.jsp로 갈때
						// ?idx=유일키값 : Get방식으로 전송함!
						jdbc.rs.getString("dname") + "</a></td>" + "   <td>" + 
						jdbc.rs.getString("actors") + "</td>" + "   <td>" + 
						jdbc.rs.getString("broad") + "</td>" + "   <td>" + 
						jdbc.rs.getString("gubun") + "</td>" + "   <td>" + 
						jdbc.rs.getString("stime") + "</td>" + "   <td>" + 
						jdbc.rs.getString("total") + "</td>" + "</tr>";

				// 일련번호증가
				listNum++;

			} //////////// while //////////////

			// 16. 연결해제하기
			jdbc.close();

		} //// try /////
		catch (Exception e) {
			e.printStackTrace();
		} ///// catch //////

		// 최종결과 리턴
		return result;

	} ////////////// setList 메서드 ////////////

} /////// class ////////
