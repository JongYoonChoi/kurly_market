<%@page import="project.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 아이디와 상태를 전달받아 MEMBER 테이블에 저장된 회원정보의 상태를 변경하고 회원목록 출력페이지
(member_manager.jsp)로 이동하기 위한 정보를 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 관리자만 요청 가능한 JSP 문서 --%>
<%@include file="/security/admin_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("id")==null || request.getParameter("status")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;			
	}

	//전달값을 반환받아 저장
	String id=request.getParameter("id");
	int status=Integer.parseInt(request.getParameter("status"));
	
	//아이디와 상태를 전달받아 MEMBER 테이블에 저장된 회원정보의 상태를 변경하는 DAO 클래스의 메소드 호출
	MemberDAO.getDAO().updateStatus(id, status);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?folder=admin&category=member_manager';");
	out.println("</script>");
%>