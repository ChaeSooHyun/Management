<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@page import="java.util.ArrayList"%>
<%@ page import="home.menu.MenuDAO"%>
<jsp:useBean id="menu_dto" class="home.menu.MenuDTO" />
<jsp:useBean id="menu_dao" class="home.menu.MenuDAO" />  

<%
	menu_dto.setName(request.getParameter("name"));
	menu_dto.setPrice(Integer.parseInt(request.getParameter("price")));

	boolean boolName = menu_dto.getName() == null || menu_dto.getName().trim().equals("") 
			|| menu_dto.getName().getBytes().length > 36;
	boolean boolAmount = true;
	
	int price = menu_dto.getPrice();
	
	ArrayList<String[]> consumption = new ArrayList<String[]>();
	
	for(int i = 1 ; i <= Integer.parseInt(request.getParameter("count")) ; i++) {
			
		if(request.getParameter("source_id" + i) == null) {
			break;
		}
		String use_0 = "source_id" + i;
		String use_1 = "amount" + i;
		
		String s_id = request.getParameter(use_0);
		String amount = request.getParameter(use_1);
		boolean isOverlap = false;
		
		for(int j = 0 ; j < consumption.size() ; j++) {
			String[] use = consumption.get(j);
			if(use[0].equals(s_id)) {
				try {
					double amount_sum = Double.parseDouble(use[1]) + Double.parseDouble(amount);
					use[1] = Double.toString((double) Math.round(amount_sum * 1000) / 1000);
				} catch (NumberFormatException e) {
					
				}
				consumption.set(j, use);
				isOverlap = true;
			}
		}
		
		if(!isOverlap) {
			String[] use = {s_id, amount};
			consumption.add(use);
		}
	}
	
	for(String[] use : consumption) {
		if(Double.parseDouble(use[1]) <= 0) {
			boolAmount = false;
		}
	}

	menu_dto.setConsumption(consumption);
	
	int res = 0;

	if (!(boolName) && price > 0 && boolAmount) {
		res = menu_dao.createMenu(menu_dto);		
	}

	if (res > 0) {
%>
		<script type="text/javascript">
			alert("메뉴 등록 성공")
			window.opener.location.reload();
			self.close()
		</script>			
<%	
	} else { 
%>
		<script type="text/javascript">
			alert("메뉴 등록 실패")
			window.opener.location.reload();
			self.close()
		</script>
<%	
	} 
%>		