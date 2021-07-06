<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="home.menu.*"%>
<%@ page import="home.source.*" %>
<%@ include file="../top.jsp"%>
<jsp:useBean id="menu_dao" class="home.menu.MenuDAO"/>
<jsp:useBean id="source_dao" class="home.source.SourceDAO"/>

<script>
	function menuCreate(){
		var url = "<%=request.getContextPath()%>/menu/menuCreate.jsp";
		window.open(url, "menuCreate", "width=1000, height=565");
	}
	
	function menuUpdate(id){
		var url = "<%=request.getContextPath()%>/menu/menuUpdate.jsp?id=" + id;
		window.open(url, "menuUpdate", "width=1000, height=565");
	}
	
	function menuDelete(id){
		var url = "<%=request.getContextPath()%>/menu/menuDelete.jsp?id=" + id;
		window.open(url, "menuDelete", "width=1000, height=565");
	}
	
	function searchChange(){
		var select = document.getElementById("search"); 
		var selectIndex = select.selectedIndex; 
		
		if(selectIndex == 0) {			
			document.getElementById("searchString").type = "text";
			document.getElementById("searchString").value = "";
		} else if(selectIndex == 1) {
			document.getElementById("searchString").type = "number";
			document.getElementById("searchString").value = "";
			document.getElementById("searchString").min = "0";
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
						<option value="name" <%if(search != null && search.equals("name")) {%>selected<%}%>>메뉴명
						<option value="price" <%if(search != null && search.equals("price")) {%>selected<%}%>>판매 가격
					</select>
				</td>
				<td width="200" align="center">
					<input type="text" id="searchString" name="searchString" autocomplete="off"
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
			<th>메뉴명</th>
			<th>판매 가격</th>
			<th>소모 재료</th>
			<th>수정 / 삭제</th>
		</tr>

<%
	ArrayList<MenuDTO> menuList = null;
	ArrayList<SourceDTO> sourceList = source_dao.readSource();
	
	if(request.getParameter("search") == null) {
		menuList = menu_dao.readMenu();
	} else {
		menu_dao.setSearchColumn(request.getParameter("search"));
		menu_dao.setSearchValue(request.getParameter("searchString"));
		menuList = menu_dao.searchMenu();
	}
	
	for(MenuDTO dto : menuList) {
		DecimalFormat fmtr = new DecimalFormat("###,###");
		String name = dto.getName();
		int price = dto.getPrice();
		ArrayList<String[]> consumption = dto.getConsumption();
	
%>
		<tr>
			<td align="center"><%=dto.getName()%></td>
			<td align="center"><%=fmtr.format(dto.getPrice()) %></td>
			<td align="center">
				<ul style="list-style:none; padding:0px; margin:0px">
<%
		for(String[] use : consumption) {
			String sourceName = "";
			String unit = "";
			
			for(SourceDTO dto2 : sourceList) {
				if(use[0].equals(Integer.toString(dto2.getId()))) {
					sourceName = dto2.getName();
					unit = dto2.getUnit();
					break;
				}
			}
%>
					<li><%=sourceName%> <%=use[1]%><%=unit%></li>
<%
		}
%>
				</ul>
			</td>
			<td align="center">
				<a href="javascript:menuUpdate(<%=dto.getId()%>)">수정 </a> 
				/
				<a href="javascript:menuDelete(<%=dto.getId()%>)">삭제 </a> 
			</td>
		</tr>
<%
	}
%>
		<tr>
			<td colspan="4" align="center">
				<a href="javascript:menuCreate()" class="myButton2">+</a>
			</td>
		</tr>
	</table>
</div>

<%@ include file="../bottom.jsp"%>