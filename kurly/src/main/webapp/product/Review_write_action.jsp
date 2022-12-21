<%@page import="project.dto.ProductDTO"%>
<%@page import="project.dao.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page import="project.dto.ReviewDTO"%>
<%@page import="project.dao.ReviewDAO"%>
<%@page import="util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 게시글(새글 또는 답글)을 전달받아 Review 테이블에 삽입하고 게시글 목록 출력페이지(Review_list.jsp)로
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

	//전달값을 반환받아 저장
	String pageNum=request.getParameter("pageNum");


	//전달값에 태그 관련 기호가 있는 경우 회피문자로 변환하여 저장 - XSS 공격에 대한 방법
	String Title=Utility.escapeTag(request.getParameter("pTitle"));
	String Content=Utility.escapeTag(request.getParameter("pContent"));
	
	//Review_SEQ 시퀸스의 다음값(자동 증가값)을 검색하여 반환하는 DAO 클래스의 메소드 호출
	// => 게시글(새글 또는 답글)의 글번호(NUM 컬럼값)로 저장
	// => 새글인 경우에는 게시글의 그룹번호(REF 컬럼값)로 저장
	int num=ReviewDAO.getDAO().selectNextNum();
	
	//ReviewDTO 객체를 생성하고 필드값 변경
	ReviewDTO review=new ReviewDTO();
	review.setrPno(1);
	review.setrNo(num);
	review.setpUser(loginMember.getuId());
	review.setpTitle(Title);
	review.setpContent(Content);
	
	//게시글을 전달받아 Review 테이블에 삽입하는 DAO 클래스의 메소드 호출
	ReviewDAO.getDAO().insertReview(review);

	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?folder=product&category=Product_review';");
	out.println("</script>");
%>









