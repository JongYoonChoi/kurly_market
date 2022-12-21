<%@page import="project.dao.PayDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("no")==null || request.getParameter("status")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;			
	}

	//전달값을 반환받아 저장
	int no=Integer.parseInt(request.getParameter("no"));
	int status=Integer.parseInt(request.getParameter("status"));
	
	//아이디와 상태를 전달받아 PAY 테이블에 저장된 회원정보의 상태를 변경하는 DAO 클래스의 메소드 호출
	PayDAO.getDAO().updateStatus(no, status);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?folder=admin&category=pay_manager';");
	out.println("</script>");
%>