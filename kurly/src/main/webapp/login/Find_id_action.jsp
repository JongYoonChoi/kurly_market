<%@page import="project.dao.MemberDAO"%>
<%@page import="project.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	if(request.getMethod().equals("GET")){
    	out.println("<script type='text/javascript'>");
        out.println("location.href='index.jsp?folder=error&category=error_400';");
        out.println("</script>");
        return;
    }
            	
           	
	String uName = request.getParameter("name");        	
	String uEmail = request.getParameter("email");        
	
	MemberDTO member = MemberDAO.getDAO().selectMemberE(uEmail);
	
	if(member==null) {
		session.setAttribute("message", "가입시 입력하신 회원 정보가 맞는지 다시 한번 확인해주세요.");
		session.setAttribute("u_name", uName);
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=login&category=Find_id';");
		out.println("</script>");
		return;
	}
	
	if(!uEmail.equals(member.getuEmail())) {
		session.setAttribute("message", "가입시 입력하신 회원 정보가 맞는지 다시 한번 확인해주세요. ");
		session.setAttribute("u_email", uEmail);
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=login&category=Find_id';");
		out.println("</script>");
		return;
	}
	
	
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=login&category=login';");
		out.println("</script>");
	
	
	
	
            	
%>