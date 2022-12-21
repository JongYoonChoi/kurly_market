<%@page import="project.dao.MemberDAO"%>
<%@page import="project.dto.MemberDTO"%>
<%@page import="util.Utility"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<style>
#message {
	color: red;
    font-weight: bold;
    position: relative;
    width: 152px;
	left:50%;
	white-space: nowrap;

}
</style>


<%
	String message=(String)session.getAttribute("message");
		if(message==null) {
			message="";
		} else {
			session.removeAttribute("message");
		}

%>


<style type="text/css">
#mobile1, #mobile2, #mobile3 {
	height: 44px;
	width: 110px;
	padding: 0 14px;
	border: 1px solid #ccc;
	font-size: 14px;
	color: #333;
	line-height: 20px;
	border-radius: 3px;
	background: #fff;
	outline: none;
	vertical-align: top;
}
</style>
<div class="page_aticle aticle_type2">
	<jsp:include page="mykurly/left.jsp"/>
	<div class="page_section section_myinfo">
		<div class="head_aticle">
			<h2 class="tit"> 회원 탈퇴 </h2>
		</div>
		<div class="type_form member_join member_mod">
			<form id="modi" name="modi" method="post" action="index.jsp?folder=login&category=delete_action">
				<table class="tbl_comm">
					<tbody>
						<tr class="fst">
							<th>아이디<span class="ico">*<span class="screen_out">필수항목</span></span></th>
							<td>
								<input type="text" name = "id" id = "id" value="<%=loginMember.getuId() %>" readonly="readonly" class="inp_read">
							</td>
						</tr>
						<tr>
							<th>비밀번호<span class="ico">*</span></th>
							<td>
								<input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요">
								<div id="passwdMsg" class="error">비밀번호를 입력해 주세요</div>
								<div id="passwdRegMsg" class="error">10~16 자리, 영문/숫자/특수문자(공백제외)만 허용하며, 2개 이상 조합</div>
							</td>
						</tr>
						
					</tbody>
				</table>
				<div id="message"><%=message %></div>
				<div id="formSubmit" class="form_footer">
				
					<button type="submit" class="btn active">탈퇴</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">


$("#password").focus();

$("#join").submit(function() {
	var submitResult=true;
	
	$(".error").css("display","none");
	
	
	var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	if($("#password").val()=="") {
		$("#passwdMsg").css("display","block");
		submitResult=false;
	} else if(!passwdReg.test($("#password").val())) {
		$("#passwdRegMsg").css("display","block");
		submitResult=false;
	} 
	
		
	
	return submitResult;
});

</script>