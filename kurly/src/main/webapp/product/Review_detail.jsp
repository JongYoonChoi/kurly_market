<%@page import="java.util.List"%>
<%@page import="project.dto.ProductDTO"%>
<%@page import="project.dao.ProductDAO"%>
<%@page import="project.dto.MemberDTO"%>
<%@page import="project.dao.ReviewDAO"%>
<%@page import="project.dto.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 글번호를 전달받아 Review 테이블에 저장된 게시글을 검색하여 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => [글변경]을 클릭한 경우 게시글 변경 입력페이지(Review_modify.jsp)를 요청하여 이동 - 글번호, 페이지번호, 검색대상, 검색단어 전달 --%>
<%-- => [글삭제]를 클릭한 경우 게시글 삭제페이지(Review_remove_action.jsp)를 요청하여 이동 - 글번호 전달 --%>
<%-- => [답글쓰기]를 클릭한 경우 게시글 입력페이지(Review_write.jsp)를 요청하여 이동 - 답글그룹번호, 답글순서, 답글깊이, 페이지번호 전달 --%>
<%-- => [글목록]를 클릭한 경우 게시글 목록 출력페이지(Review_list.jsp)를 요청하여 이동 - 페이지번호, 검색대상, 검색단어 전달 --%>
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
	
	//글번호를 전달받아 Review 테이블에 저장된 게시글을 검색하여 반환하는 DAO 클래스의 메소드 호출
	ReviewDTO Review=ReviewDAO.getDAO().selectReview(num);
	
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");

	
	List<ProductDTO> productList = ProductDAO.getDAO().selectAllProductList();
%>    
<style type="text/css">
#Review_detail {
	width: 500px;
	margin: 0 auto;
}

table {
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	border: 1px solid black;
	padding: 5px;
}

th {
	width: 100px;
	background-color: black;
	color: white; 
}

td {
	width: 400px;
}

.subject, .content {
	text-align: left;
}

.content {
	height: 100px;
	vertical-align: middle;
}

#Review_menu {
	text-align: right;
	margin: 5px;
}
</style>

<div id="Review_detail">
	<h2>게시글</h2>
	<table>
		<tr>
			<th>작성자</th>
			<td>
				<%=Review.getpUser() %>
			</td>
		</tr>
		<tr>	
			<th>작성일</th>
			<td>
				<%=Review.getpDate() %>
			</td>
		</tr>
		<tr>	
			<th>제목</th>
			<td class="subject">
				<%=Review.getpTitle() %>
			</td>
		</tr>
		<tr>	
			<th>내용</th>
			<td class="content">
				<%=Review.getpContent().replace("\n", "<br>") %>
			</td>
		</tr>
	</table>
	
	<div id="Review_menu">
		<% if(loginMember!=null && (loginMember.getuId().equals(Review.getpUser()) 
			|| loginMember.getuStatus()==1)) {//로그인 사용자 중 게시글 작성자이거나 관리자인 경우 %>	
			<button type="button" id="removeBtn">글삭제</button>
		<% } %>	
	</div>
	
	<%-- 요청 페이지로 값을 전달하기 위한 form 태그 --%>
	<form method="post" id="menuForm">
		<%-- [글변경] 및 [글삭제]를 클릭한 경우 전달되는 값 --%>
		<input type="hidden" name="num" value="<%=Review.getrNo()%>">
		
		<%-- [글변경] 및 [글목록]을 클릭한 경우 전달되는 값 --%>
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
	</form>
</div>

<script type="text/javascript">

$("#removeBtn").click(function() {
	if(confirm("게시글을 삭제 하시겠습니까?")) {	
		$("#menuForm").attr("action","index.jsp?folder=product&category=Review_remove_action");
		$("#menuForm").submit();
	}
});

</script>













