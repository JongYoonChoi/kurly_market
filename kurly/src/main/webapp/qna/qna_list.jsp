<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="project.dto.MemberDTO"%>
<%@page import="project.dto.QnaDTO"%>
<%@page import="java.util.List"%>
<%@page import="project.dao.QnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//검색대상과 검색단어를 반환받아 저장
	String search=request.getParameter("search");
	if(search==null) {
		search="";
	}
	
	String keyword=request.getParameter("keyword");
	if(keyword==null) {
		keyword="";
	}
	
	//페이징 처리 관련 전달값(요청 페이지 번호)을 반환받아 저장
	// => 요청 페이지 번호 전달값이 없는 경우 첫번째 페이지의 게시글 목록을 검색하여 응답
	int pageNum=1;
	if(request.getParameter("pageNum")!=null) {//전달값이 있는 경우
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	//하나에 페이지에 검색되어 출력될 게시글의 갯수 설정 - 전달값을 반환받아 저장 가능
	int pageSize=10;

	//검색 관련 정보를 전달받아 qna 테이블에 저장된 전체 게시글 중 검색대상에 검색단어가 포함된  
	//게시글의 갯수를 검색하여 반환하는 DAO 클래스의 메소드 호출
	int totalQna=QnaDAO.getDAO().selectQnaCount(search, keyword);
	
	//전체 페이지의 갯수를 계산하여 저장
	int totalPage=(int)Math.ceil((double)totalQna/pageSize);

	//전달된 요청 페이지 번호에 대한 검증
	if(pageNum<=0 || pageNum>totalPage) {//비정상적인 요청 페이지 번호인 경우
		pageNum=1;//첫번째 페이지의 게시글이 검색되도록 요청 페이지 번호 설정
	}
	
	//요청 페이지에 검색될 시작 게시글의 행번호를 계산하여 저장
	int startRow=(pageNum-1)*pageSize+1;

	//요청 페이지에 검색될 종료 게시글의 행번호를 계산하여 저장
	int endRow=pageNum*pageSize;
	
	//마지막 페이지에 대한 종료 게시글의 행번호를 검색 게시글의 갯수로 변경
	if(endRow>totalQna) {
		endRow=totalQna;
	}
	
	//요청 페이지에 대한 시작 게시글의 행번호와 종료 게시글의 행번호를 전달받아 qna 테이블에 
	//저장된 게시글에서 해당 범위의 게시글들을 검색하여 반환하는 DAO 클래스의 메소드 호출
	List<QnaDTO> qnaList=QnaDAO.getDAO().selectQnaList(startRow, endRow, search, keyword);
	
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	// => 로그인 사용자만 문의하기 권한 제공
	// => 비밀 게시글인 경우 로그인 사용자가 게시글 작성자이거나 관리자인 경우에만 접근 권한 제공
	MemberDTO loginMember=(MemberDTO)session.getAttribute("loginMember");
	
	//서버 시스템의 현재 날짜를 반환받아 저장
	// => 게시글의 작성일을 현재 날짜와 비교하여 구분 출력
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	//요청 페이지에 검색되어 응답될 게시글 출력번호의 시작값을 계산하여 저장
	int rowNum=totalQna-(pageNum-1)*pageSize;
%>
<style type="text/css">
#qna_list {
	width: 900px;
	margin: 0 auto;
	text-align: center;
}

#qna_title {
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

#qna_list a:hover {
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

