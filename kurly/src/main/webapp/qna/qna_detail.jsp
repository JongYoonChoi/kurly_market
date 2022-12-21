<%@page import="project.dto.MemberDTO"%>
<%@page import="project.dao.QnaDAO"%>
<%@page import="project.dto.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	//글번호를 전달받아 qna 테이블에 저장된 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	QnaDTO qna=QnaDAO.getDAO().selectQna(num);
	
	//검색된 게시글이 없거나 삭제된 게시글인 경우 에러 페이지로 이동 - 비정상적 요청
	if(qna==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;		
	}
	
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	if(qna.getQstatus()==2) {//비밀 게시글인 경우
		//비로그인 사용자이거나 로그인 사용자가 게시글 작성자 또는 관리자가 아닌 경우 에러 페이지 이동
		// => 권한이 없는 사용자가 JSP 문서를 요청한 경우 - 비정상적인 요청
		if(loginMember==null || !loginMember.getuId().equals(qna.getQname()) && loginMember.getuStatus()!=1) {
			out.println("<script type='text/javascript'>");
			out.println("location.href='index.jsp?folder=error&category=error_400';");
			out.println("</script>");
			return;	
		}
	}
	
%>    
<style type="text/css">
#qna_detail {
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

#qna_menu {
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

<div id="qna_detail">
	<br><br><br>
	<h1>질문과 답변</h1><br><br>
	<table>
		<tr>
			<th>작성자</th>
			<td style="text-align: center;" >
			<% if(qna.getQname().equals("threeid")){ //작성자 아이디가 관리자일 경우%>
			MarketKurly
			<%} else { %>
				<%=qna.getQname() %>
			<%} %>
			</td>
		</tr>
		<tr>	
			<th>작성일</th>
			<td style="text-align: center;" >
				<%=qna.getQdate().substring(0,10) %>
			</td>
		</tr>
		<tr>	
			<th>제목</th>
			<td style="padding: 10px;" class="subject">
				<%if(qna.getReStep()!=0) {%>
					[답변]
				<%} %>
				<% if(qna.getQstatus()==2) {//비밀글인 경우 %>
					&#128274;
				<% } %>
				<%=qna.getQtitle() %>
			</td>
		</tr>
		<tr>	
			<th>내용</th>
			<td style="padding: 10px;" class="content">
				<%=qna.getQcontent().replace("\n", "<br>") %>
			</td>
		</tr>
	</table>
	
	<div id="qna_menu">
		<% if(loginMember!=null && (loginMember.getuId().equals(qna.getQname()) 
			|| loginMember.getuStatus()==1)) {//로그인 사용자 중 게시글 작성자이거나 관리자인 경우 %>	
			<button type="button" class="w-btn" id="modifyBtn">수정</button>	
			<button type="button" class="w-btn" id="removeBtn">삭제</button>
		<% } %>	
		<% if(loginMember!=null && loginMember.getuStatus()==1) {//로그인 사용자중 관리자인 경우 %>
			<%if(qna.getReLevel()==0) { %>
				<button type="button" class="w-btn" id="replyBtn" class="w-btn">답변쓰기</button>
			<%} %>
		<% } %>	
		<button type="button" class="w-btn" id="listBtn" class="w-btn">목록</button>	
	</div>
	
	<%-- 요청 페이지로 값을 전달하기 위한 form 태그 --%>
	<form method="post" id="menuForm">
		<%-- [수정] 및 [삭제]를 클릭한 경우 전달되는 값 --%>
		<input type="hidden" name="num" value="<%=qna.getQno()%>">

		<%-- [답변쓰기]를 클릭한 경우 전달되는 값 --%>
		<input type="hidden" name="ref" value="<%=qna.getRef()%>">
		<input type="hidden" name="reStep" value="<%=qna.getReStep()%>">
		<input type="hidden" name="reLevel" value="<%=qna.getReLevel()%>">
		
		<%-- [수정] 및 [목록]을 클릭한 경우 전달되는 값 --%>
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="search" value="<%=search%>">
		<input type="hidden" name="keyword" value="<%=keyword%>">
	</form>
</div>

<script type="text/javascript">
$("#modifyBtn").click(function() {
	$("#menuForm").attr("action","index.jsp?folder=qna&category=qna_modify");
	$("#menuForm").submit();
});

$("#removeBtn").click(function() {
	if(confirm("게시글을 삭제 하시겠습니까?")) {	
		$("#menuForm").attr("action","index.jsp?folder=qna&category=qna_remove_action");
		$("#menuForm").submit();
	}
});

$("#replyBtn").click(function() {
	$("#menuForm").attr("action","index.jsp?folder=qna&category=qna_write");
	$("#menuForm").submit();
});

$("#listBtn").click(function() {
	$("#menuForm").attr("action","index.jsp?folder=qna&category=qna_list");
	$("#menuForm").submit();
});
</script>