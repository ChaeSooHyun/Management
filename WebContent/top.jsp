<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>Management 홈페이지</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style.css"> 
</head>
<script>
	function printTime() {
	    var clock = document.getElementById("now"); 
   		var now = new Date();  
    	var nowTime = now.getFullYear() + "년" + (now.getMonth()+1) + "월" + now.getDate() + "일" + now.getHours() + "시" + now.getMinutes() + "분";

    	clock.innerHTML = nowTime;
    	setTimeout("printTime()",1000);       
	}

	window.onload = function() {                
   		printTime();
	}
</script>
	
<body>
	<div align="center">
		<table border="0" style="min-width:800px">
			<tr height="10%">
				<td style="display:flex; padding:0px" align="center">
					<table style="padding:0px	">
						<tr style="padding:0px">
							<td style="padding:0px" width="200px">
								<img src="<%=request.getContextPath()%>/img/Logo.png" width="100px" height="100px"
								onclick="location.href='<%=request.getContextPath()%>/index.jsp'">
							</td>
							<td width="378px">
								<h1 style="text-align: center; font-size:35px">재고 관리 종합 시스템</h1>
							</td>
							<td style="text-align:right; vertical-align : bottom; padding:0px; width:200px" id="now">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr height="10%">
				<td align="center">
					<a class="myButton" href="<%=request.getContextPath()%>/source/sourceRead.jsp">재료 목록</a>
					<a class="myButton" href="<%=request.getContextPath()%>/stock/stockRead.jsp">재고 목록</a>
					<a class="myButton" href="<%=request.getContextPath()%>/menu/menuRead.jsp">메뉴 목록</a>
					<a class="myButton" href="<%=request.getContextPath()%>/sold/soldRead.jsp">매출 목록</a>
				</td>
			</tr>
				<td align="center">

				
				
				
				
				
				
				
				