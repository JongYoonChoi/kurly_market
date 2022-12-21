<%@page import="project.dao.QnaDAO"%>
<%@page import="project.dto.QnaDTO"%>
<%@page import="util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	String subject=Utility.escapeTag(request.getParameter("subject"));
	int status=1;
	if(request.getParameter("secret")!=null) {
		status=Integer.parseInt(request.getParameter("secret"));
	}
	String content=Utility.escapeTag(request.getParameter("content"));
	
	//qnaDTO 객체를 생성하고 필드값 변경
	QnaDTO qna=new QnaDTO();
	qna.setQno(num);
	qna.setQtitle(subject);
	qna.setQcontent(content);
	qna.setQstatus(status);
	
	//게시글을 전달받아 qna 테이블에 저장된 게시글을 변경하는 DAO 클래스의 메소드 호출
	QnaDAO.getDAO().updateQna(qna);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?folder=qna&category=qna_detail&num="+num
		+"&pageNum="+pageNum+"&search="+search+"&keyword="+keyword+"';");
	out.println("</script>");	
%>