	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");

	String folder = request.getParameter("folder");
	if(folder==null) {
		folder = "main";
	}
	
	String category=request.getParameter("category");
	if(category==null){
		category = "MainPage";
	}
	
	String headerPath="header.jsp";
	if(folder.equals("admin")) {
		headerPath="admin/header.jsp";
	}
	
	String contentPath=folder+ "/" + category + ".jsp";
	
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv= "Content-Type" content = "text/html; charset=UTF-8">
<title>kurlykurly</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link
	href="https://www.kurly.com/shop/data/skin/designgj/common.css?ver=1.70.10"
	type="text/css" rel="stylesheet">
<link
	href="https://www.kurly.com/asset/css/cart/list.bundle.css?ver=1.70.10"
	type="text/css" rel="stylesheet">
	
<link href="https://www.kurly.com/shop/goods/goods_cart.php"
	type="text/css" rel="stylesheet">
<link
	href="https://www.kurly.com/shop/data/skin/designgj/normalize.css?ver=1.70.10"
	type="text/css" rel="stylesheet">
	
<link
	href="https://www.kurly.com/shop/main/index.php?utm_source=1055&utm_medium=2206&utm_campaign=home_hashtag&utm_content=brand&utm_term=MARKETKURLY&gclid=CjwKCAjw77WVBhBuEiwAJ-YoJDAwmmk800Va8OQZ7FwzpBbOQ87UCMagSWPG6COFQ2aFb09oWW37wRoCFJ8QAvD_BwE"
	type="text/css" rel="stylesheet">

<link
	href="https://www.kurly.com/shop/data/skin/designgj/common.css?ver=1.71.3"
	type="text/css" rel="stylesheet">
	
<link
	href="https://www.kurly.com/shop/data/skin/designgj/normalize.css?ver=1.71.3"
	type="text/css" rel="stylesheet">

<link
	href="https://www.kurly.com/shop/data/skin/designgj/section1.css?ver=1.71.3"
	type="text/css" rel="stylesheet">	

<link
	href="https://www.kurly.com/shop/data/skin/designgj/swiper.min.css"
	type="text/css" rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.min.css"
	type="text/css" rel="stylesheet">

<link 
	href="css/main.css" 
	rel="stylesheet" type="text/css">

<link 
	href="css/MarketStyle.css" 
	rel="stylesheet" type="text/css">

<link 
	href="css/find_id.css" 
	rel="stylesheet" type="text/css">
<link 
	href="css/join.css" 
	rel="stylesheet" type="text/css">
	
</head>
<body>
	<div id = "header">
		<jsp:include page="<%=headerPath %>"/>
	</div>
	
	<div id = "content">
		<jsp:include page = "<%=contentPath %>"/>
	</div>
	
	<div id = "footer">
		<jsp:include page = "footer.jsp"/>
	</div>
</body>
</html>