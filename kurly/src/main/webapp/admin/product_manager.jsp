<%@page import="project.dao.PayDAO"%>
<%@page import="project.dto.PayDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="project.dao.ProductDAO"%>
<%@page import="project.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 카테고리를 전달받아 PRODUCT 테이블에 저장된 해당 카테고리의 제품목록을 검색하여 
클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 관리자만 요청 가능한 JSP 문서 --%>
<%-- => [제품등록]을 클릭한 경우 제품정보 입력페이지(product_add.jsp)를 요청하여 이동 --%>
<%-- => [카테고리]를 선택한 경우 제품목록 출력페이지(product_manager.jsp)를 form 태그를 이용하여
post 방식으로 요청하여 이동하며 카테고리를 전달 --%>
<%-- => [제품명]을 클릭한 경우 제품정보 출력페이지(product_detail.jsp)를 요청하여 이동하며
제품번호를 전달 --%>
<%@include file="/security/admin_check.jspf" %>
<%
	String cate=request.getParameter("cate");
	if(cate==null) {
		cate="ALL";
	}
	
	//카테고리를 전달받아 PRODUCT 테이블에 저장된 해당 카테고리의 제품목록을 검색하여 반환하는
	//DAO 클래스의 메소드 호출
	List<ProductDTO> productList=ProductDAO.getDAO().selectProductList(cate); 	
%>
<style type="text/css">
#product {
	width: 1000px;
	margin: 0 auto;
	text-align: center;
	font-size: 1.1em;
}

#btn {
	text-align: right;
	margin-bottom: 5px;
	width: 980px;
}

#addBtn {
	border: none;
    padding: 10px 20px;
    font-weight: 600;
    background-color: #5f0080;
    color: white;
}


table {
	border: 1px solid black;
	border-collapse: collapse;
	margin: 20px;
}

th, td {
	border: 1px solid black;
	padding: 3px;
	text-align: center;
	width: 250px;	
}

th {
	background-color: black;
	color: white;
}

.pname {
	width: 400px;
}

td a, td a:visited {
	text-decoration: none;
}

td a:hover {
	text-decoration: underline;
	color: blue;
}
</style>

<div id="product">
<br><br><br>
	<h1>제품목록</h1>
	
	<div id="btn">
		<button type="button" id="addBtn">제품등록</button>
	</div>
	
	<table>
		<tr>
			<th>제품번호</th>
			<th class="pname">제품명</th>
			<th>제품수량</th>
			<th>제품가격</th>
		</tr>
		
		<% if(productList.isEmpty()) { %>
		<tr>
			<td colspan="4">검색된 제품이 하나도 없습니다.</td>
		</tr>
		<% } else { %>
			<% for(ProductDTO product:productList) { %>
			<tr>
				<td><%=product.getpNo() %></td>
				<td>
					<a href="index.jsp?folder=admin&category=product_detail&num=<%=product.getpNo()%>">
						<%=product.getpName() %>
					</a>
				</td>
				<%-- DecimalFormat 객체 : 숫자값을 원하는 형식의 문자열로 변환하기 위한 기능을 
				제공하기 위한 객체 --%>
				<%-- DecimalFormat.getInstance() : 기본 패턴이 저장된 DecimalFormat 객체를 반환하는 메소드 --%>
				<%-- DecimalFormat.format(Object number) : 숫자값을 전달받아 원하는 패턴의 문자열로
				변환하여 반환하는 메소드 --%>
				<td><%=DecimalFormat.getInstance().format(product.getpStock()) %></td>
				<%-- DecimalFormat.getCurrencyInstance() : 기본 패턴에 화폐단위가 추가된 패턴이  
				저장된 DecimalFormat 객체를 반환하는 메소드 --%>
				<td><%=DecimalFormat.getCurrencyInstance().format(product.getpPrice()) %></td>
			</tr>
			<% } %>
		<% } %>
	</table>
	<br>
	
	<form method="post" id="productForm">
		<select name="cate" id="cate">
			<option value="ALL" <% if(cate.equals("ALL")) { %> selected="selected" <% } %>>전체</option>
			<option value="FRESH" <% if(cate.equals("FRESH")) { %> selected="selected" <% } %>>채소/과일/신선식품</option>
			<option value="DISH" <% if(cate.equals("DISH")) { %> selected="selected" <% } %>>국/반찬/메인요리</option>
			<option value="EASY" <% if(cate.equals("EASY")) { %> selected="selected" <% } %>>샐러드/간편식/밀키트</option>
		</select>
	</form>
</div>

<script type="text/javascript">
$("#addBtn").click(function() {
	location.href="index.jsp?folder=admin&category=product_add";
});

$("#cate").change(function() {
	$("#productForm").submit();
});
</script>