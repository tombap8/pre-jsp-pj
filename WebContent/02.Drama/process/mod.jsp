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
    
    // 파라미터 정보 가져오기
    String dname = request.getParameter("dname");
    String actors = request.getParameter("actors");
    String broad = request.getParameter("broad");
    String gubun = request.getParameter("gubun");
    String stime = request.getParameter("stime");
    String total = request.getParameter("total");

    out.print(dname+"/"+actors+"/"+broad+"/"+gubun+"/"+stime+"/"+total+"/"+pgnum);

    String DB_URL = "jdbc:mysql://localhost:3306/mydb";
    String DB_USER = "root";
    String DB_PASSWORD= "";

    Connection conn = null;
    PreparedStatement stmt = null;

    // 3) SQL문 준비
    String sql = "UPDATE `drama_info` "+
    "SET "+    "`dname`=?,`actors`=?,`broad`=?,`gubun`=?,`stime`=?,`total`=? "+
    "WHERE `idx`=" + request.getParameter("num");

    out.print("<br>"+sql);

    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

    stmt = conn.prepareStatement(sql);
    stmt.setString(1, dname);
    stmt.setString(2, actors);
    stmt.setString(3, broad);
    stmt.setString(4, gubun);
    stmt.setString(5, stime);
    stmt.setString(6, total);

    // 4) 실행
    stmt.executeUpdate();

    out.println(
        "<script>"+
        "alert(\"업데이트 성공!\");"+
        "location.href = \"../list.jsp?pgnum="+pgnum+"\";"+
        "</script>"
    );


    // JDBC 자원 닫기
    stmt.close();
    conn.close();

}

 catch(Exception e){

  out.print("Exception Error...");
  out.print(e.toString());

 }


%>


</body>
</html>