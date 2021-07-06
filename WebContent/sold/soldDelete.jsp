<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.util.*"%>
<%@ page import="home.sold.*" %>
<%@ page import="home.menu.*" %>
<jsp:useBean id="sold_dao" class="home.sold.SoldDAO"/>
<jsp:useBean id="menu_dao" class="home.menu.MenuDAO"/>
<jsp:useBean id="menu_dao2" class="home.menu.MenuDAO"/>

<%
	String id = request.getParameter("id");
	int menu_id = 0;
	int volume = 0;
	String sold_date = null;
	String name = null;
	int price = 0;
	
	MenuDTO m_idDTO = null;
	ArrayList<MenuDTO> menuList = null;
	
	try {
		int id2 = Integer.parseInt(id);
		if (id2 < 1) {
			throw new NumberFormatException();
		}
		
		sold_dao.setSearchColumn("id");
		sold_dao.setSearchValue(id);
		
		ArrayList<SoldDTO> soldList = sold_dao.searchSold();
		
		menu_id = soldList.get(0).getMenu_id();
		volume = soldList.get(0).getVolume();
		sold_date = soldList.get(0).getSold_date();
		
		menu_dao.setSearchColumn("id");
		menu_dao.setSearchValue(Integer.toString(menu_id));
		
		m_idDTO = menu_dao.searchMenu().get(0);
		
		name = m_idDTO.getName();
		price = m_idDTO.getPrice();
		
		menuList = menu_dao2.readMenu();
		
	} catch (NumberFormatException e) {
		id = "0";
	}
%>

<html>
<head>
	<title>매출 삭제</title>
	<link rel="stylesheet" type="text/css" href="../style.css">
</head>
<body>
	<div align="center">
		
		<h2> 삭 제 하 기 </h2>
		
		<form name="f" action="soldDelete_ok.jsp" method="post">
			<table border="0" class="outline">
				<tr>
					<th>판매일</th>
					<th>메뉴명</th>
					<th>판매량</th>
					<th>판매액</th>
				<tr>
					<td>
						<input  id="now_date" type="date" name="sold_date" class="box" value="<%=sold_date%>" readonly>
					</td>
					<td>
						<select id = "m_id" name="menu_id" class="box" readonly
						onFocus="this.initialSelect = this.selectedIndex;" 
        				onChange="this.selectedIndex = this.initialSelect;">
<%
	for (MenuDTO dto : menuList) {
%>
							<option value="<%=dto.getId() %>"
								<%if (dto.getId() == menu_id) {%> selected <%}%>
							><%=dto.getName() %></option>
<%
	}
%>
						</select>
					</td>
					<td>
						<input type="text" id="volume" name="volume" class="box" value="<%=volume %>" readonly>
					</td>
					<td>
						<input type="test" id="price_result" value="<%=volume * price %>" readonly>
					</td>
				</tr>
				<tr>
					<td colspan="4" align="center">
						<input type="hidden" name = "id" value="<%=id%>">
						<input type="submit" value="삭제" class="myButton3">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>	