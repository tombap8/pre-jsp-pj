package com.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConn {
	
	private static Connection conn = null;
	
	public static Connection getConnection() {
		
		String url = "jdbc:mysql://localhost:3306/mydb";
		String user = "root";
		String pwd = "";
		
		if(conn==null) {
			
			try {
				
				Class.forName("com.mysql.jdbc.Driver");
				
				conn = DriverManager.getConnection(url, user, pwd);
				
			} catch (Exception e) {
				System.out.print(e.toString());
			}
		}
		
		return conn;
		
		
	}
	
	public static void close() {
		
		if(conn==null)
			return;
		
		try {
			
			if(!conn.isClosed())
				conn.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		conn = null;
	}
	
	
	

}
