<%@page import="project.dao.CartDAO"%>
<%@page import="project.dto.CartDTO"%>
<%@page import="project.dto.PayDTO"%>
<%@page import="project.dao.PayDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="project.dto.ProductDTO"%>
<%@page import="project.dao.PayDAO"%>
<%@page import="project.dto.PayDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_url.jspf"%>

<style>
.only_pc .box .list li .goods .price .in_price {
    position: absolute;
    right: 49px;
    top: 50%;
    width: auto !important;
    transform: translateY(-50%);
 }
 .package{
	position: absolute;
    text-align: center;
    top: 42%;
    left: 192px;
    float: left;
}
img.product_img {

    position: absolute;
    height: 133px;
    width: auto;
    top: 0;
}   
.only_pc .box {
    border-top: 1px solid #f4f4f4 !important;
}
</style>
<% 
	//아이디저장
	String uId = loginMember.getuId();
	//아이디로 주문내역 조회
	List<PayDTO> PayList=PayDAO.getDAO().selectPayList(uId);
	//아이디로 장바구니 조회
	List<CartDTO> CartList=CartDAO.getDAO().selectCartList(uId);
	//주문 갯수 조회
	int totalPay=PayDAO.getDAO().selectPayCount(uId);
	
	System.out.println(PayList);
%>
<div class="tit_page">
	<h2 class="tit">주문내역</h2>
</div>
	<div id="payItemList" class="only_pc">
		<div class="empty">
			<div class="pay_item no_item">
											
				<% if(PayList.isEmpty()) { %>
				
				<div class="inner_empty">
					<span class="bg"></span>
					<p class="txt">주문 내역이 없습니다</p>
					
				</div>
				
				<%
				} else {		
				
				for(PayDTO pay:PayList){ 
				%>	
				<div class="box cold">
					<ul class="list ">
						<li>
							<div class="item">
								
								<div class="name">
									<div class="inner_name">
										<a href="#" class="package " ><%=pay.getPitem()%></a>
										<div class="info"></div>
									</div>
								</div>
								<div class="goods">

									<div class="price">
									<img class="product_img" src="<%=request.getContextPath()%>/product_image/<%=pay.getpImg()%>">
										<div class="in_price">
							
											<span class="selling">총 가격 :  <%=pay.getpPrice() %><span class="won">원</span></span>
											<span class="selling"><span class="won">수량 : <%=pay.getPamount() %></span></span>
											<span class="selling">배송 상태 :  
											<% if (pay.getPstatus()==0) { %> 
												<span class="won">배송 준비중</span>
											<% } else if (pay.getPstatus()==1){%>
												<span class="won">배송 중</span>
											<% } else if (pay.getPstatus()==2){%>
												<span class="won">배송 완료</span>
											<% } %>
											</span>
											<p class="noti"></p>
											
										</div>
									</div>
								</div>
								<div>
								<input type ="hidden" name = "pNo" id = "pNo" value = "<%=pay.getPno() %>">
								</div>
							</div>
							
						</li>
					</ul>
				</div>

				
			<%} %>		
			<%} %>
			</div>
			</div>
			</div>
			