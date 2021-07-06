<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="stock_dao" class="home.stock.StockDAO" />

<%
	String id = request.getParameter("id");
	int res = 0;
	
	try {
		if (Integer.parseInt(id) > 0) {
			res = stock_dao.deleteStock(Integer.parseInt(id));					
		}
  	} catch (NumberFormatException e) {
  		
  	}

  	if (res > 0) {
%>
<script type="text/javascript">
	alert("재고 삭제 성공")
	window.opener.location.reload();
	self.close()
</script>
<%	
	} else { 
%>
<script type="text/javascript">
	alert("재고 삭제 실패")
	window.opener.location.reload();
	self.close();
</script>
<%	
	} 
%>

