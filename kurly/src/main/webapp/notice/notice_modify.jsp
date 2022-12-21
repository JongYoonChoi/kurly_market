<%@page import="project.dao.NoticeDAO"%>
<%@page import="project.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 글번호를 전달받아 notice 테이블에 저장된 게시글을 검색하여 입력태그의 초기값으로 설정하고
수정값을 입력받기 위한 JSP 문서 --%>
<%-- => 로그인 사용자 중 게시글 작성자이거나 관리자인 경우에 요청 가능한 JSP 문서 --%>
<%-- => [글수정]을 클릭한 경우 form 태그를 이용하여 게시글 저장페이지(notice_modify_action.jsp)를
post 방식으로 요청하여 입력값을 전달 --%>
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
	String pageNum=request.getParameter("pageNum");
	
	//글번호를 전달받아 notice 테이블에 저장된 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	NoticeDTO notice=NoticeDAO.getDAO().selectNotice(num);
	
	//검색된 게시글이 없는경우 에러 페이지로 이동 - 비정상적 요청
	if(notice==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;		
	}	
	
	//로그인 사용자가 관리자가 아닌 경우 에러 페이지로 이동 - 비정상적 요청
	if(loginMember.getuStatus()!=1) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;			
	}
%>
<style type="text/css">
#notice_modify {
	width: 800px;
	margin: 0 auto;
}

table {
	border: none;
	border-collapse: collapse;
	color: #282828;
	font-size: 1.2em;
	margin: 40 px;
}

th, td {
	padding: 15px;
}

th {
	width: 150px;
}

td {
	width: 650px;
}
 .w-btn {
   width: 60px; height: 30px;
    border: none;
    font-weight: 600;
    background-color: #5f0080;
    color: white;
    font-size: 0.8em;
   }
</style>
<div id="notice_modify">
<br><br><br><h2 style="text-align: center;">글수정</h2><br><br>
<form action="index.jsp?folder=notice&category=notice_modify_action" method="post" id="noticeForm">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="subject" id="subject" size="60" value="<%=notice.getNtitle()%>">
			</td>	
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="20" cols="70" name="content" id="notice_content"><%=notice.getNcontent() %></textarea>
			</td>	
		</tr>
		<tr>
			<th colspan="2">
				<button type="submit" class="w-btn">수정</button>
				<button type="reset" id="resetBtn" class="w-btn">다시쓰기</button>
			</th>
		</tr>
	</table>
</form>
<div id="message" style="color: red;"></div>
</div>

<script type="text/javascript">
$("#subject").focus();

$("#noticeForm").submit(function() {
	if($("#subject").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#subject").focus();
		return false;
	}
	
	if($("#notice_content").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#notice_content").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#subject").focus();
	$("#message").text("");
});
</script>