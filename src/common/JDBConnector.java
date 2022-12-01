package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// DB관련 객체 import하기

public class JDBConnector {
	// 1. 연결객체 선언
	public Connection conn;	
	// 2. 쿼리문 저장객체
	public PreparedStatement pstmt;	
	// 3. 결과저장 객체
	public ResultSet rs;
	
	// 생성자 메서드
	public JDBConnector() {
		try {
			System.out.println("나는 처음자바야!");
			// 1. DB 연결 문자열값 만들기!
			String DB_URL = "jdbc:mysql://localhost:3306/mydb";
			// 2. DB 아이디계정 : root는 슈퍼어드민 기본계정임
			String DB_USER = "root";
			// 3. DB 비밀번호 : root는 최초에 비밀번호가 없음
			String DB_PWD = "";
			
			// 8. DB 종류 클래스 등록하기 -> 해당 연결 드라이브 로딩!
			Class.forName("com.mysql.jdbc.Driver");
			
			// 9. DB연결하기
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PWD);
			
			// 10. 성공메시지띄우기
			System.out.println("DB연결 성공하였습니다!");
		} /////// try ////////////////
		catch (Exception e) {
			e.printStackTrace();
		} //// catch ////////
	} ////// 생성자 메서드 /////
	
	// 연결 해제 메서드 ///////
	public void close() {
		try {
			if(conn != null) conn.close();
			if(pstmt != null) pstmt.close();
			if(rs != null) rs.close();
		} /// try ///
		catch (Exception e) {
			e.printStackTrace();
		} /// catch ///
	} /////// close 메서드 ///////////
	
	
	
} //////// 클래스 /////////
