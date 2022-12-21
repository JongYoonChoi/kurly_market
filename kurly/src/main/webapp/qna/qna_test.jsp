<%@page import="project.dao.QnaDAO"%>
<%@page import="project.dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- notice 테이블에 게시글(새글)을 저장하는 JSP 문서 - 테스트 프로그램 --%>
<%
QnaDTO qna=new QnaDTO();
	for(int i=1;i<=2;i++) {
		int num=QnaDAO.getDAO().selectNextNum();
		qna.setQno(num);
		qna.setQname("monkey1004");
		qna.setQtitle("테스트-"+i);
		qna.setRef(num);
		qna.setQcontent("게시글 연습-"+i);
		qna.setQstatus(1);
		QnaDAO.getDAO().insertQna(qna);
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>30개의 테스트 게시글을 저장 하였습니다.</h1>
</body>
</html>