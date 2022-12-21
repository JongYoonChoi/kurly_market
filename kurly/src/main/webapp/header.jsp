<%@page import="project.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	MemberDTO loginMember = (MemberDTO)session.getAttribute("loginMember");

	if (loginMember==null){ 
%>

<div id="wrap" >
	<div id="container">
		<div id="header">
			<div id="userMenu">
				<ul class="list_menu">
					<li class="menu none_sub menu_join">
						<a href="index.jsp?folder=login&category=join" class="link_menu">회원가입</a></li>
						<li class="menu none_sub menu_login"><a href="index.jsp?folder=login&category=login" class="link_menu">로그인</a></li>
						<li class="menu lst">
							<a href="#" class="link_menu">고객센터</a>
							<ul class="sub">
								<li><a href="index.jsp?folder=notice&category=notice_list">공지사항</a></li>
								<li><a href="index.jsp?folder=qna&category=qna_list">QNA</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<%} else {%>
		<div id="wrap" >
		<div id="container">
			<div id="header">
				<div id="userMenu">
					<ul class="list_menu">
						<li class= "menu lst">
							<a class = "link_menu"><%=loginMember.getuName() %> 님, 환영합니다.</a>
							<ul class= "sub">
								<li><a href = "index.jsp?folder=mypage&category=PayStatus">주문내역</a></li>
								<li><a href = "index.jsp?folder=login&category=password_confirm">개인정보수정</a></li>
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
		<% } %>
		<div id="headerLogo" class="layout-wrapper">
			<h1 class="logo">
				<a href="index.jsp?folder=main&category=MainPage" class="link_main"> 
					<span id="gnbLogoContainer"></span>
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
							<ul class="gnb" id = "top_list">
								<li>
									<button class="menu1"  onclick = "showHide()" ><a id = "top" >
										<span class="ico"></span>
										<span class="txt" >전체 카테고리</span></a>
									</button>
									<ul class="item_lists"  >
										<li>
											<ul>
												<a href = "index.jsp?folder=product&category=Product_list_fresh" class="sub_menu1"  >
													<span class="tit"><span class="txt">채소/과일/신선식품</span></span>
												</a> 
											</ul>
											<ul>
												<a href = "index.jsp?folder=product&category=Product_list_dish" class="sub_menu2">
													<span class="tit"><span class="txt">국/반찬/메인요리</span></span>
												</a> 
											</ul>
											<ul>
												<a href = "index.jsp?folder=product&category=Product_list_easy" class="sub_menu3">
													<span class="tit"><span class="txt">샐러드/간편식/밀키트</span></span>
												</a> 
											</ul>
										</li>
									</ul>	
									<script type="text/javascript">
										$(".item_lists").hide();
									
										function showHide(){
							          	  if($('.item_lists').css('display') == 'none'){
							            	$('.item_lists').show();
							       			}else{
							            		$('.item_lists').hide();
							       	 		}
							        	};		
									</script>
								</li>
								<li class="menu2">
									<a href="#" class="link new ">
										<span class="txt">신상품</span>
									</a>
								</li>
								<li class="menu3">
									<a href="#" class="link best ">
										<span class="txt">베스트</span>
									</a>
								</li>
							</ul>
							<div class="cart_count">
								<div class="inner_cartcount">
									<a href="index.jsp?folder=cart&category=cart" class="btn_cart">
										<span class="screen_out">장바구니</span>
										<span id="cart_item_count" class="num realtime_cartcount" style="display: none;"></span>
									</a>
								</div>
								<div id="addMsgCart" class="msg_cart">
									<span class="point"></span>
									<div class="inner_msgcart">
										<img src="https://res.kurly.com/images/common/bg_1_1.gif" class="thumb">
										<p id="msgReaddedItem" class="desc">
											<span class="tit"></span> 
											<span class="txt"> 장바구니에 상품을 담았습니다. <span class="repeat">이미 담으신 상품이 있어 추가되었습니다.</span>
											</span>
										</p>
									</div>
								</div>
							</div>
							<div class="gnbPick">
								<a href="#" class="btn_pick">찜한 상품 보기</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
