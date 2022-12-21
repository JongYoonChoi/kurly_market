package project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.dto.CartDTO;
import project.dto.PayDTO;
import project.dto.ProductDTO;

public class PayDAO extends JdbcDAO {
	private static PayDAO _dao;
	
	private PayDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new PayDAO();
	}
	
	public static PayDAO getDAO() {
		return _dao;
	}
	
	//검색 관련 값을 전달받아 Cart 테이블에 저장된 전체 데이터 중 검색컬럼에 검색어가 포함된
	//데이터의 갯수를 검색하여 반환하는 메소드 - 검색 기능 사용
	//개인별 장바구니카욷트 저장 메소드
	public int selectCartCount(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			String sql="select count(*) from cart where u_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectCartCount 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	//검색 관련 값을 전달받아 Cart 테이블에 저장된 전체 데이터 중 검색컬럼에 검색어가 포함된
	//데이터의 갯수를 검색하여 반환하는 메소드 - 검색 기능 사용
	//개인별 장바구니카욷트 저장 메소드
	public int selectPayCount(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			String sql="select count(*) from pay where p_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectCartCount 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	//주문자의 아이디를 전달받아 cart 테이블에 
	//저장된 데이터에서 해당 데이터들을 검색하여 반환하는 DAO 클래스의 메소드 호출
	//개인별 장바구니리스트 저장 메소드;주문내역 입력용
	public List<CartDTO> selectCartList(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<CartDTO> cartList=new ArrayList<CartDTO>();
		try {
			con=getConnection();
			
			String sql="select * from cart where u_id=?";
			
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, id);
						
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				CartDTO cart=new CartDTO();
				cart.setCartIdx(rs.getString("cart_idx"));
				cart.setuId(rs.getString("u_id"));
				cart.setpNo(rs.getInt("p_no"));
				cart.setQuantity(rs.getInt("quantity"));
				cart.setpName(rs.getString("p_name"));
				cart.setpPrice(rs.getInt("p_price"));
				cart.setpImg(rs.getString("p_img"));
				
				cartList.add(cart);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectCartList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return cartList;
	}
	
	//product 테이블에 저장된 모든 상품정보를 검색하여 반환하는 메소드
	//상품정보 총 리스트;상품명 검색용
	public List<ProductDTO> allProductList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<ProductDTO>();
		try {
			con=getConnection();
			
			String sql="select * from product";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
					
			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product.setpNo(rs.getInt("p_no"));
				product.setpName(rs.getString("p_name"));
				productList.add(product);
			}  
		} catch (SQLException e) {
			System.out.println("[에러]AllProductList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
//관리자 페이지 관련
	//PAY 테이블에 저장된 모든 주문정보를 검색하여 반환하는 메소드
	public List<PayDTO> allPayList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<PayDTO> payList=new ArrayList<PayDTO>();
		try {
			con=getConnection();
			
			String sql="select * from pay order by p_no desc";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				PayDTO pay=new PayDTO();

				pay.setPno(rs.getInt("p_no"));
				pay.setPdate(rs.getString("p_date"));
				pay.setPid(rs.getString("p_id"));
				pay.setPitem(rs.getString("p_item"));
				pay.setPamount(rs.getInt("p_amount"));
				pay.setPaddress(rs.getString("p_address"));
				pay.setPstatus(rs.getInt("p_status"));
				pay.setPmsg(rs.getString("p_msg"));
				payList.add(pay);
			}
		} catch (SQLException e) {
			System.out.println("[에러]allPayList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return payList;
	}
	
	public List<PayDTO> selectPayList(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<PayDTO> payList=new ArrayList<PayDTO>();
		try {
			con=getConnection();
			
			String sql="select * from pay where p_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				PayDTO pay=new PayDTO();

				pay.setPno(rs.getInt("p_no"));
				pay.setPdate(rs.getString("p_date"));
				pay.setPid(rs.getString("p_id"));
				pay.setPitem(rs.getString("p_item"));
				pay.setPamount(rs.getInt("p_amount"));
				pay.setPaddress(rs.getString("p_address"));
				pay.setPstatus(rs.getInt("p_status"));
				pay.setPmsg(rs.getString("p_msg"));
				pay.setpImg(rs.getString("p_img"));
				pay.setpPrice(rs.getInt("p_price"));
				payList.add(pay);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectPayList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return payList;
	}
	
	//글번호와 상태정보를 전달받아 QNA 테이블에 저장된 게시글의 상태를 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateStatus(int num, int status) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update pay set p_status=? where p_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, status);
			pstmt.setInt(2, num);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateStatus 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;		
	}
	
	//회원정보를 전달받아 pay 테이블에 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertPay(PayDTO pay) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into pay values(?,sysdate,?,?,?,?,0,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pay.getPno());
			pstmt.setString(2, pay.getPid());
			pstmt.setString(3, pay.getPitem());
			pstmt.setInt(4, pay.getPamount());
			pstmt.setString(5, pay.getPaddress());
			pstmt.setString(6, pay.getPmsg());
			pstmt.setString(7, pay.getpImg());
			pstmt.setInt(8, pay.getpPrice());
			pstmt.setString(9, pay.getTotal());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertPay 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	
	
	//Pay_SEQ 시퀸스의 다음값을 검색하여 반환하는 메소드
	public int selectNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select pay_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNextNum 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	
	
	//학번을 전달받아 STUDENT 테이블에 저장된 해당 학번의 학생정보를 검색하여 반환하는 메소드
		// => 단일행 검색 : 검색행이 하나인 경우 값 또는 DTO 객체 반환
	public PayDTO selectTotal(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		PayDTO pay=null;
		try {
			con=getConnection();
			
			String sql="select * from pay where p_id=? and p_status=0";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				pay=new PayDTO();
				pay.setTotal(rs.getString("total"));
			}
				
		} catch (SQLException e) {
			System.out.println("[에러]selectStudent() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return pay;
	}
	
}
