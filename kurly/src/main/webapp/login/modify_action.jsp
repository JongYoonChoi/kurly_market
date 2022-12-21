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
	
	
	
	String uId=request.getParameter("id");
	String uPw=request.getParameter("newPassword");
	
	if(uPw==null || uPw.equals("")) {
		uPw=loginMember.getuPw();
	} else {
		uPw=Utility.encrypt(uPw);
	}
	String uName=request.getParameter("name");
	
	String uPhone = request.getParameter("mobile1") + "-" + request.getParameter("mobile2") + "-"
        	+ request.getParameter("mobile3");
	if(uPhone==null || uPhone.equals("")) {
		uPhone=loginMember.getuPhone();
	}
	
	String uEmail = request.getParameter("email");
	String uAddressU= request.getParameter("address1");
	String uAddressD = request.getParameter("address2");
	String uAddressN = request.getParameter("zipcode");
	
	MemberDTO member=new MemberDTO();
	member.setuId(uId);
	member.setuName(uName);
	member.setuPw(uPw);
	member.setuAddressU(uAddressU);
	member.setuAddressD(uAddressD);
	member.setuAddressN(uAddressN);
	member.setuPhone(uPhone);
	member.setuEmail(uEmail);
	
	MemberDAO.getDAO().updateMember(member);
	
	session.setAttribute("loginMember", MemberDAO.getDAO().selectMember(uId));
	
	
	out.println("<script type='text/javascript'>");
	out.println("alert('회원정보를 수정하셨습니다');");
	out.println("location.href='index.jsp?folder=login&category=password_confirm';");
	out.println("</script>");
%>
