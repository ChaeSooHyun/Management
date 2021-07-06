<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="home.sold.SoldDAO"%>
<jsp:useBean id="sold_dto" class="home.sold.SoldDTO" />
<jsp:setProperty property="*" name="sold_dto"/>
<jsp:useBean id="sold_dao" class="home.sold.SoldDAO" />

<%
	int volume = sold_dto.getVolume();
	
	int res = 0;
	
	if (volume > 0) {
		try {
			if (Integer.parseInt(request.getParameter("id")) > 0) {
				sold_dto.setId(Integer.parseInt(request.getParameter("id")));
				res = sold_dao.updateSold(sold_dto);					
			}
	  	} catch (NumberFormatException e) {
	  		
	  	}
  	}

  	if (res > 0) {
%>
<script type="text/javascript">
	alert("매출 수정 성공")
	window.opener.location.reload();
	self.close()
</script>
<%	
	} else { 
%>
<script type="text/javascript">
	alert("매출 수정 실패")
	window.opener.location.reload();
	self.close()
</script>
<%	
	} 
%>
