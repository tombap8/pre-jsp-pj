<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>City List</title>
</head>
<body>
<%
// POST 방식의 한글처리
request.setCharacterEncoding("UTF-8");

try{
    
    // 파라미터 받기(파라미터는 처음에 모두 문자형임!)
    String pgnum = request.getParameter("pgnum");

    String DB_URL = "jdbc:mysql://localhost:3306/mydb";
    String DB_USER = "root";
    String DB_PASSWORD= "";

    Connection conn = null;
    PreparedStatement stmt = null;

    // 3) SQL문 준비
    String sql = "DELETE FROM `drama_info` " +
    "WHERE `idx`= " + request.getParameter("num");

    out.print("<br>"+sql);

    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

    stmt = conn.prepareStatement(sql);

    // 4) 실행
    stmt.executeUpdate();

    // JDBC 자원 닫기
    stmt.close();
    conn.close();

    
    out.println(
        "<script>"+
        "alert(\"데이터가 삭제되었습니다!\");"+
        "location.href = \"../list.jsp?pgnum="+pgnum+"\";"+
        "</script>"
    );

}

 catch(Exception e){

  out.print("Exception Error...");
  out.print(e.toString());

 }



%>

</body>
</html>