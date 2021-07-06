<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.util.*"%>
<%@ page import="home.stock.*" %>
<%@ page import="home.source.*" %>
<jsp:useBean id="stock_dao" class="home.stock.StockDAO"/>
<jsp:useBean id="source_dao" class="home.source.SourceDAO"/>
<jsp:useBean id="source_dao2" class="home.source.SourceDAO"/>

<%
	String id = request.getParameter("id");
	int source_id = 0;
	String company = null;
	String warehousing_date = null;
	String shelf_life = null;	double amount = 0;
	String name = null;
	String unit = null;
	
	SourceDTO s_idDTO = null;
	ArrayList<SourceDTO> sourceList = null;
	
	try {
		int id2 = Integer.parseInt(id);
		if (id2 < 1) {
			throw new NumberFormatException();
		
		}
		
		stock_dao.setSearchColumn("id");
		stock_dao.setSearchValue(id);
		
		ArrayList<StockDTO> stockList = stock_dao.searchStock();
		
		source_id = stockList.get(0).getSource_id();
		company = stockList.get(0).getCompany();
		warehousing_date = stockList.get(0).getWarehousing_date();
		shelf_life = stockList.get(0).getShelf_life();
		amount = stockList.get(0).getAmount();
		
		source_dao.setSearchColumn("id");
		source_dao.setSearchValue(Integer.toString(source_id));
		
		s_idDTO = source_dao.searchSource().get(0);
		
		name = s_idDTO.getName();
		unit = s_idDTO.getUnit();
		
		sourceList = source_dao2.readSource();
		
	} catch (NumberFormatException e) {
		id = "0";
	}
%>

<html>
<head>
	<title>재고 삭제</title>
	<link rel="stylesheet" type="text/css" href="../style.css">
</head>
<body>
	<div align="center">
		
		<h2> 삭 제 하 기 </h2>
		
		<form name="f" action="stockDelete_ok.jsp" method="post">
			<table border="0" class="outline">
				<tr>
					<th>재고명</th>
					<th>업체명</th>
					<th>입고일</th>
					<th>유통기한</th>
					<th>수량</th>
				<tr>
					<td>
						<select id = "s_id" name="source_id" class="box" readonly 
       					onFocus="this.initialSelect = this.selectedIndex;" 
        				onChange="this.selectedIndex = this.initialSelect;">
<%
	for (SourceDTO dto : sourceList) {
%>
							<option value="<%=dto.getId() %>" 
								<%if (dto.getId() == source_id) {%> selected <%}%>
							><%=dto.getName() %></option>
<%
	}
%>
						</select>
					</td>
					<td>
						<input type="text" name="company" class="box" value="<%=company%>" readonly>
					</td>
					<td>
						<input  id="now_date" type="date" name="warehousing_date" class="box" value="<%=warehousing_date%>" readonly>
					</td>
					<td>
						<input type="date" name="shelf_life" class="box" value="<%=shelf_life%>" readonly>
					</td>
					<td>
						<input type="text" name="amount" class="box" value="<%=amount %>" readonly>
						<span id = "unit"><%=unit %></span>
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