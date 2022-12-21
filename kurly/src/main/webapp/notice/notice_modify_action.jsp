<%@page import="project.dao.NoticeDAO"%>
<%@page import="project.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 게시글을 전달받아 notice 테이블에 저장된 게시글을 변경하고 게시글 출력페이지(notice_detail.jsp)로
이동하기 위한 정보를 전달하는 JSP 문서 - 글번호, 페이지 번호, 검색 관련 값 전달 --%>
<%@include file="/security/login_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;		
	}	

	//전달값을 반환받아 저장
	int num=Integer.parseInt(request.getParameter("num"));
	String pageNum=request.getParameter("pageNum");
	String subject=request.getParameter("subject");
	String content=request.getParameter("content");
	
	//NoticeDTO 객체를 생성하고 필드값 변경
	NoticeDTO notice=new NoticeDTO();
	notice.setNno(num);
	notice.setNtitle(subject);
	notice.setNcontent(content);
	
	//게시글을 전달받아 notice 테이블에 저장된 게시글을 변경하는 DAO 클래스의 메소드 호출
	NoticeDAO.getDAO().updateNotice(notice);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?folder=notice&category=notice_detail&num="+num+"&pageNum="+pageNum+"';");
	out.println("</script>");	
%>