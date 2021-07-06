<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="source_dto" class="home.source.SourceDTO" />
<jsp:setProperty property="*" name="source_dto"/>
<jsp:useBean id="source_dao" class="home.source.SourceDAO" />  

<%
	boolean boolName = source_dto.getName() == null || source_dto.getName().trim().equals("") 
			|| source_dto.getName().getBytes().length > 36;
	boolean boolUnit = source_dto.getUnit() == null || source_dto.getUnit().trim().equals("") 
			|| source_dto.getUnit().getBytes().length > 12;
	int res = 0;

	if (!(boolName || boolUnit)) {
		res = source_dao.createSource(source_dto);		
	}

	if (res > 0) {
%>
		<script type="text/javascript">
			alert("재료 등록 성공")
			window.opener.location.reload();
			self.close()
		</script>			
<%	
	} else { 
%>
		<script type="text/javascript">
			alert("재료 등록 실패")
			window.opener.location.reload();
			self.close()
		</script>
<%	
	} 
%>		