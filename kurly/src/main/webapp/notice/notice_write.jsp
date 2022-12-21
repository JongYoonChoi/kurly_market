<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 게시글(새글 또는 답글)을 입력받기 위한 JSP 문서 --%>
<%-- => 로그인 사용자만 요청 가능한 JSP 문서 --%>
<%-- => [글저장]을 클릭한 경우 form 태그를 이용하여 게시글 저장페이지(notice_write_action.jsp)를
post 방식으로 요청하여 입력값을 전달 --%>

<%-- 비로그인 사용자가 JSP 문서를 요청한 경우 에러 페이지로 이동 - 비정상적인 요청 --%>
<%@include file="/security/login_check.jspf" %>
    
<%-- 새글 : notice_list.jsp 문서에 의해 요청한 경우 - 전달값 : X --%>    
<%-- 답글 : notice_detail.jsp 문서에 의해 요청한 경우 - 전달값 : O >> 부모글(ref,reStep,reLevel,pageNum) --%>

<style type="text/css">
#notice_write {
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
<div id="notice_write">
	<br><br><br><h2 style="text-align: center;">새글 쓰기</h2><br><br>

<form action="index.jsp?folder=notice&category=notice_write_action" method="post" id="noticeForm">
	<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="subject" id="subject" size="60">
			</td>	
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="20" cols="70" name="content" id="notice_content"></textarea>
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