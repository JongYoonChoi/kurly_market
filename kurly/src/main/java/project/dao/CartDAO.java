package project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.dto.CartDTO;

public class CartDAO extends JdbcDAO{
	private static CartDAO _dao;
	
	private CartDAO() {
		
	}
	
	static {
		_dao = new CartDAO();
	}
	
	public static CartDAO getDAO() {
		return _dao;
	}

	public int insertCart(CartDTO cart) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();
			
			String sql = "insert into cart values(sqe_cart.nextval,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cart.getuId());
			pstmt.setInt(2, cart.getpNo());
			pstmt.setInt(3, cart.getQuantity());
			pstmt.setString(4, cart.getpName());
			pstmt.setInt(5, cart.getpPrice());
			pstmt.setString(6, cart.getpImg());
			
		
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertCart 메소드 SQL 오류 = " + e.getMessage());
		}finally {
			close (con, pstmt);
		}
		return rows;
	}
	
	public CartDTO selectCartP(int pNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CartDTO cart = null;
		try {
			con = getConnection();
			
			String sql = "select * from cart where p_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pNo);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cart = new CartDTO();
				cart.setCartIdx(rs.getString("cart_idx"));
				cart.setuId(rs.getString("u_id"));
				cart.setpNo(rs.getInt("p_no"));
				cart.setQuantity(rs.getInt("quantity"));
				cart.setpImg(rs.getString("p_img"));
				cart.setpName(rs.getString("p_name"));
				cart.setpPrice(rs.getInt("p_price"));
				
				
				
			}
		}catch(SQLException e) {
			System.out.println("[에러] selectCartP 메소드의 SQL 오류=" + e.getMessage());
		}finally {
			close(con,pstmt,rs);
		}
		return cart;
	}

	public List<CartDTO> selectCartList(String uId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CartDTO> cartList = new ArrayList<CartDTO>();

		try {
			con = getConnection();

			String sql = "select * from cart where u_id = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uId);
			

			rs = pstmt.executeQuery();

			while (rs.next()) {
				CartDTO cart = new CartDTO();
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
			System.out.println("[에러] selectCartList() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);

		}

		return cartList;
	}
	
	public int deleteCart (int pNo, String uId) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from cart where p_no=? and u_id = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pNo);
			pstmt.setString(2, uId);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteMember 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		} 
		return rows;
	}
	
	public CartDTO selectTotalCart(String uId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CartDTO cart = null;

		try {
			con = getConnection();

			String sql = "SELECT SUM(P_PRICE * QUANTITY) AS TOTAL, (SUM(P_PRICE * QUANTITY)+3000) AS DE_TOTAL  FROM CART WHERE U_ID = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uId);
			
			

			rs = pstmt.executeQuery();

			if(rs.next()) {
				cart = new CartDTO();
				cart.setTotal(rs.getInt("total"));
				cart.setDeTotal(rs.getInt("de_total"));
				
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectTotalCart() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);

		}

		return cart;
	}
	
	public CartDTO selectIndTotal(String uId, int pNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CartDTO cart = null;

		try {
			con = getConnection();

			String sql = "SELECT P_PRICE * QUANTITY AS IND_TOTAL FROM CART WHERE U_ID = ? AND P_NO = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uId);
			pstmt.setInt(2, pNo);
			
			

			rs = pstmt.executeQuery();

			if(rs.next()) {
				cart = new CartDTO();
				cart.setIndTotal(rs.getInt("ind_total"));
				
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectTotalCart() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);

		}

		return cart;
	}
}