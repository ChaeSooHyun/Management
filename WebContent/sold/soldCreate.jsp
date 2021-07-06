<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="home.menu.*" %>
<%@ page import="java.util.*"%>
<jsp:useBean id="menu_dao" class="home.menu.MenuDAO"/>

<% 
	ArrayList<MenuDTO> menuList = menu_dao.readMenu();
%>

<html>
<head>
	<title>매출 추가</title>
	<link rel="stylesheet" type="text/css" href="../style.css">
</head>
<script>
	function idSelected() {
		var m_idArray = new Array(0);
		var priceArray = new Array(0);
<%
	for (MenuDTO dto : menuList) {
%>
		m_idArray.push("<%=dto.getId()%>");
		priceArray.push(<%=dto.getPrice()%>);
<%
	}
%>
		var select = document.getElementById("m_id"); 
		var volume = document.getElementById("volume").value;
		var selectValue = select.options[select.selectedIndex].value;
		
		for(var i = 0 ; i < m_idArray.length ; i++) {
			if(m_idArray[i] == selectValue) {
				document.getElementById("price_result").value = priceArray[i] * Number.parseInt(volume);
				break;
			}
		}
	}
</script>
<body>
	<div align="center">
		
		<h2> 추 가 하 기 </h2>
		
		<form name="f" action="soldCreate_ok.jsp" method="post">
			<table border="0" class="outline">
				<tr>
					<th>판매일</th>
					<th>메뉴명</th>
					<th>판매량</th>
					<th>판매액</th>
				</tr>
				<tr>
					<td>
						<input  id="now_date" type="date" name="sold_date" class="box">
						<script>document.getElementById('now_date').valueAsDate = new Date();</script>
					</td>
					<td>
						<select id = "m_id" name="menu_id" class="box" onChange="idSelected()">
<%
	for (MenuDTO dto : menuList) {
%>
							<option value="<%=dto.getId() %>"><%=dto.getName() %></option>
<%
	}
%>
						</select>
					</td>
					<td>
						<input type="text" id="volume" name="volume" class="box" value="0" autocomplete="off"
						onChange="idSelected()" oninput="this.value = this.value.replace(/[^0-9]/g, '');">
					</td>
					<td>
						<input type="test" id="price_result" value="0" readonly>
					</td>
				</tr>
				<tr>
					<td colspan="4" align="center">
						<input type="submit" value="저장" class="myButton3">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>	