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
		res = sold_dao.createSold(sold_dto);		
	}

	if (res > 0) {
%>
		<script type="text/javascript">
			alert("매출 등록 성공")
			window.opener.location.reload();
			self.close()
		</script>			
<%	
	} else { 
%>
		<script type="text/javascript">
			alert("매출 등록 실패")
			window.opener.location.reload();
			self.close()
		</script>
<%	
	} 
%>		