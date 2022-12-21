<%@page import="project.dao.ProductDAO"%>
<%@page import="project.dto.ProductDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%


	//전달값을 반환받아 저장
	int num=Integer.parseInt(request.getParameter("p_no"));
	
	//제품번호를 전달받아 PRODUCT 테이블에 저장된 제품정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	ProductDTO product=ProductDAO.getDAO().selectProduct(num);
	
	//검색된 제품정보가 없는 경우 에러페이지로 이동 - 비정상적인 요청
	if(product==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;			
	}
%>

<style type="text/css">
.section_view {
	width: 1200px;
	height: 700px;
	margin: 0 auto;
	margin-top : 40px;
	padding-top: 20px;

}

.p_image1 {
	width: 500px;
	height: 560px;
	float: left;
	overflow: hidden;
}

.p_image2 {
	width: 1000px;
	float: left;

}

.p_name {
	font-size: 40px;
	float: left;
	width: 600px;
	padding-left: 50px;
	margin-bottom: 0;

}


.p_price {
	font-size: 30px;
	float: left;
	width: 600px;
	padding-left: 50px;
	margin-top: 30px;
}

table.content {
	font-size: 16px;
	float: left;
	width: 550px;
	padding-left: 50px;
	border-style: hidden;
	border-top: 1px solid;
	border-bottom: 1px solid rgb(230,230,230);
	border-collapse: collapse;
	margin-top: 50px;
	margin-left: 50px;
}

th.content, td.content {
	border-top: 1px solid rgb(230,230,230);	
	border-left: none;
	border-right: none;
	padding: 10px 10px;

}

.quantity {
	float: left;
	width: 600px;
	padding-top: 50px;
	margin-top: 0;
	margin-left: 50px;
	font-size: 20px;

}

.count1 {
	margin-top: 10px;
	display:inline;
	width: 20px;
}


.price {
	float: left;
	width: 600px;
	
	font-size: 25px;
	text-align: right;
	margin-left: 500px;
}

.cart_put {
	float: left;
	margin-top: 15px;
	margin-left: 750px;
	width: 350px;
    height: 62px;
	border-radius: 3px;
	background-color: #5f0081;
	text-align: center;
	padding-top : 20px;

	
}

button#cart_put{
	color: white;
	font-size: 18px;
	font-weight: 600;
	cursor:pointer;
	background-color: #5f0081;
	border-style: none;

}

.information {
	width: 1000px;
	padding-top: 50px;
	margin: 0 auto;

}

.information_view {
	display: flex;
	height: 60px;
	background-color: rgb(255, 255, 255);
}



li.item {
	padding-top: 15px;
	width: 490px;
	height: 65px;
	list-style-type: none;
	float: left;
	font-size: 30px;
	text-align: center;
	border-style: solid;
	border-color: rgb(230,230,230);
}


#product_explain {
	margin-top: 50px;
}



a, a:visited {
	text-decoration: none;
	color: black;
}


</style>



<body onload="init();">
	<div class="section_view">
		<div class="p_image1">
			<img src="<%=request.getContextPath()%>/product_image/<%=product.getpImgD1() %>" />
			<!-- <img src="/semi/product_image/p_image2/12e0deb4b5210e5081c55a10dbd3f64eb5140fa6fde705c8d3f3cf5260eb.jpg" alt="상세사진" />  -->
		</div>

		<h1 class="p_name"><%=product.getpName() %></h1>
		<!-- <h1 class="p_name">밀키트</h1> -->
		<br>
		<p class="p_price"><%=DecimalFormat.getInstance().format(product.getpPrice()) %>원</p>
		<!-- <p class="p_price">1000원</p> -->

		<table class="content" border="1">
			<tr>
				<td class="content" width="150">제품종류</td>
				<td class="content"><%=product.getpKinds()%></td>
			</tr>
			<tr>
				<td class="content">용량</td>
				<td class="content">500g</td>
			</tr>
			<tr>
				<td class="content">배송구분</td>
				<td class="content">택배배송</td>
			</tr>
			<tr>
				<td class="content">포장타입</td>
				<td class="content">냉동/스티로폼</td>
			</tr>
			<tr>
				<td class="content">알레르기정보</td>
				<td class="content" width="400">- 알류, 우유, 메밀, 땅콩, 대두, 밀, 고등어, 게, 새우, 돼지고기, 복숭아, 토마토, 
				아황산류, 호두, 닭고기, 쇠고기, 오징어, 조개류(굴,전복,홍합 포함), 잣을 사용한 제품과 같은 제조시설에서 제조</td>
			</tr>
		</table>

		<div id="cart">
		<form action = "index.jsp?folder=cart&category=add_cart"name="form" method="post">
			<input type ="hidden" name = "pNo" value ="<%=product.getpNo() %>">
			
			<div class="quantity">
				<span class="btn_position">구매수량</span> 
				<br> 
				<div class="count">

	<input type="hidden" name="sell_price" value="<%=product.getpPrice()%>">
	<input type="text" name="amount" value="1" size="3" onchange="change();">
	<input type="button" value=" + " onclick="add();"><input type="button" value=" - " onclick="del();">
	

				</div>
			</div>
			<div class="price">
				총 금액 : <input type="text" name="sum" size="7"  readonly>원
			</div>
			
			<div class="cart_put">
				<button type="submit" id="cart_put">장바구니 담기</button>
			</div>
			
</form>
		</div>
	</div>

	<%--상품 상세설명 --%>
	<div class="information">
		<div class="information_view">
			<ul class="product_information">
				<li class="item"><a href="#product_explain">상품설명</a></li>
				<li class="item"><a href="#product_review">후기</a></li>
			</ul>

			<br>
		</div>

		<div class="p_image2">
			<div id="product_explain">
			
				<img src="<%=request.getContextPath()%>/product_image/<%=product.getpImgD2() %>" />
			</div>
		</div>
		
		<div class="review_page">
			
				<jsp:include page = "Product_review.jsp"/>
			<div id="product_review"></div>
		</div>
	</div>
</body>
	
	<script type="text/javascript">
	
	var sell_price;
	var amount;

	function init () {
		sell_price = document.form.sell_price.value;
		amount = document.form.amount.value;
		document.form.sum.value = sell_price;
		change();
	}

	function add () {
		hm = document.form.amount;
		sum = document.form.sum;
		hm.value ++ ;

		sum.value = hm.value * sell_price;
	}

	function del () {
		hm = document.form.amount;
		sum = document.form.sum;
			if (hm.value > 1) {
				hm.value -- ;
				sum.value = hm.value * sell_price;
			}
	}

	function change () {
		hm = document.form.amount;
		sum = document.form.sum;

			if (hm.value < 1) {
				hm.value = 1;
			} else {
				sum.value = hm.value * sell_price;
			}

	}  
	
	
	</script>
	
