<%@page import="project.dto.NoticeDTO"%>
<%@page import="project.dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 게시글(새글 또는 답글)을 전달받아 notice 테이블에 삽입하고 게시글 목록 출력페이지(notice_list.jsp)로
이동하기 위한 정보를 전달하는 JSP 문서 --%>
<%-- => 로그인 사용자만 요청 가능한 JSP 문서 --%>

<%-- 비로그인 사용자가 JSP 문서를 요청한 경우 에러 페이지로 이동 - 비정상적인 요청 --%>
<%@include file="/security/login_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;		
	}

	String subject=request.getParameter("subject");
	String content=request.getParameter("content");

	//notice_SEQ 시퀸스의 다음값(자동 증가값)을 검색하여 반환하는 DAO 클래스의 메소드 호출
	// => 게시글(새글 또는 답글)의 글번호(NUM 컬럼값)로 저장
	// => 새글인 경우에는 게시글의 그룹번호(REF 컬럼값)로 저장
	int num=NoticeDAO.getDAO().selectNextNum();

	//noticeDTO 객체를 생성하고 필드값 변경
	NoticeDTO notice=new NoticeDTO();
	notice.setNno(num);
	notice.setNtitle(subject);
	notice.setNcontent(content);
	
	//게시글을 전달받아 notice 테이블에 삽입하는 DAO 클래스의 메소드 호출
	NoticeDAO.getDAO().insertNotice(notice);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?folder=notice&category=notice_list&pageNum=1';");
	out.println("</script>");
%>