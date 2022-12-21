<%@page import="java.text.DecimalFormat"%>
<%@page import="project.dao.ProductDAO"%>
<%@page import="project.dto.ProductDTO"%>
<%@page import="java.util.List"%>

<%@page import="project.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.third_slick button.slick-prev {
	position: absolute;
	z-index: 10;
	top: 40%;
	left: -27px;
	transform: translateY(-50%);
	width: 52px;
	height: 52px;
	border-radius: 100%;
	opacity: 1;
	border: none;
	color: transparent;
	background:
		url(https://s3.ap-northeast-2.amazonaws.com/res.kurly.com/kurly/ico/2021/arrow_list_left_60_60.svg)
		50% 50% no-repeat;
	
}

.third_slick button.slick-next {
	position: absolute;
	z-index: 10;
	top: 40%;
	right: -15px;
	transform: translateY(-50%);
	width: 52px;
	height: 52px;
	border-radius: 100%;
	color: transparent;
	opacity: 1;
	border: none;
	background:
		url(https://s3.ap-northeast-2.amazonaws.com/res.kurly.com/kurly/ico/2021/arrow_list_right_60_60.svg)
		50% 50% no-repeat;
	
}
.product img:hover {
	transform: scale(1.02);
    transition: all .3s ease-in-out;
    cursor:pointer;
}
</style>
<div class = "container_banner">
	<div class="slick_slide">
		<div><img  src="<%=request.getContextPath()%>/banner_image/01.png"></div>
		<div><img  src="<%=request.getContextPath()%>/banner_image/02.png"></div>
		<div><img  src="<%=request.getContextPath()%>/banner_image/03.png"></div>
	</div>
</div>
	
<script type="text/javascript">
$('.slick_slide').slick({
	autoplay : true,			
	autoplaySpeed : 2000, 		
	pauseOnHover : true		
});
	
	
</script>
<%

List<ProductDTO> productList = ProductDAO.getDAO().selectAllProductList();


%>
<div class = "recommend-container">
	<div class="recommend-head">
		<span class="head">이 상품 어때요?</span>
	</div>

		<div class="slick-slider13">
			<%
			for(ProductDTO product:productList) {
			%>
			<div class="container">
			
				<div class="product_container">
					<div class="product">
						<img  class="product_img" src="<%=request.getContextPath()%>/product_image/<%=product.getpImg()%>" 
								onclick = "javascript:location.href='index.jsp?folder=product&category=Product_details&p_no=<%=product.getpNo()%>">
							<img onclick = "javascript:location.href='index.jsp?folder=product&category=Product_details&p_no=<%=product.getpNo()%>'" class="cart"></img>
							
					</div>
					<div class="description_list">
						<h3>
							<a href="index.jsp?folder=product&category=Product_details&p_no=<%=product.getpNo()%>" class="product_name"><%=product.getpName() %></a>
						</h3>
						<div class="product_price">
							<div class="product_calcu">
								<div class="coupon">0%</div>
								<div class="price">
									<%=DecimalFormat.getCurrencyInstance().format(product.getpPrice()) %><span>원</span>

								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			<%} %>
		</div>
	</div>
	<script type="text/javascript">
	$('.slick-slider13').slick({
		  dots: true,
		  infinite: false,
		  speed: 300,
		  slidesToShow: 4,
		  slidesToScroll: 4,
		  responsive: [
		    {
		      breakpoint: 1024,
		      settings: {
		        slidesToShow: 3,
		        slidesToScroll: 3,
		        infinite: true,
		        dots: true
		      }
		    },
		    {
		      breakpoint: 600,
		      settings: {
		        slidesToShow: 2,
		        slidesToScroll: 2
		      }
		    },
		    {
		      breakpoint: 480,
		      settings: {
		        slidesToShow: 1,
		        slidesToScroll: 1
		      }
		    }
		   
		  ]
		});

</script>	
<%

List<ProductDTO> lowProduct = ProductDAO.getDAO().selectLowPriceProduct();


%>
<div class = "recommend-container">
	<div class="recommend-head">
		<span class="head">5000원 이하 상품</span>
	</div>
		<div class="third_slick">
			
			
			
			<% for(ProductDTO product:lowProduct) {%>
				
				
			<div class="container">
			
				<div class="product_container">
					<div class="product">
						<img onclick = "javascript:location.href='index.jsp?folder=product&category=Product_details&p_no=<%=product.getpNo()%>'" class="product_img" src="<%=request.getContextPath()%>/product_image/<%=product.getpImg()%>"/>
							<img class="cart"></img>
							
					</div>
					<div class="description_list">
						<h3>
							<a href="index.jsp?folder=product&category=Product_details&p_no=<%=product.getpNo()%>" class="product_name"><%=product.getpName() %></a>
						</h3>
						<div class="product_price">
						<div class="product_calcu">
								<div class="coupon">0%</div>
								<div class="price">
									<%=DecimalFormat.getCurrencyInstance().format(product.getpPrice()) %><span>원</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			<%} %>
		</div>
	</div>
	
	<script type="text/javascript">
	$('.third_slick').slick({
		  dots: true,
		  infinite: false,
		  speed: 300,
		  slidesToShow: 4,
		  slidesToScroll: 4,
		  responsive: [
		    {
		      breakpoint: 1024,
		      settings: {
		        slidesToShow: 3,
		        slidesToScroll: 3,
		        infinite: true,
		        dots: true
		      }
		    },
		    {
		      breakpoint: 600,
		      settings: {
		        slidesToShow: 2,
		        slidesToScroll: 2
		      }
		    },
		    {
		      breakpoint: 480,
		      settings: {
		        slidesToShow: 1,
		        slidesToScroll: 1
		      }
		    }
		   
		  ]
		});

</script>	
	
