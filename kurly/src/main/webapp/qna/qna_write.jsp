<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%
	//전달값을 반환받아 저장 - 전달값이 없는 경우(새글인 경우) 초기값 저장
	String ref="0", reStep="0", reLevel="0", pageNum="1";
	if(request.getParameter("ref")!=null) {//전달값이 있는 경우(답글인 경우)
		ref=request.getParameter("ref");
		reStep=request.getParameter("reStep");
		reLevel=request.getParameter("reLevel");
		pageNum=request.getParameter("pageNum");
	}
%>
<style type="text/css">
#qna_write {
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
.ico{
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
<div id="qna_write">
<% if(ref.equals("0")) {//새글인 경우 %>
	<br><br><br><h2 style="text-align: center;">새글 쓰기</h2><br><br>
<% } else {//답글인 경우 %>
	<br><br><br><h2 style="text-align: center;">답글 쓰기</h2><br><br>
<% } %>
<form action="index.jsp?folder=qna&category=qna_write_action" method="post" id="qnaForm">
	<input type="hidden" name="ref" value="<%=ref%>">
	<input type="hidden" name="reStep" value="<%=reStep%>">
	<input type="hidden" name="reLevel" value="<%=reLevel%>">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="subject" id="subject" size="50">
				<label><input type="checkbox" name="secret" value="2"><span class="ico"></span></label>비밀글
			</td>	
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="20" cols="70" name="content" id="qna_content"></textarea>
			</td>	
		</tr>
		<tr>
			<th colspan="2">
				<button type="submit" class="w-btn">작성완료</button>
				<button type="reset" id="resetBtn" class="w-btn">다시쓰기</button>
			</th>
		</tr>
	</table>
</form>
<div id="message" style="color: red;"></div>
</div>

<script type="text/javascript">
$("#subject").focus();

$("#qnaForm").submit(function() {
	if($("#subject").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#subject").focus();
		return false;
	}
	
	if($("#qna_content").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#qna_content").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#subject").focus();
	$("#message").text("");
});
</script>