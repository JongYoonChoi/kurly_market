<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
String message=(String)session.getAttribute("message");
if(message==null) {
	message="";
} else {
	session.removeAttribute("message");
}
%>
	<div class="css-140915z e13dlrpy2">
		<div class="css-7500ra e13dlrpy0">비밀번호 찾기</div>
		<div class="css-u3y03b e13dlrpy1">
			
			<form id ="find" class="css-s3iz85 e1h5g482" action = "index.jsp?folder=login&category=Find_id_action" method = "post">
				<div class="css-1blp8ou e1h5g481">
					<div class="css-1yjqrpx e1uzxhvi4">
						<label for="name" class="css-c3g9of e1uzxhvi2">아이디</label>
						<div class="css-176lya2 e1uzxhvi1">
							<input id="id" name="id" placeholder="아이디를 입력해 주세요" type="text"
								class="css-upmixo e1uzxhvi0" >
						</div>
					</div>
				</div>
				<div class="css-1blp8ou e1h5g481">
					<div class="css-1yjqrpx e1uzxhvi4">
						<label for="email" class="css-c3g9of e1uzxhvi2">이메일</label>
						<div class="css-176lya2 e1uzxhvi1">
							<input  id="email" name="email"	placeholder="이메일을 입력해 주세요" type="email"
								class="css-upmixo e1uzxhvi0" >
						</div>
					</div>
				</div>
				<div id="message"><%=message %></div>
				<div class="css-3vxi16 e1h5g480">
					<div class="css-1s9rhb5 e4nu7ef2"  id= "clear" >
						<span class="css-1dqhxzp e4nu7ef1" id = "check">확인</span>
					</div>
				</div>
			</form>
		</div>
	</div>
<script type="text/javascript">

$("#id").focus();


$("#clear").click(function() {
	if($("#id").val()=="") {
		alert("가입 시 등록한 아이디를 입력해주세요.");
		$("#id").focus();
		return;
	}
	
	if($("#email").val()=="") {
		alert("가입 시 등록한 이메일을 입력해 주세요.");
		$("#email").focus();
		return;
	}
	
	$("#find").submit();
	
	window.open("<%=request.getContextPath()%>/login/find_pw_alarm.jsp?email="+$("#email").val()
			,"check","width=540,height=350,left=700,top=400");
});	
</script>