<%@page import="project.dao.MemberDAO"%>
<%@page import="project.dto.MemberDTO"%>
<%@page import="util.Utility"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
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
			<h2 class="tit">개인 정보 수정</h2>
		</div>
		<div class="type_form member_join member_mod">
			<form id="modi" name="modi" method="post" action="index.jsp?folder=login&category=modify_action">
				<table class="tbl_comm">
					<tbody>
						<tr class="fst">
							<th>아이디<span class="ico">*<span class="screen_out">필수항목</span></span></th>
							<td>
								<input type="text" name = "id" id = "id" value="<%=loginMember.getuId() %>" readonly="readonly" class="inp_read">
							</td>
						</tr>
						<tr class="member_pwd">
							<th>새 비밀번호</th>
							<td>
								<input type="password" name="newPassword" id="newPassword"  maxlength="16" class="reg_pw">
								<div id="newpasswdMsg" class="error">비밀번호를 입력해 주세요</div>
								<div id="newpasswdRegMsg" class="error">10~16 자리, 영문/숫자/특수문자(공백
								제외)만 허용하며, 2개 이상 조합</div>
								<div id="newpasswdMatchMsg" class="error">새로운 비밀번호를 입력해주세요 </div>								
							</td>
						</tr>
						<tr class="member_pwd">
							<th>새 비밀번호 확인</th>
							<td>
								<input type="password" name="confirmPassword" id="confirmPassword" maxlength="16" class="confirm_pw">
								<div id="repasswdMatchMsg" class="error">동일한 비밀번호를 입력해주세요.</div>								
							</td>
						</tr>
						<tr>
							<th>이름<span class="ico">*<span class="screen_out">필수항목</span></span></th>
							<td><input type="text" name="name" id= "name" value="<%=loginMember.getuName() %>" placeholder="이름을 입력해주세요"></td>
						</tr>
						<tr>
							<th>이메일<span class="ico">*<span class="screen_out">필수항목</span></span></th>
							<td>
								<input type="text" name="email" id="email"value="<%=loginMember.getuEmail() %>" size="30" placeholder="예: marketkurly@kurly.com">
								<input type="hidden" name="emailCheckResult"  id="emailCheckResult" value="1">
								<a href="#" class="btn default">중복확인</a>
								<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
								<div id="emailRegMsg" class="error">올바른 이메일 주소를 입력해해주세요.</div>
								<div id="example_email" class="error">예시 : markeykurly@gmail.com</div>
							</td>
						</tr>
						<tr class="field_phone">
							<th>휴대폰<span class="ico">*<span class="screen_out">필수항목</span></span></th>
							<td>
								<div class="phone_num">
									<input type="text" name="mobile1" id="mobile1" maxlength="3" >
									<input type="text" name="mobile2" id="mobile2" maxlength="4" >
									<input type="text" name="mobile3" id="mobile3" maxlength="4" >
									<div id="mobileMsg" class="error">전화번호를 입력해 주세요.</div>
									<div id="mobileRegMsg" class="error">11~12자리 숫자로만 입력해 주세요.</div>
								</div>								
							</td>
						</tr>	
						<tr>
							<th>주소<span class="ico">*</span></th>
							<td class="field_address">
								<div>
									<div id="wrapper">
										<input type="text" name="zipcode" id="zipcode" size="7"
											readonly="readonly" value = "<%=loginMember.getuAddressN()%>"> 
										<a id="addressSearch" class="search"> 
										<span id="addressNo" class="address_no" data-text="재검색">주소 검색</span>
										</a>
									</div>
									<input type="text" name="address1" id="address1" readonly="readonly" value = "<%=loginMember.getuAddressU()%>"> 
									<input type="text" name="address2" id="address2" value = "<%=loginMember.getuAddressD	()%>">
									<div id="addressMsg" class="error">번지 또는 주소를 검색해주세요.</div>
									<div id="addressEmpty" class="error">상세 주소를 입력해주세요.</div>
								</div>
							</td>
							
						</tr>					
											
					</tbody>
				</table>
				<div id="formSubmit" class="form_footer">
					<a href="index.jsp?folder=login&category=delete_id" class="btn default">탈퇴하기</a>
					<button type="submit" class="btn active">회원정보수정</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(".error").css("display","none");
	
	$("#modi").submit(function() {
	var submitResult=true;
	
	var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	if($("#newPassword").val()!="" && !passwdReg.test($("#newPassword").val())) {
		$("#newpasswdRegMsg").css("display","block");
		submitResult=false;
	} 
		
	if($("#newPassword").val() != $("#confirmPassword").val()) {
		$("#repasswdMatchMsg").css("display","block");
		submitResult=false;
	} 
	
	if($("#name").val()=="") {
		$("#nameMsg").css("display","block");
		submitResult=false;
	}
	
	var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	if($("#email").val()=="") {
		$("#emailMsg").css("display","block");
		submitResult=false;
	} else if(!emailReg.test($("#email").val())) {
		$("#emailRegMsg").css("display","block");
		$("#example_email").css("display","block");
		submitResult=false;
	}  else if($("#emailCheckResult").val()=="0") {
		$("#emailCheckMsg").css("display","block");
		submitResult=false;
	}
	
	var mobile1Reg=/\d{3}/;
	var mobile2Reg=/\d{3,4}/;
	var mobile3Reg=/\d{4}/;
	if($("#mobile1").val()!="" || $("#mobile2").val()!="" || $("#mobile3").val()!="" && !mobile1Reg.test($("#mobile1").val()) || !mobile2Reg.test($("#mobile2").val()) || !mobile3Reg.test($("#mobile3").val()){
		$("#mobileRegMsg").css("display","block");
		submitResult=false;
	} 
	
	return submitResult;
});

$("#emailCheck").click(function() {
	$("#emailMsg").css("display", "none");
	$("#emailRegMsg").css("display","none");
	$("#example_email").css("display","none");
	
	var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	if($("#email").val()=="") {
		$("#emailMsg").css("display","block");
		return;
	} else if(!emailReg.test($("#email").val())) {
		$("#emailRegMsg").css("display","block");
		$("#example_email").css("display","block");
		return;
	}
		 
	window.open("<%=request.getContextPath()%>/login/email_check.jsp?email="+ $("#email").val(), 
			"emailcheck","width=540,height=350,left=700,top=400");
	});

	$("#email").change(function() {
		$("#emailCheckResult").val("0");
	});
</script>
