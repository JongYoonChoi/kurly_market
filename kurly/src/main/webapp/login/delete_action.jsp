<%@page import="project.dao.MemberDAO"%>
<%@page import="project.dto.MemberDTO"%>
<%@page import="util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>

  <% 
   
   String uPw = Utility.encrypt(request.getParameter("password"));  
  
   if(!uPw.equals(loginMember.getuPw())) {
		session.setAttribute("message", "입력된 아이디가 잘못 되었거나 비밀번호가 맞지 않습니다.");
		session.setAttribute("p_pw", uPw);
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=login&category=delete_id';");
		out.println("</script>");
		return;
	}
	
   MemberDAO.getDAO().deleteMember(loginMember.getuId());
   
   session.invalidate();
   
   	out.println("<script type='text/javascript'>");
   	out.println("alert(' 회원탈퇴 되셨습니다');");
	out.println("location.href='index.jsp?folder=main&category=MainPage';");
	out.println("</script>");
   
   %>