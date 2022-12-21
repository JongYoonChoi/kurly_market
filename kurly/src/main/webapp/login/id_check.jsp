<%@page import = "project.dao.MemberDAO"%>
<%@page import = "project.dto.MemberDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if (request.getParameter("id") == null) {
	response.sendError(HttpServletResponse.SC_BAD_REQUEST);
	return;
}

String uId = request.getParameter("id");

MemberDTO member = MemberDAO.getDAO().selectMember(uId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림</title>
<link
	href="https://www.kurly.com/shop/data/skin/designgj/section1.css?ver=1.71.2"
	type="text/css" rel="stylesheet">
<style type="text/css">

	
p {
text-align : center;
margin: 10px;

}
.styled-button.__active {
    background-color: #5f0080;
    color: #fff;
}


.id {

color = red;
	
}

button, html input[type=button], input[type=reset], input[type=submit] {
    -webkit-appearance: button;
    cursor: pointer;
}

.styled-button {
    display: inline-block;
   
    border: 1px solid #5f0080;
    text-align: center;
}


</style>
</head>
<body>
	<%
	if (member == null) {
	%>

	<div class="ask-alert-wrapper">
		<div class="ask-alert-header">알림메세지</div>
		<div class="ask-alert-content">
			<p class="ask-alert-message">
				입력된 <span class="id"> [<%=uId%>]
				</span>는 사용 가능한 아이디 입니다.
			</p>
		</div>
		
		<div class="ask-alert-footer">
			<button  class="ask-alert-close-button" onclick = "selectId()">닫기</button>
			<button type="button"  class="styled-button __active" onclick= "selectId()">아이디 사용</button>
		</div>	
		<script type="text/javascript">
				
		function selectId() {
			opener.join.id.value = "<%=uId%>";
			opener.join.idCheckResult.value = "1";
			window.close();

			}
		
	
		</script>
	</div>

	<%} else {%>

	<div class="ask-alert-wrapper">
		<div class="ask-alert-header">알림메세지</div>
		<div class="ask-alert-content">
			<p class="ask-alert-message">
				입력된 <span class="id">[<%=uId%>]
				</span>는 이미 사용중인 아이디 입니다.
			</p>
		</div>
		<div class="ask-alert-footer">
		<button class="ask-alert-close-button" onclick= "closeId()">닫기</button>
			<button type="button"  class="styled-button __active" onclick= "closeId()">닫기</button>
		</div>
		
		<script type="text/javascript">
				
		function closeId() {
			opener.join.id.value = "<%=uId%>";
			opener.join.idCheckResult.value = "0";
			window.close();
			}
		</script>
	</div>
	<%}%>
</body>
</html>