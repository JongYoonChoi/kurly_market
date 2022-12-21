<%@page import="project.dao.MemberDAO"%>
<%@page import="project.dto.MemberDTO"%>
<%@page import="util.Utility"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;
	}

	String uId = request.getParameter("id");
	String uPw = Utility.encrypt(request.getParameter("passwd"));
	
	
	MemberDTO member = MemberDAO.getDAO().selectMember(uId);
	
	
	if(member==null) {
		session.setAttribute("message", "입력된 아이디가 존재하지 않습니다.");
		session.setAttribute("u_id", uId);
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=login&category=login';");
		out.println("</script>");
		return;
	}
	
	
	if(!uPw.equals(member.getuPw())) {
		session.setAttribute("message", "입력된 아이디가 잘못 되었거나 비밀번호가 맞지 않습니다.");
		session.setAttribute("p_pw", uPw);
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=login&category=login';");
		out.println("</script>");
		return;
	}
	
	
	session.setAttribute("loginMember", MemberDAO.getDAO().selectMember(uId));
	
	
	String url=(String)session.getAttribute("url");
	
	if(url==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=main&category=MainPage';");
		out.println("</script>");
	} else {
		
		session.removeAttribute("url");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+url+"';");
		out.println("</script>");
	}
	
%>    
