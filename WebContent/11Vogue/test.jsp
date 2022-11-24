<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
	function getit(){
		$.post( "process/test.jsp", { name: "John2", time: "2pm" } , 
				function( data ) {
			  console.log( data.trim());
			});
	}
</script>
</head>
<body>

<button id="my" onclick="getit()">클릭!!!</button>
</body>
</html>