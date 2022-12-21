<%@page import="project.dao.MemberDAO"%>
<%@page import="project.dto.MemberDTO"%>
<%@page import="util.Utility"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>   
<%
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;
	}

	

	String uId = request.getParameter("id");
	String uPw = Utility.encrypt(request.getParameter("password"));
	
	MemberDTO member = MemberDAO.getDAO().selectMember(uId);
	
	
	
	if(member== null) {
		session.setAttribute("message", "입력된 아이디가 존재하지 않습니다.");
		session.setAttribute("u_id", uId);
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=login&category=password_confirm';");
		out.println("</script>");
		return;
	}
	
	
	if(!uPw.equals(member.getuPw())) {
		session.setAttribute("message", "비밀번호가 정확한지 다시한번 확인해주세요.");
		session.setAttribute("u_pw", uPw);
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=login&category=password_confirm';");
		out.println("</script>");
		return;
	}
	
		
	
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=login&category=modify';");
		out.println("</script>");
	
	
%>    