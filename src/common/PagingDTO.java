package common;

// 페이징 속성(변수) 캡슐화 클래스
// DTO - Data Transfer Object 의 줄임말로
// 데이터 캡슐화의 겟터,셋터가 있는 클래스를 부르는말임!
public class PagingDTO {
	// ***** 페이징 변수 ****** 
	// 1.시작 레코드번호 : LIMIT의 시작값
	private int startNum;
	// 2.페이지당 레코드개수 : LIMIT의 개수
	final private int onePageCnt = 3;
	// 3.전체 레코드수
	private int totalCnt;
	// 4.리스트 그룹수 : 전체개수 ÷ 페이지당개수
	private int listGroup;
	// 5.남은 레코드수 : 리스트 그룹에서 남은 레코드수
	private int etcRecord;	
	// 6.파라미터 형변환 변수(현재 페이지번호)
	private int pageSeq; // 기본값 1(파라미터가 없으면 1들어감!)
	// 7.한계수 체크: 나머지가 있고 없고에 따라 1개차이남
	private int limit;

	// 겟터와 셋터 생성 /////////////////
	// 1.시작 레코드번호 : LIMIT의 시작값
	public int getStartNum() {
		return startNum;
	}
	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}
	// 2.페이지당 레코드개수 : LIMIT의 개수
	// -> final 이므로 셋터가 없다!
	public int getOnePageCnt() {
		return onePageCnt;
	}
	// 3.전체 레코드수
	public int getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
	// 4.리스트 그룹수 : 전체개수 ÷ 페이지당개수
	public int getListGroup() {
		return listGroup;
	}
	public void setListGroup(int listGroup) {
		this.listGroup = listGroup;
	}
	// 5.남은 레코드수 : 리스트 그룹에서 남은 레코드수
	public int getEtcRecord() {
		return etcRecord;
	}
	public void setEtcRecord(int etcRecord) {
		this.etcRecord = etcRecord;
	}
	// 6.파라미터 형변환 변수(현재 페이지번호)
	public int getPageSeq() {
		return pageSeq;
	}
	public void setPageSeq(int pageSeq) {
		this.pageSeq = pageSeq;
	}
	// 7.한계수 체크: 나머지가 있고 없고에 따라 1개차이남
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}

}
