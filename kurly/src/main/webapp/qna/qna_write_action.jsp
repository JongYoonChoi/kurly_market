<%@page import="project.dto.QnaDTO"%>
<%@page import="project.dao.QnaDAO"%>
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
	int ref=Integer.parseInt(request.getParameter("ref"));
	int reStep=Integer.parseInt(request.getParameter("reStep"));
	int reLevel=Integer.parseInt(request.getParameter("reLevel"));
	String pageNum=request.getParameter("pageNum");
	//전달값에 태그 관련 기호가 있는 경우 회피문자로 변환하여 저장 - XSS 공격에 대한 방법
	String subject=Utility.escapeTag(request.getParameter("subject"));
	int status=1;
	if(request.getParameter("secret")!=null) {
		status=Integer.parseInt(request.getParameter("secret"));//status=2;
	}
	String content=Utility.escapeTag(request.getParameter("content"));
	
	//qna_SEQ 시퀸스의 다음값(자동 증가값)을 검색하여 반환하는 DAO 클래스의 메소드 호출
	// => 게시글(새글 또는 답글)의 글번호(NUM 컬럼값)로 저장
	// => 새글인 경우에는 게시글의 그룹번호(REF 컬럼값)로 저장
	int num=QnaDAO.getDAO().selectNextNum();
	
	//새글과 답글을 구분하여 qna 테이블의 컬럼값으로 저장될 변수값 변경
	// => hidden 타입으로 전달된 값이 저장된 ref,reStep,reLevel 변수값(새글-초기값,답글-부모글)을 변경
	if(ref==0) {//새글인 경우
		//qna 테이블의 REF 컬럼에는 자동 증가값(num 변수값)을 저장하고 RE_STEP 컬럼과  
		//RE_LEVEL 컬럼에는 0이 저장되도록 변수값 변경
		ref=num;
		//reStep=0;//qna_write.jsp에서 reStep 이름으로 전달된 값이 0이므로 명령 생략 가능
		//reLevel=0;//qna_write.jsp에서 reLevel 이름으로 전달된 값이 0이므로 명령 생략 가능
	} else {//답글인 경우
		//부모글의 ref 변수값과 reStep 변수값을 전달받아 qna 테이블에 저장된 게시글에서 
		//REF 컬럼값과 ref 변수값이 같은 게시글 중 reStep 변수값보다 RE_STEP 컬럼값이 큰 
		//게시글의 RE_STEP 컬럼값이 1 증가되도록 변경하는 DAO 클래스의 메소드 호출
		// => 답글의 검색 순서가 다시 정렬되도록 RE_STEP 컬럼값 변경
		QnaDAO.getDAO().updateReStep(ref, reStep);
		
		//qna 테이블의 REF 컬럼에는 부모글의 전달값을 그대로 저장하고 RE_STEP 컬럼과  
		//RE_LEVEL 컬럼에는 부모글의 전달값을 1 증가한 후 저장되도록 변수값 변경
		reStep++;
		reLevel++;
	}
	
	//qnaDTO 객체를 생성하고 필드값 변경
	QnaDTO qna=new QnaDTO();
	qna.setQno(num);
	qna.setQname(loginMember.getuId());
	qna.setQtitle(subject);
	qna.setRef(ref);
	qna.setReStep(reStep);
	qna.setReLevel(reLevel);
	qna.setQcontent(content);
	qna.setQstatus(status);
	
	//게시글을 전달받아 qna 테이블에 삽입하는 DAO 클래스의 메소드 호출
	QnaDAO.getDAO().insertQna(qna);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?folder=qna&category=qna_list&pageNum="+pageNum+"';");
	out.println("</script>");
%>