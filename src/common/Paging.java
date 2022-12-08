package common;

public class Paging {
	
	// 페이징 DTO 생성
	PagingDTO pgdto = new PagingDTO();
	// DB연결 클래스 생성하기
	JDBConnector jdbc = new JDBConnector();
	// 파라미터 공유
	public static String numBk,colPm,keyPm;

	///////////////////////
	// 생성자 메서드 /////////
	///////////////////////
	// 역할: 인스턴스 생성시 바로 실행하므로 기본 변수값을 모두 셋팅한다!
	public Paging(String tbName,String bkNum, String pmCol,String pmKey) { 
		// tbName - 페이징대상테이블

		numBk = bkNum;
		colPm = pmCol;
		keyPm = pmKey;
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
		try {
			// 15-1. 전체 레코드 수 구하기
			// 레코드수 구하기 쿼리
			String cntQuery = "SELECT COUNT(*) FROM "+ tbName;
			
			// 1.5. 만약 검색어가 있으면 쿼리 변경!
			if(pmKey!=null) {
				cntQuery += " WHERE `"+pmCol+"` "
						+ "LIKE \"%"+pmKey+"%\"";
				System.out.println("널이 아냐!");
			}
			
			// 쿼리를 PreparedStatement에 넣기
			jdbc.pstmt = jdbc.conn.prepareStatement(cntQuery);
			// 쿼리실행! -> 개수정보를 리턴받아 ResultSet에 담는다!
			jdbc.rs = jdbc.pstmt.executeQuery();

			// 개수결과가 있으면 가져오기
			if (jdbc.rs.next()) {
				pgdto.setTotalCnt(jdbc.rs.getInt(1));
				// getInt(1)은 정수형 결과를 가져옴!
			} ////// if ///////////

			// 15-2. 리스트 그룹수 : 전체개수 ÷ 페이지당개수
			pgdto.setListGroup(
					pgdto.getTotalCnt() / pgdto.getOnePageCnt());

			// 15-3. 남은 레코드수 : 전체개수 % 페이지당개수
			// 나머지 구할땐 %연산자
			pgdto.setEtcRecord(
					pgdto.getTotalCnt() % pgdto.getOnePageCnt());

			// 한계수 체크: 나머지가 있고 없고에 따라 1개차이남
			pgdto.setLimit(
			pgdto.getEtcRecord() == 0 ? 
			pgdto.getListGroup() : pgdto.getListGroup() + 1);
			// 나머지가 있으면 1페이지 더 추가!
			
			
			// ####### 페이징 블록 셋팅하기 ########
			// 8.페이징 단위개수(oneBlockCnt)
			// 9.페이징 그룹수 : (리스트그룹수+남은레코드수) ÷ 페이징 단위개수 (blockGroup)
			pgdto.setBlockGroup(
			(pgdto.getListGroup()+pgdto.getEtcRecord())/pgdto.getOneBlockCnt());
			// 10.남은 페이징수 : (리스트그룹수+남은레코드수) % 페이징 단위개수 (etcBlock)
			pgdto.setEtcBlock(
			(pgdto.getListGroup()+pgdto.getEtcRecord())%pgdto.getOneBlockCnt());
			


		} /// try ////
		catch (Exception e) {
			e.printStackTrace();
		} /// catch ////

		// 콘솔에 찍어보기
		System.out.println("# 전체개수:" + pgdto.getTotalCnt() + "개");
		System.out.println("# 페이지당개수:" + pgdto.getOnePageCnt() + "개");
		System.out.println("# 리스트 그룹수:" + pgdto.getListGroup() + "개");
		System.out.println("# 남은 레코드수:" + pgdto.getEtcRecord() + "개");
		System.out.println("# 페이징 단위개수:" + pgdto.getOneBlockCnt() + "개");
		System.out.println("# 페이징 그룹수:" + pgdto.getBlockGroup() + "개");
		System.out.println("# 남은 페이징수:" + pgdto.getEtcBlock() + "개");

	} /////// 생성자 메서드 ///////

	
	// 사용자 정의 메서드 1
	//////////////////////////////////
	/// 시작번호 구해서 리턴하는 메서드 /////
	/////////////////////////////////
	// 역할: 각 페이지마다 시작번호가 다르므로 이를 구하여 리턴함!
	public int changeStartNum(String pgnum) {
		// pgnum 변수는 리스트 페이지의 파라미터 pgnum을 가져옴!
		// url/.../list.html?pgnum=3 이부분임!
		/**************************************** 
		[ 페이징 변수처리전 페이지번호로 시작번호 변경하기 ]
		 *****************************************/
		// 페이지번호 가져오기
		String pgNum = pgnum;
		System.out.println("파라미터:" + pgNum);


		// 파라미터가 있으면 시작값 처리하기
		if (pgNum != null) { // null이 아니면!
			// 파라미터 형변환!
			try {
				pgdto.setPageSeq(Integer.parseInt(pgNum));
			} catch (NumberFormatException ex) {
				System.out.println("파라미터가 숫자가 아닙니다!<br>");
				// 기본값으로 돌려보낸다!
				pgdto.setPageSeq(1);
			}
			// 시작번호 계산하기 : 페이지당 레코드수 * (페이지번호-1)
			pgdto.setStartNum(pgdto.getOnePageCnt() * (pgdto.getPageSeq() - 1));

		} //////////// if //////////////

		// 시작번호 리턴하기
		return pgdto.getStartNum();

	} ///////////// changeStartNum 메서드 //////////

