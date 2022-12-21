<%@page import="project.dao.PayDAO"%>
<%@page import="project.dto.PayDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@include file="/security/login_check.jspf" %>
<%
	PayDTO pay = PayDAO.getDAO().selectTotal(loginMember.getuId());
	System.out.println(pay.getTotal());
	String total =pay.getTotal();
	
%>   
<style type="text/css">
  
body { background-color: #f3f2f4; }
  
#pay {
	width: 330px;
	margin: 0 auto;
}

table {
	margin: 0 auto;
	border-collapse: collapse;
}

td {
	color: #3c3c3c;
  	padding-top: 10px;
    padding-bottom: 30px;
    padding-left: 35px;
    padding-right: 35px;
    font-size: 1.2em;
  	background-color: white;
  	text-align: center;
}

.info {
	color: 	#828282;
	font-size: 1.1em;
	line-height: 15px;
	text-align: left;
	line-height: 18px;
}
.level1 {
	font-size: 1.6em;
	line-height: 25px;
	font-weight: 650;
	padding-top: 5px;
}
.level2 {
	font-size: 1.3em;
	text-align: left;
}
.level3 {
	font-size: 1.6em;
	font-weight: 650;
	text-align: right;
}
.level3_1 {
	font-size: 1.4em;
	text-align: right;
	color: #5f0080;
	
}
.level4 {
	padding-top: 5px;
    padding-bottom: 7px;
}

.w-btn1 {
    width: 300px; height: 55px; 
    border: 1px solid #dcdcdc;
    font-weight: 600;
    background-color: white;
    font-size: 1em;
}
 .w-btn2 {
   width: 300px; height: 55px;
    border: none;
    font-weight: 600;
    background-color: #5f0080;
    color: white;
    font-size: 1em;
</style>
  
<div id="pay">
	<br><br><br><br>
	<table>
      <tr><td style="padding: 45px;"colspan="2"><img src="http://localhost:8000/semi/pay/icon.jpg"></td></tr>
      <tr><td class="level1" colspan="2"><%=loginMember.getuName() %>님의 주문이 완료되었습니다.<br>
        내일 아침에 만나요!</td></tr>
      <tr><td class="level2">결제금액</td><td class="level3"><%=total %>원</td></tr>
	  <tr><td class="level2">적립금</td><td class="level3_1">0 원</td></tr>
      <tr><td class="info" colspan="2">&#183; [배송준비중] 이전일 때 주문내역 상세페이지 에서 주문 취소가 가능합니다.<br>
        &#183; 엘리베이터 이용이 어려운 경우 6층 이상부터는 공동 현관 앞 또는 경비실로 대응 배송 될 수 있습니다.<br>
        &#183; 주문 / 배송 및 기타 문의가 있을 경우, 1:1 문의에 남겨주시면 신속히 해결해 드리겠습니다.
        </td ></tr>
      <tr><td class="level4" colspan="2"><button class="w-btn1" type="button" onclick="location.href='index.jsp?folder=mypage&category=PayStatus';">주문 상세보기</button></td></tr>
      <tr><td colspan="2"><button class="w-btn2" type="button" onclick="location.href='index.jsp?folder=main&category=MainPage';">쇼핑 계속하기</button></td></tr>
  </table>
</div>