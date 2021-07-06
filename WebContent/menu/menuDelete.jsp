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
	<title>메뉴 삭제</title>
	<link rel="stylesheet" type="text/css" href="../style.css">
</head>
<body>
	<div align="center">
		
		<h2> 삭 제 하 기 </h2>
		
		<form name="f" action="menuDelete_ok.jsp" method="post">
			<table border="0" class="outline">
				<tr>
					<th>메뉴명</th>
					<th>판매 가격</th>
				</tr>
				<tr>
					<td>
						<input type="text" name="name" class="box" value="<%=name%>" readonly>
					</td>
					<td>
						<input type="text" name="price" class="box" value="<%=price %>" readonly>
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
										<select name="source_id<%=i%>" class="box" readonly
										onFocus="this.initialSelect = this.selectedIndex;" 
        								onChange="this.selectedIndex = this.initialSelect;">
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
										<input type="text" name="amount<%=i%>" class="box" value="<%=consumption.get(i-1)[1]%>" readonly> 
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
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="5" align="center">
						<input type="hidden" name = "id" value="<%=id%>">
						<input type="submit" value="삭제" class="myButton3">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>	