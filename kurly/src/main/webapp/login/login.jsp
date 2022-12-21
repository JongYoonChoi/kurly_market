<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	if(request.getParameter("login_state")!=null) {
		session.removeAttribute("url");
	}

	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
	
	String id=(String)session.getAttribute("id");
	if(id==null) {
		id="";
	} else {
		session.removeAttribute("id");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style type="text/css">
#btn_type1 {
cursor:pointer;

}

#message {
	color: red;
    font-weight: bold;
    position: relative;
    left: 2px;
    top: 6px;
    width: 152px;
    white-space: nowrap;
}

</style>
</head>
<body>
	<div id="main">
		<div id="content">
			<div class="section_login">
				<h3 class="tit_login">로그인</h3>
				<div class="write_form">
					<div class="write_view login_view">
						<form  name="form" id="form" action="index.jsp?folder=login&category=login_action" method="post">
							<input type="text" name="id" id ="id" size="20" placeholder="아이디를 입력해주세요" value = "<%=id %>">
							<input type="password" name="passwd" id = "passwd" size="20" placeholder="비밀번호를 입력해주세요">
							<div class="checkbox_save">
								<div class="login_search">
									<a class="link"	href="index.jsp?folder=login&category=Find_id"> 아이디 찾기 </a> <span class="bar"></span> 
									<a class="link"	href="index.jsp?folder=login&category=Find_pw"> 비밀번호 찾기 </a>
								</div>
							<div id="message"><%=message %></div>
							</div>
							<div class="btn_type1" id ="btn_type1">
								<span class="txt_type">로그인</span>
							</div>
						</form>
						<a class="btn_type2 btn_member"	href="index.jsp?folder=login&category=join"> <span class="txt_type">회원가입</span>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	
<script type="text/javascript">

$("#id").focus();

$("#btn_type1").click(function() {
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



	
</body>
</html>