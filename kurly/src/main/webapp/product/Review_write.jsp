<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 게시글(새글 또는 답글)을 입력받기 위한 JSP 문서 --%>
<%-- => 로그인 사용자만 요청 가능한 JSP 문서 --%>
<%-- => [글저장]을 클릭한 경우 form 태그를 이용하여 게시글 저장페이지(board_write_action.jsp)를
post 방식으로 요청하여 입력값을 전달 --%>

<%-- 비로그인 사용자가 JSP 문서를 요청한 경우 에러 페이지로 이동 - 비정상적인 요청 --%>
<%@include file="/security/login_check.jspf" %>
    
<%-- 새글 : board_list.jsp 문서에 의해 요청한 경우 - 전달값 : X --%>    
<%-- 답글 : board_detail.jsp 문서에 의해 요청한 경우 - 전달값 : O >> 부모글(ref,reStep,reLevel,pageNum) --%>
<%
	//전달값을 반환받아 저장 - 전달값이 없는 경우(새글인 경우) 초기값 저장
	String pageNum="1";
		pageNum=request.getParameter("pageNum");
%>
<style type="text/css">
table {
	margin: 0 auto;
}

th {
	width: 70px;
	font-weight: normal;
}

td {
	text-align: left;
}
</style>
	<h2>새글 쓰기</h2>
<form action="index.jsp?folder=product&category=Review_write_action" method="post" >
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name = "pTitle" size="40">
			</td>	
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="7" name = "pContent" cols="60" ></textarea>
			</td>	
		</tr>
		<tr>
			<th colspan="2">
				<button type="submit">글저장</button>
			</th>
		</tr>
	</table>
</form>
<div id="message" style="color: red;"></div>

<script type="text/javascript">
$("#subject").focus();

$("#boardForm").submit(function() {
	if($("#subject").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#subject").focus();
		return false;
	}
	
	if($("#board_content").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#board_content").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#subject").focus();
	$("#message").text("");
});
</script>







