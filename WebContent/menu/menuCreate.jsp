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
	<title>메뉴 추가</title>
	<link rel="stylesheet" type="text/css" href="../style.css">
</head>
<script>
	function idSelected(count) {
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
		var select = document.getElementById("s_id"+count); 
		var selectValue = select.options[select.selectedIndex].value; 
		
		for(var i = 0 ; i < unitArray.length ; i++) {
			if(s_idArray[i] == selectValue) {
				document.getElementById("unit"+count).innerHTML = unitArray[i];
				break;
			}
		}
	}
	
	var count = 2;
	function rowAdd() {
		var objRow;
		objRow = document.all["tblshow"].insertRow();

		var objCell_Id = objRow.insertCell();
		objCell_Id.innerHTML = "<select id = \"s_id"+count+"\" name=\"source_id"+count+"\" class=\"box\" onChange=\"idSelected("+count+")\"><%for (SourceDTO dto : sourceList) {%><option value=\"<%=dto.getId() %>\"><%=dto.getName() %></option><%}%></select>";

		var objCell_Am = objRow.insertCell();
		objCell_Am.style.paddingLeft = "50px";
		objCell_Am.innerHTML = "<input type=\"text\" name=\"amount"+count+"\" class=\"box\" autocomplete=\"off\" oninput=\"this.value = this.value.replace(/[^0-9.]/g, \'\').replace(/(\\..*)\\./g, \'$1\');\"> <span id = \"unit"+count+"\"><%=sourceList.get(0).getUnit() %></span>";

		document.getElementById("count").value = count;
		count++;
	}
</script>
<body>
	<div align="center">
		<h2> 추 가 하 기 </h2>
		<form name="f" action="menuCreate_ok.jsp" method="post">
			<table border="0" class="outline">
				<tr>
					<th>메뉴명</th>
					<th>판매 가격</th>
				</tr>
				<tr>
					<td>
						<input type="text" name="name" class="box" autocomplete="off">
					</td>
					<td>
						<input type="text" name="price" class="box" autocomplete="off"
						oninput="this.value = this.value.replace(/[^0-9]/g, '');">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<table class="outline" style="width:100%">
							<tr>
								<th>재료명</th>
								<th>수량</th>
							</tr>
							<tbody id="tblshow">
								<tr>
									<td>
										<select id = "s_id1" name="source_id1" class="box" onChange="idSelected(1)">
<%
	for (SourceDTO dto : sourceList) {
%>
											<option value="<%=dto.getId() %>"><%=dto.getName() %></option>
<%
	}
%>
										</select>
									</td>
									<td style="padding-left:50px">
										<input type="text" name="amount1" class="box" autocomplete="off"
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> 
										<span id = "unit1"><%=sourceList.get(0).getUnit() %></span>
									</td>
								</tr>
							</tbody>
							<tr>
								<td colspan="2" align="center">
									<a href="javascript:rowAdd()" id="addBtn" name="addBtn" class="myButton2">+</a>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="5" align="center">
						<input type="hidden" id="count" name="count" value="1">
						<input type="submit" value="저장" class="myButton3">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>	