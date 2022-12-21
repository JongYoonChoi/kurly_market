<%@page import="java.text.DecimalFormat"%>
<%@page import="project.dto.MemberDTO"%>
<%@page import="project.dto.CartDTO"%>
<%@page import="project.dao.CartDAO"%>
<%@page import="project.dao.ProductDAO"%>
<%@page import="project.dto.ProductDTO"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
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
<%@include file="/security/login_url.jspf"%>

<div class="tit_page">
	<h2 class="tit">장바구니</h2>
</div>

	
	<div id="cartItemList" class="only_pc">
		<div class="empty">
			<div class="cart_item no_item">
													
				<%
				
				
				String uId = loginMember.getuId();
				
				List<CartDTO> cartList = CartDAO.getDAO().selectCartList(uId);
						
				
				if(cartList==null) { 
				%>
				
				<div class="inner_empty">
					<span class="bg"></span>
					<p class="txt">장바구니에 담긴 상품이 없습니다</p>
					<div class="btn_submit">
						<button type="button" class="btn disabled">상품을 담아주세요</button>
					</div>
				</div>
				
				<%
				} else {
					
				
				for(CartDTO cart:cartList){ 
					
					CartDTO indTotal = CartDAO.getDAO().selectIndTotal(uId, cart.getpNo());		
				%>
			<form action ="index.jsp?folder=cart&category=delete_cart" method = "post">		
				<div class="box cold">
					<ul class="list ">
						<li>
							<div class="item">
								
								<div class="name">
									<div class="inner_name">
										<a href="#" class="package " ><%=cart.getpName() %></a>
										<div class="info"></div>
									</div>
								</div>
								<div class="goods">
									<img class="product_img" src="<%=request.getContextPath()%>/product_image/<%=cart.getpImg()%>">
									<div class="price">
										<div class="in_price">
											<span class="selling">총 가격 : <%=DecimalFormat.getCurrencyInstance().format(indTotal.getIndTotal()) %><span class="won">원</span></span>
											<span class="selling"><span class="won">수량 : <%=cart.getQuantity() %></span></span>
											<p class="noti"></p>
										</div>
									</div>
								</div>
								<div>
								<input type ="hidden" name = "pNo" id = "pNo" value = "<%=cart.getpNo() %>">
								<button type="submit" class="btn_delete" id = "btn_delete">상품 삭제</button>
								</div>
							</div>
							
						</li>
					</ul>
				</div>
			</form>
				<script type="text/javascript">
				$("#btn_delete").click(function{
					action.("");
				
				});
				
				
				
				
				</script>
				
			<%} %>		
			<%} %>	
			</div>
			
			
			
			<% CartDTO totalPrice = CartDAO.getDAO().selectTotalCart(uId);%>
			
			<div class="cart_result">
				<div class="inner_result" >
					<div class="cart_delivery">
						<h3 class="tit">배송지</h3>
						<div class="address">
							<p class="addr"><%=loginMember.getuAddressU()  %></p>
							<p class= "addr"><%=loginMember.getuAddressD()%></p>
						</div>
					</div>
					<div class="amount_view">
						<dl class="amount">
							<dt class="tit">상품금액</dt>
							<dd class="price">
								<span class="num"><%=DecimalFormat.getCurrencyInstance().format(totalPrice.getTotal()) %></span><span class="won">원</span>
							</dd>
						</dl>
						<dl class="amount">
							<dt class="tit">상품할인금액</dt>
							<dd class="price">
								<span class="num">0</span><span class="won">원</span>
							</dd>
						</dl>
						<%if(totalPrice.getTotal() < 25000 && totalPrice.getTotal() > 0) { %>
						<dl class="amount">
							<dt class="tit">배송비</dt>
							<dd class="price">
								<span class="num"><%=DecimalFormat.getCurrencyInstance().format(3000)%></span><span class="won">원</span>
							</dd>
						</dl>
						<dl class="amount lst">
							<dt class="tit">결제예정금액</dt>
							<dd class="price">
								<span class="num"><%=DecimalFormat.getCurrencyInstance().format(totalPrice.getDeTotal()) %></span><span class="won">원</span>
							</dd>
						</dl>
						<%} else if(totalPrice.getTotal() >= 25000 || totalPrice.getTotal() == 0 ){ %>
						<dl class="amount">
							<dt class="tit">배송비</dt>
							<dd class="price">
								<span class="num">0</span><span class="won">원</span>
							</dd>
						</dl>
						<dl class="amount lst">
							<dt class="tit">결제예정금액</dt>
							<dd class="price">
								<span class="num"><%=DecimalFormat.getCurrencyInstance().format(totalPrice.getTotal()) %></span><span class="won">원</span>
							</dd>
						</dl>
									
						<%} %>
						<div class="reserve"></div>
					</div>
					<div class="btn_submit">
						<button type="button" class="btn active" onclick="location.href='index.jsp?folder=pay&category=pay_page';">주문하기</button>
					</div>
					<div class="notice">
						<span class="txt"><span class="ico">·</span>[배송준비중] 이전까지 주문
							취소 가능합니다.</span><span class="txt"><span class="ico">·</span>[마이컬리
							&gt; 개인정보수정 페이지] 에서 주소지를 변경하실수 있습니다.</span>
					</div>
				</div>
			
			</div>
			
		</div>
	</div>




