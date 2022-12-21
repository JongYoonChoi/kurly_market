<%@page import="project.dto.MemberDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="project.dto.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@page import="project.dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//페이지 관련 전달값
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	//출력될 게시글의 갯수
	int pageSize=10;
	
	//저장된 전체게시글의 갯수
	int totalNotice=NoticeDAO.getDAO().selectNoticeCount();

	//전체 페이지의 갯수를 계산하여 저장
	int totalPage=(int)Math.ceil((double)totalNotice/pageSize);

	//전달된 요청 페이지 번호에 대한 검증
	if(pageNum<=0 || pageNum>totalPage) {//비정상적인 요청 페이지 번호인 경우
		pageNum=1;//첫번째 페이지의 게시글이 검색되도록 요청 페이지 번호 설정
	}
		
	//요청 페이지에 검색될 시작 게시글의 행번호
	int startRow=(pageNum-1)*pageSize+1;
	//요청 페이지에 검색될 종료 게시글의 행번호
	int endRow=pageNum*pageSize;
		
	//마지막 페이지에 대한 종료 게시글의 행번호를 검색 게시글의 갯수로 변경
	if(endRow>totalNotice) {
		endRow=totalNotice;
	}
		
	//요청 페이지에 대한 시작 게시글의 행번호와 종료 게시글의 행번호를 전달받아 notice 테이블에 
	//저장된 게시글에서 해당 범위의 게시글들을 검색하여 반환하는 DAO 클래스의 메소드 호출
	List<NoticeDTO> noticeList=NoticeDAO.getDAO().selectNoticeList(startRow, endRow);
		
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	// => 로그인 사용자만 글쓰기 권한 제공
	// => 비밀 게시글인 경우 로그인 사용자가 게시글 작성자이거나 관리자인 경우에만 접근 권한 제공
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
		
	//서버 시스템의 현재 날짜를 반환받아 저장
	// => 게시글의 작성일을 현재 날짜와 비교하여 구분 출력
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		
	//요청 페이지에 검색되어 응답될 게시글 출력번호의 시작값을 계산하여 저장
	//ex)전체 게시글의 갯수 : 91 >> 1Page : 91~82, 2Page : 81~70, 3Page : 71~60, 4Page : 61~50,...
	int rowNum=totalNotice-(pageNum-1)*pageSize;
%>
<style type="text/css">
#notice_list {
	width: 900px;
	margin: 0 auto;
	text-align: center;
}

#notice_title {
	font-size: 1.8em;
	font-weight: bold;
	text-align: left;
}

#num {
	font-size: 1.1em;
	color: #646464;
}

table {
	margin: 20px auto;
	border-collapse: collapse;
}

th {
	border-top : 2px solid #5f0080;
	border-bottom : 1px solid black;
 	font-size: 1.2em;
  	padding-top: 15px;
    padding-bottom: 15px;
    padding-left: none;
    padding-right: none;
}

td {
	border-bottom: 1px solid #dcdcdc;
	color: #646464;
  	padding-top: 18px;
    padding-bottom: 18px;
    padding-left: none;
    padding-right: none;
    font-size: 1.2em;
}

.subject {
	text-align: left;
	padding: 5px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

#notice_list a:hover {
	text-decoration: none;
	color: red;
}

.sub {
	color: #828282;
	font-size: 0.6em;
	padding: 20px;
}

.w-btn {
    border: none;
    padding: 15px 30px;
    font-weight: 600;
    background-color: #5f0080;
    color: white;
    font-size: 1em;
}

</style>

<div id="notice_list">
	<br><br><br>
	<div id="notice_title">
	공지사항<span class="sub">  컬리의 새로운 소식들과 유용한 정보들을 한곳에서 확인하세요.</span>
	</div>	
	<br>
	
	<table>
		<tr>
			<th width="100">번호</th>
			<th width="500">제목</th>
			<th width="100">작성자</th>
			<th width="200">작성일</th>
		</tr>

		<% if(totalNotice==0) { %>
		<tr>
			<td colspan="5">게시글이 하나도 없습니다.</td>
		</tr>
		<% } else { %>
			<%-- 검색된 게시글들을 List 객체에서 하나씩 반복적으로 제공받아 응답 처리 --%>
			<% for(NoticeDTO notice:noticeList) { %>
			<tr>
				<%-- 글번호 : notice 테이블에 저장된 게시글의 글번호가 아닌 계산된 출력 글번호로 응답 --%>
				<td><%=rowNum %></td>
				<% rowNum--;//출력 글번호의 변수값 1씩 감소 처리 %>

				<%-- 제목 --%>
				<td class="subject">
						<a href="index.jsp?folder=notice&category=notice_detail&num=<%=notice.getNno() %>&pageNum=<%=pageNum%>">
							<%=notice.getNtitle() %>
						</a>
				</td>
				<%-- 작성자 --%>
				<td style="color: black">KurlyKurly</td>
				
				<%-- 작성일 : 오늘 날짜에 작성된 게시글은 시간만 출력하고 다른 날짜에 작성된 게시글은 날짜와 시간 출력 --%>
				<td>
					<% if(currentDate.equals(notice.getNdate().substring(0, 10))) {//오늘 작성된 게시글인 경우 %>
						<%=notice.getNdate().substring(11) %>
					<% } else {//과거에 작성된 게시글인 경우 %>
						<%=notice.getNdate().substring(0,10) %>
					<% } %>
				</td>
			</tr>
			<% } %>
		<% } %>
	</table>
	<% if(loginMember!=null && loginMember.getuStatus()==1) {//로그인 사용자가 관리자인 경우 %>
	<div style="text-align: right;">
		<button class="w-btn" type="button" onclick="location.href='index.jsp?folder=notice&category=notice_write';">글쓰기</button>
	</div>
	<% } %>
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
	<div id="num">
	<% if(startPage>blockSize) {//첫번째 블럭이 아닌 경우 - 링크 설정 %>
		<a href="index.jsp?folder=notice&category=notice_list&pageNum=1">[처음]</a>
		<a href="index.jsp?folder=notice&category=notice_list&pageNum=<%=startPage-blockSize%>">[이전]</a>
	<% } else {//첫번째 블럭인 경우 - 링크 미설정 %>
		[처음][이전]
	<% } %>
	
	<% for(int i=startPage;i<=endPage;i++) { %>
		<% if(pageNum!=i) {//요청 페이지 번호와 이벤트 페이지 번호가 다른 경우 - 링크 설정 %>
			<a href="index.jsp?folder=notice&category=notice_list&pageNum=<%=i%>">[<%=i %>]</a>
		<% } else {//요청 페이지 번호와 이벤트 페이지 번호가 같이 경우 - 링크 미설정 %>
			[<%=i %>]
		<% } %>
	<% } %>
	
	<% if(endPage!=totalPage) {//마지막 블럭이 아닌 경우 - 링크 설정 %>
		<a href="index.jsp?folder=notice&category=notice_list&pageNum=<%=startPage+blockSize%>">[다음]</a>
		<a href="index.jsp?folder=notice&category=notice_list&pageNum=<%=totalPage%>">[마지막]</a>
	<% } else {//마지막 블럭인 경우 - 링크 미설정 %>
		[다음][마지막]
	<% } %>
	</div>
</div>
