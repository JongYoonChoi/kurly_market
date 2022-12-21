<%@page import="project.dto.MemberDTO"%>
<%@page import="project.dao.ReviewDAO"%>
<%@page import="project.dto.ReviewDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- BAORD 테이블에 저장된 게시글을 검색하여 게시글 목록을 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 게시글 목록을 페이지로 구분 검색하여 응답 처리 - 페이징 처리 --%>
<%-- => 로그인 사용자가 [글쓰기]를 클릭한 경우 게시글 입력페이지(Review_write.jsp)를 요청하여 이동 --%>
<%-- => 게시글의 [제목]을 클릭한 경우 게시글 출력페이지(Review_detail.jsp)를 요청하여 이동 - 글번호, 페이지 번호, 검색대상, 검색단어 전달 --%>
<%-- => [페이지번호]를 클릭한 경우 게시글 목록 출력페이지(Review_list.jsp)를 요청하여 이동 - 페이지 번호, 검색대상, 검색단어 전달 --%>
<%-- => [검색]을 클릭한 경우 게시글 목록 출력페이지(Review_list.jsp)를 요청하여 이동 - 검색대상, 검색단어 전달 --%>
<%

	


	//페이징 처리 관련 전달값(요청 페이지 번호)을 반환받아 저장
	// => 요청 페이지 번호 전달값이 없는 경우 첫번째 페이지의 게시글 목록을 검색하여 응답
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {//전달값이 있는 경우
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	//하나에 페이지에 검색되어 출력될 게시글의 갯수 설정 - 전달값을 반환받아 저장 가능
	int pageSize=5;
	
	//Review 테이블에 저장된 전체 게시글의 갯수를 검색하여 반환하는 DAO 클래스의 메소드 호출
	// => 검색 기능 미구현시 호출되는 메소드
	//int totalReview=ReviewDAO.getDAO().selectReviewCount();

	//검색 관련 정보를 전달받아 Review 테이블에 저장된 전체 게시글 중 검색대상에 검색단어가 포함된  
	//게시글의 갯수를 검색하여 반환하는 DAO 클래스의 메소드 호출
	int totalReview=ReviewDAO.getDAO().selectReviewCount();
	
	//전체 페이지의 갯수를 계산하여 저장
	//int totalPage=totalReview/pageSize+totalReview%pageSize==0?0:1;
	int totalPage=(int)Math.ceil((double)totalReview/pageSize);

	//전달된 요청 페이지 번호에 대한 검증
	if(pageNum<=0 || pageNum>totalPage) {//비정상적인 요청 페이지 번호인 경우
		pageNum=1;//첫번째 페이지의 게시글이 검색되도록 요청 페이지 번호 설정
	}
	
	//요청 페이지에 검색될 시작 게시글의 행번호를 계산하여 저장
	//ex)1Page : 1, 2Page : 11, 3Page : 21, 4Page : 31, ...
	int startRow=(pageNum-1)*pageSize+1;

	//요청 페이지에 검색될 종료 게시글의 행번호를 계산하여 저장
	//ex)1Page : 10, 2Page : 20, 3Page : 30, 4Page : 40, ...
	int endRow=pageNum*pageSize;
	
	//마지막 페이지에 대한 종료 게시글의 행번호를 검색 게시글의 갯수로 변경
	if(endRow>totalReview) {
		endRow=totalReview;
	}
	
	//요청 페이지에 대한 시작 게시글의 행번호와 종료 게시글의 행번호를 전달받아 Review 테이블에 
	//저장된 게시글에서 해당 범위의 게시글들을 검색하여 반환하는 DAO 클래스의 메소드 호출
	List<ReviewDTO> ReviewList=ReviewDAO.getDAO().selectReviewList(startRow, endRow);
	
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	// => 로그인 사용자만 글쓰기 권한 제공
	// => 비밀 게시글인 경우 로그인 사용자가 게시글 작성자이거나 관리자인 경우에만 접근 권한 제공
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	//서버 시스템의 현재 날짜를 반환받아 저장
	// => 게시글의 작성일을 현재 날짜와 비교하여 구분 출력
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	//요청 페이지에 검색되어 응답될 게시글 출력번호의 시작값을 계산하여 저장
	//ex)전체 게시글의 갯수 : 91 >> 1Page : 91~82, 2Page : 81~70, 3Page : 71~60, 4Page : 61~50,...
	int rowNum=totalReview-(pageNum-1)*pageSize;
%>
<style type="text/css">
#Review_list {
	width: 1000px;
	margin: 0 auto;
	text-align: center;
	
}
.review_text {
	font-size: 1em;
	text-align: left;
}


#Review_title {
	font-size: 3em;
	font-weight: bold;
	padding : 15px;
}

table.review {
	width: 1000px;
	margin-top:10px;
	border-top: 1px solid  #5f0081;
	border-bottom: 1px solid #5f0081;;	
	border-left: none;
	border-right: none;
	padding: 10px 10px;
	text-align: center;
	font-size: 1.1em;
}

th.review {
	border-bottom: 1px solid rgb(230,230,230);
	padding-top: 10px;
	padding-bottom: 10px;
	font-size: 1.1em;
}

td.review {
	border-bottom: 1px solid rgb(230,230,230);
	text-align: center;	
	overflow: hidden;
	padding-top: 10px;
	padding-bottom: 10px;
	font-size: 1.1em;
}

.subject {
	border-bottom: 1px solid rgb(230,230,230);
	text-align: left;
	padding: 5px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	font-size: 1.1em;
}

.write_review {
	margin-top: 15px;
	margin-left: 850px;
	width: 80px;
	text-align: center;
	border-style: solid #5f0081;
	background-color: #5f0081;
	color: white;
	font-weight: bold;
	border-radius: 3px;
	
}

