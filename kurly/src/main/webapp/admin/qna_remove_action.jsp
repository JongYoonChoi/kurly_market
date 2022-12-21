<%@page import="project.dao.QnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>
<%
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;			
	}

	String[] checkNo=request.getParameterValues("checkNo");
	
	for(String no:checkNo) {
		QnaDAO.getDAO().deleteQna(Integer.parseInt(no));
	}

	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?folder=admin&category=qna_manager';");
	out.println("</script>");
%>