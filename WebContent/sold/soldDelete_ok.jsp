<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="sold_dao" class="home.sold.SoldDAO" />

<%
	String id = request.getParameter("id");
	int res = 0;
	
	try {
		if (Integer.parseInt(id) > 0) {
			res = sold_dao.deleteSold(Integer.parseInt(id));					
		}
  	} catch (NumberFormatException e) {
  		
  	}

  	if (res > 0) {
%>
<script type="text/javascript">
	alert("매출 삭제 성공")
	window.opener.location.reload();
	self.close()
</script>
<%	
	} else { 
%>
<script type="text/javascript">
	alert("매출 삭제 실패")
	window.opener.location.reload();
	self.close();
</script>
<%	
	} 
%>

