<%@page import="project.dao.ProductDAO"%>
<%@page import="project.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 제품번호를 전달받아 PRODUCT 테이블에 저장된 제품정보를 검색하여 입력태그의 초기값으로 설정하고
변경값을 입력받기 위한 JSP 문서 --%>
<%-- => 관리자만 요청 가능한 JSP 문서 --%>
<%-- => [제품변경]를 클릭한 경우 form 태그를 이용하여 제품정보 변경페이지(product_modify_action.jsp)를 
form 태그로 post 방식으로 요청하여 이동하며 사용자가 입력한 제품정보를 전달 --%>
<%@include file="/security/admin_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("num")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;			
	}

	//전달값을 반환받아 저장
	int num=Integer.parseInt(request.getParameter("num"));
	
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
#product {
	width: 800px;
	margin: 0 auto;
}

table {
	margin: 0 auto;
}

td {
	text-align: left;
}
</style>

<div id="product">
	<h2>제품변경</h2>
	
	<%-- 파일을 입력받아 전달하기 위해서는 반드시 form 태그의 method 속성을 [post]로 설정하고 
	enctype 속성을 [multipart/form-data]로 설정 --%>
	<form action="index.jsp?folder=admin&category=product_modify_action" method="post"
		enctype="multipart/form-data" id="productForm">
	<%-- 변경할 제품정보를 구분하기 위한 식별자로 제품번호를 전달 --%>	
	<input type="hidden" name="num" value="<%=product.getpNo()%>">	
	<%-- 제품 이미지를 변경하지 않을 경우 기존 제품 이미지를 사용하기 위해 전달하거나
	제품 이미지를 변경할 경우 기존 제품 이미지를 서버 디렉토리에서 삭제하기 위해 전달 --%>
	<input type="hidden" name="currentImageMain" value="<%=product.getpImg()%>">	
	<input type="hidden" name="currentImageDetail" value="<%=product.getpImgD1()%>">	
	<input type="hidden" name="currentImageDetail2" value="<%=product.getpImgD2()%>">	
	<table>
		<tr>
			<td>카테고리</td>
			<td>
				<select name="category">
					<option value="FRESH" <% if(product.getpKinds().equals("FRESH")) { %> selected="selected" <% } %>>채소/과일/신선식품</option>
					<option value="DISH" <% if(product.getpKinds().equals("DISH")) { %> selected="selected" <% } %>>국/반찬/메인요리</option>
					<option value="EASY" <% if(product.getpKinds().equals("EASY")) { %> selected="selected" <% } %>>샐러드/간편식/밀키트</option>
				</select>
			</td>	
		</tr>
		<tr>
			<td>제품명</td>
			<td>
				<input type="text" name="name" id="name" value="<%=product.getpName()%>">
			</td>
		</tr>
		<tr>
			<td>대표이미지</td>
			<td>
				<img src="<%=request.getContextPath()%>/product_image/<%=product.getpImg() %>" width="200">
				<br>
				<span style="color: red;">이미지를 변경하기 않을 경우 입력하지 마세요.</span>
				<br>			
				<input type="file" name="imageMain" id="imageMain">
			</td>
		</tr>
		<tr>
			<td>상세이미지</td>
			<td>
				<img src="<%=request.getContextPath()%>/product_image/<%=product.getpImgD1() %>" width="400">
				<br>
				<span style="color: red;">이미지를 변경하기 않을 경우 입력하지 마세요.</span>
				<br>			
				<input type="file" name="imageDetail" id="imageDetail">
			</td>
		</tr>
		<tr>
			<td>상세이미지</td>
			<td>
				<img src="<%=request.getContextPath()%>/product_image/<%=product.getpImgD2() %>" width="400">
				<br>
				<span style="color: red;">이미지를 변경하기 않을 경우 입력하지 마세요.</span>
				<br>			
				<input type="file" name="imageDetail2" id="imageDetail2">
			</td>
		</tr>
		<tr>
			<td>제품수량</td>
			<td>
				<input type="text" name="stock" id="stock" value="<%=product.getpStock()%>">
			</td>
		</tr>
		<tr>
			<td>제품가격</td>
			<td>
				<input type="text" name="price" id="price" value="<%=product.getpPrice()%>">
			</td>
		</tr>
		<tr>
			<td>
				<button type="submit">제품변경</button>
			</td>
		</tr>
	</table>	
	</form>
	
	<div id="message" style="color: red;"></div>
</div>

<script type="text/javascript">
$("#productForm").submit(function() {
	if($("#name").val()=="") {
		$("#message").text("제품명을 입력해 주세요.");
		$("#name").focus();
		return false;
	}
	
	if($("#stock").val()=="") {
		$("#message").text("제품수량을 입력해 주세요.");
		$("#stock").focus();
		return false;
	}
	
	if($("#price").val()=="") {
		$("#message").text("제품가격을 입력해 주세요.");
		$("#price").focus();
		return false;
	}
});
</script>