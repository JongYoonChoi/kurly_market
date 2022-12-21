<%@page import="project.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>
		<div id="container">
			<div id="header">
				<div id="userMenu">
					<ul class="list_menu">
						<li class= "menu lst"><a class = "link_menu">관리자&nbsp;<%=loginMember.getuName() %> 님, 환영합니다.</a>
							<ul class= "sub">
								<li><a href = "#none">주문내역</a></li>
								<li><a href = "#none">개인정보수정</a></li>
								<li><a href = "index.jsp?folder=login&category=logout_action">로그아웃</a></li>
								<% if(loginMember.getuStatus()==1) {//로그인 사용자가 관리자인 경우 %>
								<li><a href = "index.jsp?folder=admin&category=main_page">관리자</a></li>
								<% } %>
							</ul>
						</li>
						<li class="menu lst"><a href="#" class="link_menu">고객센터</a>
							<ul class="sub">
								<li><a href = "index.jsp?folder=notice&category=notice_list">공지사항</a></li>
								<li><a href = "index.jsp?folder=qna&category=qna_list">QNA</a></li>
							</ul>
						</li>
					
					</ul>
				</div>
			</div>
		</div>
		
		<div id="headerLogo" class="layout-wrapper">
			<h1 class="logo">
				<a href="index.jsp?folder=main&category=MainPage" class="link_main"> <span id="gnbLogoContainer"></span>
					<img src="<%=request.getContextPath()%>/product_image/mainlogo.PNG">
				</a>
			</h1>
		</div>
		<div id="gnb">
			<div class="fixed_container">
				<h2 class="screen_out">메뉴</h2>
				<div id="gnbMenu" class="gnb_kurly">
					<div class="inner_gnbkurly">
						<div class="gnb_main">
							<ul class="gnb" style="text-align: center;">
								<li class="menu2"><a href="none" class="link new "><span
										class="txt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span></a></li>
								<li class="menu2"><a href="none" class="link new "><span
										class="txt">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span></a></li>
								<li class="menu2"><a href="index.jsp?folder=admin&category=member_manager" class="link new "><span
										class="txt">회원관리</span></a></li>
								<li class="menu3"><a href="index.jsp?folder=admin&category=product_manager" class="link best "><span
										class="txt">제품관리</span></a></li>
								<li class="menu4"><a href="index.jsp?folder=admin&category=pay_manager" class="link new "><span
										class="txt">주문관리</span></a></li>
								<li class="menu5"><a href="index.jsp?folder=admin&category=qna_manager" class="link best "><span
										class="txt">QNA관리</span></a></li>
							</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
