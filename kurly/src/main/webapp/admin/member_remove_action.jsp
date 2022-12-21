<%@page import="project.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 아이디 목록을 전달받아 MEMBER 테이블에 저장된 회원정보를 삭제하고 회원목록 출력페이지
(member_manager.jsp)로 이동하기 위한 정보를 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 관리자만 요청 가능한 JSP 문서 --%>
<%@include file="/security/admin_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;			
	}

	//체크박스로 선택되어 전달된 모든 회원의 아이디를 반환받아 저장
	// => 하나의 이름의 여러 개의 값이 전달되므로 request.getParameterValues 메소드 호출
	String[] checkId=request.getParameterValues("checkId");
	
	//배열에 저장된 요소를 하나씩 반복적으로 제공받아 일괄처리
	for(String id:checkId) {
		//아이디를 전달받아 MEMBER 테이블에 저장된 회원정보를 삭제하는 DAO 클래스의 메소드 호출
		MemberDAO.getDAO().deleteMember(id);
	}

	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?folder=admin&category=member_manager';");
	out.println("</script>");
%>