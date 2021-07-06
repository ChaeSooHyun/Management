<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.util.*"%>
<%@ page import="home.stock.*"%>
<%@ page import="home.source.*" %>
<%@ include file="../top.jsp"%>
<jsp:useBean id="stock_dao" class="home.stock.StockDAO"/>
<jsp:useBean id="source_dao" class="home.source.SourceDAO"/>

<script>
	function stockCreate(){
		var url = "<%=request.getContextPath()%>/stock/stockCreate.jsp";
		window.open(url, "stockCreate", "width=1000, height=565");
	}
	
	function stockUpdate(id){
		var url = "<%=request.getContextPath()%>/stock/stockUpdate.jsp?id=" + id;
		window.open(url, "stockUpdate", "width=1000, height=565");
	}
	
	function stockDelete(id){
		var url = "<%=request.getContextPath()%>/stock/stockDelete.jsp?id=" + id;
		window.open(url, "stockDelete", "width=1000, height=565");
	}
	
	function searchChange(){
		var select = document.getElementById("search"); 
		var selectIndex = select.selectedIndex; 
		
		if(selectIndex == 0 || selectIndex == 1) {
			document.getElementById("searchString").type = "text";
			document.getElementById("searchString").value = "";
		} else if(selectIndex == 2 || selectIndex == 3) {
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
						<option value="source_id" <%if(search != null && search.equals("source_id")) {%>selected<%}%>>재고명
						<option value="company" <%if(search != null && search.equals("company")) {%>selected<%}%>>업체명
						<option value="warehousing_date" <%if(search != null && search.equals("warehousing_date")) {%>selected<%}%>>입고일
						<option value="shelf_life" <%if(search != null && search.equals("shelf_life")) {%>selected<%}%>>유통기한
					</select>
				</td>
				<td width="200" align="center">
					<input <%if (search != null && (search.equals("warehousing_date") || search.equals("shelf_life"))) {%> type="date" <%}
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
			<th>재고명</th>
			<th>업체명</th>
			<th>입고일</th>
			<th>유통기한</th>
			<th>수량</th>
			<th>수정 / 삭제</th>
		</tr>
<%
	ArrayList<StockDTO> stockList = null;
	ArrayList<SourceDTO> sourceList = source_dao.readSource();	

	if(request.getParameter("search") == null) {
		stockList = stock_dao.readStock();
	} else {
		stock_dao.setSearchColumn(request.getParameter("search"));
		stock_dao.setSearchValue(request.getParameter("searchString"));
		stockList = stock_dao.searchStock();
	}

	for(StockDTO dto : stockList) {
		String name = "";
		String unit = "";
		for(SourceDTO dto2 : sourceList) {
			if (dto2.getId() == dto.getSource_id()) {
				name = dto2.getName();
				unit = dto2.getUnit();
				break;
			}
		}
%>
		<tr>
			<td align="center"><%=name%></td>
			<td align="center"><%=dto.getCompany() %></td>
			<td align="center"><%=dto.getWarehousing_date() %></td>
			<td align="center"><%=dto.getShelf_life()%></td>
			<td align="center"><%=dto.getAmount() %> <%=unit %></td>
			<td align="center">
				<a href="javascript:stockUpdate(<%=dto.getId()%>)">수정 </a> 
				/
				<a href="javascript:stockDelete(<%=dto.getId()%>)">삭제 </a> 
			</td>
		</tr>
<%
	}
%>
		<tr>
			<td colspan="6" align="center">
				<a href="javascript:stockCreate()" class="myButton2">+</a>
			</td>
		</tr>
	</table>
</div>

<%@ include file="../bottom.jsp"%>