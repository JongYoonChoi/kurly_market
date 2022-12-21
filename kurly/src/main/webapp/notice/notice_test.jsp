<%@page import="project.dao.NoticeDAO"%>
<%@page import="project.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- notice 테이블에 게시글(새글)을 저장하는 JSP 문서 - 테스트 프로그램 --%>
<%
	NoticeDTO notice=new NoticeDTO();
	for(int i=1;i<=50;i++) {
		int num=NoticeDAO.getDAO().selectNextNum();
		notice.setNno(num);
		notice.setNtitle("공지사항-"+i);
		notice.setNcontent("공지사항 연습-"+i);
		NoticeDAO.getDAO().insertNotice(notice);
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>50개의 테스트 게시글을 저장 하였습니다.</h1>
</body>
</html>