	// 사용자 정의 메서드 2
	/////////////////////////////
	//// 페이징 소스 리턴 메서드 /////
	/////////////////////////////
	// 역할: 페이징 정보에 따라 실제 링크코드를 만들어서 본 html페이지로 리턴
	public String makePaging() {
		// 페이징링크 코드 저장변수
		String pgCode="";
		
		// #### 블록 시작값 ####
		int bkStart = (Integer.parseInt(numBk) - 1) * pgdto.getOneBlockCnt();
		// #### 블록 한계값 ####
		int bkLimit = Integer.parseInt(numBk) * pgdto.getOneBlockCnt();
		// #### 블록 한계값이 리스트그룹수 보다크면 리스트 그룹수로 정한다!
		// (남은 레코드가 있으면 1더함)
		if(bkLimit > pgdto.getListGroup()) 
			bkLimit = pgdto.getListGroup()+(pgdto.getEtcRecord()>0?1:0);
		
		// ######## 이전블록가기 ##########
		if(Integer.parseInt(numBk)-1 > 0) {
			pgCode += "<a href='list.jsp?pgnum=" 
			+ (((Integer.parseInt(numBk)-1)*pgdto.getOneBlockCnt())
					-(pgdto.getOneBlockCnt()-1));
			pgCode += "&bknum=" +  + (Integer.parseInt(numBk)-1); 
			if(keyPm!=null) {
				pgCode += "&col="+colPm+"&key="+keyPm;
			}
			pgCode += "'>◀</a> ";
		}
		else {
			pgCode += "◁ ";
		}
		
		System.out.println("현재블록번호:"+numBk);
		System.out.println("이전블록:"+(Integer.parseInt(numBk)-1));

		// ########################

		// 15-4. 페이징 링크 코드 만들기
//		for (int i = 0; i < pgdto.getLimit(); i++) {
		for (int i = bkStart; i < bkLimit; i++) {
			// 만약 현재 페이지와 같은 번호는 a링크 걸지말고
			// b태그로 두꺼운 글자 표시만 해주자!
			if (i == pgdto.getPageSeq() - 1) { // i는 0부터니까 1뺌
				pgCode += "<b>" + (i + 1) + "</b>";
			} /// if ////
			else {
				// pgCode변수에 모두 넣는다
				pgCode += "<a href='list.jsp?pgnum=" + (i + 1); 
				pgCode += "&bknum=" + numBk; 
				if(keyPm!=null) {
					pgCode += "&col="+colPm+"&key="+keyPm;
				}
				pgCode += "'>" + (i + 1) + "</a>";
			} /// else //////

			// 사이바 찍기 
			// (한계값-1,즉 마지막번호 전까지만 사이바출력)
			if (i < bkLimit - 1) {
				pgCode += " | ";
			}

		} ////////// for //////////////
		
		// ##### 다음블록가기 #######
		if(Integer.parseInt(numBk)+1 < 
				pgdto.getListGroup()/pgdto.getOneBlockCnt()
				+pgdto.getEtcBlock()) {
			pgCode += "<a href='list.jsp?pgnum=" 
		+ ((Integer.parseInt(numBk)*pgdto.getOneBlockCnt())+1); 
			pgCode += "&bknum=" + (Integer.parseInt(numBk)+1); 
			if(keyPm!=null) {
				pgCode += "&col="+colPm+"&key="+keyPm;
			}
			pgCode += "'>▶</a>";
		}
		else {
			pgCode += " ▷";
		}
		// ######################
		
		System.out.println("다음블록:"+(pgdto.getBlockGroup()+pgdto.getEtcBlock()));
		System.out.println("계산:"+(Integer.parseInt(numBk)+1));
		
		// 최종 결과 리턴하기!!!
		return pgCode;
		
	} ////////// makePaging 메서드 //////////





} ///////// 클래스 //////////
