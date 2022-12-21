<%@page import="project.dao.ProductDAO"%>
<%@page import="project.dto.ProductDTO"%>
<%@page import="project.dao.CartDAO"%>
<%@page import="project.dto.CartDTO"%>
<%@page import="project.dao.PayDAO"%>
<%@page import="project.dto.PayDTO"%>
<%@page import="util.Utility"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 회원정보를 전달받아 PAY 테이블에 삽입하고 로그인 입력페이지(pay_finish.jsp)로 이동되도록
클라이언트에게 URL 주소를 전달하는 JSP 문서 --%>    
<%@include file="/security/login_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	List<CartDTO> cartList = CartDAO.getDAO().selectCartList(loginMember.getuId());
	
	for(CartDTO cart:cartList){

		//전달값을 반환받아 저장
		String address=request.getParameter("address");
		String msg=Utility.escapeTag(request.getParameter("msg"));
		String total=request.getParameter("total");
		int num=PayDAO.getDAO().selectNextNum();
		

		CartDTO cartInd=CartDAO.getDAO().selectIndTotal(loginMember.getuId(), cart.getpNo());
		CartDAO.getDAO().selectIndTotal(loginMember.getuId(), cart.getpNo());
		CartDAO.getDAO().deleteCart(cart.getpNo(), loginMember.getuId());
		//DTO 객체를 생성하여 반환받은 전달값으로 필드값 변경
		
		PayDTO pay=new PayDTO();
		pay.setPno(num);
		pay.setPid(loginMember.getuId());
		pay.setPitem(cart.getpName());
		pay.setPamount(cart.getQuantity());
		pay.setPaddress(address);
		pay.setPmsg(msg); 
		pay.setpImg(cart.getpImg());
		pay.setpPrice(cart.getpPrice()*cart.getQuantity());
		pay.setTotal(total);
		
		//PAY 테이블에 회원정보를 삽입하는 DAO 클래스의 메소드 호출
		PayDAO.getDAO().insertPay(pay);
	}
	
	//로그인 입력페이지(pay_login.jsp)로 이동 - 자바스크립트 이용
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?folder=pay&category=pay_finish';");
	out.println("</script>");
%>
