<%@page import = "project.dao.MemberDAO"%>
<%@page import = "project.dto.MemberDTO"%>
<%@page import="util.Utility"%>
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
    border: none;
    width: 101px;
    text-align: center;
    color: red;
}
.ask-alert-message {
    height: 60px;
    display: table-cell;
    vertical-align: middle;
    font-size: 13px;
    line-height: 1.5;
    text-align: center;
    width: 100%;
    left: 63px !important;
    position: relative !important;
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
	
	<input type ="hidden" name = "email" value = "<%=member.getuEmail() %>">
	<div class="ask-alert-wrapper">
		<div class="ask-alert-header">알림메세지</div>
		<div class="ask-alert-content">
			<p class="ask-alert-message">
				사용자의 임시비밀번호는 <input class="id" name = "pw" value = <%=Utility.newPassword()%>>
				 입니다. 접속후 비밀번호를 변경해주세요.
		
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
