<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<html>
<head>
	<title>재료 추가</title>
	<link rel="stylesheet" type="text/css" href="../style.css">
</head>
<body>
	<div align="center">
		
		<h2> 추 가 하 기 </h2>
		
		<form name="f" action="sourceCreate_ok.jsp" method="post">
			<table border="0" class="outline">
				<tr>
					<th>재료명</th>
					<th>단위</th>
				</tr>
				<tr>
					<td>
						<input type="text" name="name" class="box" autocomplete="off">
					</td>
					<td>
						<input type="text" name="unit" class="box" autocomplete="off">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="저장" class="myButton3">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>	