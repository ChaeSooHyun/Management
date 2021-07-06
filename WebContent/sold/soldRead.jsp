<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="home.sold.*"%>
<%@ page import="home.menu.*" %>
<%@ include file="../top.jsp"%>
<jsp:useBean id="sold_dao" class="home.sold.SoldDAO"/>
<jsp:useBean id="menu_dao" class="home.menu.MenuDAO"/>

<script>
	function soldCreate(){
		var url = "<%=request.getContextPath()%>/sold/soldCreate.jsp";
		window.open(url, "soldCreate", "width=1000, height=565");
	}
	
	function soldUpdate(id){
		var url = "<%=request.getContextPath()%>/sold/soldUpdate.jsp?id=" + id;
		window.open(url, "soldUpdate", "width=1000, height=565");
	}
	
	function soldDelete(id){
		var url = "<%=request.getContextPath()%>/sold/soldDelete.jsp?id=" + id;
		window.open(url, "soldDelete", "width=1000, height=565");
	}
	
	function searchChange(){
		var select = document.getElementById("search"); 
		var selectIndex = select.selectedIndex; 
		
		if(selectIndex == 0) {
			document.getElementById("searchString").type = "text";
			document.getElementById("searchString").value = "";
		} else if(selectIndex == 1) {
			document.getElementById("searchString").type = "date";
			document.getElementById("searchString").valueAsDate = new Date();
		}
	}
</script>
<%
	String search = request.getParameter("search");
	String searchString = request.getParameter("searchString");
%>
<div>
	<form name="searching" method="POST">
		<table height="50">
			<tr>
				<td>
					<select name="search" id="search" onChange="searchChange()" style="width:90px">
						<option value="menu_id" <%if(search != null && search.equals("menu_id")) {%>selected<%}%>>메뉴명
						<option value="sold_date" <%if(search != null && search.equals("sold_date")) {%>selected<%}%>>판매일
					</select>
				</td>
				<td width="200" align="center">
					<input <%if (search != null && search.equals("sold_date")) {%> type="date" <%}
					  	else {%> type="text" <%}%>
					 id="searchString" name="searchString" autocomplete="off"
					<%if (searchString != null) { %>value = "<%=searchString%>"<%}%>>
				</td>
				<td>
					<input type="submit" value="찾기" class="myButton3">
				</td>
			</tr>
		</table>
	</form>
</div>

<div align="center">
	<table width="99%" class="outline">
		<tr>
			<th>판매일</th>
			<th>메뉴명</th>
			<th>판매량</th>
			<th>판매액</th>
			<th>수정 / 삭제</th>
		</tr>
<%
	ArrayList<SoldDTO> soldList = null;
	ArrayList<MenuDTO> menuList = menu_dao.readMenu();
	
	if(request.getParameter("search") == null) {
		soldList = sold_dao.readSold();
	} else {
		sold_dao.setSearchColumn(request.getParameter("search"));
		sold_dao.setSearchValue(request.getParameter("searchString"));
		soldList = sold_dao.searchSold();
	}

	for(SoldDTO dto : soldList) {
		DecimalFormat fmtr = new DecimalFormat("###,###");
		String name = "";
		int price = 0;
		String sold_date = dto.getSold_date();
		
		for(MenuDTO dto2 : menuList) {
			if (dto2.getId() == dto.getMenu_id()) {
				name = dto2.getName();
				price = dto2.getPrice();
				break;
			}
		}
%>
		<tr>
			<td align="center"><%=sold_date%></td>
			<td align="center"><%=name%></td>
			<td align="center"><%=dto.getVolume() %></td>
			<td align="center"><%=fmtr.format(dto.getVolume() * price) %></td>
			<td align="center">
				<a href="javascript:soldUpdate(<%=dto.getId()%>)">수정 </a> 
				/
				<a href="javascript:soldDelete(<%=dto.getId()%>)">삭제 </a> 
			</td>
		</tr>
<%
	}
%>
		<tr>
			<td colspan="5" align="center">
				<a href="javascript:soldCreate()" class="myButton2">+</a>
			</td>
		</tr>
	</table>
</div>

<%@ include file="../bottom.jsp"%>