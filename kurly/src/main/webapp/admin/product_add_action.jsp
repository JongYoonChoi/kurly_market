<%@page import="java.io.File"%>
<%@page import="project.dao.ProductDAO"%>
<%@page import="project.dto.ProductDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 제품정보를 전달받아 PRODUCT 테이블에 삽입하고 제품목록 출력페이지(product_manager.jsp)로
이동하기 위한 정보를 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 관리자만 요청 가능한 JSP 문서 --%>
<%@include file="/security/admin_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='index.jsp?folder=error&category=error_400';");
		out.println("</script>");
		return;			
	}

	//전달받아 파일을 저장하기 위한 서버 디렉토리의 파일 시스템 경로를 반환받아 저장
	// => 작업 디렉토리(categorySpace)가 아닌 웹 디렉토리(WebApps)에 파일 시스템 경로 반환
	String saveDirectory=request.getServletContext().getRealPath("/product_image");
	//System.out.println("saveDirectory = "+saveDirectory);
	
	//MultipartRequest 객체([multipart/form-data]로 전달된 값을 처리하기 위한 객체) 생성
	// => MultipartRequest 객체를 생성하면 전달된 모든 파일이 서버 디렉토리에 자동으로 저장 - 업로드
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	//전달값과 업로드 처리된 파일명을 반환받아 저장
	String category=multipartRequest.getParameter("category");
	String name=multipartRequest.getParameter("name");
	String imageMain=multipartRequest.getFilesystemName("imageMain");
	String imageDetail=multipartRequest.getFilesystemName("imageDetail");
	String imageDetail2=multipartRequest.getFilesystemName("imageDetail2");
	int stock=Integer.parseInt(multipartRequest.getParameter("stock"));
	int price=Integer.parseInt(multipartRequest.getParameter("price"));
	
	//DTO 객체를 생성하여 전달값(파일명)을 이용하여 필드값 변경
	ProductDTO product=new ProductDTO();
	product.setpKinds(category);
	product.setpName(name);
	product.setpImg(imageMain);
	product.setpImgD1(imageDetail);
	product.setpImgD2(imageDetail2);
	product.setpStock(stock);
	product.setpPrice(price);
	
	//제품정보를 전달받아 PRODUCT 테이블에 삽입하는 DAO 클래스의 메소드 호출
	int rows=ProductDAO.getDAO().insertProduct(product);
	if(rows<=0) {//PRODUCT 테이블에 제품정보가 삽입되지 않은 경우
		//서버 디렉토리에 업로드되어 저장된 제품 관련 이미지 삭제
		//File 객체 : 파일 정보를 저장하고 파일 처리하기 위한 기능을 제공하는 객체
		//File.delete() : File 객체로 표현된 파일을 삭제하는 메소드
		new File(saveDirectory, imageMain).delete();
		new File(saveDirectory, imageDetail).delete();
		new File(saveDirectory, imageDetail2).delete();
	}
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='index.jsp?folder=admin&category=product_manager';");
	out.println("</script>");
%>