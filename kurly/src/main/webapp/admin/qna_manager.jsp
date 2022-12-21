<%@page import="project.dto.QnaDTO"%>
<%@page import="project.dao.QnaDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>
<%
	List<QnaDTO> qnaList=QnaDAO.getDAO().allQnaList();
%>    
<style type="text/css">
#qna {
	width: 1000px;
	margin: 0 auto;
	text-align: center;
}

#btn {
	text-align: right;
	margin-bottom: 5px;
}

#removeBtn {
	border: none;
    padding: 10px 20px;
    font-weight: 600;
    background-color: #5f0080;
    color: white;
}

table {
	margin: 20px;
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	border: 1px solid black;
	padding: 3px;
	text-align: center;
	font-size: 12px;
}

th {
	background-color: black;
	color: white; 
}

.qna_check { width: 50px; }
.qna_no { width: 70px; }
.qna_title { width: 200px; }
.qna_content { width: 400px; }
.qna_name { width: 80px; }
.qna_date { width: 120px; }
.qna_status { width: 80px; }
</style>

<div id="qna">
<br><br><br>
<h1>QNA목록</h1>
<form name="qnaForm" id="qnaForm">
	<table>
		<tr>
			<th><input type="checkbox" id="allCheck"></th>
			<th>글번호</th>
			<th>제목</th>
			<th>내용</th>
			<th>아이디</th>
			<th>작성일자</th>
			<th>상태</th>
		</tr>
		
		<% for(QnaDTO qna:qnaList) { %>
		<tr>
			<td class="qna_check">
				<label><input type="checkbox" name="checkNo" value="<%=qna.getQno()%>" class="check">
				<span class="ico"></span></label>
			</td>
			<td class="qna_no"><%=qna.getQno()%></td>
			<td class="qna_title"><%=qna.getQtitle() %></td>
			<td class="qna_content"><%=qna.getQcontent() %></td>
			<td class="qna_name"><%=qna.getQname() %></td>
			<td class="qna_date"><%=qna.getQdate() %></td>
			<td class="qna_status">
				<select class="status" name="<%=qna.getQno() %>">
					<option value="1" <% if(qna.getQstatus()==1) { %> selected="selected" <% } %>>일반글</option>
					<option value="2" <% if(qna.getQstatus()==2) { %> selected="selected" <% } %>>비밀글</option>
				</select>
			</td>
		</tr>
		<% } %>
	</table>
	<p><button type="button" id="removeBtn">선택글삭제</button></p>
	<div id="message" style="color: red;"></div>
</form>
</div>

<script type="text/javascript">
$("#allCheck").change(function() {
	if($(this).is(":checked")) {
		$(".check").prop("checked",true);
	} else {
		$(".check").prop("checked",false);
	}
});

$("#removeBtn").click(function() {
	if($(".check").filter(":checked").length==0) {
		$("#message").text("선택된 글이 하나도 없습니다.");
		return;
	}
	
	$("#qnaForm").attr("action","index.jsp?folder=admin&category=qna_remove_action");
	$("#qnaForm").attr("method","post");
	$("#qnaForm").submit();
});

$(".status").change(function() {
	var no=$(this).attr("name");
	var status=$(this).val();
	
	location.href="index.jsp?folder=admin&category=qna_status_action&no="+no+"&status="+status;
});
</script>