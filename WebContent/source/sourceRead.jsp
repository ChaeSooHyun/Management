<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.util.*"%>
<%@ page import="home.source.*"%>
<%@ include file="../top.jsp"%>
<jsp:useBean id="source_dao" class="home.source.SourceDAO"/>

<script>
	function sourceCreate(){
		var url = "<%=request.getContextPath()%>/source/sourceCreate.jsp";
		window.open(url, "sourceCreate", "width=1000, height=565");
	}
	
	function sourceUpdate(id){
		var url = "<%=request.getContextPath()%>/source/sourceUpdate.jsp?id=" + id;
		window.open(url, "sourceUpdate", "width=1000, height=565");
	}
	
	function sourceDelete(id){
		var url = "<%=request.getContextPath()%>/source/sourceDelete.jsp?id=" + id;
		window.open(url, "sourceDelete", "width=1000, height=565");
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
					<select name="search" style="width:90px">
						<option value="name" <%if(search != null && search.equals("name")) {%>selected<%}%>>재료명
						<option value="unit" <%if(search != null && search.equals("unit")) {%>selected<%}%>>단위
					</select>
				</td>
				<td width="200" align="center">
					<input type="text" name="searchString" autocomplete="off"
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
			<th>재료명</th>
			<th>단위</th>
			<th>수정 / 삭제</th>
		</tr>
<%
	ArrayList<SourceDTO> sourceList = null;	

	if(request.getParameter("search") == null) {
		sourceList = source_dao.readSource();
	} else {
		source_dao.setSearchColumn(request.getParameter("search"));
		source_dao.setSearchValue(request.getParameter("searchString"));
		sourceList = source_dao.searchSource();
	}

	for(SourceDTO dto : sourceList) {
%>
		<tr>
			<td align="center"><%=dto.getName() %></td>
			<td align="center"><%=dto.getUnit() %></td>
			<td align="center">
				<a href="javascript:sourceUpdate(<%=dto.getId()%>)">수정 </a> 
				/
				<a href="javascript:sourceDelete(<%=dto.getId()%>)">삭제 </a> 
			</td>
		</tr>
<%
	}
%>
		<tr>
			<td colspan="3" align="center">
				<a href="javascript:sourceCreate()" class="myButton2">+</a>
			</td>
		</tr>
	</table>
</div>

<%@ include file="../bottom.jsp"%>