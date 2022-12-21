
package project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.dto.ProductDTO;

public class ProductDAO extends JdbcDAO{
	private static ProductDAO _dao;
	
	private ProductDAO() {
		
	}
	
	static {
		_dao = new ProductDAO();
	}
	
	public static ProductDAO getDAO() {
		return _dao;
	}

	public int insertCart(ProductDTO cart) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();
			
			String sql = "insert into product values(product_p_no_sqe.nextval,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cart.getpName());
			pstmt.setString(2, cart.getpImg());
			pstmt.setString(3, cart.getpImgD1());
			pstmt.setString(4, cart.getpImgD2());
			pstmt.setInt(5, cart.getpPrice());
			pstmt.setString(6, cart.getpKinds());
			pstmt.setInt(7, cart.getpStock());
		
		
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertCart 메소드 SQL 오류 = " + e.getMessage());
		}finally {
			close (con, pstmt);
		}
		return rows;
	}
	
	//제품번호를 전달받아 PRODUCT 테이블에 저장된 제품정보를 검색하여 반환하는 메소드
	public ProductDTO selectProduct(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductDTO product = null;
		try {
			con = getConnection();
			
			String sql = "select * from product where p_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				product = new ProductDTO();
				product.setpNo(rs.getInt("p_no"));
				product.setpName(rs.getString("p_name"));
				product.setpImg(rs.getString("p_img"));
				product.setpImgD1(rs.getString("p_img_D1"));
				product.setpImgD2(rs.getString("p_img_D2"));
				product.setpPrice(rs.getInt("p_price"));
				product.setpKinds(rs.getString("p_kinds"));
				product.setpStock(rs.getInt("p_Stock"));
			}
		}catch(SQLException e) {
			System.out.println("[에러] selectProduct 메소드의 SQL 오류=" + e.getMessage());
		}finally {
			close(con,pstmt,rs);
		}
		return product;
	}

	public List<ProductDTO> selectAllProductList(int startRow, int endRow) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();

		try {
			con = getConnection();

			String sql="select * from (select rownum rn, temp.* from "
					+ "(select * from product order by p_no desc) temp) "
					+ "where rn between ? and ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setpNo(rs.getInt("p_no"));
				product.setpName(rs.getString("p_name"));
				product.setpImg(rs.getString("p_img"));
				product.setpImgD1(rs.getString("p_img_d1"));
				product.setpImgD2(rs.getString("p_img_d2"));
				product.setpPrice(rs.getInt("p_price"));
				product.setpKinds(rs.getString("p_kinds"));
				product.setpStock(rs.getInt("p_stock"));

				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectAllProductList() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}

		return productList;
	}
	
	public List<ProductDTO> selectLowPriceProduct() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();

		try {
			con = getConnection();

			String sql = "Select * from(select * from product order by DBMS_RANDOM.RANDOM) where p_price < 5000 and rownum < 20 ";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setpNo(rs.getInt("p_no"));
				product.setpName(rs.getString("p_name"));
				product.setpImg(rs.getString("p_img"));
				product.setpImgD1(rs.getString("p_img_d1"));
				product.setpImgD2(rs.getString("p_img_d2"));
				product.setpPrice(rs.getInt("p_price"));
				product.setpKinds(rs.getString("p_kinds"));
				product.setpStock(rs.getInt("p_stock"));

				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectLowPriceProduct() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);

		}

		return productList;
	}	


