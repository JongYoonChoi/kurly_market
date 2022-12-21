<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.invalidate();
		
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?main=&category=MainPage';");
	out.println("</script>");
%>