<%@page import="project.dao.CartDAO"%>
<%@page import="project.dto.CartDTO"%>
<%@page import="project.dao.PayDAO"%>
<%@page import="project.dto.PayDTO"%>
<%@page import="project.dao.ProductDAO"%>
<%@page import="project.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/security/login_check.jspf"%>
<% 		
	

		int pNo=Integer.parseInt(request.getParameter("pNo"));
		String address=request.getParameter("p_address");
		String msg=request.getParameter("p_msg");
	
		ProductDTO product=ProductDAO.getDAO().selectProduct(pNo);
		CartDTO cart=CartDAO.getDAO().selectCartP(pNo);
		
		PayDTO pay = new PayDTO();
		pay.setPno(pNo);
		pay.setPid(loginMember.getuId());
		pay.setPitem(product.getpName());
		pay.setPamount(cart.getQuantity());
		pay.setPaddress(product.getpName());
		pay.setPmsg(msg);
		pay.setpImg(product.getpImg());
		pay.setpPrice(product.getpPrice());
		
		
		PayDAO.getDAO().insertPay(pay);
		
		
		
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=mypage&category=PayStatus';");
		out.println("</script>");	


%>
