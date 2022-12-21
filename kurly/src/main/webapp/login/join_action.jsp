<%@page import = "project.dao.MemberDAO"%>
<%@page import = "project.dto.MemberDTO"%>
<%@page import = "util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
		
    if(request.getMethod().equals("GET")){
            		out.println("<script type='text/javascript'>");
            		out.println("location.href='index.jsp?folder=error&category=error_400';");
            		out.println("</script>");
            		return;
            	}
   
            	String uId = request.getParameter("id");
            	String uName = request.getParameter("name");
            	String uPw =Utility.encrypt(request.getParameter("password"));
            	String uAddressU= request.getParameter("address1");
            	String uAddressD = request.getParameter("address2");
            	String uAddressN = request.getParameter("zipcode");
            	String uPhone = request.getParameter("mobile1") + "-" + request.getParameter("mobile2") + "-"
                    	+ request.getParameter("mobile3");
            	String uEmail = request.getParameter("email");
            	
            	
            	
            	
            	MemberDTO member=new MemberDTO();
            	
            	member.setuId(uId);
				member.setuName(uName);
				member.setuPw(uPw);
				member.setuAddressU(uAddressU);
				member.setuAddressD(uAddressD);
				member.setuAddressN(uAddressN);
				member.setuPhone(uPhone);
				member.setuEmail(uEmail);
						
				
            	MemberDAO.getDAO().insertMember(member);
            	 
            	out.println("<script type='text/javascript'>");
            	out.println("location.href='index.jsp?folder=login&category=login';");
            	out.println("</script>");
            	 
    %>