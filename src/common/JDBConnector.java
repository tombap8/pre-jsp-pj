package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class JDBConnector {
	public Connection conn;
	public Statement stmt;
	public PreparedStatement pstmt;
	public ResultSet rs;
	
	// 기본생성자
	public JDBConnector() {
		try {
			// JDBC드라이버 로드
			Class.forName("com.mysql.jdbc.Driver");
			
			// DB에 연결
			String url = "jdbc:mysql://localhost:3306/mydb"; 
			String id = "root";
			String pwd = "";
			
			conn = DriverManager.getConnection(url,id,pwd);
			
			System.out.println("MYSQL DB에 연결하였습니다!");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	} ////////// JDBConnecton 기본생성자 ////////
	

    // 연결 해제(자원 반납)
    public void close() { 
        try {            
            if (rs != null) rs.close(); 
            if (stmt != null) stmt.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close(); 

            System.out.println("JDBC 자원 해제");
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    } /////// 연결해제 메서드 ////////////
}
