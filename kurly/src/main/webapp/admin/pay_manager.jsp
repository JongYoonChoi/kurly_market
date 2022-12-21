<%@page import="project.dto.PayDTO"%>
<%@page import="project.dao.PayDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>
<%
	//모든 장바구니 정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	List<PayDTO> payList=PayDAO.getDAO().allPayList();
%>
<style type="text/css">
#pay {
	width: 1000px;
	margin: 0 auto;
	text-align: center;
}

table {
	margin: 20px;
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	border: 1px solid black;
	padding: 3px;
	text-align: center;
	font-size: 12px;
}

th {
	background-color: black;
	color: white; 
}

.pay_no { width: 70px; }
.pay_date { width: 130px; }
.pay_id { width: 80px; }
.pay_item { width: 200px; }
.pay_amount { width: 70px; }
.pay_address { width: 270px; }
.pay_msg { width: 100px; }
.pay_status { width: 80px; }
</style>

<div id="pay">
<br><br><br>
<h1>주문목록</h1>
	<table>
		<tr>
			<th>주문번호</th>
			<th>주문날짜</th>
			<th>아이디</th>
			<th>상품명</th>
			<th>주문수량</th>
			<th>주소</th>
			<th>요청사항</th>
			<th>상태</th>
		</tr>
		<% if(payList.isEmpty()) { %>
		<tr>
			<td colspan="8">주문된 제품이 하나도 없습니다.</td>
		</tr>
		<% } else { %>
			<% for(PayDTO pay:payList) { %>
			<tr>
				<td class="pay_no"><%=pay.getPno()%></td>
				<td class="pay_date"><%=pay.getPdate() %></td>
				<td class="pay_id"><%=pay.getPid() %></td>
				<td class="pay_item"><%=pay.getPitem() %></td>
				<td class="pay_amount"><%=pay.getPamount() %></td>
				<td class="pay_address"><%=pay.getPaddress() %></td>
				<% if(pay.getPmsg()==null) {%>
					<td class="pay_msg">&nbsp;</td>
				<%} else {%>
					<td class="pay_msg"><%=pay.getPmsg()%></td>
				<%} %>
				<td class="pay_status">
					<select class="status" name="<%=pay.getPno() %>">
						<option value="1" <% if(pay.getPstatus()==0) { %> selected="selected" <% } %>>배송준비</option>
						<option value="2" <% if(pay.getPstatus()==1) { %> selected="selected" <% } %>>배송중</option>
						<option value="2" <% if(pay.getPstatus()==2) { %> selected="selected" <% } %>>배송완료</option>
						<option value="3" <% if(pay.getPstatus()==3) { %> selected="selected" <% } %>>주문취소</option>
					</select>
				</td>
			</tr>
			<% } %>
		<% } %>
	</table>
</div>

<script type="text/javascript">
$(".status").change(function() {
	var no=$(this).attr("name");
	var status=$(this).val();
	
	location.href="index.jsp?folder=admin&category=pay_status_action&no="+no+"&status="+status;
});
</script>