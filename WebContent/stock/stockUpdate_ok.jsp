<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="home.stock.StockDAO"%>
<jsp:useBean id="stock_dto" class="home.stock.StockDTO" />
<jsp:setProperty property="*" name="stock_dto"/>
<jsp:useBean id="stock_dao" class="home.stock.StockDAO" />

<%
	boolean boolCompany = stock_dto.getCompany() == null || stock_dto.getCompany().trim().equals("") 
			|| stock_dto.getCompany().getBytes().length > 36;
			
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	int compare = dateFormat.parse(stock_dto.getWarehousing_date()).compareTo(dateFormat.parse(stock_dto.getShelf_life()));

	double amount = stock_dto.getAmount();
	
	int res = 0;
	
	if (!boolCompany && amount > 0 && compare < 0) {
		try {
			if (Integer.parseInt(request.getParameter("id")) > 0) {
				stock_dto.setId(Integer.parseInt(request.getParameter("id")));
				res = stock_dao.updateStock(stock_dto);					
			}
	  	} catch (NumberFormatException e) {
	  		
	  	}
  	}

  	if (res > 0) {
%>
<script type="text/javascript">
	alert("재고 수정 성공")
	window.opener.location.reload();
	self.close()
</script>
<%	
	} else { 
%>
<script type="text/javascript">
	alert("재고 수정 실패")
	window.opener.location.reload();
	self.close()
</script>
<%	
	} 
%>
