<%@page import="project.dto.MemberDTO"%>
<%@page import="project.dao.NoticeDAO"%>
<%@page import="project.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 글번호를 전달받아 notice 테이블에 저장된 게시글을 검색하여 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => [수정]을 클릭한 경우 게시글 수정 입력페이지(notice_modify.jsp)를 요청하여 이동 - 글번호, 페이지번호, 검색대상, 검색단어 전달 --%>
<%-- => [삭제]를 클릭한 경우 게시글 삭제페이지(notice_remove_action.jsp)를 요청하여 이동 - 글번호 전달 --%>
<%-- => [목록]를 클릭한 경우 게시글 목록 출력페이지(notice_list.jsp)를 요청하여 이동 - 페이지번호, 검색대상, 검색단어 전달 --%>
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
	
	//검색된 게시글이 없거나 삭제된 게시글인 경우 에러 페이지로 이동 - 비정상적 요청
	if(notice==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;		
	}
	
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");

%>    
<style type="text/css">
#notice_detail {
	width: 800px;
	margin: 0 auto;
}

table {
	border: none;
	border-collapse: collapse;
	color: #282828;
	font-size: 1.1em;
	margin: 50 px;
}

th, td {
	border-bottom: 1px solid #aaaaaa;
	border-top: 1px solid #aaaaaa;
	padding: 15px;

}

th {
	width: 150px;
	background-color: #f7f5f8; 
}

td {
	width: 650px;
}

.subject, .content {
	text-align: left;
}

.content {
	height: 100px;
	vertical-align: middle;
}

#notice_menu {
	text-align: right;
	margin: 5px;
}

 .w-btn {
   width: 60px; height: 30px;
    border: none;
    font-weight: 600;
    background-color: #5f0080;
    color: white;
    font-size: 1em;
   }
</style>

<div id="notice_detail">
	<br><br><br>
	<h1>공지사항</h1><br><br>
	<table>
		<tr>
			<th>작성자</th>
			<td style="text-align: center;" >
				운영자
			</td>
		</tr>
		<tr>	
			<th>작성일</th>
			<td style="text-align: center;">
				<%=notice.getNdate().substring(0,10) %>
			</td>
		</tr>
		<tr>	
			<th>제목</th>
			<td style="padding: 10px;" class="subject">
				<%=notice.getNtitle() %>
			</td>
		</tr>
		<tr>	
			<th>내용</th>
			<td style="padding: 10px;" class="content">
				<%=notice.getNcontent().replace("\n", "<br>") %>
			</td>
		</tr>
	</table>
	
	<div id="notice_menu">
		<% if(loginMember!=null && loginMember.getuStatus()==1) {//로그인 사용자 중 관리자인 경우 %>	
			<button type="button" id="modifyBtn" class="w-btn">수정</button>	
			<button type="button" id="removeBtn" class="w-btn">삭제</button>
		<% } %>	
		<button type="button" id="listBtn" class="w-btn">목록</button>	
	</div>
	
	<%-- 요청 페이지로 값을 전달하기 위한 form 태그 --%>
	<form method="post" id="menuForm">
		<%-- [수정] 및 [삭제]를 클릭한 경우 전달되는 값 --%>
		<input type="hidden" name="num" value="<%=notice.getNno()%>">

		<%-- [수정] 및 [목록]을 클릭한 경우 전달되는 값 --%>
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
	</form>
</div>

<script type="text/javascript">
$("#modifyBtn").click(function() {
	$("#menuForm").attr("action","index.jsp?folder=notice&category=notice_modify");
	$("#menuForm").submit();
});

$("#removeBtn").click(function() {
	if(confirm("게시글을 삭제 하시겠습니까?")) {	
		$("#menuForm").attr("action","index.jsp?folder=notice&category=notice_remove_action");
		$("#menuForm").submit();
	}
});

$("#listBtn").click(function() {
	$("#menuForm").attr("action","index.jsp?folder=notice&category=notice_list");
	$("#menuForm").submit();
});
</script>