<div id="qna_list">
	<br><br><br>
	<div id="qna_title">질문과 답변<span class="sub">컬리에게 질문해 주시면 최대한 빠르게 답변해 드립니다.</span></div>
	<%-- 게시글 출력 --%>
	<table>
		<tr>
			<th width="100">번호</th>
			<th width="500">제목</th>
			<th width="100">작성자</th>
			<th width="200">작성일</th>
		</tr>

		<% if(totalQna==0) { %>
		<tr>
			<td colspan="5">게시글이 하나도 없습니다.</td>
		</tr>
		<% } else { %>
			<%-- 검색된 게시글들을 List 객체에서 하나씩 반복적으로 제공받아 응답 처리 --%>
			<% for(QnaDTO qna:qnaList) { %>
			<tr>
				<%-- 글번호 : qna 테이블에 저장된 게시글의 글번호가 아닌 계산된 출력 글번호로 응답 --%>
				<td><%=rowNum %></td>
				<% rowNum--;//출력 글번호의 변수값 1씩 감소 처리 %>

				<%-- 제목 --%>
				<td class="subject">
					<%-- 게시글이 답변인 경우에 대한 응답 처리  --%>					
					<% if(qna.getReStep()!=0) {//답변인 경우 %>
						<%-- 게시글의 깊이에 의해 왼쪽 여백을 다르게 설정하여 응답되도록 처리 --%>
						<span style="margin-left: <%=qna.getReLevel()*20%>px;">└[답변]</span>
					<% } %>
					
					<%-- 게시글 상태를 구분하여 제목과 링크를 다르게 설정하여 응답되도록 처리 --%>
					<% if(qna.getQstatus()==1) {//[일반글]인 경우 %>
						<a href="index.jsp?folder=qna&category=qna_detail&num=<%=qna.getQno() %>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>">
							<%=qna.getQtitle() %>
						</a>
					<% } else if(qna.getQstatus()==2) {//[비밀글]인 경우 %>
						<span class="secret">&#128274;</span>
						<%-- 로그인 사용자가 게시글 작성자이거나 관리자인 경우 --%>
						<% if(loginMember!=null && (loginMember.getuId().equals(qna.getQname()) 
								|| loginMember.getuStatus()==1)) { %>	
							<a href="index.jsp?folder=qna&category=qna_detail&num=<%=qna.getQno() %>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>">
								<%=qna.getQtitle() %>
							</a>
						<% } else { %>
							작성자 또는 관리자만 확인 가능합니다.
						<% } %>	
					<% } %>
				</td>
					<%-- 작성자 --%>
					<td style="color: black">
					<% if(qna.getQname().equals("rtgm1215")){ //작성자 아이디가 관리자일 경우%>
					KurlyKurly
					<%} else { %>
						<%=qna.getQname() %>
					<%} %>
					</td>
		
					<%-- 작성일 : 오늘 날짜에 작성된 게시글은 시간만 출력하고 다른 날짜에 작성된 게시글은 날짜와 시간 출력 --%>
					<td>
						<% if(currentDate.equals(qna.getQdate().substring(0, 10))) {//오늘 작성된 게시글인 경우 %>
							<%=qna.getQdate().substring(11) %>
						<% } else {//과거에 작성된 게시글인 경우 %>
							<%=qna.getQdate().substring(0,10) %>
						<% } %>
					</td>
			</tr>
			<% } %>
		<% } %>
	</table>
	<% if(loginMember!=null) {//로그인 사용자인 경우 %>
	<div style="text-align: right;">
		<button class="w-btn" type="button" onclick="location.href='index.jsp?folder=qna&category=qna_write';">문의하기</button>
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
		<a href="index.jsp?folder=qna&category=qna_list&pageNum=1&search=<%=search%>&keyword=<%=keyword%>">[처음]</a>
		<a href="index.jsp?folder=qna&category=qna_list&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[이전]</a>
	<% } else {//첫번째 블럭인 경우 - 링크 미설정 %>
		[처음][이전]
	<% } %>
	
	<% for(int i=startPage;i<=endPage;i++) { %>
		<% if(pageNum!=i) {//요청 페이지 번호와 이벤트 페이지 번호가 다른 경우 - 링크 설정 %>
			<a href="index.jsp?folder=qna&category=qna_list&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>">[<%=i %>]</a>
		<% } else {//요청 페이지 번호와 이벤트 페이지 번호가 같이 경우 - 링크 미설정 %>
			[<%=i %>]
		<% } %>
	<% } %>
	
	<% if(endPage!=totalPage) {//마지막 블럭이 아닌 경우 - 링크 설정 %>
		<a href="index.jsp?folder=qna&category=qna_list&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[다음]</a>
		<a href="index.jsp?folder=qna&category=qna_list&pageNum=<%=totalPage%>&search=<%=search%>&keyword=<%=keyword%>">[마지막]</a>
	<% } else {//마지막 블럭인 경우 - 링크 미설정 %>
		[다음][마지막]
	<% } %>
	</div>
	<br>
	<%-- 검색단어를 이용한 게시글 검색 기능 구현 --%>
	<form action="index.jsp?folder=qna&category=qna_list" method="post">
		<%-- select 태그에 의해 전달되는 값은 검색단어를 비교하기 위한 컬럼명과 동일한 이름으로 전달되도록 설정 --%>
		<select name="search">
			<option value="q_name" selected="selected">&nbsp;작성자&nbsp;</option>
			<option value="q_title">&nbsp;제목&nbsp;</option>
			<option value="q_content">&nbsp;내용&nbsp;</option>
		</select>
		<input type="text" name="keyword">
		<button type="submit">검색</button>
	</form>
</div>