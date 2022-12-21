<%@page import="java.text.DecimalFormat"%>
<%@page import="project.dao.ProductDAO"%>
<%@page import="project.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 제품번호를 전달받아 PRODUCT 테이블에 저장된 제품정보를 검색하여 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 관리자만 요청 가능한 JSP 문서 --%>
<%-- => [제품정보변경]을 클릭한 경우 제품정보 변경값 입력페이지(product_modify.jsp)를 요청하여
이동하며 제품번호 전달 --%>
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
table {
	margin: 0 auto; 
	border: 1px solid black;
	border-collapse: collapse;
}

td {
	border: 1px solid black;
}

.title {
	background-color: black;
	color: white;
	text-align: center;
	width: 100px;
}

.value {
	padding: 5px;
	text-align: left;
	width: 500px;
}
</style>

<h2>제품상세정보</h2>
<table>
	<tr>
		<td class="title">제품번호</td>
		<td class="value"><%=product.getpNo() %></td>
	</tr>
	<tr>
		<td class="title">카테고리</td>
		<td class="value"><%=product.getpStock()%></td>
	</tr>
	<tr>
		<td class="title">제품명</td>
		<td class="value"><%=product.getpName() %></td>
	</tr>
	<tr>
		<td class="title">대표이미지</td>
		<td class="value">
			<img src="<%=request.getContextPath()%>/product_image/<%=product.getpImg() %>" width="200">
		</td>
	</tr>
	<tr>
		<td class="title">상세이미지</td>
		<td class="value">
			<img src="<%=request.getContextPath()%>/product_image/<%=product.getpImgD1() %>" width="400">
		</td>	
	</tr>
		<tr>
		<td class="title">상세이미지2</td>
		<td class="value">
			<img src="<%=request.getContextPath()%>/product_image/<%=product.getpImgD2() %>" width="400">
		</td>	
	</tr>
	<tr>
		<td class="title">제품수량</td>
		<td class="value"><%=DecimalFormat.getInstance().format(product.getpStock()) %></td>
	</tr>
	<tr>
		<td class="title">제품가격</td>
		<td class="value"><%=DecimalFormat.getInstance().format(product.getpPrice()) %>원</td>
	</tr>	
</table>

<p>
	<button type="button" onclick="location.href='index.jsp?folder=admin&category=product_modify&num=<%=product.getpNo()%>';">제품정보변경</button>
</p>