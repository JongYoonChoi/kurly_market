<%@page import="java.util.List"%>
<%@page import="project.dao.ProductDAO"%>
<%@page import="project.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.product_number{
	text-align: center;
    font-size: 20px;
}
.product_number a:hover {
	color : purple;

}

</style>
<%

int pageNum=1;
if(request.getParameter("pageNum")!=null) {
	pageNum=Integer.parseInt(request.getParameter("pageNum"));
}

int pageSize=9;

int totalProduct=ProductDAO.getDAO().selectFreshCount();



int totalPage=(int)Math.ceil((double)totalProduct/pageSize);



if(pageNum<=0 || pageNum>totalPage) {
	pageNum=1;
}
int startRow=(pageNum-1)*pageSize+1;

int endRow=pageNum*pageSize;

if(endRow>totalProduct) {
	endRow=totalProduct;
}


List<ProductDTO> productList = ProductDAO.getDAO().selectFreshProductList(startRow, endRow);

%>	
	
<div class="page_aticle">
	<div id="lnbMenu" class="lnb_menu">
		<div id="bnrCategory" class="bnr_category link"
			style="display: block;">
			<div class="thumb">
				<img src="https://img-cf.kurly.com/category/banner/pc/ea34abfa-6994-4175-a5cd-d1115b516f04">
			</div>
		</div>
		<div class="inner_lnb">
			<h3 class="tit">채소/과일/신선식품</h3>
			<ul class="list on">
				<li><a href = "index.jsp?&folder=product&category=Product_list">전체보기</a></li>
				<li><a href = "index.jsp?&folder=product&category=Product_list_fresh">채소/과일/신선식품</a></li>
				<li><a href = "index.jsp?&folder=product&category=Product_list_dish">국/반찬/메인요리</a></li>
				<li><a href = "index.jsp?&folder=product&category=Product_list_easy">샐러드/간편식/밀키트</a></li>
				
				<li class="bg"></li>
			</ul>
		</div>
	</div>
	<div id="goodsList" class="page_section section_goodslist">
		<div class="list_ability">
			<div class="sort_menu">
				<div>
					<p class="count">
						<span class="inner_count"> 총 <%=totalProduct %>개 </span>
					</p>
			
				</div>
			</div>
		</div>
		
		
		<div class="list_goods">
			<div class="inner_listgoods">
				<ul class="list">
					<%for(ProductDTO product:productList){ %>
					<li><div class="item">
							<div class="thumb">
								<a class="img">
									 <img src="<%=request.getContextPath()%>/product_image/<%=product.getpImg()%>" onclick = "javascript:location.href='index.jsp?folder=product&category=Product_details&p_no=<%=product.getpNo()%>'" >
								</a>
								
								<div class="group_btn">
									<button type="button" onclick = "javascript:location.href='index.jsp?folder=product&category=Product_details&p_no=<%=product.getpNo()%>'" " class="btn btn_cart">
										<span class="screen_out"></span>
									</button>
								</div>
							</div>
							<a class="info"><span class="name"> <%=product.getpName() %> </span> 
							<span  class="cost">
								<span class="price"><%=product.getpPrice() %>원
								</span> 
							</span> 
							<span class="tag"></span></a>
						</div>
					</li>
					<%} %>
				</ul>
			</div>
		</div>
		
		<%
		
		int blockSize=8;
	
		
		int startPage=(pageNum-1)/blockSize*blockSize+1;

		
		int endPage=startPage+blockSize-1;
		
		
		if(endPage>totalPage) {
			endPage=totalPage;
		}
	%>	
	
		<div class="product_number">
		<% if(startPage>blockSize) { %>
			<a href="index.jsp?folder=product&category=Product_list_fresh&pageNum=1&search=">[&lt;&lt;]</a>
			<a href="index.jsp?folder=product&category=Product_list_fresh&pageNum=<%=startPage-blockSize%>">[&lt;]</a>
		<% } else { %>
			[&lt;&lt;][&lt;]
		<% } %>
		
		<% for(int i=startPage;i<=endPage;i++) { %>
			<% if(pageNum!=i) { %>
				<a href="index.jsp?folder=product&category=Product_list_fresh&pageNum=<%=i%>">[<%=i %>]</a>
			<% } else { %>
				[<%=i %>]
			<% } %>
		<% } %>
		
		<% if(endPage!=totalPage) { %>
			<a href="index.jsp?folder=product&category=Product_list_fresh&pageNum=<%=startPage+blockSize%>">[&gt;]</a>
			<a href="index.jsp?folder=product&category=Product_list=fresh&pageNum=<%=totalPage%>">[&gt;&gt;]</a>
		<% } else { %>
			[&gt;][&gt;&gt;]
		<% } %>
		</div>
		
	</div>
</div>