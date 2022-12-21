<%@page import="project.dao.CartDAO"%>
<%@page import="project.dto.CartDTO"%>
<%@page import="project.dao.ProductDAO"%>
<%@page import="project.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/security/login_url.jspf"%>
<% 		
	

		int pNo=Integer.parseInt(request.getParameter("pNo"));
		int Quantity = Integer.parseInt(request.getParameter("amount"));
	
		ProductDTO product=ProductDAO.getDAO().selectProduct(pNo);
		
		CartDTO cart = new CartDTO();
		cart.setuId(loginMember.getuId());
		cart.setpNo(pNo);
		cart.setQuantity(Quantity);
		cart.setpImg(product.getpImg());
		cart.setpName(product.getpName());
		cart.setpPrice(product.getpPrice());
		
		
		CartDAO.getDAO().insertCart(cart);
		
		
		
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=cart&category=cart';");
		out.println("</script>");	


%>