//관리자페이지 관련
	//제품정보를 전달받아 PRODUCT 테이블에 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertProduct(ProductDTO product) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into product values(product_seq.nextval,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, product.getpName());
			pstmt.setString(2, product.getpImg());
			pstmt.setString(3, product.getpImgD1());
			pstmt.setString(4, product.getpImgD2());
			pstmt.setInt(5, product.getpPrice());
			pstmt.setString(6, product.getpKinds());
			pstmt.setInt(7, product.getpStock());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertProduct 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//카테고리를 전달받아 PRODUCT 테이블에 저장된 해당 카테고리의 제품목록을 검색하여 반환하는 메소드
		// => PRODUCT 테이블에 저장된 모든 제품정보를 검색하여 반환
	public List<ProductDTO> selectProductList(String category) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<ProductDTO>();
		try {
			con=getConnection();
			
			//동적 SQL 기능을 이용하여 매개변수에 전달된 값에 따라 다른 SQL 명령이 실행되도록 설정
			if(category.equals("ALL")) {
				String sql="select * from product order by p_kinds, p_name";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select * from product where p_kinds=? order by p_kinds, p_name";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, category);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product.setpNo(rs.getInt("p_no"));
				product.setpKinds(rs.getString("p_kinds"));
				product.setpName(rs.getString("p_name"));
				product.setpStock(rs.getInt("p_stock"));
				product.setpPrice(rs.getInt("p_price"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}	
		return productList;
	}
	
	//제품정보를 전달받아 PRODUCT 테이블에 저장된 제품정보를 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateProduct(ProductDTO product) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update product set p_kinds=?,p_name=?,p_img=?,p_img_d1=?,p_img_d2=?,p_stock=?,p_price=? where p_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, product.getpKinds());
			pstmt.setString(2, product.getpName());
			pstmt.setString(3, product.getpImg());
			pstmt.setString(4, product.getpImgD1());
			pstmt.setString(5, product.getpImgD2());
			pstmt.setInt(6, product.getpStock());
			pstmt.setInt(7, product.getpPrice());
			pstmt.setInt(8, product.getpNo());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateProduct 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	public int selectProductCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			String sql="select count(*) from product";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
				
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductCount 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	public int selectDishCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			String sql="select count(*) from product where p_kinds = 'DISH'";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
				
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductCount 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	public int selectFreshCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			String sql="select count(*) from product where p_kinds = 'FRESH'";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
				
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductCount 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	public int selectEasyCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			String sql="select count(*) from product where p_kinds = 'EASY'";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
				
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductCount 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	public List<ProductDTO> selectAllProductList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();

		try {
			con = getConnection();

			String sql = "Select * from(select * from product order by DBMS_RANDOM.RANDOM) where rownum < 20 ";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setpNo(rs.getInt("p_no"));
				product.setpName(rs.getString("p_name"));
				product.setpImg(rs.getString("p_img"));
				product.setpImgD1(rs.getString("p_img_d1"));
				product.setpImgD2(rs.getString("p_img_d2"));
				product.setpPrice(rs.getInt("p_price"));
				product.setpKinds(rs.getString("p_kinds"));
				product.setpStock(rs.getInt("p_stock"));

				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectAllProductList() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);

		}

		return productList;
	}
	
	public List<ProductDTO> selectFreshProductList(int startRow, int endRow) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();

		try {
			con = getConnection();

			String sql="select * from (select rownum rn, temp.* from (select * from product where p_kinds = 'FRESH' ) temp) where rn between ? and ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setpNo(rs.getInt("p_no"));
				product.setpName(rs.getString("p_name"));
				product.setpImg(rs.getString("p_img"));
				product.setpImgD1(rs.getString("p_img_d1"));
				product.setpImgD2(rs.getString("p_img_d2"));
				product.setpPrice(rs.getInt("p_price"));
				product.setpKinds(rs.getString("p_kinds"));
				product.setpStock(rs.getInt("p_stock"));

				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectFreshProductList() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}

		return productList;
	}
	public List<ProductDTO> selectDishProductList(int startRow, int endRow) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();

		try {
			con = getConnection();

			String sql="select * from (select rownum rn, temp.* from (select * from product where p_kinds ='DISH') temp) where rn between ? and ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setpNo(rs.getInt("p_no"));
				product.setpName(rs.getString("p_name"));
				product.setpImg(rs.getString("p_img"));
				product.setpImgD1(rs.getString("p_img_d1"));
				product.setpImgD2(rs.getString("p_img_d2"));
				product.setpPrice(rs.getInt("p_price"));
				product.setpKinds(rs.getString("p_kinds"));
				product.setpStock(rs.getInt("p_stock"));

				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectDishProductList() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}

		return productList;
	}
	
	public List<ProductDTO> selectEasyProductList(int startRow, int endRow) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();

		try {
			con = getConnection();

			String sql="select * from (select rownum rn, temp.* from (select * from product where p_kinds ='EASY') temp) where rn between ? and ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setpNo(rs.getInt("p_no"));
				product.setpName(rs.getString("p_name"));
				product.setpImg(rs.getString("p_img"));
				product.setpImgD1(rs.getString("p_img_d1"));
				product.setpImgD2(rs.getString("p_img_d2"));
				product.setpPrice(rs.getInt("p_price"));
				product.setpKinds(rs.getString("p_kinds"));
				product.setpStock(rs.getInt("p_stock"));

				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectEasyProductList() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}

		return productList;
	}
	
	
}