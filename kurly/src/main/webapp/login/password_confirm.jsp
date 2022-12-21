<%@page import="util.Utility"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<style>
#message {
	color: red;
    font-weight: bold;
    position: relative;
    width: 152px;
}
</style>

<%@include file="/security/login_check.jspf" %>

<%
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
%>


<div class="page_aticle aticle_type2">
	<jsp:include page="mykurly/left.jsp"/>
		<div class="page_section section_myinfo">
			<div class="head_aticle">
				<h2 class="tit">개인 정보 수정</h2>
			</div>
			<div class="type_form member_join member_pw">
				<div class="field_pw">
					<h3 class="tit">비밀번호 재확인</h3>
					<p class="sub">회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해주세요.</p>
					<form name="confirmForm" method="post" action="index.jsp?folder=login&category=confirm_action">
						<table class="tbl_comm">
							<tbody>
								<tr class="fst">
									<th>아이디</th>
									<td><input type="text" name = "id" id ="id" value="<%=loginMember.getuId() %>" readonly = "readonly" class="inp_read"></td>	
								</tr>
								<tr>
									<th>비밀번호<span class="ico">*<span class="screen_out">필수항목</span></span></th>
									<td>
										<input type="password"	name="password" id="password" class="inp_pw">
										<div id="message"><%=message %></div>
									</td>
								</tr>
							</tbody>
						</table>
					<button type="submit" class="btn active" id ="clear">확인</button>
				</form>
			</div>
		</div>
	</div>
</div>
	
<script type="text/javascript">

$("#id").focus();

$("#clear").click(function() {
	if($("#id").val()=="") {
		alert("아이디를 입력해주세요.");
		$("#id").focus();
		return;
	}
	

	if($("#password").val()=="") {
		alert("비밀번호를 입력해 주세요.");
		$("#password").focus();
		return;
	}


	$("#form").submit();
	
});
	
</script>