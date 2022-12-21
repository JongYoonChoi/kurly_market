<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="tit_page">
	<h2 class="tit">회원가입</h2>
</div>
<div class="page_article">
	<div class="type_form member_join">
		<form action="index.jsp?folder=login&category=join_action" method="post" id="join">
			<input type="hidden" name="idCheckResult" id="idCheckResult" value="0"> 
			<input type="hidden" name="emailCheckResult" id="emailCheckResult" value="0">
			<p class="page_sub">
				<span class="ico">*</span>필수입력사항
			</p>
			<table class="tbl_comm">
				<tr class="fst">
					<th>아이디<span class="ico">*</span></th>
					<td>
						<input type="text" name="id" id="id" 	placeholder="6자 이상의 영문 혹은 영문과 숫자를 조합"> 
						<span class="btn default" id="idCheck">중복확인</span>
						<div id="idMsg" class="error">아이디를 입력해주세요</div>
						<div id="idRegMsg" class="error">6자 이상의 영문 혹은 영문과 숫자를 조합</div>
						<div id="idCheckMsg" class="error">아이디 중복확인</div>
					</td>
				</tr>
				<tr>
					<th>비밀번호<span class="ico">*</span></th>
					<td>
						<input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요">
						<div id="passwdMsg" class="error">비밀번호를 입력해 주세요</div>
						<div id="passwdRegMsg" class="error">10~16 자리, 영문/숫자/특수문자(공백
							제외)만 허용하며, 2개 이상 조합</div>
					</td>
				</tr>
				<tr class="member_pwd">
					<th>비밀번호확인<span class="ico">*</span></th>
					<td>
						<input type="password" name="repassword" id ="repassword"placeholder="비밀번호를 한번 더 입력해주세요">
						<div id="repasswdMsg" class="error">비밀번호 확인을 입력해 주세요.</div>
						<div id="repasswdMatchMsg" class="error">동일한 비밀번호를 입력해주세요.</div>
					</td>
				</tr>
				<tr>
					<th>이름<span class="ico">*</span></th>
					<td>
						<input type="text" name="name" id="name" 	placeholder="이름을 입력해주세요">
						<div id="nameMsg" class="error">이름을 입력해 주세요.</div></td>
				</tr>
				<tr>
					<th>이메일<span class="ico">*</span></th>
					<td>
						<input type="text" name="email" class="email" id="email" placeholder="예: marketkurly@kurly.com"> <span
						class="btn default" id="emailCheck">중복확인</span>
						<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
						<div id="emailRegMsg" class="error">올바른 이메일 주소를 입력해해주세요.</div>
						<div id="example_email" class="error">예시 : markeykurly@gmail.com</div>
						<div id="emailCheckMsg" class="error">이메일 중복확인</div>
					</td>
				</tr>
				<tr class="field_phone">
					<th>휴대폰<span class="ico">*</span></th>
					<td>
					<input type="text" name="mobile1" id="mobile1" maxlength="3" >
					<input type="text" name="mobile2" id="mobile2" maxlength="4" >
					<input type="text" name="mobile3" id="mobile3" maxlength="4" >
					<div id="mobileMsg" class="error">전화번호를 입력해 주세요.</div>
					<div id="mobileRegMsg" class="error">11~12자리 숫자로만 입력해 주세요.</div></td>
				</tr>
				<tr>
					<th>주소<span class="ico">*</span></th>
					<td class="field_address">
						<div>
							<div id="wrapper">
								<input type="text" name="zipcode" id="zipcode" size="7"
									readonly="readonly" placeholder="번지를 검색해 주세요."> 
								<a id="addressSearch" class="search"> 
								<span id="addressNo" class="address_no" data-text="재검색">주소 검색</span>
								</a>
							</div>
							<input type="text" name="address1" id="address1"
								readonly="readonly"  placeholder="주소를 검색해주세요."> 
							<input type="text" name="address2" id="address2" placeholder="나머지 주소를 입력해주세요">
							<div id="addressMsg" class="error">번지 또는 주소를 검색해주세요.</div>
							<div id="addressEmpty" class="error">상세 주소를 입력해주세요.</div>
						</div>
					</td>
					
				</tr>
				</tbody>
			</table>
			<div id="formSubmit" class="form_footer">
				<button type="submit" class="btn active btn_join">가입하기</button>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript">
$("#id").focus();

$("#join").submit(function() {
	var submitResult=true;
	
	$(".error").css("display","none");
	
	var idReg=/^[a-zA-Z]\w{5,19}$/g;
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");
		submitResult=false;
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display","block");
		submitResult=false;
	} else if($("#idCheckResult").val()=="0") {
		$("#idCheckMsg").css("display","block");
		submitResult=false;
	}
		
	var passwdReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	if($("#password").val()=="") {
		$("#passwdMsg").css("display","block");
		submitResult=false;
	} else if(!passwdReg.test($("#password").val())) {
		$("#passwdRegMsg").css("display","block");
		submitResult=false;
	} 
	
	if($("#repassword").val()=="") {
		$("#repasswdMsg").css("display","block");
		submitResult=false;
	} else if($("#password").val()!=$("#repassword").val()) {
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
	if($("#mobile1").val()=="" || $("#mobile2").val()=="" || $("#mobile3").val()==""){
		$("#mobileMsg").css("display","block");
		submitResult=false;
	} else if(!mobile1Reg.test($("#mobile1").val()) || !mobile2Reg.test($("#mobile2").val()) || !mobile3Reg.test($("#mobile3").val())) {
		$("#mobileRegMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#zipcode").val()=="") {
		$("#addressMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#address1").val()=="") {
		$("#addressMsg").css("display","block");
		submitResult=false;
	}
	
	
	
	return submitResult;
});

$("#idCheck").click(function() {
	
	$("#idMsg").css("display", "none");
	$("#idRegMsg").css("display", "none");
	
	var idReg=/^[a-zA-Z]\w{5,19}$/g;
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");
		return;
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display","block");
		return;
	}
	
	window.open("<%=request.getContextPath()%>/login/id_check.jsp?id="+$("#id").val()
			,"idcheck","width=540,height=350,left=700,top=400");
});

$("#id").change(function() {
	$("#idCheckResult").val("0");
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
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$("#addressNo").click(function() {
		new daum.Postcode({
			oncomplete : function(data) {
				join.zipcode.value = data.zonecode;
				
				join.address1.value = data.roadAddress;
			}
		}).open();
	});
</script>