.review_write {
	color: white;
	font-weight: bold;
	border-style: none;
	background-color: #5f0081;
	padding: 10px;
	border-radius: 3px;
	font-size: 1.1em;
	
}

.review_number{
	font-size: 1.1em;
}

#Review_list a:hover {
	text-decoration: none;
	color: red;
}

.secret, .remove {
	background-color: black;
	color: white;
	font-size: 14px;
	border: 1px solid black;
	border-radius: 4px;
}


</style>

<div id="Review_list">
	<div id="Review_title">상품 후기(게시글 : <%=totalReview %>)</div>
		<div class="review_text" >
			PRODUCT REVIEW
			<br>
			상품에 대한 문의를 남기는 공간입니다. 해당 게시판의 성격과 다른 글은 사전동의 없이 담당 게시판으로 이동될 수 있습니다.
			<br>
			배송관련, 주문(취소/교환/환불)관련 문의 및 요청사항은 마이컬리 내 1:1 문의에 남겨주세요.
		</div>
	
	<%-- 게시글 출력 --%>
	<table class="review">
		<tr>
			<th class="review" width="100">번호</th>
			<th class="review" width="500">제목</th>
			<th class="review" width="100">작성자</th>
			<th class="review" width="200">작성일</th>
		</tr>

		<% if(totalReview==0) { %>
		<tr>
			<td class="review" colspan="5">후기가 하나도 없습니다.</td>
		</tr>
		<% } else { %>
			<%-- 검색된 게시글들을 List 객체에서 하나씩 반복적으로 제공받아 응답 처리 --%>
			<% for(ReviewDTO Review:ReviewList) { %>
			<tr>
				<%-- 글번호 : Review 테이블에 저장된 게시글의 글번호가 아닌 계산된 출력 글번호로 응답 --%>
				<td class="review"><%=rowNum %></td>
				<% rowNum--;//출력 글번호의 변수값 1씩 감소 처리 %>

				<%-- 제목 --%>
				<td class="subject">
							<a href="index.jsp?folder=product&category=Review_detail&num=<%=Review.getrNo() %>&pageNum=<%=pageNum%>">
								<%=Review.getpTitle() %>
							</a>

					<%-- 작성자 --%>
					<td class="review"><%=Review.getpUser() %></td>
					
					<%-- 작성일 : 오늘 날짜에 작성된 게시글은 시간만 출력하고 다른 날짜에 작성된 게시글은 날짜와 시간 출력 --%>
					<td class="review"> 
						<% if(currentDate.equals(Review.getpDate().substring(0, 10))) {//오늘 작성된 게시글인 경우 %>
							<%=Review.getpDate().substring(11) %>
						<% } else {//과거에 작성된 게시글인 경우 %>
							<%=Review.getpDate() %>
						<% } %>
					</td>
			</tr>
			<% } %>
		<% } %>
	</table>
	
<%-- 	<% if(loginReview!=null) {//로그인 사용자인 경우 %>   --%>
	<div class="write_review" >
		<button class="review_write" type="button"  onclick="location.href='index.jsp?folder=product&category=Review_write';">후기쓰기</button>
	</div>
<%--	<% } %>   --%>
	
	<%-- 페이지 번호 출력 : 클릭 이벤트에 의한 링크 설정 - 블럭화 처리 --%>
	<%
		//하나의 블럭에 출력될 페이지 번호의 갯수를 설정
		int blockSize=5;
	
		//블럭에 출력될 페이지 번호의 시작값을 계산하여 저장
		//ex)1Block : 1, 2Block : 6, 3Block : 11, 4Block : 16,...
		int startPage=(pageNum-1)/blockSize*blockSize+1;

		//블럭에 출력될 페이지 번호의 종료값을 계산하여 저장
		//ex)1Block : 5, 2Block : 10, 3Block : 15, 4Block : 20,...
		int endPage=startPage+blockSize-1;
		
		//마지막 블럭의 페이지 번호 종료값 변경
		if(endPage>totalPage) {
			endPage=totalPage;
		}
	%>	
	<div class="review_number">
	<% if(startPage>blockSize) {//첫번째 블럭이 아닌 경우 - 링크 설정 %>
		<a href="index.jsp?folder=product&category=Product_review&pageNum=1&search=">[&lt;&lt;]</a>
		<a href="index.jsp?folder=product&category=Product_review&pageNum=<%=startPage-blockSize%>">[&lt;]</a>
	<% } else {//첫번째 블럭인 경우 - 링크 미설정 %>
		[&lt;&lt;][&lt;]
	<% } %>
	
	<% for(int i=startPage;i<=endPage;i++) { %>
		<% if(pageNum!=i) {//요청 페이지 번호와 이벤트 페이지 번호가 다른 경우 - 링크 설정 %>
			<a href="index.jsp?folder=product&category=Product_review&pageNum=<%=i%>">[<%=i %>]</a>
		<% } else {//요청 페이지 번호와 이벤트 페이지 번호가 같이 경우 - 링크 미설정 %>
			[<%=i %>]
		<% } %>
	<% } %>
	
	<% if(endPage!=totalPage) {//마지막 블럭이 아닌 경우 - 링크 설정 %>
		<a href="index.jsp?folder=product&category=Product_review&pageNum=<%=startPage+blockSize%>">[&gt;]</a>
		<a href="index.jsp?folder=product&category=Product_review&pageNum=<%=totalPage%>">[&gt;&gt;]</a>
	<% } else {//마지막 블럭인 경우 - 링크 미설정 %>
		[&gt;][&gt;&gt;]
	<% } %>
	</div>
</div>
