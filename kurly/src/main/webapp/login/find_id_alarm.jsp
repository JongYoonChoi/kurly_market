<%@page import = "project.dao.MemberDAO"%>
<%@page import = "project.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%
if (request.getParameter("email") == null) {
	response.sendError(HttpServletResponse.SC_BAD_REQUEST);
	return;
}
String uEamil = request.getParameter("email");

MemberDTO member = MemberDAO.getDAO().selectMemberE(uEamil);
%>
	<div class="ask-alert-wrapper">
		<div class="ask-alert-header">알림메세지</div>
		<div class="ask-alert-content">
			<p class="ask-alert-message">
				사용자의 아이디는 <span class="id"><%=member.getuId() %>
				</span> 입니다.
			</p>
		</div>
		<div class="ask-alert-footer">
		<button class="ask-alert-close-button" onclick= "closeId()">닫기</button>
			<button type="button"  class="styled-button __active" onclick= "closeId()">닫기</button>
		</div>
		
		<script type="text/javascript">
				
		function closeId() {
			window.close();
		}
		</script>
	</div>
