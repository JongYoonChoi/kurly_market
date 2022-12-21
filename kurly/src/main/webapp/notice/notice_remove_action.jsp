<%@page import="project.dao.NoticeDAO"%>
<%@page import="project.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 글번호를 전달받아 notice 테이블에 저장된 게시글을 삭제하고 게시글 목록 출력페이지(notice_list.jsp)로
이동하기 위한 정보를 전달하는 JSP 문서 --%>
<%@include file="/security/login_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("num")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;			
	}

	//전달값을 반환받아 저장
	int num=Integer.parseInt(request.getParameter("num"));
	
	//글번호를 전달받아 notice 테이블에 저장된 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	NoticeDTO notice=NoticeDAO.getDAO().selectNotice(num);
	
	//검색된 게시글이 없거나 삭제된 게시글인 경우 에러 페이지로 이동 - 비정상적 요청
	if(notice==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;		
	}	
	
	//로그인 사용자가 게시글 작성자가 아니거나 관리자가 아닌 경우 에러 페이지로 이동 - 비정상적 요청
	if(loginMember.getuStatus()!=1) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;			
	}	
	
	//글번호를 전달받아 Notice 테이블에 저장된 게시글의 상태를 삭제글로 변경하는 DAO 클래스의 메소드 호출
	NoticeDAO.getDAO().deleteNotice(num);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?folder=notice&category=notice_list';");
	out.println("</script>");	
%>