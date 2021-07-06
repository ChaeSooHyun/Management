<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="home.menu.*" %>
<%@ page import="home.source.*" %>
<%@ page import="java.util.*"%>
<jsp:useBean id="menu_dao" class="home.menu.MenuDAO"/>
<jsp:useBean id="source_dao" class="home.source.SourceDAO"/>

<% 
	ArrayList<SourceDTO> sourceList = source_dao.readSource();
	String id = request.getParameter("id");
	menu_dao.setSearchColumn("id");
	menu_dao.setSearchValue(id);
	
	String name = null;
	int price = 0;
	ArrayList<String[]> consumption = null;
	ArrayList<MenuDTO> menuList = null;
	
	try {
		int id2 = Integer.parseInt(id);
		if (id2 < 1) {
			throw new NumberFormatException();
		}
		
		menuList = menu_dao.searchMenu();
		
		name = menuList.get(0).getName();
		price = menuList.get(0).getPrice();
		consumption = menuList.get(0).getConsumption();
		
	} catch (NumberFormatException e) {
		id = "0";
	}
%>

<html>
<head>
	<title>메뉴 수정</title>
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
	
	var count = <%=consumption.size() + 1%>;
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
		
		<h2> 수 정 하 기 </h2>
		
		<form name="f" action="menuUpdate_ok.jsp" method="post">
			<table border="0" class="outline">
				<tr>
					<th>메뉴명</th>
					<th>판매 가격</th>
				</tr>
				<tr>
					<td>
						<input type="text" name="name" class="box" value="<%=name%>" autocomplete="off">
					</td>
					<td>
						<input type="text" name="price" class="box" value="<%=price %>" autocomplete="off"
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
<%
	for(int i = 1 ; i <= consumption.size() ; i++) {
%>
								<tr>
									<td>
										<select id = "s_id<%=i%>" name="source_id<%=i%>" class="box"
										onChange="idSelected(<%=i%>)">
<%
		for (SourceDTO dto : sourceList) {
%>
											<option value="<%=dto.getId() %>"
<%
			if(dto.getId() == Integer.parseInt(consumption.get(i - 1)[0])) {
%>
										selected
<%
			}
%>
											><%=dto.getName()%></option>
<%
		}
%>
										</select>
									</td>
									<td style="padding-left:50px">
										<input type="text" name="amount<%=i%>" class="box" value="<%=consumption.get(i-1)[1]%>" autocomplete="off"
										oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> 
										<span id = "unit<%=i%>">
<% 
	for (SourceDTO dto : sourceList) {
		if(dto.getId() == Integer.parseInt(consumption.get(i - 1)[0])) {
%>
										<%=dto.getUnit() %>
<%
		break;
		}
	}
%>
										</span>
									</td>
								</tr>
<%
	}
%>
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
						<input type="hidden" id="count" name="count" value="<%=consumption.size()%>">
						<input type="hidden" name = "id" value="<%=id%>">
						<input type="submit" value="수정" class="myButton3">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>	