<%@page import="project.dao.CartDAO"%>
<%@page import="project.dto.CartDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf"%>
<%
	if(request.getParameter("pNo")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;			
	}
	
	int pNo=Integer.parseInt(request.getParameter("pNo"));
	String uId = loginMember.getuId();
	
	CartDAO.getDAO().deleteCart(pNo,uId);
	
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?folder=cart&category=cart';");
	out.println("</script>");	
	
%>	
	