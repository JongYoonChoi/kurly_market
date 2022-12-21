<%@page import="java.text.DecimalFormat"%>
<%@page import="project.dao.CartDAO"%>
<%@page import="project.dto.ProductDTO"%>
<%@page import="project.dao.MemberDAO"%>
<%@page import="project.dao.PayDAO"%>
<%@page import="project.dto.CartDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="project.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%
	//주문자의 아이디를 전달받아 cart 테이블에 
	//저장된 리스트에서 해당 리스트들을 검색하여 반환하는 DAO 클래스의 메소드 호출
	List<CartDTO> cartList=PayDAO.getDAO().selectCartList(loginMember.getuId());
	
	//cart 테이블에 저장된 전체 게시글의 갯수를 검색하여 반환하는 DAO 클래스의 메소드 호출
	int totalPay=PayDAO.getDAO().selectCartCount(loginMember.getuId());
	
	//주문자의 아이디를 전달받아 member 테이블에 
	//저장된 리스트에서 해당 고객정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	MemberDTO member=MemberDAO.getDAO().selectMember(loginMember.getuId());
	String address="["+member.getuAddressN()+"]"+member.getuAddressU()+" "+member.getuAddressD();
	
	
	//product 테이블에 저장된 전체 상품을 검색하여 반환하는 DAO 클래스의 메소드 호출
	List<ProductDTO> productList = PayDAO.getDAO().allProductList();
	
	String uId = loginMember.getuId();

%>

<style>
#pay_page {
	width: 1000px;
	margin: 0 auto;
	text-align: center;
}

#pay_title {
	font-size: 2.5em;
	font-weight: bold;
}

#total{
	border-top: 1px solid #dcdcdc;
	font-weight: bold;
	font-size: 1.2em;
}

table {
	margin: 70px auto;
	border: none;
	border-collapse: collapse;
	text-align: left;
	line-height: 30px;
}

th {
	border-bottom : 1px solid black;
 	font-size: 1.5em;
  	padding-top: 15px;
    padding-bottom: 15px;
    padding-left: none;
    padding-right: none;
}
  
td {
	border-bottom: 1px solid #dcdcdc;
  	text-align: left;
  	padding-top: 10px;
    padding-bottom: 10px;
    padding-left: none;
    padding-right: none;
    font-size: 1.2em;
}

.noline {
  	border-bottom: none;
}
  
.second {
  	border: none;
	background-color: #fafafa;
  	padding: 15px;
  	line-height: 20px;
}

.second2 {
  	border: none;
	background-color: #fafafa;
  	padding: 15px;
  	line-height: 20px;
}

.thick {
	color: 	#3c3c3c;
	font-weight: 600;
	font-size: 1.4em;
	padding: 15px;
}

.purple {
	color: #5f0080;
	font-weight: 600;
	font-size: 0.9em;
}
  
.info {
	color: 	#828282;
	font-size: 0.8em;
	line-height: 15px;
}
.w-btn {
    border: none;
    padding: 15px 30px;
    font-weight: 600;
    background-color: #5f0080;
    color: white;
}
</style>

<div id="pay_page">
	<br><br>
	<div id="pay_title">주문서</div>
	<form name=pay action="index.jsp?folder=pay&category=pay_action" method="post" id="pay">
	<%-- 주문상품 출력 --%>
	<table>
		<tr><th colspan="4">주문상품</th></tr>
		
		
		
		<% if(totalPay==0) {%>
		<tr>
			<td style="text-align: center;" width="1000">장바구니에 상품이 하나도 없습니다.</td>
		</tr>
		<% } else { %>
			<%-- 검색된 게시글들을 List 객체에서 하나씩 반복적으로 제공받아 응답 처리 --%>
			<% for(CartDTO cart:cartList) { 
			CartDTO indTotal = CartDAO.getDAO().selectIndTotal(uId, cart.getpNo());
			%>
			<tr>
				<%-- 이미지 --%>
				<td width="100"><img src="<%=request.getContextPath()%>/product_image/<%=cart.getpImg()%>"></td>
							
				<%-- 주문상품 --%>
				<td class="thick" width="680" name="item"><%=cart.getpName() %></td>

				<%-- 수량 --%>
				<td width="100" name="amount"><%=cart.getQuantity() %>개</td>
			
				<%-- 가격 --%>
				<td class="thick" style="text-align: right;" width="120"><%=DecimalFormat.getInstance().format(indTotal.getIndTotal()) %>원</td>	
			<% } %>
		<% } %>
		</tr>		
	</table>
	<table>
  			<tr><th colspan="2">주문자 정보</th></tr>
			<tr>
				<td class="noline" width="200">받으실 분</td>
				<td class="noline" width="800"><%=member.getuName() %></td>
			</tr>
       		<tr>
				<td class="noline" width="200">휴대폰</td>
				<td class="noline" width="800"><%=member.getuPhone() %></td>
			</tr>
  			<tr>
				<td class="noline" width="200">이메일<br><br></td>
				<td class="noline" width="800"><%=member.getuEmail() %><br>
				<span class="info">이메일을 통해 주문처리 과정을 보내드립니다.<br>
				정보 변경은 마이컬리>개인정보 수정 메뉴에서 가능합니다.</span>
				</td>
			</tr>
	</table>
  
   <table>
  			<tr><th colspan="2">배송 정보</th></tr>
			<tr>
				<td  width="200">배송지
                  <br><br><br>
               </td>
				<td  width="800" name="address"><img src="http://localhost:8000/semi/pay/address.jpg"><br>
				<%=address%>
				<input type=hidden name="address" value="<%=address%>">
				<br><span class="purple" >샛별배송</span><br>
               </td>
              
			</tr>
       		<tr>
				<td  class="noline" width="200">요청 사항
           	   </td>
				<td  class="noline" width="800"><input type="text"name="msg"style="width:600px;height:50px;outline:none;">
           	 </td>
			</tr>
	</table>
	<table>
       <tr><th colspan="2">쿠폰</th></tr>
			<tr>
				<td class="noline" width="200">쿠폰 적용
                  <br><br>
               </td>
				<td class="noline" width="800"><img src="http://localhost:8000/semi/pay/coupon.jpg"><br>
                 <span class="purple" >&nbsp;쿠폰사용문의(카카오톡)</span>
               </td>
	</table>
	
