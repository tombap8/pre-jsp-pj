<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<%
    String DB_URL = "jdbc:mysql://localhost:3306/mydb";
    // DB URL Format = "jdbc:mysql://'DB IP':'Connector Port'/'DB_Name'";

    String DB_USER = "root";
    String DB_PASSWORD= "";
    // DB ID/PASSWORD

    // 변수선언+초기화!
    String dname = ""; 
    String actors = "";
    String broad = ""; 
    String gubun = ""; 
    String stime = ""; 
    String total = ""; 

    Connection conn;
    Statement stmt;
    ResultSet rs = null;

    String query = "SELECT * FROM `drama_info` WHERE `idx`="+
            request.getParameter("num");

    try {
    Class.forName("com.mysql.jdbc.Driver");

    // Load JDBC Class
    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

    // Make Connection
    stmt = conn.createStatement();
    rs = stmt.executeQuery(query);
    // Do Query -> ( SELECT * FROM "test" )
    out.print("쿼리문: "+query+"<br>");
    //out.print("레코드 존재여부: "+rs.next()+"<br>");
    // 주의: 절대 rs.next()를 찍어보지 말것!!!
    // 이걸 쓰는 순간 있는레코드로 라인이 이동된다!
    
        
    if (rs.next()){
        dname = rs.getString("dname");
        actors = rs.getString("actors");
        broad = rs.getString("broad");
        gubun = rs.getString("gubun");
        stime = rs.getString("stime");
        total = rs.getString("total");
    }
    out.print("드라마명: "+dname);
    // 위에서 선언된 데이터변수에 초기화해야 에러안남!


    //Print result to query
    //out.print("result: </br>"+dname);

    

    rs.close();
    stmt.close();
    conn.close();

    }

    catch(Exception e){
    out.print("Exception Error...");
    out.print(e.toString());
    }

    finally {

    }

%>