<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="home.source.*" %>
<%@ page import="java.util.*"%>
<jsp:useBean id="source_dao" class="home.source.SourceDAO"/>

<% 
	ArrayList<SourceDTO> sourceList = source_dao.readSource();
%>

<html>
<head>
	<title>재고 추가</title>
	<link rel="stylesheet" type="text/css" href="../style.css">
</head>
<script>
	function idSelected() {
		var s_idArray = new Array(0);
		var unitArray = new Array(0);
<%
	for (SourceDTO dto : sourceList) {
%>
		s_idArray.push("<%=dto.getId()%>");
		unitArray.push("<%=dto.getUnit()%>");
<%
	}
%>
		var select = document.getElementById("s_id"); 
		var selectValue = select.options[select.selectedIndex].value; 
		
		for(var i = 0 ; i < unitArray.length ; i++) {
			if(s_idArray[i] == selectValue) {
				document.getElementById("unit").innerHTML = unitArray[i];
				break;
			}
		}
	}
</script>
<body>
	<div align="center">
		
		<h2> 추 가 하 기 </h2>
		
		<form name="f" action="stockCreate_ok.jsp" method="post">
			<table border="0" class="outline">
				<tr>
					<th>재료명</th>
					<th>업체명</th>
					<th>입고일</th>
					<th>유통기한</th>
					<th>수량</th>
				</tr>
				<tr>
					<td>
						<select id = "s_id" name="source_id" class="box" onChange="idSelected()">
<%
	for (SourceDTO dto : sourceList) {
%>
							<option value="<%=dto.getId() %>"><%=dto.getName() %></option>
<%
	}
%>
						</select>
					</td>
					<td>
						<input type="text" name="company" class="box" autocomplete="off">
					</td>
					<td>
						<input  id="now_date" type="date" name="warehousing_date" class="box">
						<script>document.getElementById('now_date').valueAsDate = new Date();</script>
					</td>
					<td>
						<input type="date" name="shelf_life" class="box">
					</td>
					<td>
						<input type="text" name="amount" class="box" autocomplete="off"
						oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
						<span id = "unit"><%=sourceList.get(0).getUnit() %></span>
					</td>
				</tr>
				<tr>
					<td colspan="5" align="center">
						<input type="submit" value="저장" class="myButton3">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>	