<div style="width:70%;float:left;">  
     <table>
     	<tr><th colspan="2">결제 수단</th></tr>
		<tr>
			<td class="noline" width="200">결제수단 선택
            <br><br><br><br>
           	</td>
			<td class="noline" width="500"><img src="http://localhost:8000/semi/pay/payment.jpg"></td>
        </tr>
        <tr>
             <td colspan="2" class="noline" width="700"><img src="http://localhost:8000/semi/pay/payment2.jpg"></td>
		</tr>
	</table>
</div>
<div style="width:30%;float:right;">
<% CartDTO totalPrice = CartDAO.getDAO().selectTotalCart(uId);%>
  <table>
       <tr><th colspan="2">결제 금액</th></tr>
			<tr>
				<td class="second" width="130">주문금액</td>     
              	<td style="text-align: right;" class="second2" width="100"><%=DecimalFormat.getInstance().format(totalPrice.getTotal()) %>원</td>  
			</tr>
   			 <tr>
   			 	<%if(totalPrice.getTotal() < 25000 && totalPrice.getTotal() > 0) { %>
				<td class="second" width="100">배송비</td>     
              	<td style="text-align: right;" class="second" width="80"><%=DecimalFormat.getInstance().format(3000)%>원</td>         
			</tr>
   			 <tr>
				<td class="second" width="100">쿠폰할인금액</td>     
              	<td style="text-align: right;" class="second" width="80">0원</td>          
			</tr>
			<tr>
				<td class="second" id="total" width="100">총 금액</td>     
              	<td style="text-align: right;" class="second2" id="total" width="80"><%=DecimalFormat.getInstance().format(totalPrice.getDeTotal()) %>원</td>          
			</tr>
			<tr>
   			 	<%} else if(totalPrice.getTotal() >= 25000 || totalPrice.getTotal() == 0) { %>
				<td class="second" width="100">배송비</td>     
              	<td style="text-align: right;" class="second" width="80">0원</td>         
			</tr>
   			 <tr>
				<td class="second" width="100">쿠폰할인금액</td>     
              	<td style="text-align: right;" class="second" width="80">0원</td>          
			</tr>
			<tr>
				<td class="second" id="total" width="100">총 금액</td>     
              	<td style="text-align: right;" class="second2" id="total" width="80"><%=DecimalFormat.getInstance().format(totalPrice.getTotal()) %>원</td>          
				<input type=hidden name="total" value="<%=DecimalFormat.getInstance().format(totalPrice.getTotal()) %>">			
			</tr>
			<%} %>
	</table>
 </div>
 <div style="clear:both">
    <table>
           <tr><th>개인정보 수집/제공</th></tr>
			<tr>
				<td  class="noline" width="1000">
					<label><input type="checkbox" name="agree" value=1 required>
					<span class="ico"></span>
					결제진행 필수 동의
				
					</label>
				</td>            
			</tr>
			<tr>
				<td class="noline" width="1000"><img src="http://localhost:8000/semi/pay/agree.jpg"></td>            
			</tr>
	</table>
</div>
  <div>
  <%if(totalPrice.getTotal() < 25000 && totalPrice.getTotal() > 0) { %>
	<button class="w-btn">
        <%=DecimalFormat.getInstance().format(totalPrice.getDeTotal()) %>원 결제하기
    </button>
  <%} else if(totalPrice.getTotal() >= 25000 || totalPrice.getTotal() == 0) { %>
   <button class="w-btn">
        <%=DecimalFormat.getInstance().format(totalPrice.getTotal()) %>원 결제하기
    </button>
   <%} %>
	</div>
	<br>
	<br>
</form>
</div>
<script type="text/javascript">
</script>
