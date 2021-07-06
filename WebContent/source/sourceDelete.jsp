<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.util.*"%>
<%@ page import="home.source.*"%>
<jsp:useBean id="source_dao" class="home.source.SourceDAO"/>

<%
	String id = request.getParameter("id");
	String name = null;
	String unit = null;
	
	try {
		int id2 = Integer.parseInt(id);
		if (id2 < 1) {
			throw new NumberFormatException();
		}
		
		source_dao.setSearchColumn("id");
		source_dao.setSearchValue(id);
		
		ArrayList<SourceDTO> sourceList = source_dao.searchSource();
		
		name = sourceList.get(0).getName();
		unit = sourceList.get(0).getUnit();
	} catch (NumberFormatException e) {
		id = "0";
	}
%>

<html>
<head>
	<title>재료 삭제</title>
	<link rel="stylesheet" type="text/css" href="../style.css">
</head>
<body>
	<div align="center">
		
		<h2> 삭 제 하 기 </h2>
		
		<form name="f" action="sourceDelete_ok.jsp" method="post">
			<table border="0" class="outline">
				<tr>
					<th>재고명</th>
					<th>단위</th>
				</tr>
				<tr>
					<td>
						<input type="text" name="name" class="box" value="<%=name%>" readonly>
					</td>
					<td>
						<input type="text" name="unit" class="box" value="<%=unit%>" readonly>
					</td>
				</tr>	
				<tr>
					<td colspan="2" align="center">
						<input type="hidden" name = "id" value=<%=id%>>
						<input type="submit" value="삭제" class="myButton3">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>	