<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 제품정보를 입력받기 위한 JSP 문서 --%>    
<%-- => 관리자만 요청 가능한 JSP 문서 --%>
<%-- => [제품등록]를 클릭한 경우 form 태그를 이용하여 제품정보 삽입페이지(product_add_action.jsp)를 
form 태그로 post 방식으로 요청하여 이동하며 사용자가 입력한 제품정보를 전달 --%>
<%@include file="/security/admin_check.jspf" %>
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
	<h2>제품등록</h2>
	
	<%-- 파일을 입력받아 전달하기 위해서는 반드시 form 태그의 method 속성을 [post]로 설정하고 
	enctype 속성을 [multipart/form-data]로 설정 --%>
	<form action="index.jsp?folder=admin&category=product_add_action" method="post"
		enctype="multipart/form-data" id="productForm">
	<table>
		<tr>
			<td>카테고리</td>
			<td>
				<select name="category">
					<option value="FRESH">채소/과일/신선식품</option>
					<option value="DISH">국/반찬/메인요리</option>
					<option value="EASY">샐러드/간편식/밀키트</option>
				</select>
			</td>	
		</tr>
		<tr>
			<td>제품명</td>
			<td>
				<input type="text" name="name" id="name">
			</td>
		</tr>
		<tr>
			<td>대표이미지</td>
			<td>
				<input type="file" name="imageMain" id="imageMain">
			</td>
		</tr>
		<tr>
			<td>상세이미지</td>
			<td>
				<input type="file" name="imageDetail" id="imageDetail">
			</td>
		</tr>
		<tr>
			<td>상세이미지2</td>
			<td>
				<input type="file" name="imageDetail2" id="imageDetail2">
			</td>
		</tr>
		<tr>
			<td>제품수량</td>
			<td>
				<input type="text" name="stock" id="stock">
			</td>
		</tr>
		<tr>
			<td>제품가격</td>
			<td>
				<input type="text" name="price" id="price">
			</td>
		</tr>
		<tr>
			<td>
				<button type="submit">제품등록</button>
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
	
	if($("#imageMain").val()=="") {
		$("#message").text("대표이미지를 입력해 주세요.");
		$("#imageMain").focus();
		return false;
	}
	
	if($("#imageDetail").val()=="") {
		$("#message").text("상세이미지를 입력해 주세요.");
		$("#imageDetail").focus();
		return false;
	}
	
	if($("#imageDetail2").val()=="") {
		$("#message").text("상세이미지2를 입력해 주세요.");
		$("#imageDetail").focus();
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